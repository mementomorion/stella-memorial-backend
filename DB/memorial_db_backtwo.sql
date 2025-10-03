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
-- Name: materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    price numeric(12,2) DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.materials OWNER TO postgres;

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
    price numeric,
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
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    username text NOT NULL,
    password_hash text NOT NULL,
    role text DEFAULT 'admin'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: blagoustroystvo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blagoustroystvo (id, name, type, price, original_price, images, availability, category, material, color, polishing, description, production_time, installation_warranty, product_warranty, dimensions, features, specifications, is_new, is_exclusive, material_variants, created_at, updated_at) FROM stdin;
fab89496-5b06-4256-93cb-4f9038ff9239	Ваза А-1	Вазы	15000	20000	["/uploads/7ojt8u3e129.jpg"]	В наличии	Благоустройство	\N	\N	\N	Ваза	\N	\N	\N	{"size": "", "depth": "", "width": "", "height": "", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	[]	{}	f	f	[{"name": "Suskuyansari", "color": "", "image": "7ojt8u3e129.jpg", "priceModifier": 0}]	2025-09-28 01:39:03.614187+03	2025-09-28 01:39:03.614187+03
a9e6d934-f8ed-4a00-8081-9c20919b0587	Ваза А-2	\N	20000	\N	["/uploads/8zsseyi1ym5.jpg"]	В наличии	Благоустройство	\N	\N	\N	Ваза	\N	\N	\N	{"size": "", "depth": "", "width": "", "height": "", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	[]	{}	f	f	[{"name": "Suskuyansari", "color": "", "image": "8zsseyi1ym5.jpg", "priceModifier": 0}]	2025-09-28 01:39:33.263742+03	2025-09-28 01:39:33.263742+03
ddeadc9c-8e98-4ccc-8e3e-5bef16063140	Ваза А-3	Вазы	35000	\N	["/uploads/9b3g2429iga.jpg"]	В наличии	Благоустройство	\N	\N	\N	Ваза А-3	\N	\N	\N	{"size": "", "depth": "", "width": "", "height": "", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	[]	{}	f	f	[{"name": "Suskuyansari", "color": "", "image": "9b3g2429iga.jpg", "priceModifier": 0}]	2025-09-28 01:40:02.681301+03	2025-09-28 01:40:02.681301+03
7189b790-03fe-4e2c-8f5d-fa0322eed0f7	Ваза А-4	Вазы	25000	\N	["/uploads/7cw5p11zl4n.jpg"]	В наличии	Благоустройство		Зависит от камня	Со всех сторон	Ваза А-4В				{"size": "120х80х40", "depth": "40", "width": "80", "height": "120", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	["Надежная"]	{}	f	f	[{"name": "Suskuyansari", "color": "", "image": "7cw5p11zl4n.jpg", "priceModifier": 0}]	2025-09-28 01:40:48.669654+03	2025-09-28 01:41:12.059426+03
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
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.materials (id, name, price, created_at, updated_at) FROM stdin;
4ccfc527-0a6b-414b-972e-824882c7be2f	Free	2500000.00	2025-09-26 23:56:29.856569	2025-09-27 15:02:14.261277
4ccfc527-0a6b-412b-972e-82488bc7be1f	Koelga	2700000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-952e-72488bc7be2f	BaltikGreen	2600000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-972e-62688bc7be2f	Tokovsky	2600000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-972e-52478bc7be2f	Suskuyansari	3300000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-972e-42428bc7be2f	Leznikovsky	2800000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-972e-32418bc7be2f	Sanarskiy	1800000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-972e-22486bc7be2f	BluePearl	3700000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-972e-12488bc7be2f	Labradorit	3200000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-172e-82488bc7be2f	LabradoritZelen	3200000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-272e-82488bc7be2f	Kapistinsky	2600000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-372e-82488bc7be2f	VerdeGuatemala	3600000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-472e-82488bc7be2f	KuruGray	3200000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-572e-82488bc7be2f	KvarcitWowinsky	7000000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-672e-82488bc7be2f	KvarcitKojim	6800000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-972e-83388bc7be2f	Kurtinskiy	2500000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
4ccfc527-0a6b-414b-872e-82433bc7be2f	Kurdayskiy	1900000.00	2025-09-26 23:56:29.856569	2025-09-27 14:52:37.833655
8da6ec5f-18f9-49bf-ad42-0220521482d1	Diabaz	1800000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.750888
691239ff-1d83-41aa-88b6-c2dd8cd814c3	AbsoluteBlack	3600000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.753561
f062336a-abc0-46aa-a36b-1fb0dc0aaa17	Sibirsky	1700000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.75452
2a1deeb7-091f-4b73-a0af-fbfbb5146c8b	Dimovsky	1700000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.754634
15cc8ef7-6fcb-4d97-b8b0-1359e4250277	Mansurovsky	1600000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.7566
0b5bc186-0de1-492b-b5b5-b47bbb3e0c29	Kalguvara	1800000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.757702
c02e13f5-496b-493f-bc7f-075677ad0f5f	IglRed	2500000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.758083
367ba1fd-e8d9-457a-9819-dfdab17a2051	Hauki	2400000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.76029
e0d81324-f0b8-42a4-941a-d8f2811744f1	Konglomerat	1700000.00	2025-09-26 23:56:29.856569	2025-09-27 00:25:00.853367
465862f5-b438-4f73-98e6-16ae1c7ac48c	GranatAmfibolit	1900000.00	2025-09-26 23:56:29.856569	2025-09-27 13:51:18.350489
4ccfc527-0a6b-414b-972e-82488bc7be2f	Maslovsky	2500000.00	2025-09-26 23:56:29.856569	2025-09-27 15:02:14.261277
\.


--
-- Data for Name: oformlenie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oformlenie (id, name, type, price, original_price, images, availability, category, material, color, polishing, description, production_time, installation_warranty, product_warranty, dimensions, features, specifications, is_new, is_exclusive, material_variants, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: pamyatniki; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pamyatniki (id, name, type, price, original_price, images, availability, category, material, color, polishing, description, production_time, installation_warranty, product_warranty, dimensions, features, specifications, is_new, is_exclusive, material_variants, created_at, updated_at) FROM stdin;
d0dec04a-9416-4596-b13d-f2cbf714f519	A-4	Вертикальные	40000	\N	["/uploads/e1zmicbq6km.jpg", "/uploads/7q8cyimvk1g.jpg", "/uploads/1en6i2fklrj.jpg", "/uploads/ca4dcfrnaiu.jpg", "/uploads/yd1jr3va3ei.jpg", "/uploads/hkjtsiyj6ss.jpg", "/uploads/8fdw09zled.jpg", "/uploads/luzb4h7u9f.jpg"]	В наличии	Памятники		Зависит от камня	Со всех сторон	Памятник				{"size": "", "depth": "", "width": "", "height": "", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	["Стандарт"]	{}	f	f	[{"name": "Suskuyansari", "color": "", "image": "e1zmicbq6km.jpg", "priceModifier": 0}, {"name": "Mansurovsky", "color": "", "image": "7q8cyimvk1g.jpg", "priceModifier": 0}, {"name": "Labradorit", "color": "", "image": "1en6i2fklrj.jpg", "priceModifier": 0}, {"name": "KuruGray", "color": "", "image": "ca4dcfrnaiu.jpg", "priceModifier": 0}, {"name": "Kurdayskiy", "color": "", "image": "yd1jr3va3ei.jpg", "priceModifier": 0}, {"name": "Dimovsky", "color": "", "image": "hkjtsiyj6ss.jpg", "priceModifier": 0}, {"name": "Diabaz", "color": "", "image": "8fdw09zled.jpg", "priceModifier": 0}, {"name": "BaltikGreen", "color": "", "image": "luzb4h7u9f.jpg", "priceModifier": 0}]	2025-09-28 01:14:19.018557+03	2025-09-28 01:34:56.018787+03
2fc6607e-1a33-4022-9517-20a4284a332f	А-3	Вертикальные	40000	500000	["/uploads/4ei8dsrczwx.jpg", "/uploads/m5r8rvst0ao.jpg", "/uploads/b451uv0n3wu.jpg", "/uploads/ko6f1bp49g.jpg", "/uploads/6kbyfysgsrs.jpg", "/uploads/rhqqu2exfnc.jpg", "/uploads/pmusu2yczon.jpg", "/uploads/nbyfy8sw2qb.jpg"]	В наличии	Памятники	\N	Зависит от камня	Со всех сторон	Памятник	5-7 рабочих дней	3 года	Бессрочная	{"size": "", "depth": "", "width": "", "height": "", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	["Стандарт"]	{"Защита": "От грязи и влаги"}	f	f	[{"name": "Suskuyansari", "color": "", "image": "4ei8dsrczwx.jpg", "priceModifier": 0}, {"name": "Mansurovsky", "color": "", "image": "m5r8rvst0ao.jpg", "priceModifier": 0}, {"name": "Labradorit", "color": "", "image": "b451uv0n3wu.jpg", "priceModifier": 0}, {"name": "KuruGray", "color": "", "image": "ko6f1bp49g.jpg", "priceModifier": 0}, {"name": "Kurdayskiy", "color": "", "image": "6kbyfysgsrs.jpg", "priceModifier": 0}, {"name": "Dimovsky", "color": "", "image": "rhqqu2exfnc.jpg", "priceModifier": 0}, {"name": "Diabaz", "color": "", "image": "pmusu2yczon.jpg", "priceModifier": 0}, {"name": "BaltikGreen", "color": "", "image": "nbyfy8sw2qb.jpg", "priceModifier": 0}]	2025-09-28 01:28:38.72299+03	2025-09-28 01:28:38.72299+03
2c651d7d-0d3c-4daf-a689-3d0ee7b3790d	А-1	Вертикальные	40000	\N	["/uploads/oo4nw9oysl.jpg", "/uploads/ytpyhxhkbxn.jpg", "/uploads/mhzt5bouii.jpg", "/uploads/zlvenz7sxug.jpg", "/uploads/3gmbnmll5jp.jpg", "/uploads/61uj72c23tf.jpg", "/uploads/f0af85613zn.jpg", "/uploads/pyp8o97np59.jpg"]	В наличии	Памятники		Зависит от камня	Со всех сторон	Памятник 				{"size": "", "depth": "", "width": "", "height": "", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	["Стандарт"]	{"Защита": "От влаги и грязи"}	f	f	[{"name": "Suskuyansari", "color": "", "image": "oo4nw9oysl.jpg", "priceModifier": 0}, {"name": "Mansurovsky", "color": "", "image": "ytpyhxhkbxn.jpg", "priceModifier": 0}, {"name": "Labradorit", "color": "", "image": "mhzt5bouii.jpg", "priceModifier": 0}, {"name": "KuruGray", "color": "", "image": "zlvenz7sxug.jpg", "priceModifier": 0}, {"name": "Kurdayskiy", "color": "", "image": "3gmbnmll5jp.jpg", "priceModifier": 0}, {"name": "Dimovsky", "color": "", "image": "61uj72c23tf.jpg", "priceModifier": 0}, {"name": "Diabaz", "color": "", "image": "f0af85613zn.jpg", "priceModifier": 0}, {"name": "BaltikGreen", "color": "", "image": "pyp8o97np59.jpg", "priceModifier": 0}]	2025-09-28 01:34:04.268174+03	2025-09-28 01:34:39.317774+03
8bf1bbf3-bbf1-41b6-85aa-b9368ce8e533	А-2	Вертикальные	40000	\N	["/uploads/veinic6ne2f.jpg", "/uploads/thhxlgcyyd.jpg", "/uploads/px19dwwvcd.jpg", "/uploads/mrzore65rso.jpg", "/uploads/tw58e4p05da.jpg", "/uploads/xzp6mbr60kl.jpg", "/uploads/5x16lw2a9f2.jpg", "/uploads/yjvjg0s0yhm.jpg"]	В наличии	Памятники		Зависит от камня	Со всех сторон	Памятник				{"size": "", "depth": "", "width": "", "height": "", "stelaDepth": "", "stelaWidth": "", "stelaHeight": "", "pedestalDepth": "", "pedestalWidth": "", "pedestalHeight": ""}	["Стандарт"]	{}	f	f	[{"name": "Suskuyansari", "color": "", "image": "veinic6ne2f.jpg", "priceModifier": 0}, {"name": "Mansurovsky", "color": "", "image": "thhxlgcyyd.jpg", "priceModifier": 0}, {"name": "Labradorit", "color": "", "image": "px19dwwvcd.jpg", "priceModifier": 0}, {"name": "KuruGray", "color": "", "image": "mrzore65rso.jpg", "priceModifier": 0}, {"name": "Kurdayskiy", "color": "", "image": "tw58e4p05da.jpg", "priceModifier": 0}, {"name": "Dimovsky", "color": "", "image": "xzp6mbr60kl.jpg", "priceModifier": 0}, {"name": "Diabaz", "color": "", "image": "5x16lw2a9f2.jpg", "priceModifier": 0}, {"name": "BaltikGreen", "color": "", "image": "thhxlgcyyd.jpg", "priceModifier": 0}]	2025-09-28 01:31:30.581087+03	2025-09-28 01:34:44.616917+03
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password_hash, role, created_at) FROM stdin;
11111111-2222-3333-4444-555555555555	stella_admin_new	$2b$10$I4p37GyCySa.tGs.BmxZWu2cHt0z83P650Z2plLvisWOFnmfRAABu	admin	2025-09-19 20:49:00.113825+03
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
-- Name: materials materials_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_name_key UNIQUE (name);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


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
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


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

