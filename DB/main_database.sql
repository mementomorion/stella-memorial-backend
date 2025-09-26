--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_timestamp() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: blagoustroystvo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blagoustroystvo (
    id text NOT NULL,
    name text NOT NULL,
    type text,
    price numeric NOT NULL,
    original_price numeric,
    images jsonb DEFAULT '[]'::jsonb,
    availability text NOT NULL,
    category text NOT NULL,
    material text,
    color text,
    polishing text,
    description text,
    production_time text,
    installation_warranty text,
    product_warranty text,
    dimensions jsonb DEFAULT '{}'::jsonb,
    features jsonb DEFAULT '[]'::jsonb,
    specifications jsonb DEFAULT '{}'::jsonb,
    is_new boolean DEFAULT false,
    is_exclusive boolean DEFAULT false,
    material_variants jsonb DEFAULT '[]'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.blagoustroystvo OWNER TO postgres;

--
-- Name: kompleksy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kompleksy (
    id text NOT NULL,
    name text NOT NULL,
    type text,
    price numeric NOT NULL,
    original_price numeric,
    images jsonb DEFAULT '[]'::jsonb,
    availability text NOT NULL,
    category text NOT NULL,
    material text,
    color text,
    polishing text,
    description text,
    production_time text,
    installation_warranty text,
    product_warranty text,
    dimensions jsonb DEFAULT '{}'::jsonb,
    features jsonb DEFAULT '[]'::jsonb,
    specifications jsonb DEFAULT '{}'::jsonb,
    is_new boolean DEFAULT false,
    is_exclusive boolean DEFAULT false,
    material_variants jsonb DEFAULT '[]'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.kompleksy OWNER TO postgres;

--
-- Name: oformlenie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oformlenie (
    id text NOT NULL,
    name text NOT NULL,
    type text,
    price numeric NOT NULL,
    original_price numeric,
    images jsonb DEFAULT '[]'::jsonb,
    availability text NOT NULL,
    category text NOT NULL,
    material text,
    color text,
    polishing text,
    description text,
    production_time text,
    installation_warranty text,
    product_warranty text,
    dimensions jsonb DEFAULT '{}'::jsonb,
    features jsonb DEFAULT '[]'::jsonb,
    specifications jsonb DEFAULT '{}'::jsonb,
    is_new boolean DEFAULT false,
    is_exclusive boolean DEFAULT false,
    material_variants jsonb DEFAULT '[]'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.oformlenie OWNER TO postgres;

--
-- Name: pamyatniki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pamyatniki (
    id text NOT NULL,
    name text NOT NULL,
    type text,
    price numeric NOT NULL,
    original_price numeric,
    images jsonb DEFAULT '[]'::jsonb,
    availability text NOT NULL,
    category text NOT NULL,
    material text,
    color text,
    polishing text,
    description text,
    production_time text,
    installation_warranty text,
    product_warranty text,
    dimensions jsonb DEFAULT '{}'::jsonb,
    features jsonb DEFAULT '[]'::jsonb,
    specifications jsonb DEFAULT '{}'::jsonb,
    is_new boolean DEFAULT false,
    is_exclusive boolean DEFAULT false,
    material_variants jsonb DEFAULT '[]'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.pamyatniki OWNER TO postgres;

--
-- Data for Name: blagoustroystvo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blagoustroystvo (id, name, type, price, original_price, images, availability, category, material, color, polishing, description, production_time, installation_warranty, product_warranty, dimensions, features, specifications, is_new, is_exclusive, material_variants, created_at, updated_at) FROM stdin;
8df61564-690b-4ed1-b2ff-5007c5ea2cdb	Столик А-1	Столы и лавочки	5000	\N	["/uploads/vu975wbul8l.jpg", "/uploads/rxr0napdbgq.jpg", "/uploads/9jkzwm52bx.jpg", "/uploads/ox6lh8vpkys.jpg", "/uploads/jhdyqdl97qn.jpg", "/uploads/lutp1sqquk.jpg", "/uploads/xn81vn5p9wn.jpg", "/uploads/s8ndm2cyk4j.jpg"]	В наличии	Благоустройство	По заказу	Зависит от камня	Со всех сторон	Стол из гранита с прямоугольной столешницей и строгими геометрическими формами. Его лаконичный дизайн и монолитная структура символизируют устойчивость, порядок и вечность. Минималистичная эстетика подчеркивает solemnity пространства, предоставляя место для поминальных ритуалов и tranquil reflection. Прочность материала отражает неизменность памяти и уважения.\n\n	5-7 рабочих дней	3 года	Бессрочная	{"size": "", "depth": "40", "width": "80", "height": "120"}	[]	{}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "vu975wbul8l.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "jhdyqdl97qn.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": " Красный с черными вкраплениями", "image": "lutp1sqquk.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "s8ndm2cyk4j.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "ox6lh8vpkys.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Феавы", "image": "xn81vn5p9wn.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Гладко-черный", "image": "9jkzwm52bx.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Белый камень", "image": "rxr0napdbgq.jpg", "priceModifier": 0}]	2025-09-18 23:00:04.492993+03	2025-09-18 23:00:04.492993+03
100bf8a6-2447-4a94-ad95-3a25de504576	Лавка А-1	Столы и лавочки	15000	\N	["/uploads/y0z790j1r0f.jpg", "/uploads/8oof9edjrm3.jpg", "/uploads/tp3ud8xi2ws.jpg", "/uploads/o6zt7k6uen8.jpg", "/uploads/fyubh33sl7n.jpg", "/uploads/33gc2o284rc.jpg", "/uploads/krf8x5lnakd.jpg", "/uploads/ot1k115dlb.jpg"]	В наличии	Благоустройство	Камень	\N	\N	Прямая каменная лавка с минималистичным дизайном и строгими геометрическими формами. Её лаконичность и монолитность символизируют вечность, покой и неизменность памяти. Сдержанная прочность конструкции создает место для умиротворенного размышления и почтения, гармонично вписываясь в мемориальное пространство.\n\n	\N	\N	\N	{"size": "", "depth": "", "width": "", "height": ""}	[]	{}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "ot1k115dlb.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "krf8x5lnakd.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": " Красный с черными вкраплениями", "image": "y0z790j1r0f.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "tp3ud8xi2ws.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "fyubh33sl7n.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "o6zt7k6uen8.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "8oof9edjrm3.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Черный-блэк", "image": "33gc2o284rc.jpg", "priceModifier": 0}]	2025-09-18 22:55:57.777411+03	2025-09-18 22:55:57.777411+03
782481d6-43c5-449d-baf8-1f84c134f239	Ваза А-1	Вазы	4500	8000	["/uploads/ze7a8pg2o2h.jpg", "/uploads/9vt12chro57.jpg", "/uploads/v1njs6hc7yl.jpg", "/uploads/89978csy3l3.jpg", "/uploads/mdnoqxcbcc.jpg", "/uploads/zd26jjprfw.jpg", "/uploads/dtdd85w2g6.jpg"]	В наличии	Благоустройство	По заказу	Зависит от камня	Со всех сторон	Классическая ваза с лаконичным дизайном и строгими линиями. Её сдержанная элегантность подчеркивает торжественность момента, а прочность материала символизирует вечность памяти. Идеальный выбор для создания атмосферы уважения и почтения. Четкие формы и отсутствие излишеств отражают глубокую скорбь и достоинство.				{"size": "", "depth": "30", "width": "30", "height": "60"}	[]	{}	f	f	[{"name": "Габбро-диабаз", "color": "Черный", "image": "ze7a8pg2o2h.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "9vt12chro57.jpg", "priceModifier": 4}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "v1njs6hc7yl.jpg", "priceModifier": 0}, {"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "89978csy3l3.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Черный", "image": "mdnoqxcbcc.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Черный", "image": "zd26jjprfw.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный", "image": "dtdd85w2g6.jpg", "priceModifier": 1000}]	2025-09-18 17:52:32.975826+03	2025-09-18 22:56:24.15246+03
378c1c6b-014d-4290-98e9-8e7604e2ba73	Ограда А-1	Ограды	50000	70000	["/uploads/oae504iyo6.png"]	В наличии	Благоустройство	Гранит	Зависит от камня	Со всех сторон	Прямоугольная ограда из гранита с ровными секциями и строгими линиями. Её лаконичный дизайн подчеркивает solemnity и порядок, символизируя неприкосновенность и вечность памяти. Минималистичная форма создает завершенность мемориального пространства, обеспечивая чувство уважения и покоя.	5-7 рабочих дней	3 года	Бессрочная	{"size": "", "depth": "200", "width": "200", "height": "120"}	[]	{}	t	f	[]	2025-09-18 22:57:38.061477+03	2025-09-18 22:57:38.061477+03
\.


--
-- Data for Name: kompleksy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kompleksy (id, name, type, price, original_price, images, availability, category, material, color, polishing, description, production_time, installation_warranty, product_warranty, dimensions, features, specifications, is_new, is_exclusive, material_variants, created_at, updated_at) FROM stdin;
3f678f03-26f0-47b7-92f2-1d1abf91084c	Комплекс А-1	Маленький участок	250000	\N	["/uploads/l1vccwyua6.jpg"]	В наличии	Комплексы	На заказ	Зависит от камня	\N	Небольшой комплекс, серьезный	\N	\N	\N	{"size": "", "depth": "200", "width": "80", "height": "120"}	["Крепкий", "Универсальный"]	{}	t	f	[]	2025-09-18 23:04:31.578405+03	2025-09-18 23:04:31.578405+03
5fdb82a2-63c9-40e9-b335-c8cef6a73d65	Комплекс П-1	Простые комплексы	200000	250000	["/uploads/yr2eqgjhqc.jpg", "/uploads/jsehhlh975c.jpg", "/uploads/kp65jv1jlol.jpg"]	В наличии	Комплексы	По заказу	Зависит от камня	Со всех сторон	Гранитный мемориальный комплекс, объединяющий строгие формы и лаконичные линии всех элементов. Его монументальность и гармоничная геометрия символизируют вечность, порядок и непрерывность памяти. Единство дизайна создает solemn, упорядоченное пространство для contemplation и почтения, где каждый элемент подчеркивает величие и достоинство усопшего.				{"size": "", "depth": "200", "width": "200", "height": "120"}	["Качественный", "Бюджетный", "Статный"]	{"Камень": "На выбор", "Стойкость": "От морозов и сколов", "Под участок": "220х220 размера", "Вариативность": "Есть"}	f	f	[]	2025-09-18 23:07:16.928161+03	2025-09-18 23:07:45.423869+03
36a86dc1-b199-4af5-a3a9-665766f8771c	Эксклюзивный комплекс Э-1	Эксклюзивные комплексы	350000	\N	["/uploads/v9jit62zr3.jpg", "/uploads/rsxgeozhohi.jpg", "/uploads/2c37xaosyfs.jpg", "/uploads/6wid8dmowca.jpg"]	Нет в наличии	Комплексы	По заказу	Зависит от камня	Со всех сторон	Эксклюзивный мемориальный комплекс из цельного гранита с уникальной текстурой и идеальными геометрическими пропорциями. Его монолитные формы и авторское исполнение подчеркивают исключительность и вечность памяти. Минималистичный yet величественный дизайн создает пространство для уединенного contemplation, где каждая деталь символизирует безупречность и perpetuity.	5-7 рабочих дней	3 года	Бессрочная	{"size": "", "depth": "200", "width": "200", "height": "200"}	[]	{}	f	t	[]	2025-09-18 23:50:17.217328+03	2025-09-18 23:50:17.217328+03
be3d154b-7fdb-409c-b1ed-ec1ddd4f8e1e	Элитный комплекс Э-1	Элитные комплексы	1500000	\N	["/uploads/ozg13nhkgyr.jpg", "/uploads/x4tdjeeclh.jpg", "/uploads/eu7cauo7ml.jpg", "/uploads/sq4b9hi33gn.jpg", "/uploads/ge4erg04c39.png", "/uploads/rj7zld0mclg.png", "/uploads/q70h8mgwik.jpg", "/uploads/hri1dsd3voc.jpg", "/uploads/1p828ys2b3d.jpg"]	В наличии	Комплексы	Мрамор	Белый	Со всех сторон	Элитный мемориальный комплекс из редкого сорта чёрного гранита с полировкой до зеркального блеска. Абсолютно прямые углы, идеальные геометрические пропорции и полное отсутствие видимых соединений подчеркивают статус и безупречность. Лаконичный дизайн, лишённый декора, акцентирует глубину памяти и вечность через совершенство формы и материала. Пространство для уединённой рефлексии, где каждая деталь символизирует неизменное уважение и exclusivity.\n\n				{"size": "", "depth": "5000", "width": "5000", "height": "4000"}	["Элитный", "Красивый", "Качественный", "Белый мрамор"]	{"Дизайн ": "Абсолютный минимализм и лаконичность, акцент на монолитность и весомость", "Материал": "Цельный гранит редкого месторождения", "Геометрия": "Безупречные прямые углы и идеальные геометрические пропорции", "Символика ": "Вечность, нетленность памяти, статус, безупречный вкус и уважение", "Эксклюзивность ": " Авторский проект, изготовление под заказ в единственном экземпляре", "Нанесение информации": "Лазерная гравировка с позолотой 999 пробы или глубокая ручная резьба", "Обработка поверхности": "Полировка премиум-класса до зеркального блеска", "Технология соединения": "Скрытый анкерный крепёж и технология «невидимый шов»"}	t	t	[]	2025-09-18 23:54:35.642841+03	2025-09-18 23:55:31.733831+03
\.


--
-- Data for Name: oformlenie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oformlenie (id, name, type, price, original_price, images, availability, category, material, color, polishing, description, production_time, installation_warranty, product_warranty, dimensions, features, specifications, is_new, is_exclusive, material_variants, created_at, updated_at) FROM stdin;
96c5f934-7af6-44cb-9ff0-f9236cd591e1	ЦОКОЛЬ А-1	\N	1500000	200000	["/uploads/4527llx74d3.png"]	Под заказ	Оформление	Гранит	Зависит от камня	Со всех сторон	Оформление участка	12-17 рабочих дней	3 года	Бессрочная	{"size": "", "depth": "200", "width": "200", "height": "150"}	[]	{}	t	f	[]	2025-09-18 22:24:49.619385+03	2025-09-18 22:24:49.619385+03
cd691e89-986c-4d3b-8539-df1eb7c31dac	ЦОКОЛЬ А-2	\N	200000	\N	["/uploads/p3zjqu9pxp.png"]	Под заказ	Оформление	Гранит	Зависит от камня	Со всех сторон	Оформление участка	12-17 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	[]	{}	t	f	[]	2025-09-18 22:25:31.576046+03	2025-09-18 22:25:31.576046+03
b365e4a9-8ea7-4f45-99c7-d58760f08d4d	ЦОКОЛЬ А-3	\N	140000	150000	["/uploads/b3t4zhiy4c.png"]	Под заказ	Оформление	По заказу	Зависит от камня	Со всех сторон	Оформление участка	12-17 рабочих дней	3 года	Бессрочная	{"size": "", "depth": "200", "width": "200", "height": "120"}	[]	{}	t	f	[]	2025-09-18 22:26:24.438908+03	2025-09-18 22:26:24.438908+03
d03bb5fb-df00-45cf-b645-55a1686b8fe6	ЦОКОЛЬ А-4		150000	\N	["/uploads/7s157ecgnre.png"]	Под заказ	Оформление	По заказу	Зависит от камня	Со всех сторон	Оформление участка				{"size": "", "depth": "200", "width": "200", "height": "120"}	[]	{}	f	f	[]	2025-09-18 22:27:20.823472+03	2025-09-18 22:27:29.006215+03
\.


--
-- Data for Name: pamyatniki; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pamyatniki (id, name, type, price, original_price, images, availability, category, material, color, polishing, description, production_time, installation_warranty, product_warranty, dimensions, features, specifications, is_new, is_exclusive, material_variants, created_at, updated_at) FROM stdin;
a0dcc672-7cd4-4c64-b1a0-07cbe3bad717	Памятник прямой А-14	Вертикальные	150000	\N	["/uploads/wcltdorptz.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.	5-7 рабочих дней	3 года	Бессрочная	{"size": "", "depth": "40", "width": "60", "height": "120"}	[]	{}	f	f	[]	2025-09-18 20:12:15.602238+03	2025-09-18 20:12:15.602238+03
4573f83c-b679-4a1b-baa7-dca1ecc49661	Памятник прямой А-15	Вертикальные	50000	\N	["/uploads/n435v4yskn.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	[]	{}	f	f	[]	2025-09-18 20:13:04.194145+03	2025-09-18 20:13:04.194145+03
e60ab169-1670-4832-a8d1-28f0c4097eea	Памятник прямой А-1	Вертикальные	50000	70000	["/uploads/l0wyx1qyu98.jpg", "/uploads/9jxt901npo9.jpg", "/uploads/6eoadp55ewi.jpg", "/uploads/lzsjrwzegin.jpg", "/uploads/n13j4p1ys5.jpg", "/uploads/hzq7ni30l4.jpg", "/uploads/pdvtqcr8fdq.jpg", "/uploads/jqwgef2y55s.jpg", "/uploads/hvqr8f1dvz.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	["Строгий"]	{"Твердость": "Нет возможности скола", "Надежность": "Стойкий к каррозии"}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "l0wyx1qyu98.jpg"}, {"name": "Габбро-диабаз", "color": "Черный", "image": "9jxt901npo9.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "6eoadp55ewi.jpg", "priceModifier": 10000}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "lzsjrwzegin.jpg", "priceModifier": 5000}, {"name": "Куругрей", "color": "Серый камень", "image": "n13j4p1ys5.jpg", "priceModifier": 10000}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "hzq7ni30l4.jpg", "priceModifier": 15000}, {"name": "Мансуровский", "color": "Белый камень", "image": "pdvtqcr8fdq.jpg", "priceModifier": -4998}, {"name": "Сюксяансари", "color": "Орандж", "image": "jqwgef2y55s.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "hvqr8f1dvz.jpg", "priceModifier": 2000}]	2025-09-18 18:36:13.637177+03	2025-09-18 18:36:13.637177+03
e9c5f493-af67-498e-a0f8-e466de83087f	Памятник прямой А-13	Вертикальные	80000	\N	["/uploads/83vy1ottiiv.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	[]	{}	f	f	[]	2025-09-18 20:10:43.615866+03	2025-09-18 20:10:43.615866+03
082bab11-d166-4914-92ca-ec1f8dfdff8a	Памятник прямой А-2	Вертикальные	60000	85000	["/uploads/n3ly4i4ygb8.jpg", "/uploads/hc78ygqrz1b.jpg", "/uploads/yovfquy5irk.jpg", "/uploads/w6naic4dqpb.jpg", "/uploads/rwmm24pgsf.jpg", "/uploads/uqq1x8ovxj.jpg", "/uploads/vlfdt1pvn8.jpg", "/uploads/bbifr6o0a4e.jpg", "/uploads/q8ldci65em.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n	5-7 рабочих дней	3 года	Бессрочная	{"size": " 120х80х40", "depth": "40", "width": "80", "height": "120"}	["Твердость"]	{"Твердость": "Нет возможности скола", "Надежность": "Стойкий к каррозии"}	t	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "n3ly4i4ygb8.jpg", "priceModifier": 5000}, {"name": "Габбро-диабаз", "color": "Черный", "image": "hc78ygqrz1b.jpg", "priceModifier": 5000}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "yovfquy5irk.jpg", "priceModifier": 10000}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "w6naic4dqpb.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "rwmm24pgsf.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "uqq1x8ovxj.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "vlfdt1pvn8.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "bbifr6o0a4e.jpg", "priceModifier": -5000}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "q8ldci65em.jpg", "priceModifier": 0}]	2025-09-18 19:20:06.936283+03	2025-09-18 19:20:06.936283+03
92ecd647-4a0a-4589-914c-f45ff5851329	Памятник прямой А-3	Вертикальные	80000	100000	["/uploads/0pnexktse8b.jpg", "/uploads/iom129p6oeh.jpg", "/uploads/couj5qykaxh.jpg", "/uploads/hg25kvyws37.jpg", "/uploads/nwwt4m2que.jpg", "/uploads/xsf8wsb7ix.jpg", "/uploads/tyqt56bx7f.jpg", "/uploads/jev93bqnzhn.jpg", "/uploads/7v5jryaomk5.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "140"}	["Твердость"]	{"Твердость": "Нет возможности скола", "Надежность": "Стойкий к каррозии"}	t	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "0pnexktse8b.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "iom129p6oeh.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "couj5qykaxh.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "hg25kvyws37.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "nwwt4m2que.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "xsf8wsb7ix.jpg", "priceModifier": -5000}, {"name": "Мансуровский", "color": "Белый камень", "image": "tyqt56bx7f.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "jev93bqnzhn.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "7v5jryaomk5.jpg", "priceModifier": 10000}]	2025-09-18 19:24:09.074825+03	2025-09-18 19:24:09.074825+03
b69be217-c0e1-4e62-ba45-b6bb7eb07175	Памятник прямой А-4	Вертикальные	70000	\N	["/uploads/itt44tf7pb.jpg", "/uploads/br3a9p0eecc.jpg", "/uploads/rqg8ogkeca.jpg", "/uploads/69o87up1fl4.jpg", "/uploads/2kw8l1ylgym.jpg", "/uploads/stqd2lb1od.jpg", "/uploads/fsh6p29eaes.jpg", "/uploads/5j4rzznpnph.jpg", "/uploads/aj0gu5573x.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.	5-7 рабочих дней	3 года	Бессрочная	{"size": " 120х80х40", "depth": "40", "width": "80", "height": "120"}	["Надежность"]	{"Твердость": "Нет возможности скола"}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "itt44tf7pb.jpg"}, {"name": "Габбро-диабаз", "color": "Черный", "image": "br3a9p0eecc.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "rqg8ogkeca.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "69o87up1fl4.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "2kw8l1ylgym.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "stqd2lb1od.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "fsh6p29eaes.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "5j4rzznpnph.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "aj0gu5573x.jpg", "priceModifier": 0}]	2025-09-18 19:27:51.100619+03	2025-09-18 19:27:51.100619+03
7ac95cc6-a94b-4173-8eb9-f04fedee1486	Памятник прямой А-5	Вертикальные	90000	140000	["/uploads/j4mp0xr2nqg.jpg", "/uploads/n15r0z5hzal.jpg", "/uploads/w4eqio3vphn.jpg", "/uploads/su5k0ae9pg9.jpg", "/uploads/wb4kja7a22f.jpg", "/uploads/oc52zgi0um7.jpg", "/uploads/ryh3axpddul.jpg", "/uploads/odqc5rzebo.jpg", "/uploads/0p9y8fjnpwqh.jpg"]	Нет в наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	["Красота", "Нет возможности скола"]	{}	t	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "j4mp0xr2nqg.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "n15r0z5hzal.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "w4eqio3vphn.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "su5k0ae9pg9.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "wb4kja7a22f.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "oc52zgi0um7.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "ryh3axpddul.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "odqc5rzebo.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "0p9y8fjnpwqh.jpg", "priceModifier": 0}]	2025-09-18 19:31:33.819907+03	2025-09-18 19:31:33.819907+03
dabd7c38-7b5e-48ee-a378-c44116ef9f22	Памятник прямой А-6	Вертикальные	75000	90000	["/uploads/ryrt7gpiswm.jpg", "/uploads/x8jhepuabjp.jpg", "/uploads/kstapgn16x.jpg", "/uploads/0703j9kit8v.jpg", "/uploads/qvn0gm0klr.jpg", "/uploads/3lay4zm6tpl.jpg", "/uploads/9yzy4t4j83f.jpg", "/uploads/9q8nrz5ysks.jpg", "/uploads/gip9dv3w8y.jpg"]	Под заказ	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n				{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	["Вариативность"]	{"Установка с разных сторон": "Есть"}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "ryrt7gpiswm.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный камень", "image": "x8jhepuabjp.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "kstapgn16x.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "0703j9kit8v.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "qvn0gm0klr.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "3lay4zm6tpl.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "9yzy4t4j83f.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "9q8nrz5ysks.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "gip9dv3w8y.jpg", "priceModifier": 0}]	2025-09-18 19:35:22.66406+03	2025-09-18 19:37:17.322946+03
a38f06a0-6fc2-4361-96ba-09e61cdfe2be	Памятник прямой А-7	Вертикальные	75000	\N	["/uploads/gdhi4qa7ud.jpg", "/uploads/pyruj0c095n.jpg", "/uploads/vk7e9baf549.jpg", "/uploads/vvejqlj526m.jpg", "/uploads/sz3v3l1jdue.jpg", "/uploads/c3sfav92yav.jpg", "/uploads/cg5o1990eqq.jpg", "/uploads/4zjzp39qfgt.jpg", "/uploads/p1mjafx2ie.jpg"]	Под заказ	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n				{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	["Твердость", ""]	{"Твердость": "Нет возможности скола", "Надежность": "Стойкий к каррозии"}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "gdhi4qa7ud.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "pyruj0c095n.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "vk7e9baf549.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "vvejqlj526m.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "sz3v3l1jdue.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "c3sfav92yav.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "cg5o1990eqq.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "4zjzp39qfgt.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "p1mjafx2ie.jpg", "priceModifier": 0}]	2025-09-18 19:43:07.868195+03	2025-09-18 19:47:48.319997+03
e904827a-2521-4fe5-9452-60eabb38253d	Памятник прямой А-8	Вертикальные	100000	150000	["/uploads/9nr6jq3fxes.jpg", "/uploads/eujd1yp1b3s.jpg", "/uploads/i8es116ykcq.jpg", "/uploads/u7q37gjmwk.jpg", "/uploads/8cea6l3bchh.jpg", "/uploads/p0mp5dmgnt.jpg", "/uploads/5oo83q2tfip.jpg", "/uploads/1vb6wmr1x81.jpg", "/uploads/mwrhvx8q9g.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	[]	{}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "9nr6jq3fxes.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "eujd1yp1b3s.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "i8es116ykcq.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "u7q37gjmwk.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "8cea6l3bchh.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "p0mp5dmgnt.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "5oo83q2tfip.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "1vb6wmr1x81.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "mwrhvx8q9g.jpg", "priceModifier": 0}]	2025-09-18 19:54:09.852339+03	2025-09-18 19:54:09.852339+03
a9c9d68a-aa51-4626-95d4-c648f36f558d	Памятник прямой А-9	Вертикальные	70000	\N	["/uploads/65yo0hqmps.jpg", "/uploads/tuigp16tjw9.jpg", "/uploads/3zktg7o8usf.jpg", "/uploads/3mt668727c7.jpg", "/uploads/kfe8nxmi0p.jpg", "/uploads/71kt0a37kr.jpg", "/uploads/h2zy4q6g5i4.jpg", "/uploads/u05qmfsl55.jpg", "/uploads/ewey1pz8hc6.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n				{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	["Кайфовый", ""]	{}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "65yo0hqmps.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "tuigp16tjw9.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "3zktg7o8usf.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "3mt668727c7.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "kfe8nxmi0p.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "71kt0a37kr.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "h2zy4q6g5i4.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "u05qmfsl55.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "ewey1pz8hc6.jpg", "priceModifier": 0}]	2025-09-18 19:58:34.224137+03	2025-09-18 20:00:32.016853+03
b9424160-581f-4989-9120-676639bce4d8	Памятник прямой А-10	Вертикальные	130000	150000	["/uploads/1sb7bab4bu9.jpg", "/uploads/d1fq9dblqwl.jpg", "/uploads/asc62f0xd.jpg", "/uploads/63bwnc9or7p.jpg", "/uploads/b0eano2rkho.jpg", "/uploads/1o24od0xgtn.jpg", "/uploads/7503rf4im9r.jpg", "/uploads/x6c65uuvx3b.jpg", "/uploads/jvy9lcht0y.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	[]	{}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "1sb7bab4bu9.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "d1fq9dblqwl.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "asc62f0xd.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "63bwnc9or7p.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "b0eano2rkho.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "1o24od0xgtn.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "7503rf4im9r.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "x6c65uuvx3b.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "jvy9lcht0y.jpg", "priceModifier": 0}]	2025-09-18 20:04:05.075499+03	2025-09-18 20:04:05.075499+03
18fae962-52a5-48de-b5cc-84fb41c9385a	Памятник прямой А-11	Вертикальные	100000	\N	["/uploads/4zrkczl85mb.jpg", "/uploads/olr1mf8j7yi.jpg", "/uploads/4pbq92qgfiy.jpg", "/uploads/66kob6tdqu6.jpg", "/uploads/ha367mcfl9i.jpg", "/uploads/zseug275w4a.jpg", "/uploads/9j5oyk5izyn.jpg", "/uploads/ub20b6mstgc.jpg", "/uploads/70kvqdrazen.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n	5-7 рабочих дней	3 года	Бессрочная	{"size": "120х60х40", "depth": "40", "width": "60", "height": "120"}	[]	{}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "4zrkczl85mb.jpg", "priceModifier": 0}, {"name": "Габбро-диабаз", "color": "Черный", "image": "olr1mf8j7yi.jpg", "priceModifier": 0}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "4pbq92qgfiy.jpg", "priceModifier": 0}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "66kob6tdqu6.jpg", "priceModifier": 0}, {"name": "Куругрей", "color": "Серый камень", "image": "ha367mcfl9i.jpg", "priceModifier": 0}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "zseug275w4a.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "9j5oyk5izyn.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "ub20b6mstgc.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "70kvqdrazen.jpg", "priceModifier": 0}]	2025-09-18 20:06:45.682953+03	2025-09-18 20:06:45.682953+03
16dcc4c0-4105-42e8-b9f4-2904d4da7a64	Памятник прямой А-12	Вертикальные	80000	\N	["/uploads/ptoqgantpti.jpg", "/uploads/c56gjc72es.jpg", "/uploads/jxaarfmf23t.jpg", "/uploads/w07wvjy1mn9.jpg", "/uploads/khlkkhucuxe.jpg", "/uploads/dy0tmu4w5s.jpg", "/uploads/2ea6hzqtb1o.jpg", "/uploads/voqys3ijy8.jpg", "/uploads/j3lodpqxwf.jpg"]	В наличии	Памятники	Гранит	Зависит от камня	Со всех сторон	Прямоугольный монумент из гранита со строгими формами и лаконичными линиями. Его сдержанный дизайн подчеркивает величие и достоинство, а надежность камня символизирует прочность памяти. Этот скромный, но величественный памятник идеально подходит для увековечивания памяти значимых персон. Четкие грани и прямые углы отражают строгость и уважение.\n\n				{"size": "120х80х40", "depth": "40", "width": "80", "height": "120"}	[]	{}	f	f	[{"name": "Балтик грин", "color": "Черный с желтыми вкраплениями", "image": "ptoqgantpti.jpg", "priceModifier": 1000}, {"name": "Габбро-диабаз", "color": "Черный", "image": "c56gjc72es.jpg", "priceModifier": 2000}, {"name": "Дымовский", "color": "Красный с черными вкраплениями", "image": "jxaarfmf23t.jpg", "priceModifier": 3000}, {"name": "Курдайский", "color": "Светло-красный с черными вкраплениями", "image": "w07wvjy1mn9.jpg", "priceModifier": 15000}, {"name": "Куругрей", "color": "Серый камень", "image": "khlkkhucuxe.jpg", "priceModifier": -10000}, {"name": "Лабрадорит", "color": "Гладко-черный", "image": "dy0tmu4w5s.jpg", "priceModifier": 0}, {"name": "Мансуровский", "color": "Белый камень", "image": "2ea6hzqtb1o.jpg", "priceModifier": 0}, {"name": "Сюксяансари", "color": "Орандж", "image": "voqys3ijy8.jpg", "priceModifier": 0}, {"name": "Хакосельский", "color": "Черный-блэк", "image": "j3lodpqxwf.jpg", "priceModifier": 0}]	2025-09-18 20:09:22.544134+03	2025-09-18 23:13:16.580612+03
\.


--
-- Name: blagoustroystvo blagoustroystvo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blagoustroystvo
    ADD CONSTRAINT blagoustroystvo_pkey PRIMARY KEY (id);


--
-- Name: kompleksy kompleksy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kompleksy
    ADD CONSTRAINT kompleksy_pkey PRIMARY KEY (id);


--
-- Name: oformlenie oformlenie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oformlenie
    ADD CONSTRAINT oformlenie_pkey PRIMARY KEY (id);


--
-- Name: pamyatniki pamyatniki_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pamyatniki
    ADD CONSTRAINT pamyatniki_pkey PRIMARY KEY (id);


--
-- Name: blagoustroystvo set_timestamp_blagoustroystvo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp_blagoustroystvo BEFORE UPDATE ON public.blagoustroystvo FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: kompleksy set_timestamp_kompleksy; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp_kompleksy BEFORE UPDATE ON public.kompleksy FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: oformlenie set_timestamp_oformlenie; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp_oformlenie BEFORE UPDATE ON public.oformlenie FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: pamyatniki set_timestamp_pamyatniki; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp_pamyatniki BEFORE UPDATE ON public.pamyatniki FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- PostgreSQL database dump complete
--

