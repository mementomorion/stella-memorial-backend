const express = require('express');
const bodyParser = require('body-parser');
const db = require('./db'); // твоя база PostgreSQL
const { v4: uuidv4 } = require('uuid');
const { validateProductPayload } = require('./validators');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const rateLimit = require('express-rate-limit');

const app = express();
function normalizePayload(payload) {
  return {
    ...payload,
    originalPrice: payload.originalPrice ?? payload.original_price,
    productionTime: payload.productionTime ?? payload.production_time,
    installationWarranty: payload.installationWarranty ?? payload.installation_warranty,
    productWarranty: payload.productWarranty ?? payload.product_warranty,
    isNew: payload.isNew ?? payload.is_new,
    isExclusive: payload.isExclusive ?? payload.is_exclusive,
    materialVariants: payload.materialVariants ?? payload.material_variants,
  };
}

// ⚡️ этот роут вынеси ВЫШЕ всех app.use('/api/:category', ensureTable,...)
// ⚡️ этот роут вынеси ВЫШЕ всех app.use('/api/:category', ensureTable,...)
app.get('/bot_call', async (req, res) => {
  try {
    console.log('--- /bot_call endpoint called ---');
    console.log('Query params received:', req.query);

    const { Phone } = req.query;

    if (!Phone) {
      console.warn('Missing required field: Phone');
      return res.status(400).json({ error: "Телефон обязателен" });
    }

    const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN || "8219876383:AAGMovmnKsqXLgEdJ-F4_XNC_GwVaevynGE";
    const TELEGRAM_CHAT_ID = process.env.TELEGRAM_CHAT_ID || "-4922810294";

    console.log('Using bot token:', TELEGRAM_BOT_TOKEN);
    console.log('Sending to chat ID:', TELEGRAM_CHAT_ID);

    const text = `
📞 *Запрос на обратную связь*  

📱 Телефон: ${Phone}
`;

    console.log('Message to send:', text);

    const url = `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`;
    const response = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        chat_id: TELEGRAM_CHAT_ID,
        text,
        parse_mode: "Markdown"
      })
    });

    console.log('Raw fetch response:', response);

    const data = await response.json();
    console.log('Telegram API response:', data);

    if (!data.ok) {
      console.error("Telegram reported an error:", data);
      return res.status(500).json({ error: "Не удалось отправить сообщение в Telegram", details: data });
    }

    res.json({ success: true, messageId: data.result.message_id });
  } catch (e) {
    console.error("Ошибка /bot_call:", e);
    res.status(500).json({ error: "Ошибка сервера", details: e.message });
  }
});

app.get('/bot', async (req, res) => {
  try {
    console.log('--- /bot endpoint called ---');
    console.log('Query params received:', req.query);

    const { Name, Phone, Email, Type, Message } = req.query;

    if (!Name || !Phone) {
      console.warn('Missing required fields:', { Name, Phone });
      return res.status(400).json({ error: "Имя и телефон обязательны" });
    }

    const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN || "8219876383:AAGMovmnKsqXLgEdJ-F4_XNC_GwVaevynGE";
    const TELEGRAM_CHAT_ID = process.env.TELEGRAM_CHAT_ID || "-4922810294";

    console.log('Using bot token:', TELEGRAM_BOT_TOKEN);
    console.log('Sending to chat ID:', TELEGRAM_CHAT_ID);

    const text = `
📩 *Новая заявка с сайта*  

👤 Имя: ${Name}  
📞 Телефон: ${Phone}  
📧 Email: ${Email || "-"}  
📦 Тип: ${Type || "-"}  
💬 Сообщение: ${Message || "-"}
`;
    console.log('Message to send:', text);

    const url = `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`;
    const response = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        chat_id: TELEGRAM_CHAT_ID,
        text,
        parse_mode: "Markdown"
      })
    });

    console.log('Raw fetch response:', response);

    const data = await response.json();
    console.log('Telegram API response:', data);

    if (!data.ok) {
      console.error("Telegram reported an error:", data);
      return res.status(500).json({ error: "Не удалось отправить сообщение в Telegram", details: data });
    }

    res.json({ success: true, messageId: data.result.message_id });
  } catch (e) {
    console.error("Ошибка /bot:", e);
    res.status(500).json({ error: "Ошибка сервера", details: e.message });
  }
});


const JWT_SECRET = process.env.JWT_SECRET || 'replace_this_with_strong_secret';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '360d'; // пример

// CORS
app.use(cors({
  origin: "*",  // <- разрешает все домены
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization"],
}));

app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});
app.use(express.json()); // для парсинга JSON в POST/PUT запросах
app.use(express.urlencoded({ extended: true })); // если будут формы
app.get('/api/materials', async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM materials ORDER BY name ASC');
    res.json(result.rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

app.put('/api/materials/name/:name', authenticateJWT, ensureAdmin, async (req, res) => {
  try {
    const { price } = req.body;
    if (price === undefined) {
      return res.status(400).json({ error: 'price is required' });
    }

    const result = await db.query(
      'UPDATE materials SET price=$1, updated_at=now() WHERE name=$2 RETURNING *',
      [price, req.params.name]
    );

    if (!result.rowCount) return res.status(404).json({ error: 'not_found' });

    res.json(result.rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});


// POST /api/recalculate/prices
app.post('/api/recalculate/prices', authenticateJWT, ensureAdmin, async (req, res) => {
  try {
    // Получаем все памятники
    const monuments = await db.query(`SELECT id, name, price, material_variants FROM "pamyatniki"`);
    if (!monuments.rows.length) {
      return res.json({ message: 'Нет товаров в категории "Памятники"' });
    }

    // Получаем все материалы
    const materialsRes = await db.query(`SELECT name, price FROM materials`);
    const materialsMap = new Map(materialsRes.rows.map(m => [m.name, m.price]));

    const updates = [];

    for (const monument of monuments.rows) {
      let variants = [];

    try {
      if (typeof monument.material_variants === 'string') {
        variants = JSON.parse(monument.material_variants || '[]');
      } else if (Array.isArray(monument.material_variants)) {
        variants = monument.material_variants; // уже массив
      } else {
        console.warn(`⚠️ material_variants у id=${monument.id} не строка и не массив`, monument.material_variants);
        continue;
      }
    } catch (e) {
      console.warn(`Ошибка парсинга material_variants у id=${monument.id}`, e);
      continue;
    }
      if (!Array.isArray(variants) || !variants.length) {
        console.log(`[SKIP] ${monument.name} (${monument.id}) — нет вариантов`);
        continue;
      }

      // ищем цены для вариантов по name
      const variantPrices = variants.map(v => ({
        name: v?.name,
        price: v?.name ? Number(materialsMap.get(v.name)) : null
      }));

      const validPrices = variantPrices
        .filter(v => typeof v.price === 'number' && !isNaN(v.price))
        .map(v => v.price);


      if (!validPrices.length) {
        console.log(`[SKIP] ${monument.name} (${monument.id}) — цены не найдены для вариантов:`, variantPrices);
        continue;
      }

      const minPrice = Math.min(...validPrices);
      const newPrice = +(minPrice * 0.025).toFixed(2);

      // Логирование
      console.log('---');
      console.log(`Памятник: ${monument.name} (${monument.id})`);
      console.log(`Старая цена: ${monument.price}`);
      console.log('Варианты:', variantPrices);
      console.log(`Минимальная цена материала: ${minPrice}`);
      console.log(`Новая цена: ${newPrice}`);

      if (newPrice !== monument.price) {
        await db.query(
          `UPDATE "pamyatniki" SET price=$1, updated_at=now() WHERE id=$2`,
          [newPrice, monument.id]
        );
        updates.push({ id: monument.id, oldPrice: monument.price, newPrice });
        console.log(`✅ Цена обновлена: ${monument.price} → ${newPrice}`);
      } else {
        console.log('⏩ Цена осталась без изменений');
      }
    }

    res.json({
      message: 'Пересчёт завершён',
      updated: updates.length,
      updates
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});


// безопасный парсер
function safeParseVariants(raw) {
  if (!raw) return [];
  if (Array.isArray(raw)) return raw;
  if (typeof raw === 'object') return [raw];
  if (typeof raw === 'string') {
    try {
      const parsed = JSON.parse(raw);
      return Array.isArray(parsed) ? parsed : [];
    } catch {
      return [];
    }
  }
  return [];
}



const authLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 10, // max 10 requests per minute per IP
  message: { error: 'Слишком много попыток, попробуйте позже' }
});

function authenticateJWT(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: 'Unauthorized' });
  const [scheme, token] = authHeader.split(' ');
  if (scheme !== 'Bearer' || !token) return res.status(401).json({ error: 'Unauthorized' });

  try {
    const payload = jwt.verify(token, JWT_SECRET);
    req.user = payload; // { id, username, role, iat, exp }
    next();
  } catch (e) {
    return res.status(401).json({ error: 'Invalid token' });
  }
}

// Middleware: только админ
function ensureAdmin(req, res, next) {
  if (!req.user) return res.status(401).json({ error: 'Unauthorized' });
  if (req.user.role !== 'admin') return res.status(403).json({ error: 'Forbidden' });
  next();
}
// Логин -> выдаёт JWT
app.post('/admin/login', authLimiter, async (req, res) => {
  try {
    const { username, password } = req.body;
    if (!username || !password) return res.status(400).json({ error: 'username and password required' });

    // Попытка: сначала проверим таблицу users
    const r = await db.query('SELECT id, username, password_hash, role FROM users WHERE username=$1 LIMIT 1', [username]);

    if (r.rowCount) {
      const user = r.rows[0];
      const match = await bcrypt.compare(password, user.password_hash);
      if (!match) return res.status(401).json({ error: 'Invalid credentials' });

      const token = jwt.sign({ id: user.id, username: user.username, role: user.role }, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
      return res.json({ token, expiresIn: JWT_EXPIRES_IN });
    }

    // Если пользователя нет в БД — можно использовать fallback через env (удобно при одном админе)
    const ENV_ADMIN_USER = process.env.ADMIN_USERNAME;
    const ENV_ADMIN_PASS = process.env.ADMIN_PASSWORD;
    if (ENV_ADMIN_USER && ENV_ADMIN_PASS && username === ENV_ADMIN_USER) {
      const match = (password === ENV_ADMIN_PASS);
      if (!match) return res.status(401).json({ error: 'Invalid credentials' });
      // WARNING: env password is plain text; recommend hashing in env or create user in DB after first login
      const token = jwt.sign({ id: 'env-admin', username: ENV_ADMIN_USER, role: 'admin' }, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
      return res.json({ token, expiresIn: JWT_EXPIRES_IN });
    }

    return res.status(401).json({ error: 'Invalid credentials' });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// Upload images
const UPLOAD_DIR = path.join(__dirname, 'uploads');
if (!fs.existsSync(UPLOAD_DIR)) fs.mkdirSync(UPLOAD_DIR, { recursive: true });

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, UPLOAD_DIR),
  filename: (req, file, cb) => cb(null, file.originalname)
});


const upload = multer({
  storage,
  limits: { fileSize: 15 * 1024 * 1024 }, // 15MB
  fileFilter: (req, file, cb) => {
    const allowed = /jpeg|jpg|png|gif|webp/;
    const ext = path.extname(file.originalname).toLowerCase();
    if (allowed.test(ext)) cb(null, true);
    else cb(new Error('Только изображения разрешены'));
  }
});
// защита: только админ может грузить файлы
app.post('/api/upload', authenticateJWT, ensureAdmin, upload.array('files'), (req, res) => {
  if (!req.files || !req.files.length) {
    return res.status(400).json({ message: 'Файлы не загружены' });
  }
  const urls = req.files.map(f => `/uploads/${f.filename}`);
  res.json({ urls });
});
app.use('/uploads', express.static(UPLOAD_DIR));

// Таблицы
const tableMap = {
  pamyatniki: 'pamyatniki',
  oformlenie: 'oformlenie',
  blagoustroystvo: 'blagoustroystvo',
  kompleksy: 'kompleksy'
};

function ensureTable(req, res, next) {
  const table = tableMap[req.params.category];
  if (!table) return res.status(400).json({ error: 'Неизвестная категория' });
  req.table = table;
  next();
}

// GET список с пагинацией и поиском
app.get('/api/:category', ensureTable, async (req, res) => {
  try {
    const { page = '1', limit = '20', q: search } = req.query;
    const pageNum = Number(page);
    const limitNum = Number(limit);
    const offset = (pageNum - 1) * limitNum;
    const params = [];

    let baseQuery = `SELECT * FROM "${req.table}"`;
    if (search) {
      params.push(`%${search}%`);
      baseQuery += ` WHERE name ILIKE $${params.length}`;
    }

    params.push(limitNum);
    params.push(offset);
    baseQuery += ` ORDER BY created_at DESC LIMIT $${params.length-1} OFFSET $${params.length}`;

    const result = await db.query(baseQuery, params);

    // Получаем общее количество записей
    let countQuery = `SELECT COUNT(*) FROM "${req.table}"`;
    const countParams = [];
    if (search) {
      countParams.push(`%${search}%`);
      countQuery += ` WHERE name ILIKE $1`;
    }
    const totalResult = await db.query(countQuery, countParams);
    const total = Number(totalResult.rows[0].count);
    const totalPages = Math.ceil(total / limitNum);

    res.json({
      data: result.rows,
      pagination: { totalPages, page: pageNum }
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});


// GET один товар
app.get('/api/:category/:id', ensureTable, async (req, res) => {
  try {
    const result = await db.query(`SELECT * FROM "${req.table}" WHERE id=$1 LIMIT 1`, [req.params.id]);
    if (!result.rowCount) return res.status(404).json({ error: 'not_found' });
    res.json(result.rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// POST (создание товара) - защищён
app.post('/api/:category', ensureTable, authenticateJWT, ensureAdmin, async (req, res) => {
  try {
    const payload = normalizePayload(req.body);
    if (!payload.id) payload.id = uuidv4();

    const err = validateProductPayload(payload);
    if (err) return res.status(400).json({ error: err });

    const q = `
      INSERT INTO "${req.table}" (
        id, name, type, price, original_price, images, availability, category, material, color, polishing,
        description, production_time, installation_warranty, product_warranty, dimensions, features,
        specifications, is_new, is_exclusive, material_variants
      ) VALUES (
        $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21
      ) RETURNING *;
    `;

    const params = [
      payload.id, payload.name, payload.type || null, payload.price, payload.originalPrice || null,
      JSON.stringify(payload.images || []), payload.availability, payload.category, payload.material || null,
      payload.color || null, payload.polishing || null, payload.description || null, payload.productionTime || null,
      payload.installationWarranty || null, payload.productWarranty || null, JSON.stringify(payload.dimensions || {}),
      JSON.stringify(payload.features || []), JSON.stringify(payload.specifications || {}),
      payload.isNew || false, payload.isExclusive || false, JSON.stringify(payload.materialVariants || [])
    ];

    const result = await db.query(q, params);
    res.status(201).json(result.rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// PUT (редактирование товара) - защищён
app.put('/api/:category/:id', ensureTable, authenticateJWT, ensureAdmin, async (req, res) => {
  try {
    const id = req.params.id;
    const payload = normalizePayload(req.body);

    const allowedFields = [
      'name','type','price','originalPrice','images','availability','category','material','color','polishing',
      'description','productionTime','installationWarranty','productWarranty','dimensions','features','specifications',
      'isNew','isExclusive','materialVariants'
    ];

    const setParts = [];
    const params = [];
    let idx = 1;

    for (const field of allowedFields) {
      if (payload[field] !== undefined) {
        let dbField = field === 'originalPrice' ? 'original_price'
                    : field === 'productionTime' ? 'production_time'
                    : field === 'installationWarranty' ? 'installation_warranty'
                    : field === 'productWarranty' ? 'product_warranty'
                    : field === 'isNew' ? 'is_new'
                    : field === 'isExclusive' ? 'is_exclusive'
                    : field === 'materialVariants' ? 'material_variants'
                    : field;

        let value = payload[field];
        if (['images','dimensions','features','specifications','materialVariants'].includes(field)) {
          value = JSON.stringify(value);
        }

        setParts.push(`"${dbField}"=$${idx++}`);
        params.push(value);
      }
    }

    if (!setParts.length) return res.status(400).json({ error: 'no_fields_to_update' });
    params.push(id);

    const q = `UPDATE "${req.table}" SET ${setParts.join(', ')}, updated_at=now() WHERE id=$${idx} RETURNING *`;
    const result = await db.query(q, params);

    if (!result.rowCount) return res.status(404).json({ error: 'not_found' });
    res.json(result.rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

// DELETE - защищён
app.delete('/api/:category/:id', ensureTable, authenticateJWT, ensureAdmin, async (req, res) => {
  try {
    const selectRes = await db.query(`SELECT images FROM "${req.table}" WHERE id=$1`, [req.params.id]);
    if (!selectRes.rowCount) return res.status(404).json({ error: 'not_found' });

    const images = selectRes.rows[0].images || [];

    images.forEach((url) => {
      try {
        const filePath = path.join(__dirname, 'uploads', path.basename(url));
        if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
      } catch (e) {
        console.error('Ошибка удаления файла', url, e);
      }
    });

    const result = await db.query(`DELETE FROM "${req.table}" WHERE id=$1 RETURNING id`, [req.params.id]);
    res.json({ deleted: true, id: result.rows[0].id });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});














const PORT = 4000;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
