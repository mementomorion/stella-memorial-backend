const express = require('express');
const bodyParser = require('body-parser');
const db = require('./db'); // твоя база PostgreSQL
const { v4: uuidv4 } = require('uuid');
const { validateProductPayload } = require('./validators');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const cors = require('cors');

const app = express();

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
app.post('/api/upload', upload.array('files'), (req, res) => {
  if (!req.files || !req.files.length) {
    return res.status(400).json({ message: 'Файлы не загружены' });
  }

  const urls = req.files.map(f => `/uploads/${f.filename}`);
  res.json({ urls });
});
// Статика для доступа к файлам
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

// POST (создание товара)
app.post('/api/:category', ensureTable, async (req, res) => {
  try {
    const payload = req.body;
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

// PUT (редактирование товара)
app.put('/api/:category/:id', ensureTable, async (req, res) => {
  try {
    const id = req.params.id;
    const payload = req.body;
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

// DELETE
app.delete('/api/:category/:id', ensureTable, async (req, res) => {
  try {
    // сначала получаем запись, чтобы знать, какие изображения удалить
    const selectRes = await db.query(`SELECT images FROM "${req.table}" WHERE id=$1`, [req.params.id]);
    if (!selectRes.rowCount) return res.status(404).json({ error: 'not_found' });

    const images = selectRes.rows[0].images || [];

    // удаляем файлы с диска
    images.forEach((url) => {
      try {
        // предполагаем, что URL вида "/uploads/filename.jpg"
        const filePath = path.join(__dirname, 'uploads', path.basename(url));
        if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
      } catch (e) {
        console.error('Ошибка удаления файла', url, e);
      }
    });

    // удаляем запись из базы
    const result = await db.query(`DELETE FROM "${req.table}" WHERE id=$1 RETURNING id`, [req.params.id]);
    res.json({ deleted: true, id: result.rows[0].id });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  }
});

const PORT = 4000;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
