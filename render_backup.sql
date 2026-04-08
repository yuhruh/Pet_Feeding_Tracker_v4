--
-- PostgreSQL database dump
--

\restrict sPFnJHgvbAGmOXziWlaSpKiqGtP2hQzDNTRDt0xpVxtmOGdwbA1WiIacmexrRnj

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg12+1)
-- Dumped by pg_dump version 18.3 (Homebrew)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: connected_services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connected_services (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    provider character varying,
    uid character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: connected_services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.connected_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: connected_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.connected_services_id_seq OWNED BY public.connected_services.id;


--
-- Name: dry_foods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dry_foods (
    id bigint NOT NULL,
    brand character varying,
    food_type character varying,
    description character varying,
    amount numeric,
    used_amount numeric,
    average_used_amount numeric,
    total_ate_amount numeric,
    left_amount numeric,
    days_remaining date,
    user_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: dry_foods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dry_foods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dry_foods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dry_foods_id_seq OWNED BY public.dry_foods.id;


--
-- Name: health_checks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.health_checks (
    id bigint NOT NULL,
    crea numeric,
    bun numeric,
    phos numeric,
    ca numeric,
    alb numeric,
    chol numeric,
    tp numeric,
    alt numeric,
    alkp numeric,
    ggt numeric,
    glu numeric,
    tbil numeric,
    amyl numeric,
    lipa integer,
    na numeric,
    k numeric,
    cl numeric,
    rbc numeric,
    hct numeric,
    hgb numeric,
    mcv numeric,
    mch numeric,
    mchc numeric,
    rdw numeric,
    retic numeric,
    retic_hgb numeric,
    wbc numeric,
    neu numeric,
    lym numeric,
    mono numeric,
    eos numeric,
    baso numeric,
    plt integer,
    mpv numeric,
    pct numeric,
    osm_cal integer,
    pet_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    exam_date date,
    glob numeric,
    fbnp character varying,
    felv character varying,
    fiv character varying,
    fpl2 numeric
);


--
-- Name: health_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.health_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.health_checks_id_seq OWNED BY public.health_checks.id;


--
-- Name: pets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pets (
    id bigint NOT NULL,
    petname character varying,
    birthday timestamp(6) without time zone,
    weight numeric,
    gender character varying,
    breed character varying,
    user_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pets_id_seq OWNED BY public.pets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    ip_address character varying,
    user_agent character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: solid_cache_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_cache_entries (
    id bigint NOT NULL,
    key bytea NOT NULL,
    value bytea NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    byte_size bigint DEFAULT 0 NOT NULL,
    key_hash bigint NOT NULL
);


--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_cache_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_cache_entries_id_seq OWNED BY public.solid_cache_entries.id;


--
-- Name: solid_queue_blocked_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_blocked_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    concurrency_key character varying NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_blocked_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_blocked_executions_id_seq OWNED BY public.solid_queue_blocked_executions.id;


--
-- Name: solid_queue_claimed_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_claimed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    process_id bigint,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_claimed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_claimed_executions_id_seq OWNED BY public.solid_queue_claimed_executions.id;


--
-- Name: solid_queue_failed_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_failed_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    error text,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_failed_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_failed_executions_id_seq OWNED BY public.solid_queue_failed_executions.id;


--
-- Name: solid_queue_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_jobs (
    id bigint NOT NULL,
    queue_name character varying NOT NULL,
    class_name character varying NOT NULL,
    arguments text,
    priority integer DEFAULT 0 NOT NULL,
    active_job_id character varying,
    scheduled_at timestamp(6) without time zone,
    finished_at timestamp(6) without time zone,
    concurrency_key character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_jobs_id_seq OWNED BY public.solid_queue_jobs.id;


--
-- Name: solid_queue_pauses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_pauses (
    id bigint NOT NULL,
    queue_name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_pauses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_pauses_id_seq OWNED BY public.solid_queue_pauses.id;


--
-- Name: solid_queue_processes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_processes (
    id bigint NOT NULL,
    kind character varying NOT NULL,
    last_heartbeat_at timestamp(6) without time zone NOT NULL,
    supervisor_id bigint,
    pid integer NOT NULL,
    hostname character varying,
    metadata text,
    created_at timestamp(6) without time zone NOT NULL,
    name character varying NOT NULL
);


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_processes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_processes_id_seq OWNED BY public.solid_queue_processes.id;


--
-- Name: solid_queue_ready_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_ready_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_ready_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_ready_executions_id_seq OWNED BY public.solid_queue_ready_executions.id;


--
-- Name: solid_queue_recurring_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_recurring_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    task_key character varying NOT NULL,
    run_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_recurring_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_recurring_executions_id_seq OWNED BY public.solid_queue_recurring_executions.id;


--
-- Name: solid_queue_recurring_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_recurring_tasks (
    id bigint NOT NULL,
    key character varying NOT NULL,
    schedule character varying NOT NULL,
    command character varying(2048),
    class_name character varying,
    arguments text,
    queue_name character varying,
    priority integer DEFAULT 0,
    static boolean DEFAULT true NOT NULL,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_recurring_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_recurring_tasks_id_seq OWNED BY public.solid_queue_recurring_tasks.id;


--
-- Name: solid_queue_scheduled_executions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_scheduled_executions (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    queue_name character varying NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    scheduled_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_scheduled_executions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_scheduled_executions_id_seq OWNED BY public.solid_queue_scheduled_executions.id;


--
-- Name: solid_queue_semaphores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solid_queue_semaphores (
    id bigint NOT NULL,
    key character varying NOT NULL,
    value integer DEFAULT 1 NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.solid_queue_semaphores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.solid_queue_semaphores_id_seq OWNED BY public.solid_queue_semaphores.id;


--
-- Name: trackers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trackers (
    id bigint NOT NULL,
    date date,
    feed_time time without time zone,
    come_back_to_eat character varying,
    food_type character varying,
    brand character varying,
    description character varying,
    hungry character varying,
    amount numeric(5,2),
    left_amount numeric(5,2),
    love character varying,
    total_ate_amount numeric(5,2),
    frequency integer,
    result character varying,
    favorite_score integer DEFAULT 0,
    note character varying,
    weight numeric(4,2),
    pet_id integer NOT NULL,
    dry_food_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    archived_dry_food boolean DEFAULT false NOT NULL
);


--
-- Name: trackers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trackers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trackers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trackers_id_seq OWNED BY public.trackers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email_address character varying NOT NULL,
    password_digest character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    username character varying,
    timezone character varying,
    sign_in_count integer,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: connected_services id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_services ALTER COLUMN id SET DEFAULT nextval('public.connected_services_id_seq'::regclass);


--
-- Name: dry_foods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dry_foods ALTER COLUMN id SET DEFAULT nextval('public.dry_foods_id_seq'::regclass);


--
-- Name: health_checks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_checks ALTER COLUMN id SET DEFAULT nextval('public.health_checks_id_seq'::regclass);


--
-- Name: pets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pets ALTER COLUMN id SET DEFAULT nextval('public.pets_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: solid_cache_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_cache_entries ALTER COLUMN id SET DEFAULT nextval('public.solid_cache_entries_id_seq'::regclass);


--
-- Name: solid_queue_blocked_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_blocked_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_blocked_executions_id_seq'::regclass);


--
-- Name: solid_queue_claimed_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_claimed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_claimed_executions_id_seq'::regclass);


--
-- Name: solid_queue_failed_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_failed_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_failed_executions_id_seq'::regclass);


--
-- Name: solid_queue_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_jobs ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_jobs_id_seq'::regclass);


--
-- Name: solid_queue_pauses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_pauses ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_pauses_id_seq'::regclass);


--
-- Name: solid_queue_processes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_processes ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_processes_id_seq'::regclass);


--
-- Name: solid_queue_ready_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_ready_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_ready_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_executions_id_seq'::regclass);


--
-- Name: solid_queue_recurring_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_recurring_tasks_id_seq'::regclass);


--
-- Name: solid_queue_scheduled_executions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_scheduled_executions_id_seq'::regclass);


--
-- Name: solid_queue_semaphores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_semaphores ALTER COLUMN id SET DEFAULT nextval('public.solid_queue_semaphores_id_seq'::regclass);


--
-- Name: trackers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trackers ALTER COLUMN id SET DEFAULT nextval('public.trackers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
9	pet_avatar	Pet	2	9	2026-03-23 02:42:15.203857
10	image	ActiveStorage::VariantRecord	5	10	2026-03-23 02:42:16.738542
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
9	e8y39gn3heetfckvf7nn1bdyaga5	headshot.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	2353076	0hLe1K+o/rAiddN2TG4BkA==	2026-03-23 02:42:15.154297
10	376kr8rlzmvuew5ar29m7uh7u9tr	headshot.png	image/png	{"identified":true,"width":150,"height":150,"analyzed":true}	local	47404	0sg1WMxQ62E3g5k3ybcy7Q==	2026-03-23 02:42:16.728491
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
5	9	G0Vst4geCVOXNaQRJ+bGaGFNhTs=
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2026-02-04 13:41:38.774126	2026-02-04 13:41:38.77413
schema_sha1	af7f84e400389ad594fb72a49a2acb911b068d4e	2026-02-04 13:41:38.832617	2026-02-04 13:41:38.83262
\.


--
-- Data for Name: connected_services; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.connected_services (id, user_id, provider, uid, created_at, updated_at) FROM stdin;
3	3	google_oauth2	116145782996552963791	2026-02-11 02:17:31.927164	2026-02-11 02:17:31.927164
4	4	google_oauth2	108127620523185968326	2026-02-18 06:18:33.238304	2026-02-18 06:18:33.238304
5	5	google_oauth2	107752886497778648010	2026-03-25 11:05:03.201193	2026-03-25 11:05:03.201193
\.


--
-- Data for Name: dry_foods; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dry_foods (id, brand, food_type, description, amount, used_amount, average_used_amount, total_ate_amount, left_amount, days_remaining, user_id, created_at, updated_at) FROM stdin;
67	曙光	Kibble	無穀滋養鴨肉食譜	300.0	\N	44.98	179.9	120.1	2026-03-31	3	2026-03-23 10:18:19.826961	2026-03-23 10:18:19.826961
65	奧藍多	Kibble	天然無穀貓糧 雞肉+火雞肉+鴨肉	240.0	\N	20.07	60.2	179.8	2026-04-07	3	2026-03-22 01:18:54.774909	2026-03-28 01:05:20.058578
5	自由牌	Kibble	好吃的貓糧	30.0	\N	\N	\N	30.0	\N	4	2026-02-18 06:21:07.696006	2026-02-18 06:21:07.696006
6	自由牌	Freeze-Dried	好吃的貓糧	30.0	\N	\N	\N	30.0	\N	4	2026-02-18 06:24:57.568079	2026-02-18 06:24:57.568079
7	自由牌	Freeze-Dried	好吃的貓糧	10.0	\N	\N	\N	10.0	\N	4	2026-02-18 06:26:08.272895	2026-02-18 06:26:08.272895
69	原點	Kibble	雞肉無穀全貓配方	454.0	\N	20.0	20.0	434.0	2026-04-21	3	2026-03-31 02:29:42.370499	2026-03-31 02:29:42.370499
70	誠實貓	Freeze-Dried	雞肉凍乾	50.0	\N	5.5	5.5	44.5	2026-04-08	3	2026-03-31 02:37:15.280418	2026-03-31 02:37:15.280418
53	汪喵星球	Freeze-Dried	凍乾主食餐 低敏鴨肉餐	100.0	\N	10.1	50.5	49.5	2026-04-11	3	2026-03-07 12:53:27.575947	2026-03-30 01:11:41.966664
56	天然密碼	Kibble	無穀鴨肉&火雞肉 全齡貓配方	100.0	\N	25.4	50.8	49.2	2026-04-09	3	2026-03-09 17:36:06.85366	2026-04-04 02:25:17.326518
68	第一饗宴 FirstMate	Kibble	無穀低敏 鴨肉藍莓全貓配方	240.0	\N	36.83	147.3	92.7	2026-04-10	3	2026-03-30 02:15:21.233598	2026-03-30 02:15:21.233598
73	汪喵星球	Freeze-Dried	凍乾主食餐 安心雞肉	80.0	\N	10.15	20.3	59.7	2026-04-13	3	2026-04-02 10:10:43.144361	2026-04-02 10:10:43.144361
\.


--
-- Data for Name: health_checks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.health_checks (id, crea, bun, phos, ca, alb, chol, tp, alt, alkp, ggt, glu, tbil, amyl, lipa, na, k, cl, rbc, hct, hgb, mcv, mch, mchc, rdw, retic, retic_hgb, wbc, neu, lym, mono, eos, baso, plt, mpv, pct, osm_cal, pet_id, created_at, updated_at, exam_date, glob, fbnp, felv, fiv, fpl2) FROM stdin;
4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2026-04-03 14:41:25.716508	2026-04-03 14:55:22.706234	2024-07-06	\N	normal	negative	negative	\N
3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10.56	43.7	13.6	41.4	12.9	31.1	35.3	21.1	14.3	13.21	4.71	7.36	0.52	0.58	0.04	198	19.9	0.39	\N	2	2026-03-31 03:06:34.404499	2026-04-03 15:07:35.559521	2023-07-06	\N				\N
2	1.1	28.0	\N	\N	2.9	\N	6.9	60.0	59.0	\N	114.0	\N	\N	\N	\N	\N	\N	8.0	44.5	12.4	55.6	15.5	27.9	31.4	80.0	16.8	14.33	6.12	7.5	0.68	0.02	0.01	152	22.2	0.34	\N	2	2026-03-31 03:03:03.529771	2026-04-03 15:08:35.1601	2023-06-10	4.0				1.0
1	1.5	29.0	4.5	\N	3.3	\N	8.0	24.0	30.0	\N	127.0	\N	\N	\N	163.0	3.7	120.0	11.27	49.6	15.6	44.0	13.8	31.5	26.7	50.7	16.7	8.69	2.77	5.24	0.23	0.41	0.04	228	18.6	0.42	\N	2	2026-03-31 02:54:42.763869	2026-04-03 15:09:18.36171	2025-07-12	4.7	normal			\N
\.


--
-- Data for Name: pets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pets (id, petname, birthday, weight, gender, breed, user_id, created_at, updated_at) FROM stdin;
3	佩佩	2026-02-16 16:00:00	1.0	♂️ Male	白貓	4	2026-02-18 06:19:39.516645	2026-02-18 06:19:39.516645
4	BO BO	2024-07-24 00:00:00	5.0	♀️ Female	米克斯	5	2026-03-25 11:06:42.33964	2026-03-25 11:06:42.33964
2	Aji	2023-04-22 16:00:00	3.8	♂️ Male	Mixed	3	2026-02-11 02:18:21.856495	2026-03-31 02:59:43.881231
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schema_migrations (version) FROM stdin;
20260119090754
20260118132103
20260107121009
20260106040128
20260105033114
20260103112154
20251231035259
20251230122229
20251230122228
20260204141558
20260204144517
20260204150359
20260317120214
20260317134238
20260329133932
20260330031040
20260402142912
20260406154028
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sessions (id, user_id, ip_address, user_agent, created_at, updated_at) FROM stdin;
11	4	104.23.160.84	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36	2026-02-18 06:18:33.260439	2026-02-18 06:18:33.260439
14	3	172.68.175.88	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	2026-03-15 21:21:59.995205	2026-03-15 21:21:59.995205
15	5	172.68.174.70	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-25 11:05:03.248998	2026-03-25 11:05:03.248998
16	3	172.68.174.217	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-28 00:58:42.431374	2026-03-28 00:58:42.431374
\.


--
-- Data for Name: solid_cache_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_cache_entries (id, key, value, created_at, byte_size, key_hash) FROM stdin;
1	\\x70726f64756374696f6e3a726174652d6c696d69743a73657373696f6e733a3137322e37312e3135302e323431	\\x001101d730c98cfe60da41ffffffff04086906	2026-02-05 01:59:27.133433	204	2264359912904863575
2	\\x70726f64756374696f6e3a726174652d6c696d69743a73657373696f6e733a3137322e37312e3134362e323130	\\x00110178971ca3fe60da41ffffffff04086906	2026-02-05 02:00:56.434304	204	-5805364485162300577
3	\\x70726f64756374696f6e3a726174652d6c696d69743a73657373696f6e733a3137322e37312e3134362e323136	\\x001101984a9fa6fe60da41ffffffff04086906	2026-02-05 02:01:10.485531	204	-7099921606047322606
4	\\x70726f64756374696f6e3a726174652d6c696d69743a73657373696f6e733a3137322e37312e3134362e313033	\\x001101c8c093260261da41ffffffff04086906	2026-02-05 03:00:54.294955	204	5666268173984766962
5	\\x70726f64756374696f6e3a726174652d6c696d69743a73657373696f6e733a3137322e37312e3135302e3239	\\x001101a857c2ff1661da41ffffffff04086906	2026-02-05 08:54:43.024782	203	4712484835477830391
6	\\x70726f64756374696f6e3a726174652d6c696d69743a73657373696f6e733a3137322e37312e3135312e3632	\\x001101368a9d423061da41ffffffff04086906	2026-02-05 16:05:50.437779	203	-797593319879400901
\.


--
-- Data for Name: solid_queue_blocked_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_blocked_executions (id, job_id, queue_name, priority, concurrency_key, expires_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_claimed_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_claimed_executions (id, job_id, process_id, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_failed_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_failed_executions (id, job_id, error, created_at) FROM stdin;
1	5	{"exception_class":"SolidQueue::Processes::ProcessPrunedError","message":"Process was found dead and pruned (last heartbeat at: 2026-04-06 22:11:56 UTC)","backtrace":null}	2026-04-06 22:17:12.522861
\.


--
-- Data for Name: solid_queue_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_jobs (id, queue_name, class_name, arguments, priority, active_job_id, scheduled_at, finished_at, concurrency_key, created_at, updated_at) FROM stdin;
5	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"d52d8738-6a6a-495d-8f1e-f930685c86a2","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-06T22:12:00.028612530Z","scheduled_at":"2026-04-06T22:12:00.028403784Z"}	0	d52d8738-6a6a-495d-8f1e-f930685c86a2	2026-04-06 22:12:00.028403	\N	\N	2026-04-06 22:12:00.059874	2026-04-06 22:12:00.059874
9	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"6dc32f96-bec8-464e-a134-92420e2361e1","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T05:12:00.015673873Z","scheduled_at":"2026-04-07T05:12:00.015398997Z"}	0	6dc32f96-bec8-464e-a134-92420e2361e1	2026-04-07 05:12:00.015398	2026-04-07 05:12:00.807178	\N	2026-04-07 05:12:00.099824	2026-04-07 05:12:00.807178
10	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"306a5778-ed51-412d-8b41-229b9cd9cc67","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T06:12:00.011736675Z","scheduled_at":"2026-04-07T06:12:00.011689762Z"}	0	306a5778-ed51-412d-8b41-229b9cd9cc67	2026-04-07 06:12:00.011689	2026-04-07 06:12:00.454115	\N	2026-04-07 06:12:00.015013	2026-04-07 06:12:00.454115
11	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"6a4225da-a777-4bdd-a142-7eb431f48d59","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T07:12:00.003177360Z","scheduled_at":"2026-04-07T07:12:00.003146208Z"}	0	6a4225da-a777-4bdd-a142-7eb431f48d59	2026-04-07 07:12:00.003146	2026-04-07 07:12:00.394555	\N	2026-04-07 07:12:00.004116	2026-04-07 07:12:00.394555
12	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"44c3e2bf-54c1-4cc3-8d34-3aac585c7b85","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T08:12:00.016232178Z","scheduled_at":"2026-04-07T08:12:00.015897798Z"}	0	44c3e2bf-54c1-4cc3-8d34-3aac585c7b85	2026-04-07 08:12:00.015897	2026-04-07 08:12:00.675707	\N	2026-04-07 08:12:00.067095	2026-04-07 08:12:00.675707
13	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"80c46cf0-b6b6-47d7-840d-c4c9ff7a46e6","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["Rails.application.load_tasks; Rake::Task['notifications:weigh_pets'].invoke"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T09:00:00.047125775Z","scheduled_at":"2026-04-07T09:00:00.047061441Z"}	0	80c46cf0-b6b6-47d7-840d-c4c9ff7a46e6	2026-04-07 09:00:00.047061	2026-04-07 09:00:00.685994	\N	2026-04-07 09:00:00.04994	2026-04-07 09:00:00.685994
14	default	PetWeightReminderJob	{"job_class":"PetWeightReminderJob","job_id":"34edb700-b08d-4497-b303-23dd0cddbcdc","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://pet-tracker-v4/User/3"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T09:00:00.538926463Z","scheduled_at":"2026-04-07T09:00:00.538285594Z"}	0	34edb700-b08d-4497-b303-23dd0cddbcdc	2026-04-07 09:00:00.538285	2026-04-07 09:00:01.112417	\N	2026-04-07 09:00:00.542576	2026-04-07 09:00:01.112417
15	default	PetWeightReminderJob	{"job_class":"PetWeightReminderJob","job_id":"112e051f-a423-4c93-92bb-8cfe2c51bd46","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://pet-tracker-v4/User/4"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T09:00:00.639289356Z","scheduled_at":"2026-04-07T09:00:00.639173119Z"}	0	112e051f-a423-4c93-92bb-8cfe2c51bd46	2026-04-07 09:00:00.639173	2026-04-07 09:00:01.313456	\N	2026-04-07 09:00:00.639631	2026-04-07 09:00:01.313456
16	default	PetWeightReminderJob	{"job_class":"PetWeightReminderJob","job_id":"71a23fa3-0fed-47b6-947d-5a2d13c7e899","provider_job_id":null,"queue_name":"default","priority":null,"arguments":[{"_aj_globalid":"gid://pet-tracker-v4/User/5"}],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T09:00:00.670411114Z","scheduled_at":"2026-04-07T09:00:00.670311998Z"}	0	71a23fa3-0fed-47b6-947d-5a2d13c7e899	2026-04-07 09:00:00.670311	2026-04-07 09:00:01.400747	\N	2026-04-07 09:00:00.672373	2026-04-07 09:00:01.400747
17	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"7bb3a515-2e00-4750-bb63-f92641d45017","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T09:12:00.009818728Z","scheduled_at":"2026-04-07T09:12:00.009779386Z"}	0	7bb3a515-2e00-4750-bb63-f92641d45017	2026-04-07 09:12:00.009779	2026-04-07 09:12:00.418408	\N	2026-04-07 09:12:00.012211	2026-04-07 09:12:00.418408
18	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"515225bb-13e7-4021-b1e0-2d6b69949b1a","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T10:12:00.003859024Z","scheduled_at":"2026-04-07T10:12:00.003817282Z"}	0	515225bb-13e7-4021-b1e0-2d6b69949b1a	2026-04-07 10:12:00.003817	2026-04-07 10:12:00.461962	\N	2026-04-07 10:12:00.004976	2026-04-07 10:12:00.461962
19	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"3d6f16cb-7cfe-40e6-91b0-12c9268a6a62","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T11:12:00.003688554Z","scheduled_at":"2026-04-07T11:12:00.003640101Z"}	0	3d6f16cb-7cfe-40e6-91b0-12c9268a6a62	2026-04-07 11:12:00.00364	2026-04-07 11:12:00.429106	\N	2026-04-07 11:12:00.003983	2026-04-07 11:12:00.429106
20	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"dcfa1abc-23f7-4af4-9f61-d14c7f9e8c71","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T12:12:00.002688742Z","scheduled_at":"2026-04-07T12:12:00.002657450Z"}	0	dcfa1abc-23f7-4af4-9f61-d14c7f9e8c71	2026-04-07 12:12:00.002657	2026-04-07 12:12:00.400994	\N	2026-04-07 12:12:00.002969	2026-04-07 12:12:00.400994
21	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"97be04f5-59ae-46d8-9b53-4483c5d7b1d2","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T13:12:00.012065724Z","scheduled_at":"2026-04-07T13:12:00.011854008Z"}	0	97be04f5-59ae-46d8-9b53-4483c5d7b1d2	2026-04-07 13:12:00.011854	2026-04-07 13:12:00.754722	\N	2026-04-07 13:12:00.098914	2026-04-07 13:12:00.754722
22	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"48a67fe9-3b27-4fdf-8307-92793fba54f4","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T14:12:00.013816194Z","scheduled_at":"2026-04-07T14:12:00.013595142Z"}	0	48a67fe9-3b27-4fdf-8307-92793fba54f4	2026-04-07 14:12:00.013595	2026-04-07 14:12:00.812405	\N	2026-04-07 14:12:00.043864	2026-04-07 14:12:00.812405
23	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"0e8ea2b2-41f8-4a64-bea2-23c4c4514be3","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T15:12:00.005051834Z","scheduled_at":"2026-04-07T15:12:00.005012752Z"}	0	0e8ea2b2-41f8-4a64-bea2-23c4c4514be3	2026-04-07 15:12:00.005012	2026-04-07 15:12:00.408986	\N	2026-04-07 15:12:00.007855	2026-04-07 15:12:00.408986
24	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"e36707a1-210a-42ac-9d35-0c0ef874ee11","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T16:12:00.005083695Z","scheduled_at":"2026-04-07T16:12:00.005026211Z"}	0	e36707a1-210a-42ac-9d35-0c0ef874ee11	2026-04-07 16:12:00.005026	2026-04-07 16:12:00.391803	\N	2026-04-07 16:12:00.00595	2026-04-07 16:12:00.391803
25	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"d81fa5d9-119e-4f86-b0fb-5c3f3305debe","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T17:12:00.003161024Z","scheduled_at":"2026-04-07T17:12:00.003120212Z"}	0	d81fa5d9-119e-4f86-b0fb-5c3f3305debe	2026-04-07 17:12:00.00312	2026-04-07 17:12:00.735392	\N	2026-04-07 17:12:00.003427	2026-04-07 17:12:00.735392
26	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"1e673a96-b202-4e7b-acb1-d463a8be68fa","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T18:12:00.002643078Z","scheduled_at":"2026-04-07T18:12:00.002608846Z"}	0	1e673a96-b202-4e7b-acb1-d463a8be68fa	2026-04-07 18:12:00.002608	2026-04-07 18:12:00.703448	\N	2026-04-07 18:12:00.002895	2026-04-07 18:12:00.703448
27	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"52fad1c6-288d-43c5-a1d6-1d294d783e8f","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T19:12:00.002727971Z","scheduled_at":"2026-04-07T19:12:00.002682019Z"}	0	52fad1c6-288d-43c5-a1d6-1d294d783e8f	2026-04-07 19:12:00.002682	2026-04-07 19:12:00.36681	\N	2026-04-07 19:12:00.003021	2026-04-07 19:12:00.36681
28	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"ddfc4167-6298-4921-9aff-113ae03257ba","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T20:12:00.002818761Z","scheduled_at":"2026-04-07T20:12:00.002780839Z"}	0	ddfc4167-6298-4921-9aff-113ae03257ba	2026-04-07 20:12:00.00278	2026-04-07 20:12:00.704503	\N	2026-04-07 20:12:00.00307	2026-04-07 20:12:00.704503
29	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"7d88a4af-9cd0-4c51-928d-a3b668fde9ff","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T21:12:00.002809195Z","scheduled_at":"2026-04-07T21:12:00.002736451Z"}	0	7d88a4af-9cd0-4c51-928d-a3b668fde9ff	2026-04-07 21:12:00.002736	2026-04-07 21:12:00.668376	\N	2026-04-07 21:12:00.003098	2026-04-07 21:12:00.668376
30	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"4ad2da4d-30d5-482d-a25f-0d9d6c8865df","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T22:12:00.002575269Z","scheduled_at":"2026-04-07T22:12:00.002538807Z"}	0	4ad2da4d-30d5-482d-a25f-0d9d6c8865df	2026-04-07 22:12:00.002538	2026-04-07 22:12:00.349419	\N	2026-04-07 22:12:00.002849	2026-04-07 22:12:00.349419
31	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"8f4e84dd-b6c6-4260-a27e-9a14f7f7caea","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-07T23:12:00.002440236Z","scheduled_at":"2026-04-07T23:12:00.002400634Z"}	0	8f4e84dd-b6c6-4260-a27e-9a14f7f7caea	2026-04-07 23:12:00.0024	2026-04-07 23:12:00.361842	\N	2026-04-07 23:12:00.002709	2026-04-07 23:12:00.361842
32	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"52ad63c7-307d-4391-9c0a-7c7b5463cc4e","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-08T00:12:00.003415333Z","scheduled_at":"2026-04-08T00:12:00.003358550Z"}	0	52ad63c7-307d-4391-9c0a-7c7b5463cc4e	2026-04-08 00:12:00.003358	2026-04-08 00:12:00.684183	\N	2026-04-08 00:12:00.003704	2026-04-08 00:12:00.684183
33	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"fb31a4bd-1182-456e-a921-d24f79b43bf9","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-08T01:12:00.003097198Z","scheduled_at":"2026-04-08T01:12:00.003054335Z"}	0	fb31a4bd-1182-456e-a921-d24f79b43bf9	2026-04-08 01:12:00.003054	2026-04-08 01:12:00.689731	\N	2026-04-08 01:12:00.004887	2026-04-08 01:12:00.689731
34	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"8946af3b-5534-4085-845a-4840af9012bb","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-08T02:12:00.004268398Z","scheduled_at":"2026-04-08T02:12:00.004228806Z"}	0	8946af3b-5534-4085-845a-4840af9012bb	2026-04-08 02:12:00.004228	2026-04-08 02:12:00.732966	\N	2026-04-08 02:12:00.004531	2026-04-08 02:12:00.732966
35	solid_queue_recurring	SolidQueue::RecurringJob	{"job_class":"SolidQueue::RecurringJob","job_id":"4892d4d4-73d7-4dae-b098-9219de71aff3","provider_job_id":null,"queue_name":"solid_queue_recurring","priority":null,"arguments":["SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)"],"executions":0,"exception_executions":{},"locale":"en","timezone":"UTC","enqueued_at":"2026-04-08T03:12:00.006801045Z","scheduled_at":"2026-04-08T03:12:00.006726701Z"}	0	4892d4d4-73d7-4dae-b098-9219de71aff3	2026-04-08 03:12:00.006726	2026-04-08 03:12:00.356251	\N	2026-04-08 03:12:00.007091	2026-04-08 03:12:00.356251
\.


--
-- Data for Name: solid_queue_pauses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_pauses (id, queue_name, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_processes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_processes (id, kind, last_heartbeat_at, supervisor_id, pid, hostname, metadata, created_at, name) FROM stdin;
121	Supervisor(fork)	2026-04-08 03:20:46.810428	\N	1	srv-d7a6qiruibrs73dh6sog-5687bb7db9-b7jl4	\N	2026-04-07 13:24:40.3585	supervisor(fork)-020218b5134e559a3c07
122	Dispatcher	2026-04-08 03:20:47.47237	121	14	srv-d7a6qiruibrs73dh6sog-5687bb7db9-b7jl4	{"polling_interval":1,"batch_size":500,"concurrency_maintenance_interval":600}	2026-04-07 13:24:40.429255	dispatcher-3dd068d9baa822f6d8bf
124	Scheduler	2026-04-08 03:20:47.634344	121	25	srv-d7a6qiruibrs73dh6sog-5687bb7db9-b7jl4	{"recurring_schedule":["clear_solid_queue_finished_jobs","pet_weight_reminder"]}	2026-04-07 13:24:40.441135	scheduler-93a416c835fbe1dd1546
123	Worker	2026-04-08 03:20:48.702609	121	18	srv-d7a6qiruibrs73dh6sog-5687bb7db9-b7jl4	{"polling_interval":0.1,"queues":"*","thread_pool_size":3}	2026-04-07 13:24:40.435198	worker-5275673a7147a11e61be
\.


--
-- Data for Name: solid_queue_ready_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_ready_executions (id, job_id, queue_name, priority, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_recurring_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_recurring_executions (id, job_id, task_key, run_at, created_at) FROM stdin;
5	5	clear_solid_queue_finished_jobs	2026-04-06 22:12:00	2026-04-06 22:12:00.022137
9	9	clear_solid_queue_finished_jobs	2026-04-07 05:12:00	2026-04-07 05:12:00.022067
10	10	clear_solid_queue_finished_jobs	2026-04-07 06:12:00	2026-04-07 06:12:00.0246
11	11	clear_solid_queue_finished_jobs	2026-04-07 07:12:00	2026-04-07 07:12:00.010551
12	12	clear_solid_queue_finished_jobs	2026-04-07 08:12:00	2026-04-07 08:12:00.023136
13	13	pet_weight_reminder	2026-04-07 09:00:00	2026-04-07 09:00:00.057611
14	17	clear_solid_queue_finished_jobs	2026-04-07 09:12:00	2026-04-07 09:12:00.015798
15	18	clear_solid_queue_finished_jobs	2026-04-07 10:12:00	2026-04-07 10:12:00.009042
16	19	clear_solid_queue_finished_jobs	2026-04-07 11:12:00	2026-04-07 11:12:00.006734
17	20	clear_solid_queue_finished_jobs	2026-04-07 12:12:00	2026-04-07 12:12:00.004206
18	21	clear_solid_queue_finished_jobs	2026-04-07 13:12:00	2026-04-07 13:12:00.016099
19	22	clear_solid_queue_finished_jobs	2026-04-07 14:12:00	2026-04-07 14:12:00.019167
20	23	clear_solid_queue_finished_jobs	2026-04-07 15:12:00	2026-04-07 15:12:00.016313
21	24	clear_solid_queue_finished_jobs	2026-04-07 16:12:00	2026-04-07 16:12:00.010492
22	25	clear_solid_queue_finished_jobs	2026-04-07 17:12:00	2026-04-07 17:12:00.005735
23	26	clear_solid_queue_finished_jobs	2026-04-07 18:12:00	2026-04-07 18:12:00.002215
24	27	clear_solid_queue_finished_jobs	2026-04-07 19:12:00	2026-04-07 19:12:00.000391
25	28	clear_solid_queue_finished_jobs	2026-04-07 20:12:00	2026-04-07 20:12:00.001522
26	29	clear_solid_queue_finished_jobs	2026-04-07 21:12:00	2026-04-07 21:12:00.007044
27	30	clear_solid_queue_finished_jobs	2026-04-07 22:12:00	2026-04-07 22:12:00.008721
28	31	clear_solid_queue_finished_jobs	2026-04-07 23:12:00	2026-04-07 23:12:00.010793
29	32	clear_solid_queue_finished_jobs	2026-04-08 00:12:00	2026-04-08 00:12:00.008691
30	33	clear_solid_queue_finished_jobs	2026-04-08 01:12:00	2026-04-08 01:12:00.008793
31	34	clear_solid_queue_finished_jobs	2026-04-08 02:12:00	2026-04-08 02:12:00.011681
32	35	clear_solid_queue_finished_jobs	2026-04-08 03:12:00	2026-04-08 03:12:00.014617
\.


--
-- Data for Name: solid_queue_recurring_tasks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_recurring_tasks (id, key, schedule, command, class_name, arguments, queue_name, priority, static, description, created_at, updated_at) FROM stdin;
1	clear_solid_queue_finished_jobs	every hour at minute 12	SolidQueue::Job.clear_finished_in_batches(sleep_between_batches: 0.3)	\N	\N	\N	\N	t	\N	2026-04-06 16:06:35.7771	2026-04-06 16:06:35.7771
2	pet_weight_reminder	every day at 9am	Rails.application.load_tasks; Rake::Task['notifications:weigh_pets'].invoke	\N	\N	\N	\N	t	\N	2026-04-06 16:06:35.7771	2026-04-06 16:06:35.7771
\.


--
-- Data for Name: solid_queue_scheduled_executions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_scheduled_executions (id, job_id, queue_name, priority, scheduled_at, created_at) FROM stdin;
\.


--
-- Data for Name: solid_queue_semaphores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.solid_queue_semaphores (id, key, value, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: trackers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trackers (id, date, feed_time, come_back_to_eat, food_type, brand, description, hungry, amount, left_amount, love, total_ate_amount, frequency, result, favorite_score, note, weight, pet_id, dry_food_id, created_at, updated_at, archived_dry_food) FROM stdin;
523	2026-01-01	02:20:00	12:46, 15:30, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	38.40	🔺 So So	41.60	2	💖 - 🔺	27	6:35 叫	\N	2	\N	2026-02-23 13:47:07.375433	2026-03-11 08:09:44.600726	f
219	2026-02-22	12:45:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.20	10.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-22 12:45:56.572768	2026-02-23 14:28:06.487495	f
220	2026-02-22	12:47:00	23:44,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.00	🔺 So So	2.00	1	❌ - 🔺	15		\N	2	\N	2026-02-22 12:47:38.700935	2026-02-23 14:28:17.233859	f
221	2026-02-23	01:38:00	10:25, 11:12, 17:10, 18:55, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x3	💖 Yes, eat right away	105.00	33.70	💕 Love it So Much	71.30	4	💖 - 💕	41		\N	2	\N	2026-02-23 01:38:25.792872	2026-02-23 14:33:05.937932	f
525	2026-01-01	02:20:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.412563	2026-03-11 08:09:54.26981	f
816	2026-02-24	01:29:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	0.00	❌ No!!!	10.00	0	❌ - ❌	15		\N	2	\N	2026-02-24 01:29:49.657364	2026-02-24 13:08:14.701485	f
526	2026-01-01	02:20:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 gc2	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.416017	2026-03-11 08:10:01.955587	f
527	2026-01-01	02:20:00	15:28, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	3.90	3.30	🔺 So So	0.60	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.422335	2026-03-11 08:10:11.008979	f
529	2026-01-01	10:00:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g	💖 Yes, eat right away	20.00	5.30	❌ No!!!	14.70	0	💖 - ❌	18		\N	2	\N	2026-02-23 13:47:07.475218	2026-03-11 08:11:24.563817	f
524	2026-01-01	02:20:00	12:44, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	17.50	🔺 So So	2.90	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.406752	2026-03-11 08:10:20.413609	f
530	2026-01-01	10:00:00	18:51, 20:00, 22:41, 00:15, 3:46, 8:37,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	5.40	💕 Love it So Much	25.20	6	❌ - 💕	42		\N	2	\N	2026-02-23 13:47:07.478895	2026-03-11 08:10:29.711129	f
531	2026-01-01	10:00:00	18:52, 10:03,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.70	🔺 So So	6.30	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.48286	2026-03-11 08:10:37.817583	f
532	2026-01-01	10:00:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 gc2	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.486267	2026-03-11 08:10:49.244607	f
533	2026-01-01	10:00:00	1:29, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	3.30	0.00	🔺 So So	3.30	1	❌ - 🔺	22		\N	2	\N	2026-02-23 13:47:07.489378	2026-03-11 08:10:57.928858	f
534	2026-01-01	10:00:00	2:20, 3:46, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.50	0.00	🔺 So So	3.50	2	❌ - 🔺	24		\N	2	\N	2026-02-23 13:47:07.492568	2026-03-11 08:11:06.95373	f
528	2026-01-01	10:00:00	3:48, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	38.60	🔺 So So	41.40	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:07.426375	2026-03-11 08:11:14.613999	f
540	2026-01-02	10:50:00	20:18, 22:28, 5:11, 7:34, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	32.00	🔺 So So	48.00	4	💖 - 🔺	31		\N	2	\N	2026-02-23 13:47:07.517311	2026-03-11 08:13:23.816419	f
541	2026-01-02	10:50:00	18:48, 20:16, 22:27, 00:44, 1:50, 5:10, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	5.20	💕 Love it So Much	35.60	6	❌ - 💕	42		\N	2	\N	2026-02-23 13:47:07.520083	2026-03-11 08:13:34.624373	f
543	2026-01-02	10:50:00	19:24, 21:08, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.20	0.00	💕 Love it So Much	4.20	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:07.525336	2026-03-11 08:13:42.757775	f
535	2026-01-02	02:10:00	-	Wet	ciao	ic-351 貓用柴魚鮮味餐包- 鮪魚 x2	💖 Yes, eat right away	80.00	49.30	❌ No!!!	30.70	0	💖 - ❌	18	2:20 躁動，影響到睡覺/11:30 一直叫	\N	2	\N	2026-02-23 13:47:07.495367	2026-03-11 08:13:53.266332	f
536	2026-01-02	02:10:00	15:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	18.20	🔺 So So	2.20	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.502802	2026-03-11 08:14:02.090821	f
538	2026-01-02	03:50:00	14:25, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	5.20	🔺 So So	5.00	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.511433	2026-03-11 08:14:21.409276	f
539	2026-01-02	03:50:00	-	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.20	4.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.514701	2026-03-11 08:14:33.618168	f
537	2026-01-02	03:50:00	15:46, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	17.30	🔺 So So	47.70	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:07.507475	2026-03-11 08:14:45.088921	f
545	2026-01-03	02:35:00	12:49, 15:12, 16:51, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	7.60	🔺 So So	12.80	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.52959	2026-03-11 08:15:48.529786	f
546	2026-01-03	02:35:00	15:13, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	11.50	🔺 So So	3.50	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.531914	2026-03-11 08:15:58.749034	f
547	2026-01-03	02:35:00	17:44, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.40	0.00	💕 Love it So Much	2.40	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.533714	2026-03-11 08:16:07.134231	f
544	2026-01-03	02:35:00	12:50, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	31.20	🔺 So So	28.80	1	💖 - 🔺	25	3:45, 5:30, 7:30 有點躁動	\N	2	\N	2026-02-23 13:47:07.527457	2026-03-11 08:16:17.662911	f
551	2026-01-03	10:25:00	1:06, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.00	0.00	💕 Love it So Much	4.00	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.54273	2026-03-11 08:16:30.18339	f
549	2026-01-03	10:25:00	18:20, 19:41, 21:27, 23:25, 3:51, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	16.20	🔺 So So	24.60	5	❌ - 🔺	23		\N	2	\N	2026-02-23 13:47:07.538561	2026-03-11 08:16:44.064516	f
550	2026-01-03	10:25:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	11.50	11.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.540672	2026-03-11 08:16:54.410477	f
548	2026-01-03	10:25:00	19:42, 21:28, 3:53, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	23.20	💕 Love it So Much	56.80	3	💖 - 💕	39		\N	2	\N	2026-02-23 13:47:07.536233	2026-03-11 08:17:14.297044	f
553	2026-01-04	00:24:00	13:33, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.60	16.00	🔺 So So	4.60	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.551677	2026-03-11 08:18:13.298146	f
552	2026-01-04	00:24:00	13:34, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	38.40	🔺 So So	21.60	1	💖 - 🔺	25	00:45 陪玩約15分鐘後, 凌晨沒被吵醒	\N	2	\N	2026-02-23 13:47:07.54645	2026-03-11 08:18:48.586958	f
38	2026-02-01	01:33:00	-	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	52.20	❌ No!!!	27.80	0	💖 - ❌	18	\N	\N	2	\N	2026-02-12 14:41:09.783999	2026-02-12 14:41:09.783999	f
39	2026-02-01	01:33:00	11:31, 17:53, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.60	24.90	🔺 So So	12.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-02-12 14:41:09.815009	2026-02-12 14:41:09.815009	f
40	2026-02-01	01:33:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:09.851651	2026-02-12 14:41:09.851651	f
41	2026-02-01	07:25:00	15:25, 17:54, 	Kibble	曙光 	無穀滋養鴨肉食譜	💖 Yes, eat right away	24.90	19.50	🔺 So So	5.40	2	💖 - 🔺	27	\N	\N	2	\N	2026-02-12 14:41:09.864066	2026-02-12 14:41:09.864066	f
42	2026-02-01	11:30:00	20:53, 22:08, 1:35, 4:22, 9:16	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	18.60	💕 Love it So Much	86.40	5	💖 - 💕	50	\N	\N	2	\N	2026-02-12 14:41:09.874672	2026-02-12 14:41:09.874672	f
43	2026-02-01	11:30:00	20:51, 22:07, 1:34, 4:19	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	26.10	🔺 So So	11.30	4	❌ - 🔺	21	\N	\N	2	\N	2026-02-12 14:41:09.886668	2026-02-12 14:41:09.886668	f
44	2026-02-01	11:30:00	00:01, 9:14, 	Kibble	曙光 	無穀滋養鴨肉食譜	❌ No, not interested	25.20	17.80	🔺 So So	7.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-02-12 14:41:09.898937	2026-02-12 14:41:09.898937	f
45	2026-02-02	01:18:00	10:13, 12:05, 18:38, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	32.50	💕 Love it So Much	47.50	3	💖 - 💕	39	00:00-2:00 躁動	\N	2	\N	2026-02-12 14:41:09.907141	2026-02-12 14:41:09.907141	f
46	2026-02-02	01:18:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.60	37.60	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:09.917489	2026-02-12 14:41:09.917489	f
47	2026-02-02	01:18:00	12:04, 13:06, 16:16, 18:37, 	Kibble	曙光 	無穀滋養鴨肉食譜	❌ No, not interested	25.20	16.80	💕 Love it So Much	8.40	4	❌ - 💕	31	\N	\N	2	\N	2026-02-12 14:41:09.925452	2026-02-12 14:41:09.925452	f
48	2026-02-02	01:18:00	10:11, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.00	🔺 So So	4.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:09.934693	2026-02-12 14:41:09.934693	f
49	2026-02-02	01:18:00	16:16,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) - 冰過	❌ No, not interested	30.00	10.30	💕 Love it So Much	19.70	1	❌ - 💕	25	\N	\N	2	\N	2026-02-12 14:41:09.941076	2026-02-12 14:41:09.941076	f
50	2026-02-02	12:11:00	22:19, 2:11, 5:22, 9:22, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.60	25.90	🔺 So So	11.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-02-12 14:41:09.949396	2026-02-12 14:41:09.949396	f
51	2026-02-02	12:11:00	21:18, 00:33, 5:20, 	Kibble	曙光 	無穀滋養鴨肉食譜	❌ No, not interested	25.20	15.50	🔺 So So	9.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-02-12 14:41:09.964119	2026-02-12 14:41:09.964119	f
52	2026-02-02	12:11:00	22:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	7.90	🔺 So So	2.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:09.976347	2026-02-12 14:41:09.976347	f
53	2026-02-02	12:11:00	21:20, 00:37, 2:13,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	32.80	💕 Love it So Much	72.20	3	💖 - 💕	39	興奮的聲音然後快速奔跑	\N	2	\N	2026-02-12 14:41:09.984349	2026-02-12 14:41:09.984349	f
54	2026-02-03	01:30:00	10:27, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	84.90	61.30	🔺 So So	23.60	1	💖 - 🔺	25	00:00-1:30 有點躁動 \n7:30要咬人	\N	2	\N	2026-02-12 14:41:09.991633	2026-02-12 14:41:09.991633	f
55	2026-02-03	01:30:00	12:25, 13:43, 14:26, 16:58, 19:02,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	24.40	🔺 So So	13.00	5	❌ - 🔺	23	誠實貓雞塊	\N	2	\N	2026-02-12 14:41:09.999738	2026-02-12 14:41:09.999738	f
56	2026-02-03	01:30:00	-	Kibble	曙光 	無穀滋養鴨肉食譜	❌ No, not interested	25.20	25.20	❌ No!!!	0.00	0	❌ - ❌	8	誠實貓雞塊	\N	2	\N	2026-02-12 14:41:10.006249	2026-02-12 14:41:10.006249	f
57	2026-02-03	01:30:00	10:26, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.60	🔺 So So	1.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.014257	2026-02-12 14:41:10.014257	f
58	2026-02-03	01:30:00	-	Kibble	超躍	田園雞肉+牛肉	❌ No, not interested	20.60	20.60	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:10.02504	2026-02-12 14:41:10.02504	f
59	2026-02-03	02:45:00	11:42, 12:26, 16:59, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	16.90	💕 Love it So Much	53.10	3	💖 - 💕	46	\N	\N	2	\N	2026-02-12 14:41:10.033024	2026-02-12 14:41:10.033024	f
60	2026-02-03	11:30:00	20:53, 21:27, 22:30, 1:18, 4:55, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.70	20.30	🔺 So So	17.40	5	❌ - 🔺	23	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.040119	2026-02-12 14:41:10.040119	f
61	2026-02-03	11:30:00	-	Kibble	曙光 	無穀滋養鴨肉食譜	❌ No, not interested	25.20	25.20	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:10.04935	2026-02-12 14:41:10.04935	f
62	2026-02-03	11:30:00	22:53, 1:20	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	20.00	1.70	💕 Love it So Much	18.30	2	❌ - 💕	34	23:10 補10g	\N	2	\N	2026-02-12 14:41:10.058746	2026-02-12 14:41:10.058746	f
63	2026-02-03	11:30:00	20:55, 21:29, 22:32, 4:57, 	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154 x2	💖 Yes, eat right away	130.00	71.20	🔺 So So	58.80	4	💖 - 🔺	31	22:35, 23:00 吐	\N	2	\N	2026-02-12 14:41:10.064684	2026-02-12 14:41:10.064684	f
65	2026-02-04	00:52:00	12:21, 13:52, 17:00, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	19.50	🔺 So So	17.90	3	❌ - 🔺	19	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.081679	2026-02-12 14:41:10.081679	f
66	2026-02-04	00:52:00	-	Kibble	曙光 	無穀滋養鴨肉食譜	❌ No, not interested	25.30	25.30	❌ No!!!	0.00	0	❌ - ❌	8	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.088747	2026-02-12 14:41:10.088747	f
67	2026-02-04	00:52:00	20:25,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.80	🔺 So So	1.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.097075	2026-02-12 14:41:10.097075	f
69	2026-02-04	12:30:00	21:44, 2:08, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	18.60	🔺 So So	18.80	2	❌ - 🔺	17	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.113535	2026-02-12 14:41:10.113535	f
70	2026-02-04	12:30:00	23:30,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.30	22.50	🔺 So So	2.80	1	❌ - 🔺	15	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.12107	2026-02-12 14:41:10.12107	f
71	2026-02-04	12:30:00	6:08,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	4.20	🔺 So So	6.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.130693	2026-02-12 14:41:10.130693	f
64	2026-02-04	00:52:00	-	Wet	ciao 	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	62.10	❌ No!!!	17.90	0	💖 - ❌	18	5:52 咬人	\N	2	\N	2026-02-12 14:41:10.071899	2026-02-28 07:44:20.642171	f
554	2026-01-04	00:24:00	9:24, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.10	11.30	🔺 So So	3.80	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.553613	2026-03-11 08:18:25.028583	f
73	2026-02-05	01:00:00	-	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	65.20	❌ No!!!	19.80	0	🔺 - ❌	13	6:06 要咬人\n10:00 很躁動, 放IMC-222後狂吃, 但還是很躁動一直叫	\N	2	\N	2026-02-12 14:41:10.172234	2026-02-12 14:41:10.172234	f
74	2026-02-05	01:00:00	20:43, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	35.60	🔺 So So	1.90	1	❌ - 🔺	15	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.182408	2026-02-12 14:41:10.182408	f
75	2026-02-05	01:00:00	14:54, 17:14, 19:44, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.00	20.00	🔺 So So	5.00	3	❌ - 🔺	19	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.191351	2026-02-12 14:41:10.191351	f
76	2026-02-05	01:00:00	12:34,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	7.40	🔺 So So	2.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.198521	2026-02-12 14:41:10.198521	f
77	2026-02-05	02:40:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	🔺 No, not really. Ate A Little	70.00	43.60	❌ No!!!	26.40	0	🔺 - ❌	13	\N	\N	2	\N	2026-02-12 14:41:10.20772	2026-02-12 14:41:10.20772	f
78	2026-02-05	07:00:00	-	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	🔺 No, not really. Ate A Little	75.00	61.40	❌ No!!!	13.60	0	🔺 - ❌	13	\N	\N	2	\N	2026-02-12 14:41:10.217831	2026-02-12 14:41:10.217831	f
79	2026-02-05	09:30:00	17:57, 19:46, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	32.30	💕 Love it So Much	37.70	2	💖 - 💕	37	\N	\N	2	\N	2026-02-12 14:41:10.22749	2026-02-12 14:41:10.22749	f
80	2026-02-05	12:45:00	22:11, 1:49, 4:14, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	20.60	🔺 So So	16.90	3	❌ - 🔺	19	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.23569	2026-02-12 14:41:10.23569	f
81	2026-02-05	12:45:00	23:53,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.10	22.40	🔺 So So	2.70	1	❌ - 🔺	15	誠實貓 鴨肉	\N	2	\N	2026-02-12 14:41:10.243431	2026-02-12 14:41:10.243431	f
82	2026-02-05	12:45:00	23:54, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	7.70	🔺 So So	2.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.252527	2026-02-12 14:41:10.252527	f
83	2026-02-05	12:45:00	22:12, 1:51, 4:16, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	44.20	🔺 So So	60.80	3	💖 - 🔺	29	23:15 陪玩約30分鐘	\N	2	\N	2026-02-12 14:41:10.261177	2026-02-12 14:41:10.261177	f
84	2026-02-06	01:20:00	-	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	46.10	❌ No!!!	33.90	0	💖 - ❌	18	5:30 有點躁動	\N	2	\N	2026-02-12 14:41:10.269487	2026-02-12 14:41:10.269487	f
85	2026-02-06	01:20:00	15:44, 19:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	24.20	🔺 So So	5.80	2	❌ - 🔺	17	誠實貓 鴨肉 改換汪喵 鴨肉\n最後凍乾另外放, 額外紀錄	\N	2	\N	2026-02-12 14:41:10.279299	2026-02-12 14:41:10.279299	f
86	2026-02-06	01:20:00	19:55, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.20	18.60	🔺 So So	1.60	1	❌ - 🔺	15	誠實貓 鴨肉 改換汪喵 鴨肉\n最後凍乾另外放, 額外紀錄	\N	2	\N	2026-02-12 14:41:10.290605	2026-02-12 14:41:10.290605	f
87	2026-02-06	01:20:00	12:12, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	7.40	🔺 So So	2.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.297806	2026-02-12 14:41:10.297806	f
88	2026-02-06	04:00:00	15:45, 19:20, 19:56, 	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	💖 Yes, eat right away	60.00	16.90	💕 Love it So Much	43.10	3	💖 - 💕	39	\N	\N	2	\N	2026-02-12 14:41:10.305892	2026-02-12 14:41:10.305892	f
89	2026-02-06	13:08:00	22:08, 2:21,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	21.70	🔺 So So	8.30	2	❌ - 🔺	17	誠實貓 鴨肉 改換汪喵 鴨肉\n最後凍乾另外放, 額外紀錄	\N	2	\N	2026-02-12 14:41:10.314145	2026-02-12 14:41:10.314145	f
90	2026-02-06	13:08:00	21:07, 2:20, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	14.30	🔺 So So	5.70	2	❌ - 🔺	17	誠實貓 鴨肉 改換汪喵 鴨肉\n最後凍乾另外放, 額外紀錄	\N	2	\N	2026-02-12 14:41:10.320905	2026-02-12 14:41:10.320905	f
91	2026-02-06	13:08:00	23:53, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.60	🔺 So So	6.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.338816	2026-02-12 14:41:10.338816	f
92	2026-02-06	13:08:00	3:57, 	Freeze-Dried	誠實貓 	鴨肉凍乾	❌ No, not interested	4.90	0.00	💕 Love it So Much	4.90	1	❌ - 💕	32	\N	\N	2	\N	2026-02-12 14:41:10.349899	2026-02-12 14:41:10.349899	f
93	2026-02-06	13:08:00	22:09, 23:55, 2:22, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	28.20	💕 Love it So Much	51.80	3	💖 - 💕	39	\N	\N	2	\N	2026-02-12 14:41:10.357658	2026-02-12 14:41:10.357658	f
94	2026-02-07	00:45:00	9:35, 13;28, 16:56,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	25.80	💕 Love it So Much	79.20	3	💖 - 💕	46	\N	\N	2	\N	2026-02-12 14:41:10.370875	2026-02-12 14:41:10.370875	f
95	2026-02-07	00:45:00	13:26,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	14.40	🔺 So So	5.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.379997	2026-02-12 14:41:10.379997	f
96	2026-02-07	00:45:00	13:27, 16:54,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	15.10	🔺 So So	4.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-02-12 14:41:10.390612	2026-02-12 14:41:10.390612	f
97	2026-02-07	00:45:00	9:34, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	9.80	3.90	🔺 So So	5.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.403198	2026-02-12 14:41:10.403198	f
98	2026-02-07	00:45:00	-	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.70	4.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:10.413648	2026-02-12 14:41:10.413648	f
99	2026-02-07	12:00:00	-	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	🔺 No, not really. Ate A Little	80.00	73.40	❌ No!!!	6.60	0	🔺 - ❌	13	\N	\N	2	\N	2026-02-12 14:41:10.419492	2026-02-12 14:41:10.419492	f
100	2026-02-07	12:00:00	1:53,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	10.20	🔺 So So	10.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.429035	2026-02-12 14:41:10.429035	f
101	2026-02-07	12:00:00	00:41,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	18.70	🔺 So So	1.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.440915	2026-02-12 14:41:10.440915	f
102	2026-02-07	12:00:00	21:16, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	7.00	🔺 So So	3.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.447598	2026-02-12 14:41:10.447598	f
103	2026-02-07	12:00:00	5:31	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.70	4.40	🔺 So So	0.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.473524	2026-02-12 14:41:10.473524	f
104	2026-02-07	12:00:00	5:50, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.40	17.00	🔺 So So	3.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.482017	2026-02-12 14:41:10.482017	f
105	2026-02-07	12:56:00	21:15, 00:42, 1:55,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	41.90	💕 Love it So Much	63.10	3	💖 - 💕	39	\N	\N	2	\N	2026-02-12 14:41:10.492574	2026-02-12 14:41:10.492574	f
106	2026-02-08	01:30:00	13:52, 17:40, 20:21, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	58.60	💕 Love it So Much	71.40	3	💖 - 💕	39	\N	\N	2	\N	2026-02-12 14:41:10.502852	2026-02-12 14:41:10.502852	f
107	2026-02-08	01:30:00	13:50, 20:19, 20:58, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	11.20	🔺 So So	13.80	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-02-12 14:41:10.512564	2026-02-12 14:41:10.512564	f
108	2026-02-08	01:30:00	10:28, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.40	7.30	🔺 So So	3.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.521418	2026-02-12 14:41:10.521418	f
109	2026-02-08	01:30:00	17:39, 20:57, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.60	16.10	🔺 So So	4.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-02-12 14:41:10.532971	2026-02-12 14:41:10.532971	f
110	2026-02-08	12:58:00	22:09, 1:49,	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	29.60	💕 Love it So Much	50.40	2	💖 - 💕	37	\N	\N	2	\N	2026-02-12 14:41:10.540102	2026-02-12 14:41:10.540102	f
111	2026-02-08	12:58:00	22:06, 23:12, 1:47, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	11.40	🔺 So So	13.90	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-02-12 14:41:10.54787	2026-02-12 14:41:10.54787	f
112	2026-02-08	12:58:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	10.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:10.559577	2026-02-12 14:41:10.559577	f
113	2026-02-08	12:58:00	22:06, 6:39, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	17.20	🔺 So So	2.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-02-12 14:41:10.571965	2026-02-12 14:41:10.571965	f
114	2026-02-09	01:55:00	-	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	🔺 No, not really. Ate A Little	60.00	45.20	❌ No!!!	14.80	0	🔺 - ❌	13	21:20 陪玩約15分鐘	\N	2	\N	2026-02-12 14:41:10.583853	2026-02-12 14:41:10.583853	f
115	2026-02-09	01:55:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:10.595666	2026-02-12 14:41:10.595666	f
116	2026-02-09	01:55:00	15:03, 16:34,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	14.30	🔺 So So	10.90	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-02-12 14:41:10.608033	2026-02-12 14:41:10.608033	f
117	2026-02-09	01:55:00	10:42, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	5.90	🔺 So So	4.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.631449	2026-02-12 14:41:10.631449	f
118	2026-02-09	01:55:00	18:44,	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.20	17.30	🔺 So So	2.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.647635	2026-02-12 14:41:10.647635	f
119	2026-02-09	02:30:00	-	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	🔺 No, not really. Ate A Little	60.00	54.70	❌ No!!!	5.30	0	🔺 - ❌	13	\N	\N	2	\N	2026-02-12 14:41:10.654676	2026-02-12 14:41:10.654676	f
120	2026-02-09	04:10:00	16:35, 18:45, 19:38, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	21.60	💕 Love it So Much	48.40	3	💖 - 💕	39	\N	\N	2	\N	2026-02-12 14:41:10.665451	2026-02-12 14:41:10.665451	f
121	2026-02-09	13:10:00	-	Wet	ciao 	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	🔺 No, not really. Ate A Little	80.00	72.00	❌ No!!!	8.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-02-12 14:41:10.671104	2026-02-12 14:41:10.671104	f
122	2026-02-09	13:10:00	22:32, 00:07, 1:45, 5:28,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	13.70	🔺 So So	11.40	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-02-12 14:41:10.676522	2026-02-12 14:41:10.676522	f
123	2026-02-09	13:10:00	21:35, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	5.70	🔺 So So	4.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.682073	2026-02-12 14:41:10.682073	f
124	2026-02-09	13:10:00	22:30, 1:44, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.30	15.50	🔺 So So	4.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-02-12 14:41:10.687456	2026-02-12 14:41:10.687456	f
125	2026-02-09	13:43:00	22:32, 00:09, 5:30,	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	79.80	🔺 So So	50.20	3	💖 - 🔺	29	\N	\N	2	\N	2026-02-12 14:41:10.695654	2026-02-12 14:41:10.695654	f
127	2026-02-10	01:15:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	🔺 No, not really. Ate A Little	35.00	25.50	❌ No!!!	9.50	0	🔺 - ❌	13	\N	\N	2	\N	2026-02-12 14:41:10.708904	2026-02-12 14:41:10.708904	f
128	2026-02-10	01:15:00	11:15, 16:50, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.40	16.10	🔺 So So	8.30	2	❌ - 🔺	17	加汪喵 櫻桃鴨 4.1g	\N	2	\N	2026-02-12 14:41:10.715928	2026-02-12 14:41:10.715928	f
129	2026-02-10	01:15:00	14:00, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.40	6.10	🔺 So So	4.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.726259	2026-02-12 14:41:10.726259	f
130	2026-02-10	01:15:00	19:24, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	18.20	🔺 So So	1.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.731733	2026-02-12 14:41:10.731733	f
131	2026-02-10	02:30:00	11:16, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	🔺 No, not really. Ate A Little	70.00	59.40	🔺 So So	10.60	1	🔺 - 🔺	20	\N	\N	2	\N	2026-02-12 14:41:10.737376	2026-02-12 14:41:10.737376	f
132	2026-02-10	07:16:00	16:51, 	Wet	ciao	imc-224 雙喵杯 鮪魚+雞肉+柴魚片 x2	🔺 No, not really. Ate A Little	70.00	52.80	🔺 So So	17.20	1	🔺 - 🔺	20	\N	\N	2	\N	2026-02-12 14:41:10.742587	2026-02-12 14:41:10.742587	f
133	2026-02-10	10:20:00	19:25, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	7.10	💕 Love it So Much	27.90	1	💖 - 💕	42	\N	\N	2	\N	2026-02-12 14:41:10.750566	2026-02-12 14:41:10.750566	f
134	2026-02-10	12:50:00	23:00, 1:26, 5:44, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) x2	💖 Yes, eat right away	120.00	66.70	💕 Love it So Much	53.30	3	💖 - 💕	39	23:41 陪玩約20分鐘	\N	2	\N	2026-02-12 14:41:10.757496	2026-02-12 14:41:10.757496	f
135	2026-02-10	12:50:00	20:17, 22:58, 1:25, 5:27, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	6.70	🔺 So So	18.50	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-02-12 14:41:10.764356	2026-02-12 14:41:10.764356	f
136	2026-02-10	12:50:00	1:04, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	4.60	🔺 So So	5.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.771349	2026-02-12 14:41:10.771349	f
137	2026-02-10	12:50:00	3:36, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	18.00	🔺 So So	2.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.778118	2026-02-12 14:41:10.778118	f
138	2026-02-11	01:10:00	-	Wet	ciao	純粹餐包鮪魚雞肉扇貝 ic-571	❌ No, not interested	30.00	30.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:10.785973	2026-02-12 14:41:10.785973	f
139	2026-02-11	01:10:00	13:03, 15:37, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	20.00	💕 Love it So Much	45.00	2	💖 - 💕	37	\N	\N	2	\N	2026-02-12 14:41:10.793492	2026-02-12 14:41:10.793492	f
140	2026-02-11	01:10:00	10:11, 13:02, 15:35, 17:18, 19:28, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	5.80	💕 Love it So Much	19.60	5	❌ - 💕	40	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-02-12 14:41:10.800411	2026-02-12 14:41:10.800411	f
141	2026-02-11	01:10:00	9:35, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	6.70	🔺 So So	3.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.814995	2026-02-12 14:41:10.814995	f
142	2026-02-11	01:10:00	19:17, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.50	7.80	🔺 So So	2.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.833111	2026-02-12 14:41:10.833111	f
143	2026-02-11	09:22:00	19:28, 	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚	💖 Yes, eat right away	35.00	14.80	💕 Love it So Much	20.20	1	💖 - 💕	35	\N	\N	2	\N	2026-02-12 14:41:10.841261	2026-02-12 14:41:10.841261	f
144	2026-02-11	12:30:00	22:13, 1:26, 3:26, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	26.80	💕 Love it So Much	53.20	3	💖 - 💕	39	\N	\N	2	\N	2026-02-12 14:41:10.849527	2026-02-12 14:41:10.849527	f
145	2026-02-11	12:30:00	20:26, 21:07, 22:12, 1:23, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	6.10	💕 Love it So Much	19.00	4	❌ - 💕	38	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-02-12 14:41:10.857868	2026-02-12 14:41:10.857868	f
146	2026-02-11	12:30:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	10.20	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-02-12 14:41:10.867781	2026-02-12 14:41:10.867781	f
147	2026-02-11	12:30:00	3:24, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.50	5.70	🔺 So So	4.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-02-12 14:41:10.885175	2026-02-12 14:41:10.885175	f
148	2026-02-12	00:45:00	-	Wet	mon petit 貓倍麗	鮪魚蟹肉銀魚極品鮮湯 sp1	💖 Yes, eat right away	40.00	25.80	❌ No!!!	14.20	0	💖 - ❌	18	\N	\N	2	\N	2026-02-12 14:41:10.893179	2026-02-12 14:41:10.893179	f
150	2026-02-12	00:45:00	-	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	❌ No, not interested	65.00	65.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-12 14:41:10.918056	2026-02-12 14:42:04.441775	f
151	2026-02-12	00:45:00	10:01, 13:37, 16:26, 19:21, 19:55, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	2.90	💕 Love it So Much	22.30	5	❌ - 💕	40	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-02-12 14:41:10.926531	2026-02-12 14:42:24.372922	f
153	2026-02-12	00:45:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.50	10.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-12 14:41:10.951156	2026-02-12 14:42:44.982509	f
152	2026-02-12	00:45:00	9:18,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.50	9.20	🔺 So So	1.30	1	❌ - 🔺	15		\N	2	\N	2026-02-12 14:41:10.937945	2026-02-12 14:43:01.115964	f
154	2026-02-12	12:15:00	21:42, 7:58, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	65.90	🔺 So So	39.10	2	💖 - 🔺	27		\N	2	\N	2026-02-12 14:41:10.962817	2026-02-13 05:09:11.036916	f
155	2026-02-12	12:15:00	21:41, 1:14, 2:28, 7:57, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	12.10	🔺 So So	25.40	4	❌ - 🔺	21	加汪喵 櫻桃鴨 7.5g	\N	2	\N	2026-02-12 14:41:10.970226	2026-02-13 05:09:46.332411	f
156	2026-02-12	12:15:00	00:21,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.10	🔺 So So	6.90	1	❌ - 🔺	15		\N	2	\N	2026-02-12 14:41:10.978622	2026-02-13 05:11:02.235244	f
157	2026-02-12	12:15:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.50	10.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-12 14:41:10.993558	2026-02-13 05:11:27.717403	f
161	2026-02-13	00:50:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-13 08:34:46.133235	2026-02-23 14:22:04.684281	f
160	2026-02-13	00:50:00	13:03, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	7.80	🔺 So So	2.20	1	❌ - 🔺	15		\N	2	\N	2026-02-13 08:34:26.636021	2026-02-23 14:22:16.408516	f
166	2026-02-13	12:12:00	1:00, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.00	6.50	🔺 So So	3.50	1	❌ - 🔺	15		\N	2	\N	2026-02-13 12:13:00.189787	2026-02-23 14:22:26.781222	f
163	2026-02-13	02:30:00	18:30	Wet	ciao	布丁杯 雞肉 imc-153	🔺 No, not really. Ate A Little	65.00	46.60	🔺 So So	18.40	1	🔺 - 🔺	20		\N	2	\N	2026-02-13 08:37:55.477856	2026-02-13 11:28:24.829383	f
167	2026-02-13	12:15:00	00:06, 2:55, 5:49,	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	23.20	💕 Love it So Much	56.80	3	💖 - 💕	39		\N	2	\N	2026-02-13 12:19:15.208098	2026-02-14 01:23:56.144066	f
172	2026-02-14	02:21:00	11:56, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	🔺 No, not really. Ate A Little	70.00	57.80	🔺 So So	12.20	1	🔺 - 🔺	20	14:00送均禾貓旅	\N	2	\N	2026-02-14 08:42:04.020162	2026-02-14 12:05:30.657874	f
165	2026-02-13	12:12:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-13 12:12:35.717537	2026-02-23 14:22:36.095259	f
162	2026-02-13	00:50:00	9:27, 14:21, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	51.60	🔺 So So	33.40	2	💖 - 🔺	27		\N	2	\N	2026-02-13 08:35:40.082034	2026-02-13 11:30:12.506579	f
168	2026-02-13	15:02:00	5:51, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	❌ No, not interested	70.00	50.00	🔺 So So	20.00	1	❌ - 🔺	15	一直叫, 感覺很躁動	\N	2	\N	2026-02-13 15:37:54.007117	2026-02-23 14:22:44.575225	f
170	2026-02-14	01:25:00	11:55, 21:32, 00:13, 1:56, 4:34,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	12.20	🔺 So So	13.00	5	❌ - 🔺	23	加汪喵 櫻桃鴨 4.9g/14:00送均禾貓旅	\N	2	\N	2026-02-14 01:26:38.301757	2026-02-23 14:23:01.166243	f
171	2026-02-14	01:27:00	10:15, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.70	🔺 So So	1.30	1	❌ - 🔺	15	14:00送均禾貓旅	\N	2	\N	2026-02-14 01:28:09.488408	2026-02-23 14:23:10.442331	f
173	2026-02-14	09:45:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	12.00	🔺 So So	13.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-02-19 03:47:03.519174	2026-02-23 14:23:18.631645	f
175	2026-02-15	09:45:00	19:46, 23:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	35.00	16.00	🔺 So So	19.00	2	❌ - 🔺	17	均禾貓旅住宿/ 20g天然密碼+10g法米納+5g汪喵櫻桃鴨凍乾	\N	2	\N	2026-02-19 03:50:27.783651	2026-02-23 14:23:46.263059	f
149	2026-02-12	00:45:00	13:39, 19:56, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	39.80	🔺 So So	40.20	2	💖 - 🔺	27		\N	2	\N	2026-02-12 14:41:10.905432	2026-02-28 07:44:07.261768	f
164	2026-02-13	12:09:00	20:09, 00:05, 2:53, 5:48,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	💖 Yes, eat right away	38.70	18.10	🔺 So So	20.60	4	💖 - 🔺	31		\N	2	\N	2026-02-13 12:10:05.377224	2026-02-14 01:21:53.254555	f
555	2026-01-04	00:24:00	12:11, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	3.30	2.50	🔺 So So	0.80	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.555588	2026-03-11 08:18:37.111927	f
169	2026-02-14	01:19:00	-	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	67.10	❌ No!!!	12.90	0	💖 - ❌	18		\N	2	\N	2026-02-14 01:20:33.936239	2026-02-14 07:50:48.185967	f
176	2026-02-15	09:45:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	❌ No, not interested	70.00	11.00	💕 Love it So Much	59.00	0	❌ - 💕	30	均禾貓旅住宿	\N	2	\N	2026-02-19 03:53:57.711692	2026-02-23 14:23:54.628843	f
178	2026-02-16	09:45:00	17:55, 19:52, 20:36, 00:09, 2:44, 5:02, 6:02	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	35.00	15.00	🔺 So So	20.00	7	❌ - 🔺	27	均禾貓旅住宿/ 20g天然密碼+10g法米納+5g汪喵櫻桃鴨凍乾	\N	2	\N	2026-02-19 04:27:00.862786	2026-02-23 14:24:03.545748	f
180	2026-02-16	09:45:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	❌ No, not interested	70.00	37.00	🔺 So So	33.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-02-19 04:30:08.301844	2026-02-23 14:24:12.604445	f
181	2026-02-17	09:45:00	18:59, 19:33, 20:58, 3:42	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	🔺 No, not really. Ate A Little	35.00	20.00	🔺 So So	15.00	4	🔺 - 🔺	26	均禾貓旅住宿/ 20g天然密碼+10g法米納+5g汪喵櫻桃鴨凍乾	\N	2	\N	2026-02-19 04:32:28.710606	2026-02-19 04:33:08.506847	f
183	2026-02-18	02:36:00	13:06, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	35.00	29.00	🔺 So So	6.00	1	❌ - 🔺	15	均禾貓旅住宿/ 20g天然密碼+10g法米納+5g汪喵櫻桃鴨凍乾	\N	2	\N	2026-02-19 04:35:10.455857	2026-02-23 14:24:32.257812	f
192	2026-02-18	09:45:00	-	Wet	ciao	布丁杯 雞肉 imc-153 + imc-224 雙喵杯 鮪魚+雞肉+柴魚片	❌ No, not interested	100.00	6.00	💕 Love it So Much	94.00	0	❌ - 💕	30	均禾貓旅住宿	\N	2	\N	2026-02-19 14:08:05.639129	2026-02-23 14:24:40.2291	f
194	2026-02-18	09:45:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	35.00	22.00	🔺 So So	13.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-02-19 14:12:14.323023	2026-02-23 14:24:48.333967	f
184	2026-02-19	08:06:00	18:33, 19:01, 20:56, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	21.70	🔺 So So	3.40	3	❌ - 🔺	19	加5.1g汪喵凍乾	\N	2	\N	2026-02-19 08:06:30.655092	2026-02-23 14:24:55.631368	f
185	2026-02-19	08:08:00	19:01,	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.00	9.20	🔺 So So	0.80	1	❌ - 🔺	15		\N	2	\N	2026-02-19 08:08:26.808528	2026-02-23 14:25:03.717831	f
189	2026-02-19	13:41:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-19 13:41:53.718137	2026-02-23 14:25:15.198573	f
190	2026-02-19	13:44:00	22:17, 00:03, 3:28, 6:59	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	14.40	🔺 So So	10.70	4	❌ - 🔺	21	加汪喵 櫻桃鴨 3.5g	\N	2	\N	2026-02-19 13:44:21.409231	2026-02-23 14:25:23.7196	f
191	2026-02-19	13:46:00	7:00, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.50	6.80	🔺 So So	3.70	1	❌ - 🔺	15		\N	2	\N	2026-02-19 13:46:25.137117	2026-02-23 14:25:30.288404	f
196	2026-02-20	03:02:00	13:12, 14:41, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	14.60	🔺 So So	10.40	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-02-20 03:02:48.673857	2026-02-23 14:25:37.72086	f
197	2026-02-20	03:04:00	12:00, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	8.50	🔺 So So	1.80	1	❌ - 🔺	15		\N	2	\N	2026-02-20 03:04:28.246993	2026-02-23 14:25:45.322763	f
186	2026-02-19	08:09:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	5.20	🔺 So So	4.80	0	💖 - 🔺	23		\N	2	\N	2026-02-19 08:09:38.20987	2026-02-19 13:46:11.543671	f
198	2026-02-20	03:06:00	17:17, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.20	18.60	🔺 So So	1.60	1	❌ - 🔺	15		\N	2	\N	2026-02-20 03:07:12.764257	2026-02-23 14:25:52.773512	f
199	2026-02-20	12:00:00	20:49, 23:57, 1:15, 2:23, 5:37, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	26.00	7.80	🔺 So So	18.20	5	❌ - 🔺	23	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-02-20 12:01:13.616301	2026-02-23 14:26:00.741281	f
200	2026-02-20	12:02:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.10	21.10	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-20 12:02:51.846656	2026-02-23 14:26:08.143221	f
187	2026-02-19	08:11:00	19:02, 20:57, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	34.50	💕 Love it So Much	35.50	2	💖 - 💕	37		\N	2	\N	2026-02-19 08:11:25.349361	2026-02-19 14:05:46.325292	f
202	2026-02-20	12:07:00	21:25, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	11.30	7.30	🔺 So So	4.00	1	❌ - 🔺	15		\N	2	\N	2026-02-20 12:07:56.323997	2026-02-23 14:26:22.933083	f
188	2026-02-19	13:35:00	22:17, 00:05, 3:29, 7:00,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	41.00	💕 Love it So Much	64.00	4	💖 - 💕	41		\N	2	\N	2026-02-19 13:39:41.436692	2026-02-20 04:35:01.556984	f
204	2026-02-21	02:14:00	11:03, 18:37, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	2.30	💕 Love it So Much	7.70	2	❌ - 💕	34		\N	2	\N	2026-02-21 02:15:00.941461	2026-02-23 14:26:31.817173	f
205	2026-02-21	02:16:00	12:46, 15:54, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.90	17.30	🔺 So So	7.60	2	❌ - 🔺	17	加汪喵 櫻桃鴨 4.9g	\N	2	\N	2026-02-21 02:16:48.324476	2026-02-23 14:26:39.624456	f
206	2026-02-21	02:17:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-21 02:18:02.004566	2026-02-23 14:26:52.086353	f
207	2026-02-21	11:58:00	4:17,	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.00	9.70	🔺 So So	0.30	1	❌ - 🔺	15		\N	2	\N	2026-02-21 11:58:35.66166	2026-02-23 14:26:59.910804	f
209	2026-02-21	12:03:00	22:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.90	🔺 So So	3.10	1	❌ - 🔺	15		\N	2	\N	2026-02-21 12:03:31.149603	2026-02-23 14:27:15.618536	f
182	2026-02-17	09:45:00	21:01, 22:36, 1:36	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	❌ No, not interested	85.00	28.00	💕 Love it So Much	57.00	3	❌ - 💕	29	均禾貓旅住宿	\N	2	\N	2026-02-19 04:33:45.682959	2026-02-26 11:38:02.566604	f
556	2026-01-04	10:50:00	21:55, 5:37, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	26.50	💕 Love it So Much	53.50	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:07.557572	2026-03-11 08:19:10.885059	f
195	2026-02-20	02:58:00	13:13, 14:43, 17:52,	Wet	ciao 	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	33.80	🔺 So So	46.20	3	💖 - 🔺	29		\N	2	\N	2026-02-20 02:59:03.518262	2026-02-20 12:10:01.371139	f
201	2026-02-20	12:06:00	20:50, 21:26, 23:58, 1:16, 5:38,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	27.90	💕 Love it So Much	77.10	5	💖 - 💕	43		\N	2	\N	2026-02-20 12:06:25.928914	2026-02-21 02:13:37.279687	f
210	2026-02-21	12:05:00	20:37, 23:47, 1:35, 4:18, 7:20,	Wet	ciao 	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	🔺 No, not really. Ate A Little	80.00	25.00	💕 Love it So Much	55.00	5	🔺 - 💕	38		\N	2	\N	2026-02-21 12:06:08.437869	2026-02-22 03:59:09.43636	f
217	2026-02-22	12:39:00	21:44, 2:49, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	9.50	🔺 So So	15.50	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-02-22 12:41:04.326187	2026-02-23 14:27:58.989371	f
213	2026-02-22	02:12:00	20:34, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	10.00	6.50	🔺 So So	3.50	1	❌ - 🔺	15		\N	2	\N	2026-02-22 02:12:46.423236	2026-02-23 14:27:40.886657	f
215	2026-02-22	07:07:00	-	Wet	ciao	imc-224 雙喵杯 鮪魚+雞肉+柴魚片	💖 Yes, eat right away	35.00	14.10	❌ No!!!	20.90	0	💖 - ❌	18		\N	2	\N	2026-02-22 07:07:57.048624	2026-02-22 12:49:12.289853	f
211	2026-02-22	02:06:00	12:32, 19:30, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) 	💖 Yes, eat right away	60.00	30.20	🔺 So So	29.80	2	💖 - 🔺	27		\N	2	\N	2026-02-22 02:07:27.203867	2026-02-22 12:49:56.69451	f
223	2026-02-23	01:48:00	10:24, 11:11, 17:09, 18:53, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	13.50	🔺 So So	11.60	4	❌ - 🔺	21	加誠實貓 雞肉 5.1g	\N	2	\N	2026-02-23 01:49:10.989521	2026-02-23 14:32:38.072113	f
203	2026-02-21	02:08:00	12:48, 15:55,	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	33.60	🔺 So So	36.40	2	💖 - 🔺	27		\N	2	\N	2026-02-21 02:11:05.654819	2026-03-02 12:45:39.783943	f
218	2026-02-22	12:43:00	21:46, 23:45, 2:51, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	51.60	🔺 So So	53.40	3	💖 - 🔺	29		\N	2	\N	2026-02-22 12:44:00.411023	2026-02-23 01:45:24.024537	f
214	2026-02-22	02:13:00	19:29, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	4.90	🔺 So So	5.10	1	❌ - 🔺	15		\N	2	\N	2026-02-22 02:13:50.306123	2026-02-23 14:27:50.281012	f
224	2026-02-23	01:52:00	-	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 01:52:53.751657	2026-02-28 07:51:37.027326	f
559	2026-01-04	10:50:00	19:36, 1:44, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.50	0.00	💕 Love it So Much	2.50	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:07.57271	2026-03-11 08:19:00.741575	f
558	2026-01-04	10:50:00	00:55,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	11.30	3.90	💕 Love it So Much	7.40	1	❌ - 💕	25		\N	2	\N	2026-02-23 13:47:07.570417	2026-03-11 08:19:24.319714	f
557	2026-01-04	10:50:00	19:47, 21:54, 5:35, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	12.10	🔺 So So	28.70	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.568249	2026-03-11 08:19:35.817418	f
570	2026-01-05	09:20:00	00:46, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.90	0.00	💕 Love it So Much	3.90	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.598221	2026-03-11 08:19:58.669886	f
569	2026-01-05	09:20:00	20:40, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.70	0.00	💕 Love it So Much	2.70	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.595825	2026-03-11 08:20:09.112324	f
568	2026-01-05	09:20:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	12.80	12.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.594084	2026-03-11 08:20:19.52848	f
567	2026-01-05	09:20:00	18:58, 19:39, 22:12, 3:15, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	13.00	🔺 So So	17.60	4	❌ - 🔺	21		\N	2	\N	2026-02-23 13:47:07.592188	2026-03-11 08:20:39.745824	f
566	2026-01-05	09:20:00	3:17,	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	68.90	🔺 So So	61.10	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:07.590031	2026-03-11 08:20:53.461011	f
565	2026-01-05	01:45:00	-	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.70	2.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.588216	2026-03-11 08:21:06.589222	f
564	2026-01-05	01:45:00	12:11, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.50	0.00	💕 Love it So Much	4.50	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.586303	2026-03-11 08:21:25.322158	f
563	2026-01-05	01:45:00	9:37, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	12.80	🔺 So So	2.20	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.584225	2026-03-11 08:21:34.254717	f
561	2026-01-05	01:45:00	11:08, 14:58, 	Wet	ciao	ic-205 雞肉+干貝 (鰹魚湯底) x2	💖 Yes, eat right away	80.00	41.50	🔺 So So	38.50	2	💖 - 🔺	27		\N	2	\N	2026-02-23 13:47:07.578079	2026-03-11 08:21:45.730779	f
560	2026-01-05	00:40:00	-	Wet	ciao	ic-211 貓用巧餐包-鮪魚+扇貝 x2	🔺 No, not really. Ate A Little	80.00	61.20	❌ No!!!	18.80	0	🔺 - ❌	13	3:30 - 5:30 很躁動 & 咬人/00:30要睡時, 有點躁動/調整早晚各放30g乾乾	\N	2	\N	2026-02-23 13:47:07.574855	2026-03-11 08:21:54.547973	f
575	2026-01-06	02:52:00	-	Wet	ciao	布丁杯 雞肉 imc-153	🔺 No, not really. Ate A Little	65.00	52.70	❌ No!!!	12.30	0	🔺 - ❌	13		\N	2	\N	2026-02-23 13:47:07.631447	2026-03-11 08:22:25.648036	f
574	2026-01-06	00:37:00	12:46, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.90	0.00	💕 Love it So Much	3.90	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.629533	2026-03-11 08:22:36.306203	f
572	2026-01-06	00:37:00	10:48, 15:13, 16:52, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	20.00	🔺 So So	10.50	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.602524	2026-03-11 08:22:46.012004	f
573	2026-01-06	00:37:00	9:34, 15:13, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	14.90	10.90	🔺 So So	4.00	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.627595	2026-03-11 08:22:55.506374	f
571	2026-01-06	00:37:00	-	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	49.40	❌ No!!!	30.60	0	💖 - ❌	18	10:50 倒掉/10:00 有點躁動, 一直叫/20:05, 20:45 餓吐	\N	2	\N	2026-02-23 13:47:07.600393	2026-03-11 08:23:10.300806	f
580	2026-01-06	12:30:00	20:42, 22:26, 1:41, 4:31,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	🔺 No, not really. Ate A Little	60.00	16.10	💕 Love it So Much	43.90	4	🔺 - 💕	36		\N	2	\N	2026-02-23 13:47:07.646882	2026-03-11 08:23:22.174643	f
578	2026-01-06	09:10:00	20:55, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.90	3.70	💕 Love it So Much	7.20	1	❌ - 💕	25		\N	2	\N	2026-02-23 13:47:07.637525	2026-03-11 08:23:37.659985	f
579	2026-01-06	09:10:00	20:00, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.80	0.00	💕 Love it So Much	2.80	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.644263	2026-03-11 08:23:52.674208	f
577	2026-01-06	09:10:00	19:25, 20:40, 22:25, 23:56, 1:39, 4:30,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	6.20	💕 Love it So Much	24.40	6	❌ - 💕	42		\N	2	\N	2026-02-23 13:47:07.635321	2026-03-11 08:24:00.930136	f
576	2026-01-06	09:10:00	19:26, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	47.50	🔺 So So	32.50	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:07.633322	2026-03-11 08:24:19.784042	f
581	2026-01-07	01:30:00	-	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	59.00	❌ No!!!	21.00	0	💖 - ❌	18	10:30 整個很躁動	\N	2	\N	2026-02-23 13:47:07.650653	2026-03-11 08:25:15.467704	f
616	2026-01-10	10:30:00	20:11, 22:06, 00:49, 3:04, 4:52,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.80	4.40	💕 Love it So Much	26.40	5	❌ - 💕	40		\N	2	\N	2026-02-23 13:47:07.7427	2026-03-11 08:35:02.089329	f
590	2026-01-07	11:35:00	20:42, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.40	1.70	🔺 So So	2.70	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.676823	2026-03-11 08:25:31.15068	f
589	2026-01-07	11:35:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	3.40	3.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.674533	2026-03-11 08:25:38.834229	f
584	2026-01-07	01:30:00	-	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.40	4.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.663337	2026-03-11 08:25:50.117741	f
583	2026-01-07	01:30:00	10:43, 13:43,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	3.40	💕 Love it So Much	11.60	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:07.661409	2026-03-11 08:26:04.544661	f
582	2026-01-07	01:30:00	9:28, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	24.50	🔺 So So	6.00	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.655595	2026-03-11 08:26:12.402796	f
588	2026-01-07	11:35:00	22:09, 23:43, 3:01, 5:15, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	4.90	🔺 So So	25.70	4	❌ - 🔺	28		\N	2	\N	2026-02-23 13:47:07.672647	2026-03-11 08:26:23.561964	f
585	2026-01-07	01:30:00	-	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.50	2.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.666162	2026-03-11 08:26:51.42306	f
587	2026-01-07	11:35:00	20:44, 22:10, 5:15	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	90.30	36.70	💕 Love it So Much	53.60	3	💖 - 💕	39		\N	2	\N	2026-02-23 13:47:07.669922	2026-03-11 08:27:01.217188	f
593	2026-01-08	00:54:00	9:43, 14:50, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	25.00	🔺 So So	5.60	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.683378	2026-03-11 08:30:27.226532	f
592	2026-01-08	00:54:00	14:51, 	Wet	ciao	ic49 多樂米雞肉沾醬 20g x4	💖 Yes, eat right away	80.00	29.10	💕 Love it So Much	50.90	1	💖 - 💕	35	3:00-5:00 有點躁動/00:00 躁動, 有陪玩	\N	2	\N	2026-02-23 13:47:07.680762	2026-03-11 08:30:49.897837	f
599	2026-01-08	10:15:00	8:37, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.40	0.00	💕 Love it So Much	3.40	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.698596	2026-03-11 08:30:59.41618	f
598	2026-01-08	10:15:00	00:42, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	6.40	2.50	🔺 So So	3.90	1	❌ - 🔺	15	晚點要再補6.8g	\N	2	\N	2026-02-23 13:47:07.69656	2026-03-11 08:31:07.25731	f
597	2026-01-08	10:15:00	20:05, 21:36, 00:24, 00:44, 3:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	4.50	💕 Love it So Much	26.10	5	❌ - 💕	40		\N	2	\N	2026-02-23 13:47:07.69372	2026-03-11 08:31:15.84012	f
594	2026-01-08	00:54:00	9:41, 15:13, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	9.20	2.30	💕 Love it So Much	6.90	2	❌ - 💕	27	晚點要再補5.8g	\N	2	\N	2026-02-23 13:47:07.685247	2026-03-11 08:31:24.682421	f
596	2026-01-08	10:15:00	20:07, 00:25, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	32.00	💕 Love it So Much	48.00	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:07.688984	2026-03-11 08:31:40.752414	f
595	2026-01-08	03:00:00	-	Freeze-Dried	誠實貓	雞肉凍乾	💖 Yes, eat right away	2.40	0.00	💕 Love it So Much	2.40	0	💖 - 💕	40		\N	2	\N	2026-02-23 13:47:07.68712	2026-03-11 08:31:58.875384	f
603	2026-01-09	01:13:00	13:30	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	3.20	0.00	💕 Love it So Much	3.20	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.706753	2026-03-11 08:32:42.516724	f
602	2026-01-09	01:13:00	12:48, 16:15	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	14.90	5.40	🔺 So So	9.50	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.704569	2026-03-11 08:32:52.397735	f
601	2026-01-09	01:13:00	15:10, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	28.90	🔺 So So	1.60	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.702748	2026-03-11 08:33:03.485005	f
600	2026-01-09	01:13:00	-	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	54.70	❌ No!!!	25.30	0	💖 - ❌	18	7:30好像有叫	\N	2	\N	2026-02-23 13:47:07.700643	2026-03-11 08:33:15.697337	f
607	2026-01-09	09:00:00	4:55	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	1.60	0.00	💕 Love it So Much	1.60	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.715945	2026-03-11 08:33:28.055972	f
604	2026-01-09	09:00:00	19:59, 1:06	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	58.00	💕 Love it So Much	72.00	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:07.709404	2026-03-11 08:33:46.644977	f
605	2026-01-09	09:00:00	19:57, 21:35, 1:05, 3:29, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	2.00	🔺 So So	28.60	4	❌ - 🔺	28		\N	2	\N	2026-02-23 13:47:07.711211	2026-03-11 08:33:57.937924	f
611	2026-01-10	01:15:00	14:57, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	9.30	🔺 So So	5.70	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.731316	2026-03-11 08:34:24.402003	f
610	2026-01-10	01:15:00	13:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	29.40	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.729161	2026-03-11 08:34:31.681075	f
609	2026-01-10	01:15:00	14:59, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) - 冰過	❌ No, not interested	35.60	20.00	🔺 So So	15.60	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.726576	2026-03-11 08:34:38.813574	f
608	2026-01-10	01:15:00	13:33, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	32.30	🔺 So So	27.70	1	💖 - 🔺	25	10:50 不得已抓阿吉進外出籠, 12:00 回到家後, 只要我靠近就會想躲我	6.96	2	\N	2026-02-23 13:47:07.718606	2026-03-11 08:34:46.073009	f
612	2026-01-10	10:30:00	-	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.733733	2026-03-11 08:34:54.823741	f
615	2026-01-10	10:30:00	20:10, 4:53,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	35.30	💕 Love it So Much	49.70	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:07.740667	2026-03-11 08:35:10.123693	f
617	2026-01-10	10:30:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	9.30	9.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.744707	2026-03-11 08:35:20.079235	f
614	2026-01-10	10:30:00	-	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.738395	2026-03-11 08:35:28.002097	f
613	2026-01-10	10:30:00	-	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.73555	2026-03-11 08:35:40.688309	f
622	2026-01-11	01:00:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	15.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.756631	2026-03-11 08:36:37.921215	f
620	2026-01-11	01:00:00	12:35, 15:43, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	19.60	🔺 So So	10.90	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.752373	2026-03-11 08:36:46.367936	f
621	2026-01-11	01:00:00	12:36, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	🔺 No, not really. Ate A Little	75.00	55.60	🔺 So So	19.40	1	🔺 - 🔺	20		\N	2	\N	2026-02-23 13:47:07.754609	2026-03-11 08:36:54.165065	f
619	2026-01-11	01:00:00	-	Wet	ciao	極致濃湯餐包 ic-504 鮪魚+雞肉+干貝	❌ No, not interested	30.00	30.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.750374	2026-03-11 08:37:06.046421	f
618	2026-01-11	01:00:00	15:44, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	34.90	🔺 So So	25.10	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:07.74691	2026-03-11 08:37:15.562793	f
626	2026-01-11	11:35:00	1:07,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	9.10	🔺 So So	5.90	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.764758	2026-03-11 08:37:25.388586	f
624	2026-01-11	11:35:00	21:35, 2:16, 7:38, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) x2	🔺 No, not really. Ate A Little	120.00	78.20	🔺 So So	41.80	3	🔺 - 🔺	24		\N	2	\N	2026-02-23 13:47:07.760933	2026-03-11 08:37:32.865081	f
627	2026-01-11	10:40:00	18:41	Freeze-Dried	誠實貓	鴨肉凍乾	💖 Yes, eat right away	2.60	0.00	💕 Love it So Much	2.60	1	💖 - 💕	42		\N	2	\N	2026-02-23 13:47:07.766729	2026-03-11 08:37:48.577421	f
630	2026-01-12	02:45:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	14.90	14.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.774316	2026-03-11 08:38:41.621229	f
631	2026-01-12	02:45:00	13:43, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.10	0.00	💕 Love it So Much	3.10	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.776351	2026-03-11 08:38:52.573982	f
629	2026-01-12	02:45:00	12:16, 16:34, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	19.20	🔺 So So	11.30	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.771846	2026-03-11 08:38:59.660004	f
628	2026-01-12	02:45:00	12:18,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	54.70	🔺 So So	30.30	1	💖 - 🔺	25	3:00-7:00 躁動 & 叫	\N	2	\N	2026-02-23 13:47:07.769495	2026-03-11 08:39:08.171212	f
636	2026-01-12	17:00:00	-	Wet	銀湯匙	餐包 濃郁肉湯 鮪魚 tw t-mp	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.78909	2026-03-11 08:39:21.236512	f
635	2026-01-12	11:20:00	19:34, 23:47,	Freeze-Dried	誠實貓	雞肉凍乾	💖 Yes, eat right away	4.50	0.00	💕 Love it So Much	4.50	2	💖 - 💕	44		\N	2	\N	2026-02-23 13:47:07.785486	2026-03-11 08:39:29.181917	f
634	2026-01-12	11:20:00	18:12, 00:42, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	14.90	7.80	🔺 So So	7.10	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.782743	2026-03-11 08:39:37.374495	f
633	2026-01-12	11:20:00	20:22, 22:32, 3:22, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	23.50	🔺 So So	17.30	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.780853	2026-03-11 08:39:54.452271	f
632	2026-01-12	11:20:00	-	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	51.70	❌ No!!!	28.30	0	💖 - ❌	18		\N	2	\N	2026-02-23 13:47:07.778309	2026-03-11 08:40:02.119004	f
642	2026-01-13	12:20:00	21:27, 22:47, 00:05, 5:21, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	36.30	🔺 So So	43.70	4	💖 - 🔺	31		\N	2	\N	2026-02-23 13:47:07.829565	2026-03-11 08:40:33.391343	f
643	2026-01-13	12:20:00	-	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.840099	2026-03-11 08:40:41.233145	f
644	2026-01-13	12:20:00	21:25, 22:46, 00:04, 1:00, 5:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.70	8.90	💕 Love it So Much	31.80	5	❌ - 💕	40		\N	2	\N	2026-02-23 13:47:07.843618	2026-03-11 08:40:48.309636	f
645	2026-01-13	12:20:00	-	Kibble	極光	無穀雞肉 	❌ No, not interested	40.80	40.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.845363	2026-03-11 08:40:56.914791	f
646	2026-01-13	12:20:00	5:41, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	13.00	9.30	🔺 So So	3.70	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.847441	2026-03-11 08:41:04.417017	f
647	2026-01-13	12:20:00	21:23, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.40	0.00	💕 Love it So Much	2.40	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.850312	2026-03-11 08:41:12.089802	f
637	2026-01-13	01:00:00	9:46, 11:23, 	Wet	ciao	ic-213 高湯餐包 雞肉+干貝 (日本製)x2 	💖 Yes, eat right away	80.00	34.10	💕 Love it So Much	45.90	2	💖 - 💕	37	5:30 被咬	\N	2	\N	2026-02-23 13:47:07.794398	2026-03-11 08:41:20.117987	f
641	2026-01-13	01:00:00	18:00	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	3.80	2.40	🔺 So So	1.40	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.819845	2026-03-11 08:41:31.417059	f
638	2026-01-13	01:00:00	9:47, 11:22, 12:11, 17:34, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	20.90	🔺 So So	19.90	4	❌ - 🔺	21		\N	2	\N	2026-02-23 13:47:07.797474	2026-03-11 08:41:39.172592	f
640	2026-01-13	01:00:00	-	Kibble	極光	無穀雞肉 	❌ No, not interested	40.80	40.80	❌ No!!!	0.00	0	❌ - ❌	8	未加排毛粉	\N	2	\N	2026-02-23 13:47:07.808578	2026-03-11 08:41:46.991541	f
639	2026-01-13	01:00:00	9:49, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	14.90	13.00	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.804486	2026-03-11 08:41:55.28339	f
650	2026-01-14	01:15:00	15:27, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	12.30	🔺 So So	2.70	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.855572	2026-03-11 08:43:18.914136	f
651	2026-01-14	01:15:00	19:00	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	5.90	4.80	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.857525	2026-03-11 08:43:27.876424	f
649	2026-01-14	01:15:00	11:25, 13:16, 17:16, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.70	20.00	🔺 So So	20.70	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.853714	2026-03-11 08:43:35.178784	f
648	2026-01-14	01:15:00	-	Wet	自然小貓	無膠肉湯罐 雞肉佐鴨肉雞湯	💖 Yes, eat right away	80.00	37.00	❌ No!!!	43.00	0	💖 - ❌	18	3:30 & 5:30 躁動&準備咬人	\N	2	\N	2026-02-23 13:47:07.852066	2026-03-11 08:43:42.793604	f
653	2026-01-14	11:50:00	21:28, 4:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	27.20	🔺 So So	13.60	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.861509	2026-03-11 08:44:06.96905	f
652	2026-01-14	11:50:00	21:29, 00:24, 4:46, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	40.00	💕 Love it So Much	65.00	3	💖 - 💕	39		\N	2	\N	2026-02-23 13:47:07.859608	2026-03-11 08:44:20.724526	f
672	2026-01-16	12:30:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	3.00	3.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.913555	2026-03-11 08:48:07.150965	f
655	2026-01-14	11:50:00	-	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.80	4.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.870267	2026-03-11 08:43:51.596563	f
654	2026-01-14	11:50:00	00:28, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	12.30	7.60	🔺 So So	4.70	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.86817	2026-03-11 08:43:59.341063	f
662	2026-01-15	13:04:00	00:23, 5:36, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.00	28.60	🔺 So So	11.40	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.890591	2026-03-11 08:44:50.059829	f
663	2026-01-15	13:04:00	23:30, 1:30, 5:35, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	31.90	23.30	🔺 So So	8.60	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.892288	2026-03-11 08:44:57.558732	f
664	2026-01-15	13:04:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	6.60	6.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.894529	2026-03-11 08:45:05.796406	f
661	2026-01-15	13:04:00	23:32, 1:33, 5:37, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	77.50	🔺 So So	52.50	3	💖 - 🔺	29		\N	2	\N	2026-02-23 13:47:07.885277	2026-03-11 08:45:14.400275	f
656	2026-01-15	01:18:00	-	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	5:30 有點躁動	\N	2	\N	2026-02-23 13:47:07.872476	2026-03-11 08:45:33.114688	f
658	2026-01-15	01:35:00	16:11, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	37.40	🔺 So So	3.40	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.876251	2026-03-11 08:45:46.970087	f
660	2026-01-15	02:05:00	10:22, 16:11, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.60	🔺 So So	3.40	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.87968	2026-03-11 08:45:55.82538	f
659	2026-01-15	02:05:00	12:17, 14:18, 16:09, 18:21, 19:34, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	40.00	22.30	💕 Love it So Much	17.70	5	💖 - 💕	43		\N	2	\N	2026-02-23 13:47:07.877918	2026-03-11 08:46:04.185376	f
669	2026-01-16	07:50:00	17:14, 20:02, 23:53, 1:11, 4:38, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	40.20	25.50	🔺 So So	14.70	5	💖 - 🔺	33		\N	2	\N	2026-02-23 13:47:07.906388	2026-03-11 08:46:55.970033	f
668	2026-01-16	01:25:00	-	Kibble	曙光	無穀滋養火雞肉食譜	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.904426	2026-03-11 08:47:04.814516	f
667	2026-01-16	01:25:00	9:30, 11:21, 15:29, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.00	💕 Love it So Much	7.00	3	❌ - 💕	29		\N	2	\N	2026-02-23 13:47:07.901787	2026-03-11 08:47:27.161866	f
666	2026-01-16	01:25:00	12:56, 15:27, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	28.60	🔺 So So	12.20	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.899391	2026-03-11 08:47:35.058304	f
665	2026-01-16	01:25:00	11:24, 	Wet	mon petit 貓倍麗	極上餐包 鮮鮪比目魚 lp13 x3	💖 Yes, eat right away	105.00	63.30	🔺 So So	41.70	1	💖 - 🔺	25	16:00 有討食(肉泥)/右眼會流眼淚....可能碰到什麼過敏物質還在觀察	\N	2	\N	2026-02-23 13:47:07.896565	2026-03-11 08:47:43.280207	f
670	2026-01-16	12:30:00	21:23, 23:55, 4:40, 	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒 x2	💖 Yes, eat right away	140.00	73.00	💕 Love it So Much	67.00	3	💖 - 💕	39		\N	2	\N	2026-02-23 13:47:07.90908	2026-03-11 08:47:57.03061	f
671	2026-01-16	12:30:00	20:03, 21:21, 23:54, 7:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	27.50	🔺 So So	13.30	4	❌ - 🔺	21		\N	2	\N	2026-02-23 13:47:07.910836	2026-03-11 08:48:15.975164	f
673	2026-01-17	01:30:00	10:34, 	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚 x3	🔺 No, not really. Ate A Little	105.00	87.20	🔺 So So	17.80	1	🔺 - 🔺	20	懷疑不是很愛, 所以吃完肉泥餓吐/10:00 有討食行為 (肉泥)/10:25 餓吐/右眼會流眼淚.....可能碰到什麼過敏物質還在觀察	\N	2	\N	2026-02-23 13:47:07.915748	2026-03-11 08:48:52.037638	f
681	2026-01-17	12:40:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	5.40	5.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.95006	2026-03-11 08:49:00.554139	f
680	2026-01-17	12:40:00	21:32, 4:33, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	34.20	🔺 So So	6.60	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.944864	2026-03-11 08:49:09.765821	f
679	2026-01-17	12:40:00	21:31, 00:01, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.00	34.60	🔺 So So	5.40	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.940515	2026-03-11 08:49:17.28487	f
678	2026-01-17	12:40:00	21:32, 4:35	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	37.00	💕 Love it So Much	68.00	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:07.935626	2026-03-11 08:49:26.538454	f
677	2026-01-17	01:30:00	9:33, 10:33, 14:27, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	5.40	🔺 So So	4.60	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.929456	2026-03-11 08:49:35.505372	f
676	2026-01-17	01:30:00	15:05, 19:14, 19:29, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	32.00	🔺 So So	8.80	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.925788	2026-03-11 08:49:43.279083	f
675	2026-01-17	01:30:00	14:25, 19:28, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.00	34.20	🔺 So So	5.80	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.922187	2026-03-11 08:49:50.489901	f
674	2026-01-17	02:45:00	15:07, 19:29,	Wet	ciao	ic49 多樂米雞肉沾醬 20g x4	💖 Yes, eat right away	80.00	9.80	💕 Love it So Much	70.20	2	💖 - 💕	44		\N	2	\N	2026-02-23 13:47:07.92043	2026-03-11 08:49:57.315138	f
685	2026-01-18	01:00:00	10:07, 16:15, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	6.70	🔺 So So	3.50	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.96243	2026-03-11 08:50:58.063769	f
683	2026-01-18	01:00:00	10:06, 12:19, 16:11, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.00	33.80	🔺 So So	6.20	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.955755	2026-03-11 08:51:31.465164	f
684	2026-01-18	01:00:00	10:07, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	40.40	🔺 So So	0.40	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.959674	2026-03-11 08:51:39.382554	f
688	2026-01-18	12:40:00	20:09, 1:05, 6:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.40	27.30	🔺 So So	13.10	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.978037	2026-03-11 08:51:49.506739	f
686	2026-01-18	12:40:00	21:38, 6:34, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) x2	❌ No, not interested	84.70	40.00	🔺 So So	44.70	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.967026	2026-03-11 08:51:58.203277	f
687	2026-01-18	12:40:00	20:11, 6:30, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.00	36.20	🔺 So So	3.80	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:07.974445	2026-03-11 08:52:08.818887	f
693	2026-01-19	01:50:00	9:54, 10:36, 19:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	2.40	💕 Love it So Much	7.60	3	❌ - 💕	36		\N	2	\N	2026-02-23 13:47:07.995689	2026-03-11 08:52:37.74949	f
689	2026-01-18	12:40:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	6.70	6.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.982995	2026-03-11 08:50:38.757564	f
691	2026-01-19	01:50:00	-	Kibble	go 	四種肉 無穀貓全糧	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.989939	2026-03-11 08:52:29.890911	f
692	2026-01-19	01:50:00	14:47, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	35.20	🔺 So So	5.60	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.992723	2026-03-11 08:52:44.865425	f
690	2026-01-19	01:50:00	10:37, 14:48, 19:22, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	82.80	🔺 So So	47.20	3	💖 - 🔺	29		\N	2	\N	2026-02-23 13:47:07.986948	2026-03-11 08:52:53.246123	f
697	2026-01-19	13:06:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	2.40	2.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.00967	2026-03-11 08:53:34.115846	f
696	2026-01-19	13:06:00	21:06, 6:14, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.80	24.80	🔺 So So	16.00	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.005487	2026-03-11 08:53:42.583735	f
694	2026-01-19	13:06:00	6:16, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	50.00	🔺 So So	35.00	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:07.999851	2026-03-11 08:53:50.675323	f
702	2026-01-20	02:00:00	-	Kibble	超躍 hyperr	田園雞肉	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.025324	2026-03-11 08:54:41.112269	f
701	2026-01-20	02:00:00	10:45, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.70	🔺 So So	3.30	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.022513	2026-03-11 08:54:49.716606	f
700	2026-01-20	02:00:00	15:09, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	19.70	🔺 So So	0.30	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.018591	2026-03-11 08:54:57.145478	f
698	2026-01-20	02:00:00	10:48, 15:09, 16:58, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	39.50	🔺 So So	45.50	3	💖 - 🔺	29		\N	2	\N	2026-02-23 13:47:08.012839	2026-03-11 08:55:05.513014	f
699	2026-01-20	02:00:00	17:00, 18:12, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	10.40	🔺 So So	10.00	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.015761	2026-03-11 08:55:13.927163	f
707	2026-01-20	12:30:00	-	Kibble	超躍 hyperr	田園雞肉	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.039979	2026-03-11 08:55:22.324288	f
706	2026-01-20	12:30:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	6.70	6.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.037516	2026-03-11 08:55:31.853048	f
703	2026-01-20	12:30:00	21:35, 6:19, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	34.60	💕 Love it So Much	70.40	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:08.027609	2026-03-11 08:55:39.579495	f
705	2026-01-20	12:30:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.034792	2026-03-11 08:55:47.243554	f
704	2026-01-20	12:30:00	21:31, 00:28, 4:38,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	7.10	🔺 So So	13.30	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.030929	2026-03-11 08:55:54.734491	f
712	2026-01-21	01:17:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.30	❌ No!!!	1.70	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.057684	2026-03-11 08:56:31.321415	f
711	2026-01-21	01:17:00	-	Kibble	索美達	低溫烘焙糧+鮮食肉片 南島深海魚	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.054226	2026-03-11 08:56:39.475621	f
708	2026-01-21	01:17:00	10:18, 12:35, 15:49, 17:22, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	32.00	💕 Love it So Much	73.00	4	💖 - 💕	41	4:30 有點點躁動	\N	2	\N	2026-02-23 13:47:08.04461	2026-03-11 08:56:54.125656	f
709	2026-01-21	01:17:00	12:34, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	24.80	🔺 So So	5.70	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.047243	2026-03-11 08:57:01.781815	f
717	2026-01-21	12:15:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	8.30	8.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.078396	2026-03-11 08:57:12.092515	f
716	2026-01-21	12:15:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.075209	2026-03-11 08:57:22.453485	f
715	2026-01-21	12:15:00	20:29, 22:09, 1:43, 6:02, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	10.30	🔺 So So	20.20	4	❌ - 🔺	21		\N	2	\N	2026-02-23 13:47:08.070345	2026-03-11 08:57:30.839874	f
714	2026-01-21	12:15:00	20:30, 6:04, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	31.70	🔺 So So	48.30	2	💖 - 🔺	27		\N	2	\N	2026-02-23 13:47:08.064463	2026-03-11 08:57:39.462412	f
713	2026-01-21	12:15:00	-	Wet	mon petit 貓倍麗	鮪魚蟹肉銀魚極品鮮湯 sp1 x2	🔺 No, not really. Ate A Little	80.00	80.00	❌ No!!!	0.00	0	🔺 - ❌	13	很躁動....吃完一點到處衝來衝去	\N	2	\N	2026-02-23 13:47:08.062232	2026-03-11 08:57:48.135	f
720	2026-01-22	03:00:00	17:08, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	84.00	🔺 So So	46.00	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:08.090038	2026-03-11 09:12:36.902124	f
724	2026-01-22	01:40:00	14:12, 19:38, 	Kibble	超躍 hyperr	貓用冷凍乾燥生食餐 原野牛肉	❌ No, not interested	12.70	11.50	🔺 So So	1.20	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.103411	2026-03-11 09:12:47.731971	f
723	2026-01-22	01:40:00	10:20, 14:13,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	0.40	💕 Love it So Much	9.60	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:08.100543	2026-03-11 09:12:58.339846	f
722	2026-01-22	01:40:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.097025	2026-03-11 09:13:06.182201	f
721	2026-01-22	01:40:00	17:05, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	23.20	🔺 So So	7.40	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.093832	2026-03-11 09:13:15.077654	f
719	2026-01-22	01:40:00	14:14, 19:39, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) - 冰過	❌ No, not interested	36.10	17.60	🔺 So So	18.50	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.086346	2026-03-11 09:13:23.229669	f
718	2026-01-22	01:40:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	44.00	❌ No!!!	16.00	0	💖 - ❌	18	倒掉換罐頭/10:30開始有點躁動	\N	2	\N	2026-02-23 13:47:08.083007	2026-03-11 09:13:43.483565	f
753	2026-01-25	01:20:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.199212	2026-03-10 14:06:57.816259	f
755	2026-01-25	01:20:00	17:20, 18:54, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.10	0.00	💕 Love it So Much	4.10	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:08.202799	2026-03-10 14:07:18.828892	f
751	2026-01-25	01:20:00	10:29, 16:00, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	34.30	🔺 So So	45.70	2	💖 - 🔺	27	天然密碼未加排毛粉	\N	2	\N	2026-02-23 13:47:08.194478	2026-03-10 14:07:43.263017	f
752	2026-01-25	01:20:00	12:55, 15:59, 17:20, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	19.00	🔺 So So	11.00	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.197376	2026-03-10 14:07:52.048552	f
758	2026-01-25	12:40:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.209701	2026-03-10 14:08:02.590343	f
756	2026-01-25	12:40:00	21:51, 1:59, 2:46,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	35.50	💕 Love it So Much	69.50	3	💖 - 💕	39		\N	2	\N	2026-02-23 13:47:08.204888	2026-03-10 14:08:16.047456	f
757	2026-01-25	12:40:00	20:36, 21:50, 00:20, 1:57, 2:44, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	14.90	🔺 So So	15.10	5	❌ - 🔺	23		\N	2	\N	2026-02-23 13:47:08.206654	2026-03-10 14:08:24.207235	f
759	2026-01-25	12:40:00	20:37, 6:39,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	0.40	💕 Love it So Much	9.80	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:08.211819	2026-03-10 14:08:44.552584	f
729	2026-01-22	12:10:00	-	Kibble	超躍 hyperr	貓用冷凍乾燥生食餐 原野牛肉	❌ No, not interested	11.50	11.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.122885	2026-03-11 09:13:56.676744	f
728	2026-01-22	12:10:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	0.40	0.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.118791	2026-03-11 09:14:05.555456	f
727	2026-01-22	12:10:00	00:34, 8:14, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	18.20	🔺 So So	1.80	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.116076	2026-03-11 09:14:14.024824	f
726	2026-01-22	12:10:00	20:59, 21:52, 00:35, 4:08, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	5.00	🔺 So So	25.50	4	❌ - 🔺	28		\N	2	\N	2026-02-23 13:47:08.110881	2026-03-11 09:14:25.75197	f
725	2026-01-22	12:10:00	21:03, 21:53, 00:35, 8:15, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	45.10	🔺 So So	39.90	4	💖 - 🔺	31	19:50 一直跟上跟下, 所以提早放	\N	2	\N	2026-02-23 13:47:08.10775	2026-03-11 09:14:34.277549	f
734	2026-01-23	01:24:00	9:33, 10:01, 17:43,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	0.00	💕 Love it So Much	10.00	3	❌ - 💕	36		\N	2	\N	2026-02-23 13:47:08.139338	2026-03-11 09:15:10.867701	f
733	2026-01-23	01:24:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.13688	2026-03-11 09:15:19.14493	f
731	2026-01-23	01:24:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g	💖 Yes, eat right away	20.00	3.60	❌ No!!!	16.40	0	💖 - ❌	25		\N	2	\N	2026-02-23 13:47:08.128097	2026-03-11 09:15:26.76901	f
730	2026-01-23	01:24:00	-	Wet	ciao	原湯杯52號(鮪+蟹+小魚)	🔺 No, not really. Ate A Little	60.00	51.60	❌ No!!!	8.40	0	🔺 - ❌	13	很躁動, 換TSC-45後跑過來想吃/4:10 & 5:30 躁動+咬人	\N	2	\N	2026-02-23 13:47:08.125175	2026-03-11 09:15:34.783001	f
739	2026-01-23	12:00:00	00:24, 5:40,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	1.30	💕 Love it So Much	8.70	2	💖 - 💕	44		\N	2	\N	2026-02-23 13:47:08.157194	2026-03-11 09:15:44.222678	f
738	2026-01-23	12:00:00	5:40,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	19.00	🔺 So So	1.00	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.15529	2026-03-11 09:15:52.277782	f
737	2026-01-23	12:00:00	22:01, 2:41, 6:24	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	16.10	🔺 So So	13.90	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.15224	2026-03-11 09:16:00.837863	f
736	2026-01-23	12:00:00	22:02, 2:43, 6:26,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	40.00	💕 Love it So Much	65.00	3	💖 - 💕	39		\N	2	\N	2026-02-23 13:47:08.149666	2026-03-11 09:16:16.35299	f
735	2026-01-23	02:50:00	11:18, 15:17, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	17.00	💕 Love it So Much	53.00	2	💖 - 💕	44		\N	2	\N	2026-02-23 13:47:08.146441	2026-03-11 09:16:26.032004	f
732	2026-01-23	01:24:00	14:02, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.70	27.20	🔺 So So	3.50	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.133377	2026-03-11 09:16:36.284315	f
745	2026-01-24	02:50:00	14:50	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.00	0.00	💕 Love it So Much	4.00	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:08.177851	2026-03-11 09:18:06.642863	f
744	2026-01-24	02:50:00	14:51, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	🔺 No, not really. Ate A Little	92.30	78.50	🔺 So So	13.80	1	🔺 - 🔺	20		\N	2	\N	2026-02-23 13:47:08.17237	2026-03-11 09:18:15.01291	f
743	2026-01-24	01:22:00	15:58, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.30	5.30	🔺 So So	5.00	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:08.170498	2026-03-11 09:18:26.099225	f
742	2026-01-24	01:22:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.166345	2026-03-11 09:18:34.126525	f
740	2026-01-24	01:22:00	-	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	47.70	❌ No!!!	32.30	0	💖 - ❌	18	5:30 躁動&要咬人/22:20 有點拉肚子	\N	2	\N	2026-02-23 13:47:08.159431	2026-03-11 09:18:42.362239	f
741	2026-01-24	01:22:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.70	30.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.164353	2026-03-11 09:18:50.122086	f
749	2026-01-24	11:50:00	4:29,  6:15, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	15.00	🔺 So So	5.00	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.190238	2026-03-11 09:19:17.71583	f
747	2026-01-24	11:50:00	23:52, 4:32, 	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x3	💖 Yes, eat right away	105.00	48.20	💕 Love it So Much	56.80	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:08.185215	2026-03-11 09:19:27.634952	f
746	2026-01-24	11:50:00	-	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	🔺 No, not really. Ate A Little	60.00	53.10	❌ No!!!	6.90	0	🔺 - ❌	13		\N	2	\N	2026-02-23 13:47:08.182478	2026-03-11 09:19:36.813415	f
748	2026-01-24	11:50:00	23:50, 6:16, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.70	20.50	🔺 So So	10.20	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.188388	2026-03-11 09:19:45.775739	f
792	2026-01-29	02:28:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x2	🔺 No, not really. Ate A Little	70.00	50.60	❌ No!!!	19.40	0	🔺 - ❌	13		\N	2	\N	2026-02-23 13:47:08.289235	2026-03-10 13:55:15.944095	f
789	2026-01-29	00:50:00	-	Wet	ciao	原湯杯53號 (雞肉+蟹肉棒+柴魚片) x2	🔺 No, not really. Ate A Little	120.00	85.90	❌ No!!!	34.10	0	🔺 - ❌	13	00:00-2:10 整個很躁動 & 叫 & 衝來衝去(後來關臥室外)/10:00 - 11:30 很躁動, 跟上跟下/20g乾乾+ 5g誠實貓 (比例)/白天誠實貓鴨柳/晚上誠實貓雞塊	\N	2	\N	2026-02-23 13:47:08.282889	2026-03-10 13:56:13.625064	f
790	2026-01-29	00:50:00	12:34, 18:25, 20:14	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	21.20	🔺 So So	16.30	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.284563	2026-03-10 13:56:30.661792	f
794	2026-01-29	09:00:00	20:17, 6:49, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	25.50	🔺 So So	34.50	2	💖 - 🔺	27		\N	2	\N	2026-02-23 13:47:08.293185	2026-03-10 13:58:05.533924	f
793	2026-01-29	08:30:00	-	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚 x2	🔺 No, not really. Ate A Little	70.00	49.10	❌ No!!!	20.90	0	🔺 - ❌	13		\N	2	\N	2026-02-23 13:47:08.290872	2026-03-10 13:58:20.478414	f
783	2026-01-28	02:42:00	15:52, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	5.80	4.80	🔺 So So	1.00	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:08.270744	2026-03-10 13:59:23.083881	f
781	2026-01-28	01:03:00	13:32, 18:25, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.60	30.70	🔺 So So	6.90	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.26719	2026-03-10 13:59:35.674975	f
782	2026-01-28	01:03:00	10:42, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	7.00	🔺 So So	3.00	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.269138	2026-03-10 13:59:46.921739	f
780	2026-01-28	01:03:00	9:53, 14:36, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	48.60	🔺 So So	36.40	2	💖 - 🔺	27	10:00-11:00 很躁動, 跟上跟下衝來衝去的	\N	2	\N	2026-02-23 13:47:08.265503	2026-03-10 13:59:54.866714	f
784	2026-01-28	02:25:00	14:38, 15:53, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	70.00	26.30	💕 Love it So Much	43.70	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:08.273793	2026-03-10 14:00:07.746593	f
785	2026-01-28	12:50:00	1:34, 2:49, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	29.80	💕 Love it So Much	50.20	2	💖 - 💕	37		\N	2	\N	2026-02-23 13:47:08.27555	2026-03-10 14:00:23.85128	f
786	2026-01-28	12:50:00	22:27, 1:32, 2:39, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	23.30	🔺 So So	14.10	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.277409	2026-03-10 14:00:31.498531	f
787	2026-01-28	12:50:00	21:14, 6:32	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	1.00	💕 Love it So Much	9.00	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:08.279064	2026-03-10 14:00:41.455869	f
788	2026-01-28	12:50:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	4.80	4.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.280668	2026-03-10 14:00:51.134537	f
774	2026-01-27	02:55:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	13.50	❌ No!!!	21.50	0	💖 - ❌	18		\N	2	\N	2026-02-23 13:47:08.254016	2026-03-10 14:01:22.845622	f
771	2026-01-27	01:09:00	12:20, 15:14, 19:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.60	20.90	🔺 So So	16.70	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.247397	2026-03-10 14:01:32.490586	f
772	2026-01-27	01:09:00	-	Kibble	now 	雞肉成貓 高湯天然糧	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.249273	2026-03-10 14:01:40.567338	f
773	2026-01-27	01:09:00	10:01, 15:12, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	2.40	💕 Love it So Much	7.60	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:08.251167	2026-03-10 14:01:49.170685	f
770	2026-01-27	01:09:00	-	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	35.10	❌ No!!!	39.90	0	💖 - ❌	18	10:00 很躁動, 跟上跟下衝來衝去的/20g乾乾+ 5g誠實貓 (比例)/誠實貓鴨柳	\N	2	\N	2026-02-23 13:47:08.245668	2026-03-10 14:01:58.880325	f
776	2026-01-27	13:10:00	21:59, 5:36	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	32.00	🔺 So So	48.00	2	💖 - 🔺	27		\N	2	\N	2026-02-23 13:47:08.257931	2026-03-10 14:02:10.443882	f
777	2026-01-27	13:10:00	21:08, 21:55, 00:39, 4:00, 5:33, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	14.50	🔺 So So	23.00	5	❌ - 🔺	23		\N	2	\N	2026-02-23 13:47:08.260483	2026-03-10 14:02:24.257884	f
778	2026-01-27	13:10:00	-	Kibble	now 	雞肉成貓 高湯天然糧	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.26212	2026-03-10 14:02:34.115127	f
779	2026-01-27	13:10:00	23:22, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.10	🔺 So So	3.90	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.263809	2026-03-10 14:02:44.183129	f
775	2026-01-27	10:00:00	19:46, 	Wet	ciao	原湯杯53號 (雞肉+蟹肉棒+柴魚片)	💖 Yes, eat right away	60.00	37.40	🔺 So So	22.60	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:08.255926	2026-03-10 14:02:53.207985	f
765	2026-01-26	02:00:00	10:25, 15:26, 17:37, 19:27, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	12.80	💕 Love it So Much	57.20	4	💖 - 💕	48		\N	2	\N	2026-02-23 13:47:08.230687	2026-03-10 14:03:27.527742	f
762	2026-01-26	01:22:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.50	21.50	❌ No!!!	0.00	0	❌ - ❌	8	1.5g誠實貓 鴨肉凍乾撒上方	\N	2	\N	2026-02-23 13:47:08.223866	2026-03-10 14:03:37.012926	f
763	2026-01-26	01:22:00	9:40, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	9.60	🔺 So So	0.70	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.226181	2026-03-10 14:03:45.409285	f
764	2026-01-26	01:22:00	-	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.00	1.50	🔺 So So	2.50	0	❌ - 🔺	13		\N	2	\N	2026-02-23 13:47:08.228453	2026-03-10 14:03:53.952132	f
768	2026-01-26	12:30:00	00:22, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.50	15.40	🔺 So So	6.10	1	❌ - 🔺	15	1.5g誠實貓 鴨肉凍乾撒上方	\N	2	\N	2026-02-23 13:47:08.239057	2026-03-10 14:04:27.818915	f
769	2026-01-26	12:30:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.243275	2026-03-10 14:04:35.849847	f
767	2026-01-26	12:30:00	20:27, 21:37, 00:25, 3:26, 5:50	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	12.90	🔺 So So	17.10	5	❌ - 🔺	23		\N	2	\N	2026-02-23 13:47:08.237218	2026-03-10 14:04:44.139864	f
766	2026-01-26	12:30:00	00:25, 5:51 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	84.20	🔺 So So	45.80	2	💖 - 🔺	27		\N	2	\N	2026-02-23 13:47:08.235349	2026-03-10 14:04:53.994412	f
2351	2026-03-06	02:56:00	13:09, 14:52, 17:53, 20:32, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.30	12.60	🔺 So So	7.70	4	❌ - 🔺	21		\N	2	\N	2026-03-06 02:57:04.147909	2026-03-06 12:41:58.100172	f
2372	2026-03-08	02:23:00	15:56, 18:46, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	19.30	🔺 So So	0.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 02:23:54.998391	2026-03-08 12:23:13.341454	f
2316	2026-03-05	01:59:00	-	Freeze-Dried	索美達	凍乾生食貓貓餐 - 紐西蘭北島放牧雞	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-05 01:59:38.239564	2026-03-05 12:06:05.778784	f
2371	2026-03-07	13:50:00	-	Kibble	alleva 艾雷雅	均衡照護無麩系列 農場饗宴&敏感護理 放養鮮鴨 成貓	❌ No, not interested	20.70	20.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-07 13:57:48.067119	2026-03-08 02:21:04.59502	f
2366	2026-03-07	02:38:00	13:01, 16:59, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	25.10	🔺 So So	44.90	2	💖 - 🔺	27		\N	2	\N	2026-03-07 02:38:27.621494	2026-03-07 12:48:58.382811	f
2344	2026-03-05	12:04:00	20:51, 23:41, 1:53, 6:50,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	13.10	🔺 So So	11.90	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5g/03-06 1:58/2:40 吐食物	\N	2	\N	2026-03-05 12:04:55.087697	2026-03-06 02:52:22.524741	f
2354	2026-03-06	19:04:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.50	20.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-06 09:32:04.986139	2026-03-06 09:32:23.867195	f
801	2026-01-30	00:50:00	12:50, 14:48, 18:16, 19:07, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	21.60	🔺 So So	15.80	4	❌ - 🔺	21		\N	2	\N	2026-02-23 13:47:08.30909	2026-03-10 13:50:42.113977	f
2362	2026-03-07	01:14:00	-	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	46.10	❌ No!!!	33.90	0	💖 - ❌	18		\N	2	\N	2026-03-07 01:14:55.449431	2026-03-07 12:48:16.041726	f
2370	2026-03-07	12:46:00	21:57, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.40	6.30	🔺 So So	4.10	1	❌ - 🔺	15		\N	2	\N	2026-03-07 12:47:03.285814	2026-03-08 02:20:38.009238	f
1361	2025-04-12	01:00:00	9:27, 16:37, 	Wet	姆吉	2號無穀鮮肉餐包 鮪魚雞肉 mc-rm2	❌ No, not interested	70.00	51.80	🔺 So So	18.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.120718	2026-03-09 12:16:29.187213	f
1904	2025-06-27	02:17:00	-	Wet	ciao	ic-217 貓用巧餐包 - 雞肉+鰹魚乾	💖 Yes, eat right away	40.00	15.60	❌ No!!!	24.40	0	💖 - ❌	18	一直喵喵叫就是不吃,	\N	2	\N	2026-03-04 11:51:06.270189	2026-03-10 04:39:22.837045	f
2039	2025-07-20	10:40:00	1:47, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	17.40	💕 Love it So Much	42.60	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.854906	2026-03-10 07:45:52.472619	f
2237	2025-08-20	13:05:00	23:28, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	🔺 No, not really. Ate A Little	80.00	40.30	🔺 So So	39.70	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:08.12998	2026-03-10 08:56:24.643064	f
810	2026-01-31	11:30:00	20:17, 3:13, 6:13, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	40.50	💕 Love it So Much	64.50	3	💖 - 💕	39		\N	2	\N	2026-02-23 13:47:08.336482	2026-03-10 13:48:43.876395	f
811	2026-01-31	11:30:00	19:39, 22:22, 23:43, 3:11, 6:11, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	12.50	🔺 So So	25.00	5	❌ - 🔺	23		\N	2	\N	2026-02-23 13:47:08.338381	2026-03-10 13:48:52.402706	f
809	2026-01-31	04:00:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	19.20	❌ No!!!	15.80	0	💖 - ❌	18		\N	2	\N	2026-02-23 13:47:08.334446	2026-03-10 13:49:11.336608	f
807	2026-01-31	02:00:00	12:51, 15:25, 16:25,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	25.00	🔺 So So	12.40	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.329272	2026-03-10 13:49:20.423383	f
806	2026-01-31	02:00:00	14:47, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x3	💖 Yes, eat right away	105.00	52.60	🔺 So So	52.40	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:08.326837	2026-03-10 13:49:31.227308	f
808	2026-01-31	02:00:00	11:47, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	9.00	🔺 So So	1.30	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.331093	2026-03-10 13:49:39.40123	f
800	2026-01-30	00:50:00	-	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	42.40	❌ No!!!	37.60	0	💖 - ❌	18	00:00-2:00 躁動	\N	2	\N	2026-02-23 13:47:08.307249	2026-03-10 13:50:34.220751	f
802	2026-01-30	00:50:00	12:52, 15:46, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.50	🔺 So So	1.50	2	❌ - 🔺	17		\N	2	\N	2026-02-23 13:47:08.311303	2026-03-10 13:50:52.559878	f
803	2026-01-30	11:55:00	21:10, 1:09,  5:49, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	18.70	💕 Love it So Much	86.30	3	💖 - 💕	46		\N	2	\N	2026-02-23 13:47:08.31345	2026-03-10 13:51:09.385408	f
804	2026-01-30	11:55:00	19:55, 22:15, 1:08, 5:46, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	17.90	🔺 So So	19.60	4	❌ - 🔺	21		\N	2	\N	2026-02-23 13:47:08.315082	2026-03-10 13:51:20.574678	f
805	2026-01-30	11:55:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.317395	2026-03-10 13:51:29.402582	f
799	2026-01-29	16:15:00	-	Kibble	now	雞肉成貓 高湯天然糧	❌ No, not interested	20.50	20.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.302911	2026-03-10 13:54:40.716214	f
798	2026-01-29	16:15:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x3	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.301104	2026-03-10 13:57:16.157229	f
797	2026-01-29	13:08:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	10.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.299278	2026-03-10 13:57:29.101226	f
796	2026-01-29	13:08:00	21:05, 21:53, 2:01, 5:12, 6:48,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	16.40	🔺 So So	21.00	5	❌ - 🔺	23		\N	2	\N	2026-02-23 13:47:08.296415	2026-03-10 13:57:37.385334	f
795	2026-01-29	13:08:00	-	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	🔺 No, not really. Ate A Little	80.00	66.30	❌ No!!!	13.70	0	🔺 - ❌	13		\N	2	\N	2026-02-23 13:47:08.294786	2026-03-10 13:57:55.167104	f
159	2026-02-13	00:50:00	9:26, 14:18, 18:29, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.50	25.90	🔺 So So	11.60	3	❌ - 🔺	19	加汪喵 櫻桃鴨 7.5g	\N	2	\N	2026-02-13 08:33:38.478918	2026-02-23 14:21:28.88329	f
177	2026-02-14	09:45:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	❌ No, not interested	60.00	33.00	🔺 So So	27.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-02-19 03:56:42.159163	2026-02-23 14:23:29.07891	f
208	2026-02-21	12:01:00	20:36, 23:45, 1:34, 4:16, 7:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.70	2.10	💕 Love it So Much	23.60	5	❌ - 💕	40	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-02-21 12:01:39.43012	2026-02-23 14:27:07.261942	f
216	2026-02-22	02:10:00	12:30, 17:19,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	15.60	🔺 So So	9.60	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-02-22 12:38:39.554295	2026-02-23 14:27:29.043765	f
225	2026-02-23	01:53:00	14:37, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	7.80	🔺 So So	2.20	1	❌ - 🔺	15		\N	2	\N	2026-02-23 01:53:52.829145	2026-02-23 14:30:18.968404	f
818	2026-02-24	13:08:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-24 13:08:26.242092	2026-02-25 01:50:18.633239	f
820	2026-02-24	13:28:00	22:28, 23:36, 4:34, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	26.20	💕 Love it So Much	78.80	3	💖 - 💕	46		\N	2	\N	2026-02-24 13:28:49.792692	2026-02-25 01:51:07.472928	f
812	2026-01-31	11:30:00	20:13, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	4.50	🔺 So So	5.50	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.34027	2026-03-10 13:48:34.962977	f
817	2026-02-24	13:07:00	-	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	30.00	30.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-24 13:07:20.670187	2026-02-28 07:52:17.231007	f
815	2026-02-24	01:27:00	10:39, 13:27, 14:40, 16:25,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	16.60	🔺 So So	8.50	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-02-24 01:28:05.838058	2026-02-24 13:09:01.926855	f
520	2026-02-23	12:03:00	1:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.10	21.30	🔺 So So	2.80	1	❌ - 🔺	15	加 誠實貓 雞塊3.4g	\N	2	\N	2026-02-23 12:03:33.151233	2026-02-24 01:21:40.232713	f
814	2026-02-24	01:25:00	12:17, 14:41, 19:24, 20:13, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	30.00	15.00	🔺 So So	15.00	4	❌ - 🔺	21		\N	2	\N	2026-02-24 01:25:12.279195	2026-02-28 07:52:05.755601	f
521	2026-02-23	12:05:00	00:11,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.80	💕 Love it So Much	6.20	1	❌ - 💕	25		\N	2	\N	2026-02-23 12:06:00.532414	2026-02-24 01:22:37.303177	f
522	2026-02-23	12:07:00	21:37, 22:46, 4:55,	Wet	ciao 	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	24.10	💕 Love it So Much	55.90	3	💖 - 💕	39		\N	2	\N	2026-02-23 12:07:53.413057	2026-02-24 01:23:19.367854	f
813	2026-02-24	01:19:00	10:40, 12:18, 19:26, 	Wet	ciao 	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	26.20	💕 Love it So Much	53.80	3	💖 - 💕	39		\N	2	\N	2026-02-24 01:20:33.649612	2026-02-24 13:11:56.684222	f
823	2026-02-25	01:55:00	12:08, 14:49, 16:36, 20:53, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.80	5.60	💕 Love it So Much	18.20	4	❌ - 💕	38	加汪喵 櫻桃鴨 3.8g	\N	2	\N	2026-02-25 01:55:27.213901	2026-02-25 12:55:32.561662	f
827	2026-02-25	12:59:00	22:11, 3:36, 6:51,	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	9.60	🔺 So So	10.40	3	❌ - 🔺	19		\N	2	\N	2026-02-25 13:00:10.054186	2026-02-28 07:52:40.291855	f
819	2026-02-24	13:10:00	22:26, 23:35, 4:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	5.80	🔺 So So	19.30	3	❌ - 🔺	26	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-02-24 13:10:45.790062	2026-02-25 01:49:49.574325	f
826	2026-02-25	12:57:00	22:11, 23:03, 00:19, 6:51,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	10.00	💕 Love it So Much	15.10	4	❌ - 💕	31	加誠實貓 鴨柳 5.1g	\N	2	\N	2026-02-25 12:58:00.267818	2026-02-26 01:49:14.152608	f
822	2026-02-25	01:53:00	10:32, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.80	🔺 So So	1.20	1	❌ - 🔺	15		\N	2	\N	2026-02-25 01:53:17.124907	2026-02-25 13:01:49.715238	f
821	2026-02-25	01:46:00	12:09, 14:50, 16:37, 19:04, 	Wet	ciao 	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	22.60	💕 Love it So Much	57.40	4	💖 - 💕	41		\N	2	\N	2026-02-25 01:47:31.792675	2026-02-25 13:03:40.600582	f
833	2026-02-26	01:57:00	14:44, 17:12, 19:05, 20:53,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	14.20	💕 Love it So Much	11.00	4	❌ - 💕	31	加誠實貓 鴨柳 5.2g	\N	2	\N	2026-02-26 01:57:24.95183	2026-02-26 12:55:27.629216	f
829	2026-02-25	13:02:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-25 13:02:49.485421	2026-02-26 01:48:36.258677	f
68	2026-02-04	04:20:00	13:53, 17:01, 	Wet	ciao 	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	61.70	🔺 So So	43.30	2	💖 - 🔺	27		\N	2	\N	2026-02-12 14:41:10.10355	2026-02-26 11:36:24.193201	f
836	2026-02-26	10:09:00	19:06, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	4.80	💕 Love it So Much	30.20	1	💖 - 💕	42	一直叫想吃, 放下去馬上吃	\N	2	\N	2026-02-26 10:09:38.25681	2026-02-26 13:01:45.219321	f
835	2026-02-26	02:01:00	10:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	4.40	🔺 So So	5.60	1	❌ - 🔺	15		\N	2	\N	2026-02-26 02:02:14.323453	2026-02-26 12:59:02.600467	f
519	2026-02-23	12:00:00	21:36, 22:45, 1:29, 4:53,	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	4.00	💕 Love it So Much	16.00	4	❌ - 💕	38		\N	2	\N	2026-02-23 12:01:05.417511	2026-02-28 07:51:51.24948	f
72	2026-02-04	12:30:00	20:52, 23:31, 2:11, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	53.20	🔺 So So	76.80	3	💖 - 🔺	29		\N	2	\N	2026-02-12 14:41:10.145602	2026-02-26 11:37:03.758741	f
825	2026-02-25	12:54:00	23:03, 00:21, 3:38, 6:52	Wet	ciao 	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	18.60	💕 Love it So Much	61.40	4	💖 - 💕	48		\N	2	\N	2026-02-25 12:54:41.415314	2026-02-26 11:42:52.257065	f
837	2026-02-26	12:51:00	21:37, 1:31, 7:07, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	42.90	💕 Love it So Much	62.10	3	💖 - 💕	39		\N	2	\N	2026-02-26 12:51:35.571854	2026-02-27 00:52:30.885038	f
824	2026-02-25	01:57:00	19:03, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	15.10	🔺 So So	4.90	1	❌ - 🔺	15		\N	2	\N	2026-02-25 01:57:20.325872	2026-02-28 07:52:29.006269	f
834	2026-02-26	01:59:00	14:44, 19:44, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.30	15.90	🔺 So So	4.40	2	❌ - 🔺	17		\N	2	\N	2026-02-26 01:59:36.47563	2026-02-26 12:53:10.069784	f
1930	2025-06-30	11:10:00	22:16, 23:19, 8:36, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.40	14.70	🔺 So So	6.70	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.347246	2026-03-10 04:43:33.851298	f
1606	2025-05-18	01:10:00	10:46, 14:21, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	25.90	💕 Love it So Much	54.10	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.294935	2026-03-09 13:46:37.294343	f
844	2026-02-27	00:58:00	15:20, 16:56, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	12.10	🔺 So So	7.90	2	❌ - 🔺	17		\N	2	\N	2026-02-27 00:58:54.143563	2026-02-27 12:46:00.232699	f
586	2026-01-07	09:55:00	-	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	🔺 No, not really. Ate A Little	80.00	76.10	❌ No!!!	3.90	0	🔺 - ❌	13		\N	2	\N	2026-02-23 13:47:07.668075	2026-03-11 08:26:41.184263	f
843	2026-02-27	00:53:00	9:35, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.10	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-02-27 00:54:01.490428	2026-02-27 12:48:23.595413	f
682	2026-01-18	01:00:00	12:28	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	36.00	🔺 So So	44.00	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:07.953253	2026-03-11 08:50:48.05874	f
853	2026-02-28	02:00:00	-	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3 x2	🔺 No, not really. Ate A Little	114.00	99.40	❌ No!!!	14.60	0	🔺 - ❌	13	13:45 一直叫, 有點躁動	\N	2	\N	2026-02-28 02:01:26.567891	2026-03-02 13:30:17.575402	f
838	2026-02-26	12:53:00	1:30, 2:49, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.30	12.40	🔺 So So	7.90	2	❌ - 🔺	17		\N	2	\N	2026-02-26 12:54:09.534887	2026-02-27 00:50:42.809554	f
839	2026-02-26	12:55:00	21:36, 1:31, 7:03,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	13.30	🔺 So So	11.70	3	❌ - 🔺	19	加誠實貓 鴨柳 4.8g	\N	2	\N	2026-02-26 12:57:32.882699	2026-02-27 00:51:10.536974	f
840	2026-02-26	12:59:00	23:37,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.40	🔺 So So	3.60	1	❌ - 🔺	15		\N	2	\N	2026-02-26 12:59:47.07864	2026-02-27 00:51:41.160114	f
845	2026-02-27	00:59:00	13:31, 18:51, 20:36, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	11.60	🔺 So So	13.60	3	❌ - 🔺	19	加誠實貓 鴨柳 5.2g	\N	2	\N	2026-02-27 01:01:21.001339	2026-02-27 12:42:24.6973	f
849	2026-02-27	12:46:00	6:02,	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.40	19.60	🔺 So So	0.80	1	❌ - 🔺	15		\N	2	\N	2026-02-27 12:46:54.685766	2026-02-28 02:05:58.373087	f
852	2026-02-27	12:42:00	21:37, 23:58, 1:01, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	13.30	🔺 So So	11.80	3	❌ - 🔺	19	加誠實貓 鴨柳 5.1g	\N	2	\N	2026-02-27 13:42:27.405033	2026-02-28 02:06:28.495456	f
850	2026-02-27	12:48:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-27 12:49:19.889533	2026-02-28 02:06:49.979796	f
847	2026-02-27	12:41:00	21:38, 00:00, 1:02, 6:22,	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	39.00	💕 Love it So Much	91.00	4	💖 - 💕	41		\N	2	\N	2026-02-27 12:41:18.796558	2026-02-28 02:07:33.944123	f
855	2026-02-28	02:07:00	15:39, 20:17, 20:48, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	11.30	🔺 So So	8.70	3	❌ - 🔺	19		\N	2	\N	2026-02-28 02:08:28.688406	2026-02-28 14:00:52.875295	f
858	2026-02-28	05:43:00	15:40, 17:44, 20:19, 20:49, 	Wet	ciao 	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	27.30	💕 Love it So Much	52.70	4	💖 - 💕	41		\N	2	\N	2026-02-28 05:46:10.502526	2026-02-28 14:01:22.206718	f
869	2026-02-28	13:16:00	22:28, 1:12, 6:01	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.50	10.00	🔺 So So	15.50	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.5g	\N	2	\N	2026-02-28 15:58:24.315284	2026-03-01 01:39:53.280868	f
856	2026-02-28	02:08:00	10:49, 20:50, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	1.60	💕 Love it So Much	8.40	2	❌ - 💕	34		\N	2	\N	2026-02-28 02:09:46.948337	2026-02-28 14:01:40.67731	f
868	2026-02-28	02:03:00	11:29, 17:43, 20:18, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.90	17.50	🔺 So So	7.40	3	❌ - 🔺	19	加誠實貓 鴨柳 4.9g	\N	2	\N	2026-02-28 15:57:00.957653	2026-02-28 15:57:35.937486	f
867	2026-02-28	13:18:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-28 13:18:46.929419	2026-03-01 01:40:21.578213	f
864	2026-02-28	13:12:00	22:30, 23:48, 1:13, 6:02,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	27.10	💕 Love it So Much	77.90	4	💖 - 💕	41		\N	2	\N	2026-02-28 13:12:44.682121	2026-03-01 01:41:31.026848	f
865	2026-02-28	13:13:00	23:47, 7:35,	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	15.00	🔺 So So	5.00	2	❌ - 🔺	17		\N	2	\N	2026-02-28 13:14:02.196355	2026-03-01 01:42:45.086038	f
872	2026-03-01	01:45:00	12:58,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	5.30	🔺 So So	4.70	1	❌ - 🔺	15		\N	2	\N	2026-03-01 01:45:58.556034	2026-03-01 12:54:53.522077	f
875	2026-03-01	01:48:00	11:35, 11:42, 12:05, 20:05, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	13.00	🔺 So So	12.20	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5.2g/11:50, 12:24 吐食物	\N	2	\N	2026-03-01 01:50:56.198662	2026-03-01 12:54:20.880246	f
846	2026-02-27	01:02:00	9:37, 13:32, 15:21, 	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71 x2	🔺 No, not really. Ate A Little	120.00	66.60	🔺 So So	53.40	3	🔺 - 🔺	24		\N	2	\N	2026-02-27 01:04:15.553203	2026-03-02 12:53:42.800571	f
871	2026-03-01	01:44:00	12:04, 19:19, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	17.70	🔺 So So	2.30	2	❌ - 🔺	17		\N	2	\N	2026-03-01 01:44:46.638828	2026-03-01 12:54:45.982876	f
880	2026-03-01	12:58:00	22:56, 2:49, 5:32, 	Wet	ciao 	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	19.00	💕 Love it So Much	61.00	3	💖 - 💕	46		\N	2	\N	2026-03-01 12:58:19.161303	2026-03-02 02:14:17.438626	f
879	2026-03-01	12:42:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-01 12:42:11.204714	2026-03-02 01:18:42.007671	f
876	2026-03-01	01:54:00	11:44, 12:06, 20:07, 	Wet	ciao 	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	27.60	💕 Love it So Much	52.40	3	💖 - 💕	39		\N	2	\N	2026-03-01 01:54:41.889714	2026-03-02 12:30:55.189896	f
2306	2026-03-04	13:30:00	-	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	70.00	❌ No!!!	10.00	0	🔺 - ❌	13	有點躁動	\N	2	\N	2026-03-04 13:34:59.853553	2026-03-04 15:04:08.128272	f
2309	2026-03-04	13:42:00	22:49, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	4.80	🔺 So So	5.20	1	❌ - 🔺	15		\N	2	\N	2026-03-04 13:42:13.833526	2026-03-05 01:07:47.356528	f
877	2026-03-01	12:36:00	22:53, 2:46,	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.20	9.30	🔺 So So	10.90	2	❌ - 🔺	17		\N	2	\N	2026-03-01 12:37:00.367499	2026-03-02 02:13:51.493828	f
883	2026-03-02	01:12:00	18:00, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	13.40	🔺 So So	6.60	1	❌ - 🔺	15		\N	2	\N	2026-03-02 01:12:48.690184	2026-03-02 13:01:34.361235	f
886	2026-03-02	02:22:00	12:40, 15:56, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	4.40	💕 Love it So Much	60.60	2	💖 - 💕	44		\N	2	\N	2026-03-02 02:22:44.366224	2026-03-02 10:25:16.548312	f
885	2026-03-02	01:20:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	7.10	🔺 So So	2.90	0	💖 - 🔺	23		\N	2	\N	2026-03-02 01:21:32.273515	2026-03-02 13:06:25.490556	f
882	2026-03-02	01:11:00	18:02, 	Wet	ciao 	ic49 多樂米雞肉沾醬 20g x4	💖 Yes, eat right away	80.00	31.60	🔺 So So	48.40	1	💖 - 🔺	25		\N	2	\N	2026-03-02 01:11:31.321966	2026-03-02 13:08:29.76953	f
2346	2026-03-05	12:15:00	20:52, 21:39, 23:42, 1:55, 3:09, 5:02,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	❌ No, not interested	105.00	13.60	💕 Love it So Much	91.40	6	❌ - 💕	42		\N	2	\N	2026-03-05 12:15:44.2198	2026-03-06 02:53:26.225423	f
1887	2025-06-24	11:04:00	1:22, 4:37, 7:53,	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	39.10	28.70	🔺 So So	10.40	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.211377	2026-03-10 04:34:11.077055	f
2350	2026-03-06	02:48:00	11:41, 13:10, 19:17, 20:33, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	18.70	💕 Love it So Much	61.30	4	💖 - 💕	48		\N	2	\N	2026-03-06 02:53:57.666233	2026-03-06 12:48:35.409976	f
2357	2026-03-06	12:37:00	21:50, 1:47, 3:05, 9:00, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	37.30	💕 Love it So Much	92.70	4	💖 - 💕	41		\N	2	\N	2026-03-06 12:37:50.78963	2026-03-07 01:19:09.875989	f
887	2025-01-01	03:20:00	12:29, 17:55	Wet	ciao	cc-85 貓用頂級奢華鮪魚 鮪魚+蟹肉	💖 Yes, eat right away	60.00	37.80	🔺 So So	22.20	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.636418	2026-03-08 20:00:09.733715	f
894	2025-01-02	12:50:00	23:28, 00:04, 6:10	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	❌ No, not interested	80.00	40.20	🔺 So So	39.80	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.681182	2026-03-09 01:14:59.162719	f
890	2025-01-01	14:00:00	23:47, 4:25,	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	💖 Yes, eat right away	65.00	44.60	🔺 So So	20.40	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.648646	2026-03-08 20:01:58.989234	f
888	2025-01-01	03:20:00	12:27, 17:53	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	22.20	15.40	🔺 So So	6.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.641813	2026-03-08 20:03:53.93404	f
893	2025-01-02	10:00:00	18:35, 19:10, 23:27, 00:03, 4:47, 6:09	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	27.50	12.00	💕 Love it So Much	15.50	6	❌ - 💕	35	加 好味小姐凍乾 2.3g	\N	2	\N	2026-03-02 12:05:31.657591	2026-03-09 01:15:57.486283	f
891	2025-01-02	02:30:00	-	Wet	長靴貓	湯罐 鮪魚雞肉+鮭魚	🔺 No, not really. Ate A Little	50.00	30.80	❌ No!!!	19.20	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:31.652012	2026-03-09 01:16:16.40755	f
892	2025-01-02	02:30:00	11:12, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.50	17.20	🔺 So So	4.30	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.655006	2026-03-09 01:17:05.998613	f
895	2025-01-03	02:55:00	17:44, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	47.20	🔺 So So	37.80	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.683232	2026-03-09 03:32:26.857925	f
896	2025-01-03	02:55:00	15:40, 17:42,	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	20.50	14.80	🔺 So So	5.70	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.685785	2026-03-09 03:32:46.178735	f
897	2025-01-03	10:30:00	22:58, 4:11, 6:09, 8:55	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	41.20	19.30	🔺 So So	21.90	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:31.68806	2026-03-09 03:35:39.204496	f
898	2025-01-03	12:45:00	21:31, 21:55, 23:41, 4:13, 6:11	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	16.80	💕 Love it So Much	33.20	5	💖 - 💕	43		\N	2	\N	2026-03-02 12:05:31.689996	2026-03-09 03:35:15.674297	f
899	2025-01-04	02:48:00	16:06, 	Wet	oasy	雞肉佐鮪魚鮮食	💖 Yes, eat right away	70.00	31.40	🔺 So So	38.60	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.692462	2026-03-09 03:38:22.294506	f
900	2025-01-04	02:48:00	15:40, 15:48, 16:04, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	21.10	15.30	🔺 So So	5.80	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.69438	2026-03-09 03:38:33.030405	f
901	2025-01-04	10:25:00	20:51, 23:21, 00:09, 2:56, 5:38, 9:28	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	44.40	21.50	💕 Love it So Much	22.90	6	❌ - 💕	35	加 好味小姐凍乾 4g	\N	2	\N	2026-03-02 12:05:31.696318	2026-03-09 03:38:47.070536	f
902	2025-01-04	12:52:00	23:22, 00:11, 5:41, 9:29,	Wet	ciao	cc-83 貓用頂級奢華鮪魚 鮪魚+鰹魚 凍罐	💖 Yes, eat right away	60.00	29.10	🔺 So So	30.90	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:31.69821	2026-03-09 03:38:59.489727	f
904	2025-01-05	03:30:00	14:20, 17:06,	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	21.40	17.50	🔺 So So	3.90	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.70232	2026-03-09 03:39:57.998903	f
903	2025-01-05	03:30:00	17:18, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	29.10	🔺 So So	35.90	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.700144	2026-03-09 03:40:09.298377	f
905	2025-01-05	09:15:00	21:38, 5:11,	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	48.70	34.20	🔺 So So	14.50	2	❌ - 🔺	17	加 好味小姐凍乾 5.7g	\N	2	\N	2026-03-02 12:05:31.704324	2026-03-09 03:40:27.652125	f
906	2025-01-05	13:45:00	00:23, 6:40	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	💖 Yes, eat right away	85.00	42.30	🔺 So So	42.70	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.706729	2026-03-09 03:40:42.066853	f
908	2025-01-06	02:18:00	15:33, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	21.40	15.60	🔺 So So	5.80	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.711581	2026-03-09 03:41:36.094207	f
907	2025-01-06	02:18:00	11:25, 15:36, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	31.30	🔺 So So	28.70	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.709599	2026-03-09 03:42:07.413668	f
2355	2026-03-06	02:59:00	14:53, 15:46, 19:16, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	15.60	🔺 So So	9.60	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-03-06 10:08:49.230106	2026-03-06 12:39:00.847432	f
910	2025-01-06	13:45:00	23:05, 00:15, 4:19, 6:21	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝) 	💖 Yes, eat right away	50.00	22.40	🔺 So So	27.60	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:31.716136	2026-03-09 03:41:22.65871	f
911	2025-01-07	02:30:00	-	Wet	心靈雞湯	主食罐 雞肉及鮭魚	❌ No, not interested	156.00	156.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:31.720829	2026-03-09 03:42:37.710446	f
913	2025-01-07	02:30:00	13:46, 17:32, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	20.00	15.20	🔺 So So	4.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.725257	2026-03-09 03:42:51.395922	f
912	2025-01-07	02:30:00	13:47, 17:33, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	27.90	🔺 So So	32.10	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.723361	2026-03-09 03:43:09.769177	f
914	2025-01-07	10:30:00	18:37, 23:01, 1:46, 5:07, 10:04	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	40.50	25.40	🔺 So So	15.10	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:31.727354	2026-03-09 03:43:20.09248	f
919	2025-01-08	10:07:00	20:48, 22:06, 1:03, 4:48, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	45.00	28.60	🔺 So So	16.40	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:31.739367	2026-03-09 03:44:12.337902	f
920	2025-01-08	10:07:00	22:07, 1:04, 4;45, 7:15, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	❌ No, not interested	60.00	30.90	🔺 So So	29.10	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:31.74143	2026-03-09 03:44:22.39884	f
917	2025-01-08	02:05:00	-	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.20	19.60	❌ No!!!	1.60	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:31.73506	2026-03-09 03:44:36.135886	f
916	2025-01-08	02:05:00	11:05, 	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	💖 Yes, eat right away	65.00	38.00	🔺 So So	27.00	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.732647	2026-03-09 03:44:44.787787	f
918	2025-01-08	07:45:00	-	Other	零食	零食	❌ No, not interested	6.60	0.00	💕 Love it So Much	6.60	0	❌ - 💕	30		\N	2	\N	2026-03-02 12:05:31.737462	2026-03-09 03:45:16.154316	f
923	2025-01-09	10:15:00	18:10, 18:42, 19:06, 00:41, 4:42,	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	45.60	26.60	🔺 So So	19.00	5	❌ - 🔺	23	加 好味小姐凍乾 3.3g	\N	2	\N	2026-03-02 12:05:31.747168	2026-03-09 03:45:48.953668	f
924	2025-01-09	10:15:00	22:00, 00:42, 4:44,	Wet	ciao	近海鰹魚罐93號 (干貝味) 	❌ No, not interested	80.00	34.40	🔺 So So	45.60	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.749296	2026-03-09 03:45:58.541563	f
922	2025-01-09	02:06:00	15:45,	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	21.00	17.00	🔺 So So	4.00	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.74531	2026-03-09 03:46:08.78724	f
921	2025-01-09	02:06:00	-	Wet	ciao	a-134 1000億乳酸菌(白身鮪魚)	🔺 No, not really. Ate A Little	85.00	71.00	🔺 So So	14.00	0	🔺 - 🔺	18		\N	2	\N	2026-03-02 12:05:31.743406	2026-03-09 03:46:19.124314	f
926	2025-01-10	02:30:00	11:56, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	21.00	17.10	🔺 So So	3.90	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.75339	2026-03-09 03:46:36.90512	f
925	2025-01-10	02:30:00	11:30, 11:56, 15:14, 	Wet	mon petit 貓倍麗	 鰹魚鮮雞雙拼餐盒 lc3	💖 Yes, eat right away	57.00	8.30	💕 Love it So Much	48.70	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:31.751176	2026-03-09 03:46:48.169184	f
928	2025-01-10	13:35:00	22:40, 00:41, 5:10, 6:07, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	35.90	🔺 So So	49.10	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:31.781121	2026-03-09 03:47:00.104631	f
927	2025-01-10	13:35:00	22:38, 00:39, 5:08, 6:05, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	42.30	24.90	🔺 So So	17.40	4	❌ - 🔺	21	加 好味小姐凍乾 5.2g	\N	2	\N	2026-03-02 12:05:31.755317	2026-03-09 03:47:09.522208	f
929	2025-01-11	01:50:00	00:18, 17:39, 19:03, 	Wet	oasy	雞肉佐哈姆鮮食	💖 Yes, eat right away	70.00	17.50	💕 Love it So Much	52.50	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:31.784177	2026-03-09 04:06:11.910456	f
930	2025-01-11	01:50:00	00:17, 16:31, 17:38, 19:02, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	💖 Yes, eat right away	20.60	16.40	🔺 So So	4.20	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:31.786738	2026-03-09 04:06:21.506329	f
932	2025-01-11	14:05:00	22:15, 00:08, 2:01, 5:00, 6:21, 9:43, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	❌ No, not interested	85.00	11.70	💕 Love it So Much	73.30	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:31.792524	2026-03-09 04:06:47.278108	f
931	2025-01-11	11:05:00	22:14, 6:20, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	43.80	34.50	🔺 So So	9.30	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.788927	2026-03-09 04:07:05.173444	f
933	2025-01-12	02:50:00	11:33, 15:00, 15:54, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	33.30	🔺 So So	31.70	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:31.795813	2026-03-09 04:07:21.825821	f
934	2025-01-12	02:50:00	11:30, 14:59, 15:53, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	20.90	11.90	🔺 So So	9.00	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.798098	2026-03-09 04:07:32.566035	f
935	2025-01-12	10:00:00	21:58, 00:21, 5:19, 9:44	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	41.60	20.00	🔺 So So	21.60	4	❌ - 🔺	21	加 好味小姐凍乾 3.8g	\N	2	\N	2026-03-02 12:05:31.800152	2026-03-09 04:07:45.266801	f
936	2025-01-12	13:35:00	21:59, 00:24, 5:22, 9:47, 10:17, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	22.20	🔺 So So	27.80	5	💖 - 🔺	33		\N	2	\N	2026-03-02 12:05:31.801925	2026-03-09 04:07:57.101964	f
939	2025-01-13	14:30:00	00:10, 4:31,	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	36.90	21.10	🔺 So So	15.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.819929	2026-03-09 04:08:30.670475	f
940	2025-01-13	14:30:00	00:12, 4:33,	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	❌ No, not interested	80.00	53.20	🔺 So So	26.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.821957	2026-03-09 04:08:39.538003	f
938	2025-01-13	02:14:00	11:04, 14:51, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	21.30	16.10	🔺 So So	5.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.813867	2026-03-09 04:08:48.478523	f
937	2025-01-13	02:14:00	11:05, 	Wet	ciao	布丁杯 鮪魚 imc-151	🔺 No, not really. Ate A Little	65.00	48.80	🔺 So So	16.20	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:31.808355	2026-03-09 04:08:56.857518	f
944	2025-01-14	14:40:00	23:26, 4:34, 8:48	Wet	ciao	ic-506 貓用極致濃湯肉塊餐包- 雞肉+干貝 x3	❌ No, not interested	90.00	57.40	🔺 So So	32.60	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.830907	2026-03-09 04:09:24.32558	f
943	2025-01-14	14:40:00	23:25, 4:31, 8:47	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	31.10	22.60	🔺 So So	8.50	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.828624	2026-03-09 04:09:33.205603	f
942	2025-01-14	01:25:00	17:06, 17:27, 18:52, 20:16, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.90	10.80	🔺 So So	10.10	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:31.826229	2026-03-09 04:09:57.627268	f
941	2025-01-14	01:25:00	17:07, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	32.40	🔺 So So	47.60	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.823994	2026-03-09 04:10:06.659505	f
948	2025-01-15	12:30:00	23:53, 4:25, 7:25, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	34.00	16.00	🔺 So So	18.00	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.839154	2026-03-09 04:10:40.234767	f
947	2025-01-15	00:50:00	12:20, 14:57, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.60	13.40	🔺 So So	7.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.837238	2026-03-09 04:10:50.783013	f
946	2025-01-15	00:50:00	12:21, 	Wet	肉食控	鮮肉湯罐 嫩雞鮪魚	💖 Yes, eat right away	80.00	42.30	🔺 So So	37.70	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.834966	2026-03-09 04:10:59.099041	f
952	2025-01-16	11:00:00	00:33, 4:12, 9:19, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	37.80	21.10	🔺 So So	16.70	3	❌ - 🔺	19	加 好味小姐凍乾 2.8g	\N	2	\N	2026-03-02 12:05:31.847004	2026-03-09 04:11:30.362436	f
953	2025-01-16	14:25:00	00:36, 4:15, 9:21	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	41.10	🔺 So So	43.90	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:31.849063	2026-03-09 04:11:47.423199	f
951	2025-01-16	00:45:00	14:09, 15:05, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.00	13.50	🔺 So So	6.50	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.844803	2026-03-09 04:12:01.019072	f
950	2025-01-16	00:45:00	14:09, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	25.50	💕 Love it So Much	44.50	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:31.843034	2026-03-09 04:12:09.751362	f
956	2025-01-17	09:40:00	23:58, 4:04, 5:42, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	39.30	26.80	🔺 So So	12.50	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.855824	2026-03-09 04:12:35.341631	f
957	2025-01-17	09:40:00	23:59, 4:06, 5:44, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	19.30	💕 Love it So Much	30.70	3	🔺 - 💕	34		\N	2	\N	2026-03-02 12:05:31.857797	2026-03-09 04:12:46.206366	f
954	2025-01-17	01:25:00	-	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	🔺 No, not really. Ate A Little	57.00	43.90	❌ No!!!	13.10	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:31.851841	2026-03-09 04:12:55.54891	f
955	2025-01-17	01:25:00	14:35, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	20.00	18.90	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.853867	2026-03-09 04:13:04.456484	f
961	2025-01-18	12:20:00	23:44, 5:59	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	12.60	💕 Love it So Much	52.40	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:31.865736	2026-03-09 04:13:28.22402	f
958	2025-01-18	00:45:00	14:48, 18:46, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	37.00	🔺 So So	43.00	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.859722	2026-03-09 04:13:47.745555	f
959	2025-01-18	00:45:00	14:30, 14:46, 18:45	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.00	10.00	🔺 So So	10.00	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.861712	2026-03-09 04:14:05.669472	f
965	2025-01-19	12:40:00	23:12, 00:54, 04:55	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	18.80	💕 Love it So Much	51.20	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:31.87359	2026-03-09 04:14:35.77065	f
964	2025-01-19	12:40:00	00:52, 04:53, 9:15	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	37.70	27.50	🔺 So So	10.20	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.87166	2026-03-09 04:14:48.454374	f
963	2025-01-19	01:48:00	14:22, 18:05	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.40	16.00	🔺 So So	4.40	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.869722	2026-03-09 04:14:57.576061	f
962	2025-01-19	01:48:00	14:23, 18:05	Wet	ciao	cc-85 貓用頂級奢華鮪魚 鮪魚+蟹肉	💖 Yes, eat right away	60.00	36.40	🔺 So So	23.60	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.867736	2026-03-09 04:15:09.402623	f
968	2025-01-20	10:45:00	9:23,	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	36.10	19.60	🔺 So So	16.50	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.880647	2026-03-09 04:15:35.221639	f
969	2025-01-20	12:00:00	9:25,	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	28.70	🔺 So So	31.30	1	💖 - 🔺	25	00:00 有地震，很晃，阿吉有嚇到	\N	2	\N	2026-03-02 12:05:31.882801	2026-03-09 04:15:49.655677	f
967	2025-01-20	01:10:00	10:15, 14:36, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	20.60	15.30	🔺 So So	5.30	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.877518	2026-03-09 04:16:00.788638	f
966	2025-01-20	01:10:00	10:15, 14:38, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-92 鰹魚	💖 Yes, eat right away	85.00	45.00	🔺 So So	40.00	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.875547	2026-03-09 04:16:09.189764	f
972	2025-01-21	10:30:00	19:17, 4:58, 6:16, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	42.20	26.00	🔺 So So	16.20	3	❌ - 🔺	19	加 好味小姐凍乾 3.1g	\N	2	\N	2026-03-02 12:05:31.888985	2026-03-09 04:16:50.937117	f
973	2025-01-21	12:00:00	6:18, 	Wet	ciao	布丁杯 鮪魚 imc-151	❌ No, not interested	65.00	52.40	🔺 So So	12.60	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.890935	2026-03-09 04:17:10.576389	f
971	2025-01-21	01:40:00	17:36, 18:28	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	23.40	17.60	🔺 So So	5.80	2	❌ - 🔺	17	加 好味小姐凍乾 2.7g	\N	2	\N	2026-03-02 12:05:31.886704	2026-03-09 04:17:20.806475	f
970	2025-01-21	01:40:00	17:38, 18:29,	Wet	ciao	綜合燒鰹魚海鮮晚餐包 ic-562 烤鰹魚+扇貝 凍狀	❌ No, not interested	30.00	24.00	🔺 So So	6.00	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.884777	2026-03-09 04:17:44.761043	f
976	2025-01-22	01:30:00	-	Kibble	莫比	成貓化毛	❌ No, not interested	17.70	17.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:31.897178	2026-03-09 04:18:08.462016	f
975	2025-01-22	01:30:00	16:15, 18:41, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	22.80	15.10	🔺 So So	7.70	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.895273	2026-03-09 04:18:16.319874	f
979	2025-01-22	14:10:00	23:50, 	Wet	ciao	燒晚餐(雞肉+干貝) ic-282	💖 Yes, eat right away	50.00	47.20	🔺 So So	2.80	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.911041	2026-03-09 04:18:26.026782	f
978	2025-01-22	14:10:00	4:48, 	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚	🔺 No, not really. Ate A Little	35.00	14.20	🔺 So So	20.80	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:31.907869	2026-03-09 04:18:38.110455	f
977	2025-01-22	10:00:00	19:22, 23:49, 4:45, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	36.10	18.30	💕 Love it So Much	17.80	3	❌ - 💕	29		\N	2	\N	2026-03-02 12:05:31.899126	2026-03-09 04:18:50.105331	f
974	2025-01-22	01:30:00	18:43, 	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚	💖 Yes, eat right away	35.00	6.30	💕 Love it So Much	28.70	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:31.89313	2026-03-09 04:19:02.636243	f
981	2025-01-23	01:35:00	14:42, 16:38, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.90	16.50	🔺 So So	4.40	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.915596	2026-03-09 04:20:00.6355	f
980	2025-01-23	01:35:00	16:40, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	🔺 No, not really. Ate A Little	75.00	54.60	🔺 So So	20.40	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:31.913266	2026-03-09 04:20:09.672593	f
998	2025-01-27	02:00:00	-	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	🔺 No, not really. Ate A Little	57.00	40.00	❌ No!!!	17.00	0	🔺 - ❌	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:31.978858	2026-03-09 04:25:54.682905	f
1004	2025-01-29	04:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	20.00	18.00	🔺 So So	2.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.025437	2026-03-09 04:28:13.648164	f
1007	2025-01-30	04:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	20.00	20.00	🔺 So So	0.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.038337	2026-03-09 04:29:46.678363	f
1011	2025-01-31	10:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	45.00	10.00	🔺 So So	35.00	0	❌ - 🔺	20	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.045852	2026-03-09 04:30:35.044947	f
1016	2025-02-02	02:35:00	11:43, 16:52, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.60	16.90	🔺 So So	4.70	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.054935	2026-03-09 08:28:35.08959	f
1010	2025-01-31	04:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	20.00	20.00	🔺 So So	0.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.044003	2026-03-09 04:30:47.008054	f
1012	2025-01-31	10:00:00	-	Wet	餐包	餐包	❌ No, not interested	80.00	34.00	🔺 So So	46.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.047598	2026-03-09 04:30:25.522469	f
1009	2025-01-30	10:00:00	-	Wet	餐包	餐包	❌ No, not interested	150.00	13.00	🔺 So So	137.00	0	❌ - 🔺	20	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.042172	2026-03-09 04:29:28.442604	f
1008	2025-01-30	10:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	45.00	7.00	🔺 So So	38.00	0	❌ - 🔺	20	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.040266	2026-03-09 04:29:07.233384	f
1006	2025-01-29	10:00:00	-	Wet	餐包	餐包	❌ No, not interested	60.00	22.00	🔺 So So	38.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.034215	2026-03-09 04:27:43.860963	f
1005	2025-01-29	10:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	43.00	21.00	🔺 So So	22.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:32.027611	2026-03-09 04:27:33.986084	f
1002	2025-01-28	02:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	20.00	20.00	🔺 So So	0.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:31.989963	2026-03-09 04:27:01.18077	f
983	2025-01-23	10:15:00	18:44, 19:54, 22:19, 23:49, 00:52,4:29, 5:23, 8:48,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	36.80	14.70	💕 Love it So Much	22.10	7	❌ - 💕	37		\N	2	\N	2026-03-02 12:05:31.92062	2026-03-09 04:19:37.467239	f
999	2025-01-27	02:00:00	-	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	23.80	17.20	🔺 So So	6.60	0	❌ - 🔺	13	加 好味小姐凍乾 4.1g/均禾貓旅	\N	2	\N	2026-03-02 12:05:31.981572	2026-03-09 04:24:35.682865	f
1003	2025-01-28	10:00:00	-	Kibble	乾乾	乾乾	❌ No, not interested	45.00	25.00	🔺 So So	20.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:31.993214	2026-03-09 04:26:50.318483	f
1001	2025-01-27	10:00:00	-	Wet	餐包	餐包	❌ No, not interested	60.00	38.00	🔺 So So	22.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:31.987654	2026-03-09 04:25:15.946293	f
982	2025-01-23	01:35:00	-	Other	元氣王	柴魚片+小魚干	❌ No, not interested	3.60	0.00	💕 Love it So Much	3.60	0	❌ - 💕	30		\N	2	\N	2026-03-02 12:05:31.91768	2026-03-09 04:19:49.770556	f
984	2025-01-23	12:15:00	22:21, 23:51, 00:52, 4:30, 5:24, 8:49,	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	💖 Yes, eat right away	65.00	10.20	💕 Love it So Much	54.80	6	💖 - 💕	52		\N	2	\N	2026-03-02 12:05:31.923943	2026-03-09 04:20:23.513411	f
985	2025-01-24	02:15:00	10:55, 	Wet	mon petit 貓倍麗	珍饌雞里肌肉餐盒 lc4	💖 Yes, eat right away	57.00	27.90	🔺 So So	29.10	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:31.926014	2026-03-09 04:20:46.752309	f
986	2025-01-24	02:15:00	10:54, 11:19, 17:35, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	25.70	18.70	🔺 So So	7.00	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.928224	2026-03-09 04:20:55.584057	f
987	2025-01-24	13:20:00	21:53, 00:18, 3:51, 4:57, 7:00, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	39.50	27.60	🔺 So So	11.90	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:31.930928	2026-03-09 04:21:04.014971	f
988	2025-01-24	13:20:00	00:20, 3:52,  4:58, 7:02, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	22.30	🔺 So So	37.70	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:31.933545	2026-03-09 04:21:15.49998	f
990	2025-01-25	01:34:00	17:49, 18:33, 19:44, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.30	13.40	🔺 So So	6.90	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.939354	2026-03-09 04:21:36.657627	f
989	2025-01-25	01:34:00	17:49, 18:47, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	39.70	🔺 So So	40.30	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.937287	2026-03-09 04:21:45.607828	f
992	2025-01-25	11:45:00	3:30,  5:06, 6:20, 	Wet	oasy	雞肉佐哈姆鮮食	💖 Yes, eat right away	70.00	10.40	💕 Love it So Much	59.60	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:31.951987	2026-03-09 04:21:53.430822	f
991	2025-01-25	11:45:00	3:30, 5:05, 6:19, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	34.40	19.80	🔺 So So	14.60	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:31.941487	2026-03-09 04:22:02.138826	f
994	2025-01-26	02:50:00	11:20, 11:53, 12:34, 13:06, 13:20, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	24.10	16.10	🔺 So So	8.00	5	❌ - 🔺	23	加 好味小姐凍乾 3.2g	\N	2	\N	2026-03-02 12:05:31.959561	2026-03-09 04:22:24.309508	f
995	2025-01-26	02:50:00	-	Freeze-Dried	zimple	呼嚕凍乾	❌ No, not interested	4.30	0.00	💕 Love it So Much	4.30	0	❌ - 💕	30		\N	2	\N	2026-03-02 12:05:31.962935	2026-03-09 04:22:32.989711	f
993	2025-01-26	02:50:00	11:21, 13:21, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	38.00	🔺 So So	47.00	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:31.956935	2026-03-09 04:22:42.00564	f
997	2025-01-26	12:30:00	4:13, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	37.50	22.70	🔺 So So	14.80	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:31.971097	2026-03-09 04:22:51.26683	f
996	2025-01-26	12:30:00	-	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	50.90	❌ No!!!	29.10	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:31.965131	2026-03-09 04:23:00.955568	f
1000	2025-01-27	10:00:00	-	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	25.00	25.00	🔺 So So	0.00	0	❌ - 🔺	13	均禾貓旅	\N	2	\N	2026-03-02 12:05:31.985511	2026-03-09 04:23:35.32788	f
1018	2025-02-02	09:30:00	3:11, 5:53, 6:50	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	29.60	💕 Love it So Much	45.40	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.058434	2026-03-09 08:28:47.796216	f
1019	2025-02-02	09:30:00	3:09, 5:52, 6:48, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	18.50	1.00	🔺 So So	17.50	3	❌ - 🔺	26		\N	2	\N	2026-03-02 12:05:32.060138	2026-03-09 08:31:03.002269	f
1017	2025-02-02	09:30:00	19:34, 20:04, 20:26, 6:49, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	38.30	21.20	🔺 So So	17.10	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.056704	2026-03-09 08:31:15.874429	f
1015	2025-02-02	02:35:00	16:53, 	Wet	ciao	ic-506 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	30.00	9.40	💕 Love it So Much	20.60	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:32.053188	2026-03-09 08:54:31.863386	f
1023	2025-02-03	14:20:00	5:54	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	32.60	14.90	🔺 So So	17.70	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.068991	2026-03-09 08:55:11.907071	f
1025	2025-02-04	02:25:00	10:34, 16:58, 18:33, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.60	3.90	🔺 So So	17.70	3	❌ - 🔺	26		\N	2	\N	2026-03-02 12:05:32.072955	2026-03-09 08:55:54.037389	f
1021	2025-02-03	02:55:00	11:45, 14:13, 20:34, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.30	7.10	🔺 So So	13.20	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.063668	2026-03-09 08:55:23.671259	f
1024	2025-02-04	02:25:00	17:00, 18:34, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	84.80	24.20	💕 Love it So Much	60.60	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.07091	2026-03-09 08:56:03.463623	f
1031	2025-02-05	12:35:00	22:13, 6:31, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	36.50	20.00	🔺 So So	16.50	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.0837	2026-03-09 08:56:52.446481	f
1033	2025-02-06	02:30:00	13:52, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.20	18.30	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.087422	2026-03-09 08:58:06.66959	f
1030	2025-02-05	12:35:00	22:15, 	Wet	ciao	cc-85 貓用頂級奢華鮪魚 鮪魚+蟹肉	❌ No, not interested	74.40	56.90	🔺 So So	17.50	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.082012	2026-03-09 08:57:04.762802	f
1032	2025-02-06	02:30:00	13:53, 20:09, 21:17, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	13.00	💕 Love it So Much	67.00	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.085577	2026-03-09 08:58:14.871667	f
1039	2025-02-07	09:00:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	🔺 No, not really. Ate A Little	87.00	69.50	❌ No!!!	17.50	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:32.098771	2026-03-09 08:59:11.374349	f
1036	2025-02-07	02:20:00	10:50, 14:34, 18:06, 19:09, 19:33, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	2.00	💕 Love it So Much	48.00	5	💖 - 💕	50	18:10 有吐, 吐出凍乾及剛吃的濕食	\N	2	\N	2026-03-02 12:05:32.093298	2026-03-09 08:59:45.732589	f
1045	2025-02-09	02:30:00	14:51, 20:44, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.80	12.60	🔺 So So	9.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.109466	2026-03-09 09:01:34.039124	f
1042	2025-02-08	11:30:00	20:57, 22:00, 22:32, 5:48, 9:11, 	Wet	oasy	雞肉佐鮪魚鮮食	💖 Yes, eat right away	70.00	10.80	💕 Love it So Much	59.20	5	💖 - 💕	50		\N	2	\N	2026-03-02 12:05:32.103881	2026-03-09 09:00:31.259039	f
1044	2025-02-09	02:30:00	14:02, 20:45, 	Wet	ciao	ic-361 無穀餐包 鮪魚+雞肉+干貝	💖 Yes, eat right away	40.00	14.50	💕 Love it So Much	25.50	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.107735	2026-03-09 09:01:42.641204	f
1046	2025-02-09	13:43:00	00:09, 5:33, 6:55	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	32.90	🔺 So So	47.10	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.111298	2026-03-09 09:02:04.446941	f
1050	2025-02-10	13:19:00	00:32, 6:14, 9:21	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	💖 Yes, eat right away	57.00	22.50	🔺 So So	34.50	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.11892	2026-03-09 09:02:36.818325	f
1052	2025-02-11	02:20:00	-	Wet	喵樂	肉食控主食罐 嫩雞鮪魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞，撥沙，連吃都沒吃，直接倒掉	\N	2	\N	2026-03-02 12:05:32.122542	2026-03-09 09:03:48.973748	f
2347	2026-03-06	18:25:00	3:08, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	2.80	💕 Love it So Much	7.20	1	💖 - 💕	35		\N	2	\N	2026-03-05 18:25:29.78159	2026-03-06 02:51:04.798813	f
1027	2025-02-04	13:15:00	23:11, 4:04, 8:11, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	1.00	💕 Love it So Much	49.00	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.07695	2026-03-09 08:56:14.962523	f
1026	2025-02-04	13:15:00	23:09, 4:01, 8:10, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	29.90	16.40	🔺 So So	13.50	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.074807	2026-03-09 08:56:25.2043	f
1028	2025-02-05	02:25:00	14:44,	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	71.30	29.20	💕 Love it So Much	42.10	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:32.07867	2026-03-09 08:57:15.497381	f
1029	2025-02-05	02:25:00	14:43, 17:48, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	25.50	16.30	🔺 So So	9.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.080356	2026-03-09 08:57:32.892872	f
1034	2025-02-06	09:00:00	20:08, 01:33, 4:59,	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	28.50	20.40	🔺 So So	8.10	3	❌ - 🔺	19	加 好味小姐凍乾 2.7g	\N	2	\N	2026-03-02 12:05:32.08971	2026-03-09 08:58:23.67522	f
1035	2025-02-06	09:00:00	01:33, 5:00	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	❌ No, not interested	96.10	58.40	🔺 So So	37.70	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.091495	2026-03-09 08:58:40.465043	f
1037	2025-02-07	02:20:00	10:49, 19:08, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.80	16.80	🔺 So So	4.00	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.095067	2026-03-09 08:59:02.970368	f
1038	2025-02-07	09:00:00	1:00, 5:33, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	37.40	23.70	🔺 So So	13.70	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.097006	2026-03-09 08:59:21.390087	f
1043	2025-02-08	11:30:00	20:56, 22:31, 1:20, 5:47, 10:21, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	29.10	12.60	🔺 So So	16.50	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.105952	2026-03-09 09:00:18.984574	f
1040	2025-02-08	02:50:00	11:21, 13:56, 17:57, 18:40, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	13.30	💕 Love it So Much	46.70	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.100488	2026-03-09 09:00:40.59012	f
1041	2025-02-08	02:50:00	13:56, 17:56, 18:38, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	8.60	🔺 So So	11.40	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.102201	2026-03-09 09:00:49.169684	f
1047	2025-02-09	13:43:00	00:07, 2:21, 5:31, 6:53, 9:54, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	33.50	13.80	🔺 So So	19.70	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.113537	2026-03-09 09:01:54.247861	f
1051	2025-02-10	13:19:00	00:30, 4:15, 6:13, 9:20	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	31.40	16.20	🔺 So So	15.20	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.120713	2026-03-09 09:02:26.537263	f
1049	2025-02-10	01:55:00	9:58, 14:38, 15:29, 18:16, 20:27, 21:16, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	25.40	10.70	💕 Love it So Much	14.70	6	❌ - 💕	35	加 好味小姐凍乾 4.2g	\N	2	\N	2026-03-02 12:05:32.117202	2026-03-09 09:03:13.470664	f
1053	2025-02-11	02:20:00	11:07, 13:48, 16:17, 17:48, 	Wet	ciao	鰹魚燒晚餐 ic-281 (雞肉+鰹魚+蟹肉+干貝)	❌ No, not interested	50.00	37.50	🔺 So So	12.50	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.124463	2026-03-09 09:04:07.434088	f
1088	2025-02-19	01:30:00	2:20, 9:32	Kibble	樂境	凍乾全齡貓鮮糧 野鮭火雞凍乾干貝	❌ No, not interested	40.00	30.00	🔺 So So	10.00	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.257981	2026-03-09 09:13:38.684095	f
1055	2025-02-11	12:08:00	4:43,	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	60.00	29.10	🔺 So So	30.90	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:32.127925	2026-03-09 09:03:38.945002	f
1060	2025-02-12	13:02:00	21:37, 00:26, 5:56, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	35.60	15.40	🔺 So So	20.20	3	❌ - 🔺	19	加 好味小姐凍乾 3.3g	\N	2	\N	2026-03-02 12:05:32.136932	2026-03-09 09:06:12.619377	f
1063	2025-02-13	12:30:00	22:28, 3:26, 5:43, 6:47	Wet	oasy	雞肉佐哈姆鮮食	💖 Yes, eat right away	70.00	20.60	💕 Love it So Much	49.40	4	💖 - 💕	41		\N	2	\N	2026-03-02 12:05:32.14285	2026-03-09 09:07:13.054585	f
1059	2025-02-12	13:02:00	21:39, 00:27, 6:00, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	9.20	💕 Love it So Much	40.80	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.13482	2026-03-09 09:06:25.918524	f
1065	2025-02-14	01:49:00	10:39, 13:43, 18:44, 	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	19.20	💕 Love it So Much	50.80	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.181535	2026-03-09 09:08:00.412815	f
1067	2025-02-14	12:20:00	20:28, 00:24, 4:59, 6:29,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	49.60	🔺 So So	35.40	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:32.186306	2026-03-09 09:08:20.444367	f
1062	2025-02-13	02:20:00	11:15, 15:07, 18:27, 20:25	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.70	6.00	💕 Love it So Much	14.70	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.14081	2026-03-09 09:07:43.988431	f
1071	2025-02-15	13:10:00	22:18, 23:45, 3:45, 5:55,	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	❌ No, not interested	80.00	27.50	💕 Love it So Much	52.50	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.194881	2026-03-09 09:08:53.046598	f
1076	2025-02-16	12:51:00	21:10, 00:13, 1:29, 5:55,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	36.00	20.50	🔺 So So	15.50	4	❌ - 🔺	21	加 好味小姐凍乾 3.5g	\N	2	\N	2026-03-02 12:05:32.208328	2026-03-09 09:09:44.083649	f
1069	2025-02-15	02:03:00	10:46, 15:49, 	Wet	oasy	雞肉佐火雞鮮食	💖 Yes, eat right away	70.00	35.40	🔺 So So	34.60	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.190577	2026-03-09 09:09:12.461074	f
1073	2025-02-16	01:54:00	10:36, 12:37, 15:08, 	Wet	ciao	豪華魚三味 ic-418 高齡貓餐包 鮪魚	💖 Yes, eat right away	60.00	12.70	💕 Love it So Much	47.30	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.198937	2026-03-09 09:10:23.194064	f
1074	2025-02-16	01:54:00	10:35, 12:37, 15:07, 17:22, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.50	12.10	🔺 So So	8.40	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.201059	2026-03-09 09:10:11.522901	f
1084	2025-02-18	12:55:00	23:56, 3:15, 5:37, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	18.10	💕 Love it So Much	31.90	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.240585	2026-03-09 09:12:08.685415	f
1078	2025-02-17	01:34:00	13:44, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.90	19.10	🔺 So So	1.80	1	❌ - 🔺	15	17:30 倒掉, 有柏萊富會選柏萊富吃	\N	2	\N	2026-03-02 12:05:32.21689	2026-03-09 09:11:13.583697	f
1082	2025-02-18	01:50:00	11:01, 	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	💖 Yes, eat right away	70.00	34.80	🔺 So So	35.20	1	💖 - 🔺	25	6:15 咬人很大力	\N	2	\N	2026-03-02 12:05:32.232678	2026-03-09 09:12:38.296411	f
1083	2025-02-18	01:50:00	9:53, 11:00, 20:10, 20:51, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.90	9.70	🔺 So So	11.20	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.235833	2026-03-09 09:12:29.062396	f
1711	2025-06-01	09:00:00	-	Wet	喵探長	主食罐 極鮮干貝燉雞	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.591866	2026-03-10 02:25:10.081089	f
1054	2025-02-11	02:20:00	11:06, 14:47, 16:16, 17:47, 20:05, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	22.00	2.60	💕 Love it So Much	19.40	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.126188	2026-03-09 09:03:58.486322	f
1057	2025-02-12	01:57:00	15:56, 18:41, 	Wet	ciao	500億軟酸菌果凍杯 imc-233 雞肉	💖 Yes, eat right away	65.00	33.70	🔺 So So	31.30	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.131382	2026-03-09 09:06:36.228981	f
1058	2025-02-12	01:57:00	10:01, 10:39, 14:08, 15:55, 18:40, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.50	10.90	🔺 So So	10.60	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.133087	2026-03-09 09:06:45.904834	f
1064	2025-02-13	12:30:00	22:25, 00:18, 3:25, 5:41,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	29.70	18.90	🔺 So So	10.80	4	❌ - 🔺	21	加 好味小姐凍乾 3.2g	\N	2	\N	2026-03-02 12:05:32.144842	2026-03-09 09:07:21.411212	f
1066	2025-02-14	01:49:00	10:37, 13:43, 17:45, 18:44, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.10	9.40	🔺 So So	11.70	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.183873	2026-03-09 09:08:09.478824	f
1068	2025-02-14	12:20:00	22:15, 00:23, 4:57, 6:27, 10:01, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	30.50	14.70	🔺 So So	15.80	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.188492	2026-03-09 09:08:28.829169	f
1072	2025-02-15	13:10:00	22:16, 23:44, 3:43, 5:54,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	28.00	2.70	🔺 So So	25.30	4	❌ - 🔺	28		\N	2	\N	2026-03-02 12:05:32.196944	2026-03-09 09:09:03.381241	f
1070	2025-02-15	02:03:00	10:45, 14:19, 15:49, 17:44, 19:10,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	23.10	7.10	🔺 So So	16.00	5	❌ - 🔺	23	加 好味小姐凍乾 2.7g	\N	2	\N	2026-03-02 12:05:32.192587	2026-03-09 09:09:20.619496	f
1080	2025-02-17	13:45:00	00:16, 00:56,	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	28.30	💕 Love it So Much	56.70	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.224857	2026-03-09 09:10:54.225053	f
1081	2025-02-17	13:45:00	00:14, 00:54, 6:05, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	32.60	21.40	🔺 So So	11.20	3	❌ - 🔺	19	加 好味小姐凍乾 3.0g	\N	2	\N	2026-03-02 12:05:32.227803	2026-03-09 09:11:03.911295	f
1077	2025-02-17	01:34:00	10:32, 13:45, 15:25, 19:56, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	34.00	🔺 So So	26.00	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:32.211733	2026-03-09 09:11:23.283469	f
1079	2025-02-17	07:28:00	16:37, 18:10, 19:56, 	Kibble	柏萊富	雞肉+豌豆	💖 Yes, eat right away	20.80	7.90	🔺 So So	12.90	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.219925	2026-03-09 09:11:47.442358	f
1085	2025-02-18	12:55:00	23:54, 3:13, 5:35, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	31.30	14.30	🔺 So So	17.00	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.244165	2026-03-09 09:12:18.484995	f
1086	2025-02-19	01:30:00	10:10, 11:12, 14:40, 18:28, 	Wet	oasy	雞肉佐鮪魚鮮食	💖 Yes, eat right away	70.00	31.70	🔺 So So	38.30	4	💖 - 🔺	31	6:15 有咬, 力道有小一點	\N	2	\N	2026-03-02 12:05:32.247985	2026-03-09 09:13:28.528855	f
1087	2025-02-19	01:30:00	11:11, 14:39, 17:43, 18:27, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	24.00	10.00	🔺 So So	14.00	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.252707	2026-03-09 09:13:47.273763	f
4248	2024-09-03	00:15:00	14:19, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.60	17.40	🔺 So So	3.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.231723	2026-03-13 14:01:58.231723	f
1113	2025-02-24	02:32:00	11:07, 14:00, 	Wet	ciao	cs-193 果凍杯 鰹魚柴魚片口味	💖 Yes, eat right away	80.00	37.70	🔺 So So	42.30	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.370761	2026-03-09 09:19:39.729779	f
1120	2025-02-25	10:30:00	18:54, 20:04, 00:54, 4:59	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	15.80	8.80	🔺 So So	7.00	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.398555	2026-03-09 09:20:41.71313	f
1090	2025-02-19	13:50:00	-	Wet	無一物	蒸寵貓餐包 - 雞胸肉	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:32.264155	2026-03-09 09:13:19.071223	f
1097	2025-02-20	12:50:00	05:34, 9:07,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	18.70	11.90	🔺 So So	6.80	2	❌ - 🔺	17	加 好味小姐凍乾 3.6g	\N	2	\N	2026-03-02 12:05:32.296631	2026-03-09 09:14:22.390376	f
1096	2025-02-20	12:50:00	22:56, 23:46, 03:37, 05:33, 9:08	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	32.10	19.60	🔺 So So	12.50	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.293653	2026-03-09 09:14:31.501233	f
1095	2025-02-20	12:50:00	23:47, 05:34, 9:08,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	16.00	💕 Love it So Much	54.00	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.290079	2026-03-09 09:14:40.359896	f
1094	2025-02-20	01:40:00	10:31, 11:32, 16:05, 19:04, 19:31, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	18.20	8.30	🔺 So So	9.90	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.286584	2026-03-09 09:14:52.185603	f
1093	2025-02-20	01:40:00	10:32, 19:28,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	26.20	16.90	🔺 So So	9.30	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.283518	2026-03-09 09:15:00.900016	f
1092	2025-02-20	01:40:00	10:34, 19:29, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	32.80	🔺 So So	42.20	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.270322	2026-03-09 09:15:10.869282	f
1100	2025-02-21	13:10:00	23:50, 00:41, 5:15, 8:59	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	7.40	💕 Love it So Much	42.60	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.32493	2026-03-09 09:15:36.215557	f
1101	2025-02-21	13:10:00	5:17, 8:57,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	26.30	16.20	🔺 So So	10.10	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.331996	2026-03-09 09:15:44.365108	f
1099	2025-02-21	01:30:00	13:14, 14:32, 15:40, 18:12, 20:28, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.00	4.70	💕 Love it So Much	15.30	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.32038	2026-03-09 09:15:54.137521	f
1098	2025-02-21	01:30:00	14:33, 18:13, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	28.10	💕 Love it So Much	51.90	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.299287	2026-03-09 09:16:11.219303	f
1107	2025-02-22	11:45:00	-	Wet	ciao	cs-146 貓用綜合營養湯罐 - 雞柳	🔺 No, not really. Ate A Little	110.20	106.50	❌ No!!!	3.70	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:32.353116	2026-03-09 09:16:27.685174	f
1105	2025-02-22	11:45:00	00:08, 00:43, 5:01, 	Wet	oasy	雞肉佐哈姆鮮食	💖 Yes, eat right away	70.00	21.40	💕 Love it So Much	48.60	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.345005	2026-03-09 09:16:38.686267	f
1106	2025-02-22	11:45:00	19:55, 23:02, 00:06, 00:42, 4:59, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	31.90	19.20	🔺 So So	12.70	5	❌ - 🔺	23	加 好味小姐凍乾 2.6g	\N	2	\N	2026-03-02 12:05:32.349442	2026-03-09 09:16:49.208181	f
1103	2025-02-22	01:30:00	9:20,	Wet	ciao	cs-146 貓用綜合營養湯罐 - 雞柳	❌ No, not interested	55.60	48.00	🔺 So So	7.60	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.33764	2026-03-09 09:17:03.216668	f
1102	2025-02-22	01:30:00	10:19, 11:09, 19:17	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	4.40	💕 Love it So Much	60.60	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.334662	2026-03-09 09:17:11.73671	f
1104	2025-02-22	01:30:00	10:18, 11:08, 14:03, 15:49, 19:15, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	23.70	8.30	💕 Love it So Much	15.40	5	❌ - 💕	33	加 好味小姐凍乾 3.4g	\N	2	\N	2026-03-02 12:05:32.340707	2026-03-09 09:17:20.714425	f
1110	2025-02-23	13:30:00	00:50, 4:59, 6:15, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	19.10	💕 Love it So Much	50.90	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.361879	2026-03-09 09:17:52.569526	f
1111	2025-02-23	13:30:00	00:46, 4:57, 6:13, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	32.60	12.20	🔺 So So	20.40	3	❌ - 🔺	19	加 好味小姐凍乾 2.4g	\N	2	\N	2026-03-02 12:05:32.365132	2026-03-09 09:18:01.128972	f
1112	2025-02-23	13:30:00	-	Freeze-Dried	zimple	呼嚕凍乾	💖 Yes, eat right away	3.30	1.90	❌ No!!!	1.40	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:32.368168	2026-03-09 09:18:09.840732	f
1108	2025-02-23	02:45:00	11:54, 13:25, 17:28, 19:11, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	13.40	🔺 So So	36.60	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:32.356006	2026-03-09 09:18:19.616735	f
1109	2025-02-23	02:45:00	13:24, 17:27, 19:09, 21:27, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.30	9.60	🔺 So So	11.70	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.358479	2026-03-09 09:18:41.526588	f
1115	2025-02-24	11:50:00	-	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	❌ No, not interested	65.00	65.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:32.377376	2026-03-09 09:19:14.454704	f
1114	2025-02-24	02:32:00	11:05, 13:58, 18:11, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	9.30	🔺 So So	10.70	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.374431	2026-03-09 09:19:31.402407	f
1116	2025-02-24	14:50:00	3:26, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	❌ No, not interested	60.00	48.60	🔺 So So	11.40	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.383179	2026-03-09 09:19:58.757731	f
1121	2025-02-25	12:35:00	00:55, 5:00, 9:55, 	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚 x2	💖 Yes, eat right away	70.00	9.60	💕 Love it So Much	60.40	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.401376	2026-03-09 09:20:53.542715	f
1122	2025-02-25	12:35:00	00:53, 4:59, 9:54	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	23.05	21.50	🔺 So So	1.55	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.421172	2026-03-09 09:21:01.998654	f
1119	2025-02-25	01:15:00	9:39, 10:33, 12:32, 16:50, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.00	1.25	💕 Love it So Much	19.75	4	❌ - 💕	38		\N	2	\N	2026-03-02 12:05:32.394624	2026-03-09 09:21:14.057583	f
1118	2025-02-25	01:15:00	9:40, 10:34, 16:50, 20:04,	Wet	oasy	雞肉佐雞肝鮮食	💖 Yes, eat right away	70.00	31.90	🔺 So So	38.10	4	💖 - 🔺	31	6:10 有咬人	\N	2	\N	2026-03-02 12:05:32.391604	2026-03-09 09:21:32.978562	f
1123	2025-02-26	01:55:00	16:32, 18:32, 	Wet	ciao	cc-85 貓用頂級奢華鮪魚 鮪魚+蟹肉	🔺 No, not really. Ate A Little	60.00	45.40	🔺 So So	14.60	2	🔺 - 🔺	22		\N	2	\N	2026-03-02 12:05:32.427376	2026-03-09 09:22:10.878324	f
1828	2025-06-17	00:20:00	15:50,	Kibble	喵探長	派大雞無穀凍乾糧	💖 Yes, eat right away	16.80	9.20	🔺 So So	7.60	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:06.043395	2026-03-10 04:21:05.422885	f
1149	2025-03-02	02:18:00	12:23, 14:29, 19:40,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.50	10.60	🔺 So So	9.90	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.492089	2026-03-09 09:28:53.177279	f
1139	2025-02-28	12:10:00	21:03, 00:26, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	35.30	15.90	🔺 So So	19.40	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.469839	2026-03-09 09:24:32.379483	f
1131	2025-02-27	12:40:00	00:20, 03:57, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝) 	❌ No, not interested	50.00	31.20	🔺 So So	18.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.454473	2026-03-09 09:23:23.261246	f
1152	2025-03-02	11:43:00	1:38, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	29.40	29.00	🔺 So So	0.40	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.50011	2026-03-09 09:27:49.685917	f
1145	2025-03-01	12:45:00	23:33, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	3.70	💕 Love it So Much	26.30	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:32.482676	2026-03-09 09:26:47.241303	f
1147	2025-03-02	02:18:00	12:25, 14:31, 15:50, 18:01,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	8.90	💕 Love it So Much	51.10	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.486195	2026-03-09 09:28:30.463846	f
1153	2025-03-02	11:43:00	22:28, 23:44, 1:36, 4:52, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	31.30	12.30	🔺 So So	19.00	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.503347	2026-03-09 09:27:57.788489	f
2310	2026-03-04	14:30:00	-	Wet	ciao 	豪華罐 a-142 鮪魚+雞肉+干貝	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	有點躁動	\N	2	\N	2026-03-04 14:37:19.877469	2026-03-04 15:03:45.394045	f
1124	2025-02-26	01:55:00	12:57, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.50	18.50	🔺 So So	2.00	1	❌ - 🔺	15	16:00 一直喵喵叫	\N	2	\N	2026-03-02 12:05:32.431108	2026-03-09 09:22:24.604814	f
1126	2025-02-26	11:50:00	21:32, 00:00, 4:40, 8:24, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	38.10	🔺 So So	46.90	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:32.436286	2026-03-09 09:22:45.634156	f
1133	2025-02-27	12:40:00	00:19, 03:56, 5:54,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	34.90	22.40	🔺 So So	12.50	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.458589	2026-03-09 09:23:15.609594	f
1132	2025-02-27	12:40:00	20:58, 5:57,	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	❌ No, not interested	30.00	5.60	💕 Love it So Much	24.40	2	❌ - 💕	34		\N	2	\N	2026-03-02 12:05:32.456213	2026-03-09 09:23:31.107648	f
1130	2025-02-27	01:15:00	12:47, 18:49, 5:56, 9:22, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	40.00	25.70	🔺 So So	14.30	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.452523	2026-03-09 09:23:40.608133	f
1128	2025-02-27	01:15:00	10:38, 12:48, 	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片 x2	💖 Yes, eat right away	60.00	9.50	💕 Love it So Much	50.50	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:32.442935	2026-03-09 09:23:58.89755	f
1129	2025-02-27	01:15:00	10:36, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.20	14.90	🔺 So So	5.30	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.447683	2026-03-09 09:24:07.53568	f
1137	2025-02-28	12:10:00	21:05, 00:28, 	Wet	ciao	布丁杯 雞肉 imc-153	❌ No, not interested	65.00	9.80	💕 Love it So Much	55.20	2	❌ - 💕	34	wifi斷線	\N	2	\N	2026-03-02 12:05:32.466248	2026-03-09 09:24:43.419283	f
1138	2025-02-28	12:10:00	-	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	🔺 No, not really. Ate A Little	70.00	51.50	❌ No!!!	18.50	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:32.467963	2026-03-09 09:24:51.36739	f
1135	2025-02-28	01:40:00	11:11, 13:19, 15:10, 19:51, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	24.70	7.70	💕 Love it So Much	17.00	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.462717	2026-03-09 09:25:33.972626	f
1136	2025-02-28	01:40:00	10:07, 13:20, 18:46,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.40	14.70	🔺 So So	5.70	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.464473	2026-03-09 09:25:47.970855	f
1143	2025-03-01	08:37:00	16:37, 4:25, 8:15,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.30	9.20	🔺 So So	11.10	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.477378	2026-03-09 09:26:28.684672	f
1146	2025-03-01	12:45:00	23:32, 1:05,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	28.70	23.00	🔺 So So	5.70	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.484455	2026-03-09 09:26:37.806647	f
1144	2025-03-01	12:45:00	1:06, 4:27, 8:17,	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	23.40	💕 Love it So Much	56.60	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.479203	2026-03-09 09:26:55.786631	f
1140	2025-03-01	02:20:00	10:43, 12:05, 	Wet	ciao	ic-323 綜合營養 雞肉+干貝	❌ No, not interested	40.00	19.60	🔺 So So	20.40	2	❌ - 🔺	17	10:30, 11:50, 有吐,吐出剛吃下的食物, 幾乎都是食物的原型	\N	2	\N	2026-03-02 12:05:32.472094	2026-03-09 09:27:07.476293	f
1141	2025-03-01	02:20:00	11:24, 12:04, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	15.10	0.00	💕 Love it So Much	15.10	2	❌ - 💕	34		\N	2	\N	2026-03-02 12:05:32.473773	2026-03-09 09:27:16.05025	f
1142	2025-03-01	02:20:00	10:42, 11:22, 14:29, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	7.60	💕 Love it So Much	12.40	3	❌ - 💕	29		\N	2	\N	2026-03-02 12:05:32.47557	2026-03-09 09:27:24.770806	f
1151	2025-03-02	11:43:00	22:30, 23:49, 4:56,	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	30.00	2.80	💕 Love it So Much	27.20	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.497883	2026-03-09 09:28:05.640066	f
1150	2025-03-02	11:43:00	23:45, 1:38, 4:54, 6:20, 9:25, 	Wet	oasy	雞肉佐鮪魚鮮食	💖 Yes, eat right away	70.00	23.30	💕 Love it So Much	46.70	5	💖 - 💕	43		\N	2	\N	2026-03-02 12:05:32.494779	2026-03-09 09:28:15.252381	f
1148	2025-03-02	02:18:00	15:49, 18:00, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	16.10	14.00	🔺 So So	2.10	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.489092	2026-03-09 09:28:23.16663	f
1157	2025-03-03	13:10:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	24.20	❌ No!!!	45.80	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:32.511195	2026-03-09 09:29:25.384862	f
1158	2025-03-03	13:10:00	-	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	41.10	🔺 So So	8.90	0	❌ - 🔺	13		\N	2	\N	2026-03-02 12:05:32.513255	2026-03-09 09:29:34.179286	f
1156	2025-03-03	01:45:00	13:44, 17:00, 18:00, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.80	5.30	💕 Love it So Much	20.50	3	❌ - 💕	36		\N	2	\N	2026-03-02 12:05:32.509338	2026-03-09 09:29:47.068272	f
1154	2025-03-03	01:45:00	10:57, 18:02,	Wet	ciao	ic-509 貓用極致肉塊餐包 鮪魚片+柴魚片	💖 Yes, eat right away	30.00	10.40	🔺 So So	19.60	2	💖 - 🔺	27	6:15 有吐	\N	2	\N	2026-03-02 12:05:32.505633	2026-03-09 09:29:56.079295	f
1155	2025-03-03	01:45:00	10:58,	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝	💖 Yes, eat right away	30.00	6.80	💕 Love it So Much	23.20	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:32.507529	2026-03-09 09:30:04.496533	f
1159	2025-03-03	13:10:00	3:30, 8:26,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	30.50	8.30	🔺 So So	22.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.515544	2026-03-09 09:29:14.457751	f
1162	2025-03-04	10:10:00	20:35, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝	💖 Yes, eat right away	30.00	5.70	💕 Love it So Much	24.30	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:32.521847	2026-03-09 09:30:27.724224	f
1165	2025-03-04	12:36:00	22:27, 00:36, 4:14, 5:32, 6:14, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	30.10	3.70	💕 Love it So Much	26.40	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.528395	2026-03-09 09:30:35.836713	f
1163	2025-03-04	12:36:00	4:16, 6:15, 	Wet	ciao	ic-506 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	30.00	4.60	💕 Love it So Much	25.40	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:32.523652	2026-03-09 09:30:43.772182	f
1164	2025-03-04	12:36:00	00:39, 4:15, 5:33, 6:16, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	❌ No, not interested	60.00	34.50	🔺 So So	25.50	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.526207	2026-03-09 09:30:51.533287	f
1160	2025-03-04	01:50:00	14:27, 	Wet	ciao	布丁杯 鮪魚 imc-151	💖 Yes, eat right away	65.00	23.50	💕 Love it So Much	41.50	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:32.517778	2026-03-09 09:30:59.592941	f
1161	2025-03-04	01:50:00	12:12, 14:25, 16:27, 20:35, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	21.30	4.70	💕 Love it So Much	16.60	4	❌ - 💕	38		\N	2	\N	2026-03-02 12:05:32.519752	2026-03-09 09:31:07.937386	f
1168	2025-03-05	12:00:00	20:58, 22:15, 00:09, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	26.80	🔺 So So	33.20	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.533654	2026-03-09 09:31:32.188591	f
1169	2025-03-05	12:00:00	23:39, 00:09, 3:32, 7:42, 	Wet	ciao	豪華魚三味 ic-418 高齡貓餐包 鮪魚	🔺 No, not really. Ate A Little	60.00	11.60	💕 Love it So Much	48.40	4	🔺 - 💕	43		\N	2	\N	2026-03-02 12:05:32.535388	2026-03-09 09:31:40.22943	f
1167	2025-03-05	02:30:00	12:29, 13:25, 17:01, 18:02, 19:57, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.70	4.70	💕 Love it So Much	16.00	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.531898	2026-03-09 09:31:49.05203	f
1166	2025-03-05	02:30:00	12:30, 13:26, 17:02, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	22.80	💕 Love it So Much	57.20	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.530196	2026-03-09 09:31:59.649274	f
1170	2025-03-05	12:00:00	20:56, 22:14, 23:38, 00:08, 3:30, 7:42, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	33.00	12.40	💕 Love it So Much	20.60	6	❌ - 💕	35	加 好味小姐凍乾 2.2g	\N	2	\N	2026-03-02 12:05:32.537331	2026-03-09 09:32:09.129034	f
1173	2025-03-06	11:20:00	22:18, 00:52, 8:11, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	❌ No, not interested	60.00	35.80	🔺 So So	24.20	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.545703	2026-03-09 09:32:44.824033	f
1175	2025-03-06	11:20:00	22:18, 00:50, 4:07, 8:09, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	33.60	10.20	🔺 So So	23.40	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.584836	2026-03-09 09:32:55.581282	f
1174	2025-03-06	14:19:00	4:09, 	Wet	oasy	雞肉佐哈姆鮮食	🔺 No, not really. Ate A Little	70.00	51.20	🔺 So So	18.80	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:32.581789	2026-03-09 09:33:05.149573	f
1172	2025-03-06	02:40:00	13:31, 15:09,  16:44, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	26.60	11.50	💕 Love it So Much	15.10	3	❌ - 💕	29		\N	2	\N	2026-03-02 12:05:32.542363	2026-03-09 09:33:13.608582	f
1171	2025-03-06	02:40:00	13:32, 15:10, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	21.70	💕 Love it So Much	48.30	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.539145	2026-03-09 09:33:22.502647	f
1179	2025-03-07	12:30:00	-	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	❌ No, not interested	65.00	65.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:32.59248	2026-03-09 09:33:44.901505	f
1180	2025-03-07	12:30:00	23:22, 1:30, 7:54, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	34.00	9.70	🔺 So So	24.30	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.59432	2026-03-09 09:33:53.147682	f
1176	2025-03-07	02:35:00	13:34, 	Wet	ciao	ic-508 貓用極致肉塊餐包 鰹魚片 x2	💖 Yes, eat right away	60.00	31.20	🔺 So So	28.80	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:32.586842	2026-03-09 09:34:09.582426	f
1177	2025-03-07	02:35:00	12:23, 13:33, 17:59, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.70	7.50	🔺 So So	13.20	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.588836	2026-03-09 09:34:17.743905	f
1185	2025-03-08	12:50:00	20:53, 23:08, 00:35, 4:19, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	39.20	13.10	💕 Love it So Much	26.10	4	❌ - 💕	31	加 好味小姐凍乾 1.2g	\N	2	\N	2026-03-02 12:05:32.605073	2026-03-09 09:34:44.774554	f
1184	2025-03-08	12:50:00	23:09, 00:36, 4:20	Wet	axia	新金罐濃厚5號- 鮪, 柴	💖 Yes, eat right away	70.00	29.20	💕 Love it So Much	40.80	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.603196	2026-03-09 09:34:53.078607	f
1183	2025-03-08	12:50:00	4:20, 8:02	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片 x2	💖 Yes, eat right away	60.00	26.90	🔺 So So	33.10	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.601397	2026-03-09 09:35:01.213507	f
1182	2025-03-08	02:05:00	12:17, 14:40, 19:11, 19:42, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	21.90	12.60	🔺 So So	9.30	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.599485	2026-03-09 09:35:10.591201	f
1181	2025-03-08	02:05:00	11:25, 12:17, 14:41, 19:11, 19:41, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	8.70	💕 Love it So Much	41.30	5	💖 - 💕	50		\N	2	\N	2026-03-02 12:05:32.596569	2026-03-09 09:35:20.005421	f
1190	2025-03-09	11:04:00	19:09, 20:48, 00:48, 4:40, 8:20	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	31.10	15.30	🔺 So So	15.80	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.614223	2026-03-09 09:35:41.227365	f
1189	2025-03-09	12:50:00	23:26, 3:44, 4:41,  8:22,	Wet	ciao	鰹魚燒晚餐包 ic-244	❌ No, not interested	50.00	14.10	💕 Love it So Much	35.90	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.612412	2026-03-09 09:35:52.993848	f
1188	2025-03-09	12:50:00	23:27, 00:50, 3:46, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	❌ No, not interested	60.00	25.50	🔺 So So	34.50	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.610611	2026-03-09 09:36:01.208311	f
1187	2025-03-09	02:10:00	12:25, 15:04, 15:43, 17:49, 18:30,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.60	4.30	💕 Love it So Much	16.30	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.608831	2026-03-09 09:36:11.829112	f
1192	2025-03-10	02:15:00	14:08,	Wet	ciao	ic-564 鰹魚燒晚餐包 烤鰹魚+高湯	🔺 No, not really. Ate A Little	30.00	26.30	🔺 So So	3.70	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:32.617983	2026-03-09 09:37:38.850284	f
1191	2025-03-10	02:15:00	17:43, 	Wet	ciao	imc-165 布丁杯 雞肉+鮪魚	🔺 No, not really. Ate A Little	65.00	48.90	🔺 So So	16.10	1	🔺 - 🔺	20	17:40, 18:10 吐	\N	2	\N	2026-03-02 12:05:32.616143	2026-03-09 09:37:56.36598	f
1215	2025-03-13	09:02:00	21:16, 00:21, 3:05, 4:39, 8:39	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	32.80	10.00	💕 Love it So Much	22.80	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:32.698699	2026-03-09 09:43:21.172514	f
1199	2025-03-11	02:00:00	14:30, 14:33,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	22.10	14.30	🔺 So So	7.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.631464	2026-03-09 09:39:14.419403	f
1214	2025-03-13	09:02:00	17:08, 19:03, 21:17, 00:22, 3:06, 8:40	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	❌ No, not interested	60.00	5.10	💕 Love it So Much	54.90	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:32.696824	2026-03-09 09:43:13.304541	f
1196	2025-03-10	12:30:00	21:29, 22:20, 00:24, 3:37, 8:15, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	32.70	8.40	💕 Love it So Much	24.30	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:32.626262	2026-03-09 09:36:57.825453	f
1195	2025-03-10	12:30:00	4:25, 8:17, 9:57, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	23.50	🔺 So So	36.50	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.624148	2026-03-09 09:37:06.21597	f
1193	2025-03-10	02:15:00	14:07, 17:42, 18:18, 18:51, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	22.40	5.60	💕 Love it So Much	16.80	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.619754	2026-03-09 09:37:47.346621	f
1202	2025-03-11	12:00:00	21:33, 23:00, 00:36, 4:17, 8:06,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	41.30	13.70	💕 Love it So Much	27.60	5	❌ - 💕	33	加 好味小姐凍乾 1.7g	\N	2	\N	2026-03-02 12:05:32.637175	2026-03-09 09:38:22.944734	f
1200	2025-03-11	12:00:00	21:36, 23:01, 8:08,	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	2.50	💕 Love it So Much	62.50	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.633227	2026-03-09 09:38:31.007098	f
1201	2025-03-11	12:00:00	4:19,	Wet	oasy	雞胸肉鮮食	🔺 No, not really. Ate A Little	70.00	55.40	🔺 So So	14.60	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:32.63498	2026-03-09 09:38:40.001192	f
1197	2025-03-11	02:00:00	10:34, 14:31, 14:35,	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	30.60	🔺 So So	19.40	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.628006	2026-03-09 09:38:48.778673	f
1198	2025-03-11	02:00:00	14:31, 	Wet	ciao	ic-555 高湯鮮味餐包 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	10.90	🔺 So So	19.10	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:32.629734	2026-03-09 09:38:57.198333	f
1210	2025-03-12	12:00:00	1:02, 4:16, 7:48, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	39.50	30.40	🔺 So So	9.10	3	❌ - 🔺	19	加 好味小姐凍乾 3.4g	\N	2	\N	2026-03-02 12:05:32.687527	2026-03-09 09:40:03.366096	f
1208	2025-03-12	12:00:00	4:17, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	3.60	💕 Love it So Much	26.40	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:32.682383	2026-03-09 09:40:13.4238	f
1206	2025-03-12	02:05:00	11:03, 14:34, 17:20, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.70	10.30	🔺 So So	10.40	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:32.644435	2026-03-09 09:40:30.902488	f
1203	2025-03-12	02:05:00	11:05, 14:35, 17:21, 19:40, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	🔺 No, not really. Ate A Little	80.00	23.50	💕 Love it So Much	56.50	4	🔺 - 💕	36		\N	2	\N	2026-03-02 12:05:32.639064	2026-03-09 09:40:40.483274	f
1204	2025-03-12	02:05:00	-	Wet	axia	妙喵慕斯軟包9號 - 鮪, 雞, 交趾雞	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞撥沙的動作出現	\N	2	\N	2026-03-02 12:05:32.640859	2026-03-09 09:41:09.310655	f
1205	2025-03-12	04:05:00	-	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片	🔺 No, not really. Ate A Little	30.00	12.00	❌ No!!!	18.00	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:32.642674	2026-03-09 09:42:33.770667	f
1213	2025-03-13	11:45:00	19:58, 3:07, 4:40, 8:42	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	❌ No, not interested	50.00	20.80	🔺 So So	29.20	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.694455	2026-03-09 09:43:28.963246	f
1212	2025-03-13	02:15:00	11:13, 14:11, 15:32, 19:02, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.40	7.50	🔺 So So	12.90	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.692105	2026-03-09 09:43:37.336882	f
1211	2025-03-13	02:15:00	11:14,	Wet	ciao	啾嚕奢華果凍杯 tsc-44 鰹魚+鰹魚乾 x2	💖 Yes, eat right away	70.00	46.20	🔺 So So	23.80	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:32.689889	2026-03-09 09:43:45.547531	f
1220	2025-03-14	09:27:00	17:27, 20:30, 22:20, 00:30, 4:22, 8:32, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	35.50	2.50	💕 Love it So Much	33.00	6	❌ - 💕	42	加 好味小姐凍乾 2g	\N	2	\N	2026-03-02 12:05:32.711158	2026-03-09 09:44:14.996557	f
1218	2025-03-14	12:30:00	22:22, 00:31, 8:35, 	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	5.60	💕 Love it So Much	64.40	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.707562	2026-03-09 09:44:23.586831	f
1219	2025-03-14	09:27:00	-	Wet	ciao	燒晚餐(雞肉+干貝) ic-282	🔺 No, not really. Ate A Little	50.00	41.80	❌ No!!!	8.20	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:32.709316	2026-03-09 09:44:31.829898	f
1216	2025-03-14	02:19:00	11:49, 13:27, 18:59, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	28.60	🔺 So So	31.40	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.700536	2026-03-09 09:44:50.917688	f
1217	2025-03-14	02:19:00	11:48, 13:26, 14:31, 16:59, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.80	7.40	💕 Love it So Much	13.40	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.704492	2026-03-09 09:45:11.857248	f
1223	2025-03-15	10:00:00	19:59, 21:12, 21:52, 23:58, 1:09, 2:33, 4:39, 8:21, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	33.30	2.80	💕 Love it So Much	30.50	8	❌ - 💕	46	加 好味小姐凍乾 2.2g	\N	2	\N	2026-03-02 12:05:32.717354	2026-03-09 09:45:41.322037	f
1225	2025-03-15	10:00:00	20:02, 21:55, 	Wet	ciao	極致濃湯餐包 ic-504 鮪魚+雞肉+干貝	❌ No, not interested	30.00	9.70	💕 Love it So Much	20.30	2	❌ - 💕	27		\N	2	\N	2026-03-02 12:05:32.720954	2026-03-09 09:45:49.848519	f
1222	2025-03-15	01:50:00	10:43, 12:12, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	21.10	4.70	💕 Love it So Much	16.40	2	❌ - 💕	34		\N	2	\N	2026-03-02 12:05:32.715472	2026-03-09 09:46:15.875559	f
1221	2025-03-15	01:50:00	-	Wet	ciao	tsc-233 貓用綜合營養主食果凍杯 雞肉 x2	💖 Yes, eat right away	70.00	46.60	❌ No!!!	23.40	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:32.713685	2026-03-09 09:46:24.409718	f
1292	2025-03-28	12:40:00	6:38, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	28.50	🔺 So So	31.50	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:32.931421	2026-03-09 10:11:05.592912	f
1761	2025-06-07	00:40:00	15:24, 19:20, 	Kibble	奇境	澳洲尖吻鱸&鮪魚	❌ No, not interested	18.90	9.00	🔺 So So	9.90	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.725838	2026-03-10 03:23:46.80091	f
2107	2025-08-01	03:08:00	-	Wet	wellness	ss名廚特選主食罐 嫩牛肉塊+雞肉食譜(貓用)	🔺 No, not really. Ate A Little	79.00	63.30	❌ No!!!	15.70	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.520498	2026-03-10 08:17:59.929697	f
1230	2025-03-16	11:45:00	22:05, 01:38, 4:39, 8:44, 10:06, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	32.50	0.50	💕 Love it So Much	32.00	5	❌ - 💕	40	加 好味小姐凍乾 2.1g	\N	2	\N	2026-03-02 12:05:32.730265	2026-03-09 09:46:44.579948	f
1229	2025-03-16	11:45:00	10:09, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	❌ No, not interested	70.00	47.30	🔺 So So	22.70	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.728444	2026-03-09 09:46:53.12012	f
1228	2025-03-16	11:45:00	22:07,  01:40, 4:40, 8:46, 10:08, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	14.80	💕 Love it So Much	65.20	5	💖 - 💕	50		\N	2	\N	2026-03-02 12:05:32.72646	2026-03-09 09:47:02.033708	f
1226	2025-03-16	02:30:00	11:39, 14:48, 17:18, 18:37, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	6.40	💕 Love it So Much	53.60	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.72272	2026-03-09 09:47:10.286784	f
1227	2025-03-16	02:30:00	11:38, 14:46, 17:16, 18:36, 19:45, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.40	4.60	💕 Love it So Much	15.80	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.724536	2026-03-09 09:47:18.784529	f
1233	2025-03-17	12:30:00	22:00, 8:43, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	35.50	🔺 So So	14.50	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.735839	2026-03-09 09:47:39.066094	f
1235	2025-03-17	12:30:00	21:58, 00:44, 3:34, 8:41, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	29.80	9.00	💕 Love it So Much	20.80	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.739412	2026-03-09 09:47:46.751533	f
1231	2025-03-17	02:40:00	15:05, 18:52, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	15.70	💕 Love it So Much	54.30	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:32.732083	2026-03-09 09:48:12.202024	f
1241	2025-03-18	11:27:00	21:56, 22:27, 00:48, 4:12, 8:28, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	31.50	9.70	💕 Love it So Much	21.80	5	❌ - 💕	33	加 好味小姐凍乾 2.5g	\N	2	\N	2026-03-02 12:05:32.780858	2026-03-09 09:48:33.333697	f
1239	2025-03-18	11:30:00	21:58, 00:51, 4:14,  8:29, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	23.10	💕 Love it So Much	56.90	4	💖 - 💕	41		\N	2	\N	2026-03-02 12:05:32.746602	2026-03-09 09:48:42.000594	f
1240	2025-03-18	11:27:00	22:28, 4:15, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	❌ No, not interested	60.00	31.20	🔺 So So	28.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.748515	2026-03-09 09:48:50.508267	f
1236	2025-03-18	01:45:00	15:27, 17:13, 	Wet	ciao	金湯杯 布丁系列 imc-164 雞肉+螃蟹	💖 Yes, eat right away	65.00	39.30	🔺 So So	25.70	2	💖 - 🔺	27	16:00 吐, 吃完肉泥後 (吐食物)/16:40 吐 (吐食物)	\N	2	\N	2026-03-02 12:05:32.741149	2026-03-09 09:48:59.491799	f
1238	2025-03-18	01:45:00	10:49, 12:36, 15:26, 16:16, 17:12, 18:24, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.40	2.70	💕 Love it So Much	17.70	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:32.744625	2026-03-09 09:49:07.008745	f
1237	2025-03-18	01:45:00	12:37, 15:28, 16:16, 18:25,	Wet	ciao	布丁杯 鮪魚 imc-151	💖 Yes, eat right away	65.00	13.70	💕 Love it So Much	51.30	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.742855	2026-03-09 09:49:14.924102	f
1244	2025-03-19	10:55:00	19:31, 21:27, 22:39, 1:37, 4:39, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	29.80	4.70	💕 Love it So Much	25.10	5	❌ - 💕	40	加 好味小姐凍乾 2.1g	\N	2	\N	2026-03-02 12:05:32.787269	2026-03-09 09:49:42.600011	f
1245	2025-03-19	11:16:00	19:34, 21:28, 22:40, 4:40, 	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	11.90	💕 Love it So Much	58.10	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.789245	2026-03-09 09:49:51.464296	f
1243	2025-03-19	01:50:00	10:57, 12:21, 13:56, 16:52, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.20	0.80	💕 Love it So Much	19.40	4	❌ - 💕	38		\N	2	\N	2026-03-02 12:05:32.785226	2026-03-09 09:50:03.180535	f
1242	2025-03-19	01:50:00	10:59, 13:58, 16:54, 18:49,	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	15.10	💕 Love it So Much	44.90	4	💖 - 💕	41		\N	2	\N	2026-03-02 12:05:32.783209	2026-03-09 09:50:11.179525	f
1246	2025-03-19	11:16:00	19:32, 1:39, 4:41, 	Wet	ciao	ic-509 貓用極致肉塊餐包 鮪魚片+柴魚片 x2	💖 Yes, eat right away	60.00	25.30	🔺 So So	34.70	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.791192	2026-03-09 09:50:19.631563	f
1250	2025-03-20	09:24:00	18:54, 9:00, 	Wet	ciao	cs-193 果凍杯 鰹魚柴魚片口味	❌ No, not interested	80.00	44.20	🔺 So So	35.80	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.799304	2026-03-09 09:50:34.251937	f
1252	2025-03-20	12:10:00	22:50, 00:37, 4:43, 8:58, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	28.20	11.80	🔺 So So	16.40	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.805154	2026-03-09 09:50:42.566989	f
1251	2025-03-20	12:10:00	20:49, 22:51, 00:38, 4:45, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	9.80	💕 Love it So Much	50.20	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.802308	2026-03-09 09:50:56.288981	f
1248	2025-03-20	01:05:00	9:58, 14:43, 	Wet	無一物	蒸寵貓餐包 鮪魚	🔺 No, not really. Ate A Little	50.00	37.50	🔺 So So	12.50	2	🔺 - 🔺	22		\N	2	\N	2026-03-02 12:05:32.795103	2026-03-09 09:51:06.265081	f
1247	2025-03-20	01:05:00	9:58, 17:07, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	27.60	🔺 So So	32.40	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.793145	2026-03-09 09:51:13.921633	f
1249	2025-03-20	01:05:00	9:57, 12:18, 14:41, 17:05, 18:53, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	21.60	1.00	💕 Love it So Much	20.60	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.797134	2026-03-09 09:51:42.082028	f
1257	2025-03-21	11:03:00	19:27, 21:13, 23:31, 00:28, 4:43, 9:43,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	30.10	8.30	💕 Love it So Much	21.80	6	❌ - 💕	35	加 好味小姐凍乾 2.8g	\N	2	\N	2026-03-02 12:05:32.818664	2026-03-09 09:52:13.241977	f
1256	2025-03-21	11:03:00	21:15, 23:32, 00:30, 4:45, 9:45,	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片 x2	🔺 No, not really. Ate A Little	60.00	15.30	💕 Love it So Much	44.70	5	🔺 - 💕	38		\N	2	\N	2026-03-02 12:05:32.81669	2026-03-09 09:52:20.686289	f
1253	2025-03-21	02:25:00	11:14, 11:45, 16:45, 18:09, 	Wet	ciao	ic-218 貓用巧餐包化毛球配方-鮪魚+扇貝 x2	💖 Yes, eat right away	80.00	39.10	🔺 So So	40.90	4	💖 - 🔺	31	4:48 咬人	\N	2	\N	2026-03-02 12:05:32.809505	2026-03-09 09:52:31.09001	f
1254	2025-03-21	02:25:00	11:12, 11:44, 14:17, 16:44, 18:07, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.40	6.90	💕 Love it So Much	18.50	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:32.81254	2026-03-09 09:52:38.783085	f
1255	2025-03-21	11:30:00	00:31, 4:46, 9:45, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	12.20	💕 Love it So Much	57.80	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.814609	2026-03-09 09:52:47.523221	f
1258	2025-03-22	01:55:00	14:56, 16:12,	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	20.30	💕 Love it So Much	44.70	2	💖 - 💕	37	2:00 後 wifi 異常, 無法連線	\N	2	\N	2026-03-02 12:05:32.820602	2026-03-09 09:53:38.089695	f
1278	2025-03-25	11:40:00	1:10, 1:30, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	32.70	🔺 So So	17.30	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.889506	2026-03-09 09:56:57.282687	f
1261	2025-03-22	12:15:00	23:51, 1:14, 4:15, 	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	💖 Yes, eat right away	57.00	20.00	🔺 So So	37.00	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.82651	2026-03-09 09:53:21.847459	f
1259	2025-03-22	01:55:00	11:20, 14:55, 16:11, 19:15, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.90	15.50	💕 Love it So Much	10.40	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.822552	2026-03-09 09:53:51.472195	f
1265	2025-03-23	12:30:00	23:09, 00:49, 9:18, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	22.80	💕 Love it So Much	47.20	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.834338	2026-03-09 09:54:12.807648	f
1267	2025-03-23	12:30:00	21:26, 23:07, 00:48, 3:46, 9:16, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	31.60	14.10	💕 Love it So Much	17.50	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:32.838294	2026-03-09 09:54:21.331464	f
1266	2025-03-23	12:30:00	21:28, 23:08, 00:50, 3;48, 6:04, 9:17, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	5.10	💕 Love it So Much	44.90	6	💖 - 💕	52		\N	2	\N	2026-03-02 12:05:32.836308	2026-03-09 09:54:29.482923	f
1263	2025-03-23	02:20:00	11:17, 13:01, 	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝 x2	💖 Yes, eat right away	60.00	22.50	🔺 So So	37.50	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.830424	2026-03-09 09:54:41.071178	f
1264	2025-03-23	02:20:00	11:16, 13:01, 15:28, 18:09, 19:49, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.00	10.80	💕 Love it So Much	14.20	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:32.83239	2026-03-09 09:54:48.775645	f
1274	2025-03-24	10:45:00	20:12, 22:42, 23:26, 2:13, 8:06, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	37.70	9.40	💕 Love it So Much	28.30	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.85507	2026-03-09 09:55:13.779925	f
1272	2025-03-24	10:45:00	19:09, 20:14, 22:44, 2:15, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝 x2	🔺 No, not really. Ate A Little	60.00	21.70	🔺 So So	38.30	4	🔺 - 🔺	26		\N	2	\N	2026-03-02 12:05:32.850798	2026-03-09 09:55:21.799922	f
1273	2025-03-24	10:45:00	23:28, 8:08, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	🔺 No, not really. Ate A Little	80.00	40.70	🔺 So So	39.30	2	🔺 - 🔺	22		\N	2	\N	2026-03-02 12:05:32.852919	2026-03-09 09:55:31.28067	f
1268	2025-03-24	02:10:00	15:18, 	Wet	unicharm 三星餐包	tt-mk 境內版 多米樂 鮪魚+鰹魚濃湯 60g	🔺 No, not really. Ate A Little	60.00	50.80	🔺 So So	9.20	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:32.840266	2026-03-09 09:55:42.304843	f
1270	2025-03-24	02:10:00	10:20, 11:06, 15:18, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	27.40	17.70	🔺 So So	9.70	3	❌ - 🔺	19	加 好味小姐凍乾 1.6g	\N	2	\N	2026-03-02 12:05:32.846598	2026-03-09 09:55:58.028858	f
1269	2025-03-24	02:10:00	11:08, 	Wet	ciao	ic-220 巧餐包 鮪魚+扇貝+雞肉(乳酸菌)	❌ No, not interested	40.00	18.30	🔺 So So	21.70	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.842219	2026-03-09 09:56:05.905183	f
1271	2025-03-24	07:17:00	-	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	19.80	18.60	🔺 So So	1.20	0	❌ - 🔺	13		\N	2	\N	2026-03-02 12:05:32.848733	2026-03-09 09:56:21.78686	f
1277	2025-03-25	11:40:00	22:51, 00:49, 3:50, 6:47, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	19.40	💕 Love it So Much	40.60	4	💖 - 💕	41		\N	2	\N	2026-03-02 12:05:32.886488	2026-03-09 09:57:06.072864	f
1279	2025-03-25	11:40:00	22:49, 00:47, 1:30, 3:48, 6:45, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	31.60	4.70	💕 Love it So Much	26.90	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.891957	2026-03-09 09:57:17.848846	f
1276	2025-03-25	01:05:00	12:09, 12:47, 17:06, 17:44,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.80	11.10	🔺 So So	14.70	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.884091	2026-03-09 09:57:27.861094	f
1275	2025-03-25	01:05:00	12:10, 12:48, 17:45	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	18.30	💕 Love it So Much	41.70	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:32.881546	2026-03-09 09:57:35.659407	f
1283	2025-03-26	10:43:00	-	Wet	ciao	ic-509 貓用極致肉塊餐包 鮪魚片+柴魚片 x2	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:32.911528	2026-03-09 10:08:28.105972	f
1282	2025-03-26	10:43:00	20:57, 23:43, 1:04, 7:06,.	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	24.80	💕 Love it So Much	55.20	4	💖 - 💕	41		\N	2	\N	2026-03-02 12:05:32.909243	2026-03-09 10:08:36.971508	f
1284	2025-03-26	10:43:00	20:55, 23:41, 1:03, 3:44, 7:05, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	27.20	1.20	💕 Love it So Much	26.00	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.913697	2026-03-09 10:08:45.451752	f
1281	2025-03-26	01:10:00	9:40, 14:38, 14:46, 16:59, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.90	7.00	💕 Love it So Much	18.90	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.905944	2026-03-09 10:08:53.60459	f
1280	2025-03-26	01:10:00	9:43, 14:46, 	Wet	ciao	ic-217 貓用巧餐包 - 雞肉+鰹魚乾	💖 Yes, eat right away	40.00	15.70	🔺 So So	24.30	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.898913	2026-03-09 10:09:01.288728	f
1289	2025-03-27	12:40:00	22:49, 00:17, 3:20, 5:04, 7:52,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	28.60	6.80	💕 Love it So Much	21.80	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.925211	2026-03-09 10:09:18.078386	f
1288	2025-03-27	12:40:00	22:51, 00:18, 3:21, 5:05, 7:54,	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	18.50	💕 Love it So Much	61.50	5	💖 - 💕	50		\N	2	\N	2026-03-02 12:05:32.92315	2026-03-09 10:09:27.817653	f
1287	2025-03-27	12:40:00	9:20,	Wet	ciao	tcr-204 貓用濃湯餐包 雞肉+扇貝	💖 Yes, eat right away	40.00	4.80	💕 Love it So Much	35.20	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:32.920987	2026-03-09 10:09:39.248165	f
1290	2025-03-28	01:45:00	10:18, 19:04, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	18.30	💕 Love it So Much	51.70	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.927423	2026-03-09 10:11:30.726585	f
1285	2025-03-27	01:30:00	13:59, 18:47, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	16.50	💕 Love it So Much	43.50	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.915899	2026-03-09 10:09:56.821277	f
1286	2025-03-27	01:30:00	13:57, 16:16, 18:26, 18:47, 20:40	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	26.10	8.40	💕 Love it So Much	17.70	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:32.918553	2026-03-09 10:10:29.97674	f
1291	2025-03-28	01:45:00	10:18, 13:21, 15:32, 17:40, 20:35,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	26.10	5.10	💕 Love it So Much	21.00	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.929366	2026-03-09 10:11:39.288082	f
2286	2025-08-28	11:50:00	-	Kibble	莫比	無穀低敏 鴨肉&鵪鶉	❌ No, not interested	23.50	23.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.391837	2026-03-10 09:06:43.030506	f
1301	2025-03-30	02:55:00	14:04, 17:03, 18:33, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	26.00	3.10	💕 Love it So Much	22.90	3	❌ - 💕	36		\N	2	\N	2026-03-02 12:05:32.951096	2026-03-09 10:13:28.677978	f
1326	2025-04-04	10:00:00	-	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	45.00	19.00	🔺 So So	26.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-03-02 12:05:33.021126	2026-03-09 11:59:10.68518	f
1318	2025-04-02	09:40:00	19:42,  9:07,	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片 x2	❌ No, not interested	60.00	29.10	🔺 So So	30.90	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.00568	2026-03-09 10:34:49.533835	f
1294	2025-03-28	12:40:00	22:20, 00:00, 00:59, 1:18, 2:26, 3:47, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	30.30	1.50	💕 Love it So Much	28.80	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:32.935587	2026-03-09 10:11:21.2323	f
1297	2025-03-29	11:45:00	23:19, 1:05, 6:32, 9:35, 	Wet	ciao	布丁杯 雞肉 imc-153	❌ No, not interested	65.00	11.20	💕 Love it So Much	53.80	4	❌ - 💕	38		\N	2	\N	2026-03-02 12:05:32.942656	2026-03-09 10:11:59.766982	f
1299	2025-03-29	11:45:00	23:18, 1:04, 6:30, 9:34, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	36.90	13.60	💕 Love it So Much	23.30	4	❌ - 💕	31	加 好味小姐凍乾 1.3g	\N	2	\N	2026-03-02 12:05:32.946723	2026-03-09 10:12:07.995657	f
1295	2025-03-29	02:25:00	11:15, 12:16, 18:31, 	Wet	ciao	nc-91 極鮮合味貓罐 鮪魚	💖 Yes, eat right away	85.00	15.10	💕 Love it So Much	69.90	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.937656	2026-03-09 10:12:18.319021	f
1296	2025-03-29	02:25:00	11:14, 12:14, 18:30, 18:58, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.60	10.30	💕 Love it So Much	15.30	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.939666	2026-03-09 10:12:25.640053	f
1298	2025-03-29	11:45:00	22:12, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	15.70	💕 Love it So Much	44.30	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:32.944661	2026-03-09 10:12:33.219011	f
1302	2025-03-30	12:30:00	7:27,	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	28.40	🔺 So So	41.60	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:32.953117	2026-03-09 10:12:56.353781	f
1303	2025-03-30	12:30:00	21:50, 23:01, 00:50, 1:18, 2:11,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	💖 Yes, eat right away	85.00	42.30	🔺 So So	42.70	5	💖 - 🔺	33		\N	2	\N	2026-03-02 12:05:32.955	2026-03-09 10:13:05.356015	f
1304	2025-03-30	12:30:00	21:49, 23:01, 00:48, 1:17, 2:09, 7:26,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	28.90	5.90	💕 Love it So Much	23.00	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:32.958534	2026-03-09 10:13:12.901414	f
1300	2025-03-30	02:55:00	17:03, 18:36, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝x2	💖 Yes, eat right away	60.00	18.30	💕 Love it So Much	41.70	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.948891	2026-03-09 10:13:20.889892	f
1308	2025-03-31	11:30:00	21:53, 1:30, 7:26, 	Wet	ciao	ic-218 貓用巧餐包化毛球配方-鮪魚+扇貝	💖 Yes, eat right away	40.00	16.90	🔺 So So	23.10	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.986014	2026-03-09 10:13:57.252762	f
1307	2025-03-31	11:30:00	20:56, 21:52, 7:25	Wet	oasy	雞肉佐鮪魚鮮食	💖 Yes, eat right away	70.00	45.80	🔺 So So	24.20	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:32.983944	2026-03-09 10:14:04.971862	f
1309	2025-03-31	11:30:00	21:51, 23:50, 1:28, 7:23	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	39.50	17.40	🔺 So So	22.10	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.987959	2026-03-09 10:14:14.428875	f
1305	2025-03-31	02:40:00	11:53, 14:16, 	Wet	ciao	cs-193 果凍杯 鰹魚柴魚片口味	💖 Yes, eat right away	80.00	33.90	🔺 So So	46.10	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.960596	2026-03-09 10:14:22.825976	f
1311	2025-04-01	01:43:00	13:03, 13:32, 14:54, 16:50, 17:41, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.00	6.60	💕 Love it So Much	18.40	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:32.991846	2026-03-09 10:33:15.211014	f
1310	2025-04-01	01:43:00	14:55, 16:52, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	20.50	💕 Love it So Much	49.50	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:32.989911	2026-03-09 10:33:28.824071	f
1312	2025-04-01	12:10:00	7:14, 	Wet	axia	新金罐濃厚5號- 鮪, 柴	🔺 No, not really. Ate A Little	70.00	58.00	🔺 So So	12.00	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:32.99364	2026-03-09 10:33:41.21503	f
1314	2025-04-01	12:10:00	20:09, 21:11, 1:56, 7:11, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	31.80	14.50	🔺 So So	17.30	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:32.997243	2026-03-09 10:33:56.131938	f
1313	2025-04-01	12:10:00	21:12, 1:44, 1:57, 7:13, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	19.20	💕 Love it So Much	40.80	4	💖 - 💕	41		\N	2	\N	2026-03-02 12:05:32.995419	2026-03-09 10:34:14.944294	f
1317	2025-04-02	09:40:00	21:09, 00:53, 5:37, 9:06,	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	12.00	💕 Love it So Much	68.00	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:33.00363	2026-03-09 10:35:02.645602	f
1319	2025-04-02	09:40:00	19:41, 21:08, 00:51, 5:35, 9:05	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	31.10	4.90	🔺 So So	26.20	5	❌ - 🔺	30		\N	2	\N	2026-03-02 12:05:33.007669	2026-03-09 10:35:15.374247	f
1315	2025-04-02	01:30:00	-	Wet	heromama	維他命補給罐 南瓜雞絲	💖 Yes, eat right away	80.00	58.60	❌ No!!!	21.40	0	💖 - ❌	18	10:30 聞一聞撥沙	\N	2	\N	2026-03-02 12:05:32.999534	2026-03-09 10:35:24.784252	f
1316	2025-04-02	01:30:00	9:56, 10:27, 14:36, 15:51,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.20	5.50	🔺 So So	19.70	4	❌ - 🔺	28		\N	2	\N	2026-03-02 12:05:33.001654	2026-03-09 10:35:35.698411	f
1323	2025-04-03	10:00:00	-	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.00	6.00	🔺 So So	19.00	0	❌ - 🔺	20	均禾貓旅住宿	\N	2	\N	2026-03-02 12:05:33.015735	2026-03-09 10:36:47.112393	f
1321	2025-04-03	01:45:00	-	Wet	喜耀	紅鮭佐燉雞濃湯	💖 Yes, eat right away	34.00	19.60	❌ No!!!	14.40	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:33.012064	2026-03-09 10:37:24.331541	f
1320	2025-04-03	01:45:00	-	Wet	oasy	雞肉佐火雞鮮食	🔺 No, not really. Ate A Little	70.00	63.80	❌ No!!!	6.20	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:33.009577	2026-03-09 10:37:41.66389	f
1322	2025-04-03	01:45:00	13:04, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	15.30	8.90	🔺 So So	6.40	1	❌ - 🔺	15	均禾貓旅住宿	\N	2	\N	2026-03-02 12:05:33.013934	2026-03-09 10:37:54.836768	f
1325	2025-04-04	02:00:00	-	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.00	20.00	🔺 So So	0.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-03-02 12:05:33.01934	2026-03-09 11:58:49.617848	f
1327	2025-04-04	10:00:00	-	Wet	餐包	餐包	❌ No, not interested	80.00	26.00	🔺 So So	54.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-03-02 12:05:33.02286	2026-03-09 11:59:00.303846	f
2277	2025-08-27	01:00:00	-	Kibble	wellness	core 無穀新鮮鴨肉	❌ No, not interested	20.20	20.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.324598	2026-03-10 09:05:09.190021	f
2308	2026-03-04	13:39:00	00:33, 2:01, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.50	13.40	🔺 So So	7.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 13:40:04.520783	2026-03-05 01:07:19.808152	f
1329	2025-04-05	10:00:00	2:30, 5:38, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	26.20	6.00	🔺 So So	20.20	2	❌ - 🔺	24		\N	2	\N	2026-03-02 12:05:33.026574	2026-03-09 11:59:42.555158	f
1328	2025-04-05	02:00:00	-	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.00	10.00	🔺 So So	10.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-03-02 12:05:33.024631	2026-03-09 12:00:30.856276	f
1333	2025-04-06	11:10:00	3:57	Wet	ciao	cc-86 貓用頂級奢華鮪魚 凍罐 (新版)	❌ No, not interested	60.00	52.00	🔺 So So	8.00	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:33.033932	2026-03-09 12:01:10.329223	f
1335	2025-04-06	11:10:00	20:10, 22:31, 1:12, 3:55,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	40.30	24.10	🔺 So So	16.20	4	❌ - 🔺	21	加 好味小姐凍乾 2.2g	\N	2	\N	2026-03-02 12:05:33.037636	2026-03-09 12:01:21.069887	f
1334	2025-04-06	11:10:00	20:12, 22:32, 1:13, 3:56,	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	0.90	💕 Love it So Much	64.10	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:33.03572	2026-03-09 12:01:30.149264	f
1332	2025-04-06	01:55:00	12:38, 13:56, 16:22, 17:20, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	27.30	14.30	🔺 So So	13.00	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:33.032065	2026-03-09 12:01:44.570211	f
1331	2025-04-06	01:55:00	12:39, 16:23, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	38.70	🔺 So So	41.30	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:33.030285	2026-03-09 12:01:53.745873	f
1339	2025-04-07	11:25:00	3:32,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) x2	🔺 No, not really. Ate A Little	120.00	96.00	🔺 So So	24.00	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:33.044757	2026-03-09 12:02:20.211451	f
1340	2025-04-07	11:25:00	20:23, 1:13, 3:31, 7:31,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	29.50	10.70	🔺 So So	18.80	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:33.046929	2026-03-09 12:02:28.197599	f
1336	2025-04-07	22:05:00	-	Wet	銀湯匙	濃郁鮪魚 鰹魚 雞胸肉 tw tmc 124	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	剛放聞一聞不吃，10:00倒掉	\N	2	\N	2026-03-02 12:05:33.039357	2026-03-09 12:02:42.281081	f
1337	2025-04-07	22:05:00	12:53, 15:37, 15:53, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝 x2	💖 Yes, eat right away	60.00	35.70	🔺 So So	24.30	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:33.041143	2026-03-09 12:02:50.674356	f
1338	2025-04-07	22:05:00	9:59, 12:52, 15:36, 15:52, 19:13, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.50	9.10	🔺 So So	16.40	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:33.042903	2026-03-09 12:03:01.396414	f
1345	2025-04-08	12:00:00	20:34, 21:36, 00:10, 00:52, 3:26, 8:24,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	34.70	9.50	💕 Love it So Much	25.20	6	❌ - 💕	35		\N	2	\N	2026-03-02 12:05:33.090596	2026-03-09 12:04:07.962685	f
1344	2025-04-08	12:00:00	20:35, 00:12, 	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	0.00	💕 Love it So Much	40.00	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:33.0885	2026-03-09 12:04:18.424432	f
1343	2025-04-08	12:00:00	21:37, 3:27, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	🔺 No, not really. Ate A Little	85.00	52.50	🔺 So So	32.50	2	🔺 - 🔺	22		\N	2	\N	2026-03-02 12:05:33.086385	2026-03-09 12:04:29.21213	f
1342	2025-04-08	00:50:00	14:49, 16:13, 17:35, 19:09,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.40	9.10	💕 Love it So Much	16.30	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:33.083627	2026-03-09 12:04:39.197682	f
1341	2025-04-08	00:50:00	14:50, 16:14, 17:36, 19:10,	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	11.90	💕 Love it So Much	58.10	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:33.081319	2026-03-09 12:04:48.349707	f
1350	2025-04-09	11:25:00	21:57, 23:22, 00:21, 3:29, 7:47, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	34.50	12.50	🔺 So So	22.00	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:33.100125	2026-03-09 12:05:11.487604	f
1348	2025-04-09	11:25:00	21:58, 23:23, 7:50	Wet	ciao	ic-217 貓用巧餐包 - 雞肉+鰹魚乾	💖 Yes, eat right away	40.00	12.00	💕 Love it So Much	28.00	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:33.096351	2026-03-09 12:05:23.802962	f
1349	2025-04-09	11:25:00	20:51, 3:30, 7:49, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	11.50	💕 Love it So Much	38.50	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:33.098239	2026-03-09 12:05:32.889124	f
1346	2025-04-09	00:45:00	9:24, 13:54, 15:07, 18:20, 18:54, 	Wet	oasy	雞肉佐哈姆鮮食	💖 Yes, eat right away	70.00	26.40	💕 Love it So Much	43.60	5	💖 - 💕	43		\N	2	\N	2026-03-02 12:05:33.09253	2026-03-09 12:05:41.684211	f
1354	2025-04-10	11:50:00	19:55, 7:44,	Wet	ciao	ic47 多樂米鮪魚沾醬 x2	❌ No, not interested	40.00	0.00	💕 Love it So Much	40.00	2	❌ - 💕	34		\N	2	\N	2026-03-02 12:05:33.107632	2026-03-09 12:06:19.190876	f
1355	2025-04-10	11:50:00	19:53, 20:15, 21:08, 2:33, 7:43,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	37.90	14.20	🔺 So So	23.70	5	❌ - 🔺	23	加 好味小姐凍乾 1.8g	\N	2	\N	2026-03-02 12:05:33.109571	2026-03-09 12:06:28.128071	f
1353	2025-04-10	11:50:00	-	Wet	ciao	ic-220 巧餐包 鮪魚+扇貝+雞肉(乳酸菌) x2	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:33.105714	2026-03-09 12:10:28.615465	f
1351	2025-04-10	00:45:00	14:20, 	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	💖 Yes, eat right away	57.00	24.00	🔺 So So	33.00	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.101992	2026-03-09 12:10:44.778027	f
1352	2025-04-10	00:45:00	9:25, 9:49, 12:00, 14:19, 17:02, 18:57, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	26.40	10.70	💕 Love it So Much	15.70	6	❌ - 💕	35		\N	2	\N	2026-03-02 12:05:33.103881	2026-03-09 12:10:55.199822	f
1360	2025-04-11	10:30:00	19:39, 22:34, 	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片	💖 Yes, eat right away	30.00	6.70	💕 Love it So Much	23.30	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:33.118818	2026-03-09 12:12:19.937263	f
1359	2025-04-11	10:30:00	22:47, 3:25, 5:04, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	20.00	💕 Love it So Much	50.00	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:33.116982	2026-03-09 12:12:30.190162	f
1356	2025-04-11	00:40:00	14:01, 15:13, 	Wet	hello fresh	好鮮原汁湯罐 清蒸雞肉	💖 Yes, eat right away	80.00	29.10	💕 Love it So Much	50.90	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:33.111449	2026-03-09 12:12:44.665872	f
1358	2025-04-11	00:40:00	18:34, 19:38, 20:23, 21:16, 22:33, 00:22, 5:02, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.50	6.80	🔺 So So	13.70	7	❌ - 🔺	27		\N	2	\N	2026-03-02 12:05:33.115184	2026-03-09 12:12:54.374341	f
1357	2025-04-11	00:40:00	14:00, 14:36, 15:12, 18:35, 20:24, 21:15, 22:32, 22:47, 3:23, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	29.80	6.60	💕 Love it So Much	23.20	9	❌ - 💕	48		\N	2	\N	2026-03-02 12:05:33.113253	2026-03-09 12:13:21.917517	f
2311	2026-03-04	15:04:00	00:35, 2:02, 8:52, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	❌ No, not interested	105.00	50.50	🔺 So So	54.50	3	❌ - 🔺	19		\N	2	\N	2026-03-04 15:04:31.138329	2026-03-05 01:08:26.83827	f
1370	2025-04-13	11:40:00	21:43, 1:02, 3:15, 5:46, 9:01,.	Wet	oasy	雞肉佐鮪魚鮮食	❌ No, not interested	70.00	21.30	💕 Love it So Much	48.70	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:33.13779	2026-03-09 12:18:18.582434	f
1391	2025-04-16	12:00:00	1:25, 4:17, 	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	💖 Yes, eat right away	60.00	14.20	💕 Love it So Much	45.80	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:33.203246	2026-03-09 12:25:08.36655	f
1389	2025-04-16	00:20:00	14:23, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	22.90	💕 Love it So Much	47.10	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:33.19966	2026-03-09 12:25:51.33008	f
1396	2025-04-17	11:40:00	23:06, 1:50, 	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚 x2	❌ No, not interested	70.00	12.90	💕 Love it So Much	57.10	2	❌ - 💕	34		\N	2	\N	2026-03-02 12:05:33.212106	2026-03-09 12:29:22.498435	f
1363	2025-04-12	12:05:00	22:12, 1:32, 6:24,	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	18.40	💕 Love it So Much	46.60	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:33.124499	2026-03-09 12:14:12.165962	f
1365	2025-04-12	12:05:00	22:09, 00:28, 6:23,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	36.90	22.80	🔺 So So	14.10	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.128276	2026-03-09 12:16:15.109339	f
1362	2025-04-12	01:00:00	9:26, 16:35, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	25.80	10.90	🔺 So So	14.90	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.122607	2026-03-09 12:17:22.536903	f
1371	2025-04-13	11:40:00	21:42, 5:44, 	Wet	ciao	tcr-204 貓用濃湯餐包 雞肉+扇貝	❌ No, not interested	40.00	10.40	💕 Love it So Much	29.60	2	❌ - 💕	27		\N	2	\N	2026-03-02 12:05:33.139627	2026-03-09 12:17:48.232176	f
1372	2025-04-13	11:40:00	20:09, 21:40, 22:40, 1:02, 3:13, 5:43, 9:00, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	46.50	28.70	💕 Love it So Much	17.80	7	❌ - 💕	37		\N	2	\N	2026-03-02 12:05:33.141594	2026-03-09 12:17:56.539574	f
1373	2025-04-13	11:40:00	21:40, 1:00, 8:59, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	23.20	14.20	🔺 So So	9.00	3	❌ - 🔺	19	加 好味小姐凍乾 1.9g	\N	2	\N	2026-03-02 12:05:33.143484	2026-03-09 12:18:06.083904	f
1366	2025-04-13	01:55:00	-	Wet	ciao	tcr-202 貓用濃湯餐包 鰹魚+鮪魚+柴魚片	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:33.130189	2026-03-09 12:18:28.373364	f
1367	2025-04-13	01:55:00	13:16, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	35.90	🔺 So So	24.10	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.13204	2026-03-09 12:18:37.86274	f
1368	2025-04-13	01:55:00	13:15, 16:52, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	26.80	21.60	🔺 So So	5.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.133894	2026-03-09 12:18:50.838007	f
1369	2025-04-13	07:27:00	16:53, 5:45,	Kibble	藍摯	原野精靈 去骨雞肉無穀配方	❌ No, not interested	20.80	19.30	🔺 So So	1.50	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.1359	2026-03-09 12:19:19.640462	f
1376	2025-04-14	02:00:00	18:51, 23:40, 4:01, 9:06,	Kibble	藍摯	原野精靈 去骨雞肉無穀配方	❌ No, not interested	23.10	14.40	🔺 So So	8.70	4	❌ - 🔺	21		\N	2	\N	2026-03-02 12:05:33.149311	2026-03-09 12:20:31.562833	f
1378	2025-04-14	11:00:00	20:15, 21:40, 2:07,	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝 x2	💖 Yes, eat right away	60.00	16.10	💕 Love it So Much	43.90	3	💖 - 💕	39		\N	2	\N	2026-03-02 12:05:33.153164	2026-03-09 12:19:45.379498	f
1379	2025-04-14	11:00:00	20:14, 21:39, 23:42, 2:04, 4:02, 9:06	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	45.30	33.00	🔺 So So	12.30	6	❌ - 🔺	25	加 好味小姐凍乾 1.4g	\N	2	\N	2026-03-02 12:05:33.180927	2026-03-09 12:19:58.073339	f
1377	2025-04-14	11:00:00	2:05, 4:02	Wet	ciao	鰹魚燒晚餐包 ic-244	🔺 No, not really. Ate A Little	50.00	20.40	🔺 So So	29.60	2	🔺 - 🔺	22		\N	2	\N	2026-03-02 12:05:33.151267	2026-03-09 12:20:10.500902	f
1375	2025-04-14	02:00:00	13:36, 16:56, 18:51,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	27.10	19.20	🔺 So So	7.90	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.147311	2026-03-09 12:22:20.03733	f
1374	2025-04-14	02:00:00	-	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	37.20	❌ No!!!	42.80	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:33.145352	2026-03-09 12:22:38.252468	f
1385	2025-04-15	10:30:00	19:50, 22:16, 3:04, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	❌ No, not interested	85.00	52.90	🔺 So So	32.10	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.192661	2026-03-09 12:23:38.196953	f
1386	2025-04-15	10:30:00	-	Wet	sheba	主食罐 雞肉慕斯佐雞肝	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:33.194452	2026-03-09 12:23:57.008128	f
1384	2025-04-15	10:30:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2 + 德國迷幻喵 迷幻9號 麵包蟲+多汁雞肉	❌ No, not interested	60.60	60.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:33.190827	2026-03-09 12:24:08.941455	f
1382	2025-04-15	10:00:00	23:36, 4:26,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	15.60	0.90	🔺 So So	14.70	2	❌ - 🔺	24		\N	2	\N	2026-03-02 12:05:33.187214	2026-03-09 12:24:19.951398	f
1381	2025-04-15	01:30:00	12:55, 16:52, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.60	13.10	🔺 So So	7.50	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.185097	2026-03-09 12:24:30.416273	f
1392	2025-04-16	12:00:00	22:25, 1:23, 4:15, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	31.80	7.80	🔺 So So	24.00	3	❌ - 🔺	26		\N	2	\N	2026-03-02 12:05:33.204937	2026-03-09 12:25:16.889061	f
1390	2025-04-16	12:00:00	1:25, 	Wet	axia	新金罐濃厚5號- 鮪, 柴	❌ No, not interested	70.00	47.00	🔺 So So	23.00	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:33.201494	2026-03-09 12:25:30.112213	f
1388	2025-04-16	00:20:00	16:52, 19:55, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	22.30	19.30	🔺 So So	3.00	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.197963	2026-03-09 12:25:42.203093	f
1387	2025-04-16	00:20:00	10:05, 12:34, 14:22, 18:22, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.00	5.70	🔺 So So	19.30	4	❌ - 🔺	28		\N	2	\N	2026-03-02 12:05:33.196213	2026-03-09 12:26:38.689262	f
1395	2025-04-17	08:37:00	-	Wet	ciao	ic-216 貓用巧餐包 鮪魚+鰹魚乾+雞肉 x2	💖 Yes, eat right away	80.00	47.00	❌ No!!!	33.00	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:33.209997	2026-03-09 12:29:43.69516	f
1394	2025-04-17	00:17:00	9:23, 12:48, 16:24, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.30	16.50	🔺 So So	8.80	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.208381	2026-03-09 12:29:55.662698	f
1393	2025-04-17	00:17:00	-	Wet	喵樂	喵罐 鮭魚鮪魚燒	🔺 No, not really. Ate A Little	80.00	66.60	❌ No!!!	13.40	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:33.206641	2026-03-09 12:30:03.630303	f
1401	2025-04-18	10:30:00	20:33, 00:19, 3:10, 5:40, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	11.50	💕 Love it So Much	68.50	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:33.221048	2026-03-09 12:30:34.549208	f
1402	2025-04-18	12:35:00	22:18, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	❌ No, not interested	60.00	38.20	🔺 So So	21.80	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:33.222777	2026-03-09 12:30:46.985312	f
1403	2025-04-18	12:35:00	20:32, 22:16, 00:17, 3:08, 5:38	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	36.90	3.00	💕 Love it So Much	33.90	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:33.224469	2026-03-09 12:30:56.754294	f
1400	2025-04-18	01:27:00	17:20,	Wet	oasy	雞肉佐雞肝鮮食	💖 Yes, eat right away	70.00	40.00	🔺 So So	30.00	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.219283	2026-03-09 12:31:06.819484	f
1399	2025-04-18	01:27:00	11:31, 13:18, 14:25, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.50	10.20	🔺 So So	11.30	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.217531	2026-03-09 12:31:14.637992	f
1407	2025-04-19	11:10:00	21:56, 00:04, 2:19, 8:27, 	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	16.60	💕 Love it So Much	53.40	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:33.231504	2026-03-09 12:31:41.989136	f
1408	2025-04-19	11:10:00	19:24, 00:47, 	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚	💖 Yes, eat right away	35.00	6.90	💕 Love it So Much	28.10	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:33.233313	2026-03-09 12:31:49.55354	f
1409	2025-04-19	11:10:00	19:50, 00:02, 00:46, 2:18, 8:25, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	38.60	12.50	🔺 So So	26.10	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:33.234986	2026-03-09 12:31:57.384927	f
1405	2025-04-19	01:50:00	-	Wet	axia	妙喵14號片狀 - 鮪, 雞肉 mmf-14	🔺 No, not really. Ate A Little	70.00	52.10	❌ No!!!	17.90	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:33.228095	2026-03-09 12:32:05.41048	f
1404	2025-04-19	01:50:00	14:42, 17:19, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.50	17.60	🔺 So So	7.90	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.226339	2026-03-09 12:32:13.406281	f
1414	2025-04-20	10:00:00	21:17, 5:27, 8:51, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	33.20	🔺 So So	46.80	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:33.281144	2026-03-09 12:33:06.92274	f
1413	2025-04-20	10:00:00	2:29, 	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片	💖 Yes, eat right away	30.00	6.00	💕 Love it So Much	24.00	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:33.24235	2026-03-09 12:33:15.539663	f
1415	2025-04-20	10:00:00	19:52, 21:16, 23:35, 2:27, 5:25, 8:50, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	36.50	4.20	💕 Love it So Much	32.30	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:33.283334	2026-03-09 12:33:24.952383	f
1410	2025-04-20	01:50:00	14:49, 	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	💖 Yes, eat right away	60.00	32.90	🔺 So So	27.10	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.236707	2026-03-09 12:33:38.28042	f
1411	2025-04-20	01:50:00	-	Wet	mon petit 貓倍麗	極上餐包 鮮鮪嫩雞 lp3-c	🔺 No, not really. Ate A Little	35.00	24.40	❌ No!!!	10.60	0	🔺 - ❌	13		\N	2	\N	2026-03-02 12:05:33.238526	2026-03-09 12:33:46.709117	f
1412	2025-04-20	01:50:00	11:50, 16:40, 17:27, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.20	12.00	🔺 So So	13.20	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.240196	2026-03-09 12:33:58.144402	f
1420	2025-04-21	09:30:00	22:00, 1:14, 3:33, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	48.60	18.10	🔺 So So	30.50	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.292471	2026-03-09 12:35:13.471958	f
1419	2025-04-21	09:30:00	1:16, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	41.30	🔺 So So	23.70	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.290782	2026-03-09 12:35:25.091022	f
1418	2025-04-21	09:30:00	22:02,	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	29.20	🔺 So So	30.80	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.288995	2026-03-09 12:35:35.006465	f
1417	2025-04-21	01:11:00	11:41, 14:06, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	26.30	20.20	🔺 So So	6.10	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.287152	2026-03-09 12:35:47.589372	f
1416	2025-04-21	01:11:00	-	Wet	oasy	雞肉佐哈姆鮮食	💖 Yes, eat right away	70.00	42.80	❌ No!!!	27.20	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:33.285219	2026-03-09 12:35:58.831888	f
1424	2025-04-22	11:00:00	19:56, 00:33, 4:43, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	9.10	💕 Love it So Much	60.90	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:33.299482	2026-03-09 12:36:43.943921	f
4580	2026-03-15	01:28:00	15:28, 17:52, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	23.90	🔺 So So	36.10	2	💖 - 🔺	27		\N	2	\N	2026-03-15 01:28:40.378037	2026-03-15 12:40:17.744453	f
1426	2025-04-22	11:00:00	19:53, 21:12, 21:42, 00:31, 4:41, 8:12, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	41.70	6.50	💕 Love it So Much	35.20	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:33.303184	2026-03-09 12:37:11.657816	f
1421	2025-04-22	00:23:00	9:52, 17:13, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉) x2	💖 Yes, eat right away	70.00	25.30	💕 Love it So Much	44.70	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:33.294144	2026-03-09 12:37:20.738009	f
1422	2025-04-22	00:23:00	9:50, 14:35, 17:11, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	28.30	19.60	🔺 So So	8.70	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.295924	2026-03-09 12:37:29.188098	f
1423	2025-04-22	00:23:00	9:51, 19:54, 00:32, 	Other	零食	零食	❌ No, not interested	2.40	0.00	💕 Love it So Much	2.40	3	❌ - 💕	36		\N	2	\N	2026-03-02 12:05:33.297731	2026-03-09 12:37:39.202423	f
1431	2025-04-23	09:30:00	18:55, 19:25, 20:37, 22:09, 23:12, 00:36, 3:21, 6:53, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	41.10	6.00	💕 Love it So Much	35.10	8	❌ - 💕	46		\N	2	\N	2026-03-02 12:05:33.311765	2026-03-09 12:38:06.096744	f
1429	2025-04-23	09:30:00	18:56, 23:14, 4:33, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	❌ No, not interested	80.00	46.60	🔺 So So	33.40	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.308329	2026-03-09 12:38:14.620651	f
1430	2025-04-23	09:30:00	4:31, 	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	0.00	💕 Love it So Much	40.00	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:33.309976	2026-03-09 12:38:22.819707	f
1427	2025-04-23	00:49:00	14:29, 15:56, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	28.80	💕 Love it So Much	51.20	2	💖 - 💕	37		\N	2	\N	2026-03-02 12:05:33.304873	2026-03-09 12:38:30.34198	f
1428	2025-04-23	00:49:00	9:44, 11:39, 13:41, 15:56, 16:41, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.70	13.70	🔺 So So	12.00	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:33.306603	2026-03-09 12:38:39.981036	f
1432	2025-04-24	01:25:00	10:43, 13:53, 	Wet	nature 養生湯罐	鮪魚+雞肉	💖 Yes, eat right away	80.00	30.30	🔺 So So	49.70	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:33.313536	2026-03-09 12:39:40.860107	f
1433	2025-04-24	01:25:00	10:42, 13:51, 16:28, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.30	13.20	🔺 So So	12.10	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.315321	2026-03-09 12:39:51.613362	f
4249	2024-09-03	08:50:00	8:16	Wet	pramy 普拉	經典貓餐包 黃金鮮鮪+放山雞	🔺 No, not really. Ate A Little	70.00	49.50	🔺 So So	20.50	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:58.233315	2026-03-13 14:01:58.233315	f
1444	2025-04-26	03:30:00	9:54, 14:54, 18:41, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	24.90	13.00	🔺 So So	11.90	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.334753	2026-03-09 12:42:25.728131	f
1459	2025-04-29	01:30:00	-	Wet	ciao	魚盛貓罐頭 im-373 鮪魚+鰹魚+雞肉	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8	11:30 倒掉, 沒吃但一直叫	\N	2	\N	2026-03-02 12:05:33.401399	2026-03-09 12:46:24.544581	f
1435	2025-04-24	09:10:00	00:54, 	Wet	ciao	ic-506 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	28.20	🔺 So So	31.80	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.31894	2026-03-09 12:39:09.662889	f
2312	2026-03-05	01:03:00	12:03, 13:49, 15:47, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	27.40	🔺 So So	42.60	3	💖 - 🔺	29		\N	2	\N	2026-03-05 01:03:29.976985	2026-03-05 12:08:24.610275	f
1434	2025-04-24	09:10:00	22:56, 	Wet	ciao	cs-193 果凍杯 鰹魚柴魚片口味	❌ No, not interested	80.00	62.80	🔺 So So	17.20	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:33.317063	2026-03-09 12:39:27.191931	f
1440	2025-04-25	08:35:00	22:38, 1:10, 1:57, 8:31	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	52.50	🔺 So So	27.50	4	🔺 - 🔺	26		\N	2	\N	2026-03-02 12:05:33.327827	2026-03-09 12:40:12.214271	f
1441	2025-04-25	08:35:00	18:47, 20:20, 22:37, 1:09, 1:56, 5:32	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	38.10	6.40	💕 Love it So Much	31.70	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:33.329532	2026-03-09 12:40:20.0846	f
1438	2025-04-25	00:38:00	11:36, 14:06, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.30	12.30	🔺 So So	13.00	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.32439	2026-03-09 12:40:51.378583	f
1437	2025-04-25	00:38:00	14:07, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	26.90	💕 Love it So Much	53.10	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:33.322468	2026-03-09 12:41:04.751104	f
1446	2025-04-26	10:50:00	20:34, 5:10, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝 x2	💖 Yes, eat right away	60.00	31.30	🔺 So So	28.70	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:33.33824	2026-03-09 12:41:34.971898	f
1445	2025-04-26	10:50:00	20:36, 23:06, 3:26, 5:08, 9:28, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	11.10	💕 Love it So Much	48.90	5	💖 - 💕	50		\N	2	\N	2026-03-02 12:05:33.336515	2026-03-09 12:41:43.501555	f
1447	2025-04-26	10:50:00	20:33, 21:46, 23:04, 00:40, 3:23, 5:08,  9:27, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	38.40	4.10	💕 Love it So Much	34.30	7	❌ - 💕	44		\N	2	\N	2026-03-02 12:05:33.340109	2026-03-09 12:41:52.635728	f
1442	2025-04-26	01:05:00	9:55,	Wet	金湯	愛貓湯罐 白身鮪魚&小麥草	🔺 No, not really. Ate A Little	80.00	80.00	❌ No!!!	0.00	1	🔺 - ❌	15	11:20 聞一聞撥沙	\N	2	\N	2026-03-02 12:05:33.331261	2026-03-09 12:42:04.981583	f
1443	2025-04-26	03:30:00	14:55, 18:42, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	17.50	💕 Love it So Much	52.50	2	💖 - 💕	37	14:55 追加一個	\N	2	\N	2026-03-02 12:05:33.332965	2026-03-09 12:42:17.461758	f
1451	2025-04-27	09:25:00	-	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	56.90	❌ No!!!	23.10	0	💖 - ❌	18		\N	2	\N	2026-03-02 12:05:33.386911	2026-03-09 12:42:51.75312	f
1452	2025-04-27	09:25:00	18:29, 20:10, 21:14, 22:38, 23:36, 00:35, 4:39, 7:20,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	49.20	6.30	💕 Love it So Much	42.90	8	❌ - 💕	46		\N	2	\N	2026-03-02 12:05:33.388868	2026-03-09 12:43:00.990785	f
1450	2025-04-27	09:25:00	00:37, 	Wet	ciao	極致濃湯餐包 ic-504 鮪魚+雞肉+干貝 x2	❌ No, not interested	60.00	23.10	🔺 So So	36.90	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:33.385088	2026-03-09 12:43:08.873096	f
1449	2025-04-27	01:30:00	12:06, 14:44, 15:00, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	26.30	18.00	🔺 So So	8.30	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.383232	2026-03-09 12:43:27.915299	f
1448	2025-04-27	01:30:00	15:01, 	Wet	ciao	ic-361 無穀餐包 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	80.00	41.10	🔺 So So	38.90	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.381244	2026-03-09 12:43:37.150495	f
1456	2025-04-28	09:10:00	23:29, 6:53, 	Wet	ciao	ic-505 貓用極致濃湯肉塊餐包- 鰹魚+干貝+雞肉 x2	❌ No, not interested	60.00	35.10	🔺 So So	24.90	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.396012	2026-03-09 12:44:27.778269	f
1455	2025-04-28	09:10:00	19:15, 22:07, 6:53, 	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	❌ No, not interested	60.00	47.60	🔺 So So	12.40	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.394195	2026-03-09 12:44:36.173671	f
1457	2025-04-28	09:10:00	19:14, 20:59, 22:06, 23:28, 2:57, 6:50, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	42.60	9.20	💕 Love it So Much	33.40	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:33.397815	2026-03-09 12:44:45.484702	f
1453	2025-04-28	02:08:00	14:44, 	Wet	ciao	四連串包 多樂米濃湯 tcr-131 雞肉+鮪魚+干貝 x2	💖 Yes, eat right away	70.00	27.20	💕 Love it So Much	42.80	1	💖 - 💕	35		5.90	2	\N	2026-03-02 12:05:33.390648	2026-03-09 12:44:57.846382	f
1454	2025-04-28	02:08:00	11:31, 13:00, 14:43, 17:05, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	27.00	12.30	💕 Love it So Much	14.70	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:33.392494	2026-03-09 12:45:08.146837	f
1465	2025-04-29	10:23:00	18:46, 19:18, 21:05, 23:25, 00:56, 4:53,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	48.30	16.60	💕 Love it So Much	31.70	6	❌ - 💕	35	加 好味小姐凍乾 1.6g	\N	2	\N	2026-03-02 12:05:33.412284	2026-03-09 12:45:29.238957	f
1466	2025-04-29	11:28:00	-	Kibble	渴望	原野鮮雞貓	❌ No, not interested	21.80	21.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:33.414176	2026-03-09 12:45:52.327735	f
1467	2025-04-29	11:34:00	19:43, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.60	10.00	🔺 So So	11.60	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:33.416143	2026-03-09 12:46:10.300617	f
1460	2025-04-29	01:30:00	11:15, 	Wet	ciao	ic-217 貓用巧餐包 - 雞肉+鰹魚乾	🔺 No, not really. Ate A Little	40.00	13.50	🔺 So So	26.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-02 12:05:33.40323	2026-03-09 12:46:40.890851	f
1458	2025-04-29	01:30:00	-	Wet	銀湯匙	三星美食貓餐包 細嫩口感 鮪魚, 鰹魚, 雞胸肉	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:33.399652	2026-03-09 12:46:51.398868	f
1461	2025-04-29	03:35:00	14:30, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	22.00	💕 Love it So Much	48.00	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:33.405139	2026-03-09 12:47:19.163696	f
1463	2025-04-29	06:39:00	11:15, 12:43, 17:44, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	27.10	16.70	🔺 So So	10.40	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.408683	2026-03-09 12:47:28.769386	f
1462	2025-04-29	06:39:00	-	Wet	heromama	維他命補給罐 牛肉+雞絲	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-02 12:05:33.406894	2026-03-09 12:47:38.697022	f
1468	2025-04-30	01:00:00	16:54, 	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片 x2	💖 Yes, eat right away	60.00	32.70	🔺 So So	27.30	1	💖 - 🔺	25		\N	2	\N	2026-03-02 12:05:33.41869	2026-03-09 12:49:06.692294	f
830	2026-02-26	01:46:00	10:24, 14:46, 17:13, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	27.50	💕 Love it So Much	52.50	3	💖 - 💕	39		\N	2	\N	2026-02-26 01:47:18.136759	2026-03-02 12:07:53.816587	f
126	2026-02-10	01:15:00	-	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	💖 Yes, eat right away	70.00	45.10	❌ No!!!	24.90	0	💖 - ❌	18	5:30 要咬人	\N	2	\N	2026-02-12 14:41:10.701581	2026-03-02 12:34:46.465099	f
1014	2025-02-01	07:50:00	-	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	❌ No, not interested	65.00	16.60	🔺 So So	48.40	0	❌ - 🔺	13		\N	2	\N	2026-03-02 12:05:32.051354	2026-03-09 04:31:18.250202	f
1048	2025-02-10	01:55:00	10:40, 14:40, 15:30, 18:18, 20:28, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	💖 Yes, eat right away	50.00	10.80	💕 Love it So Much	39.20	5	💖 - 💕	50		\N	2	\N	2026-03-02 12:05:32.115442	2026-03-09 09:02:51.003061	f
1075	2025-02-16	12:51:00	1:31, 5:58,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	26.20	🔺 So So	33.80	2	💖 - 🔺	27		\N	2	\N	2026-03-02 12:05:32.20304	2026-03-09 09:09:52.489293	f
1091	2025-02-19	13:50:00	00:58, 5:09, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	31.10	20.20	🔺 So So	10.90	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.267662	2026-03-09 09:13:10.823357	f
1469	2025-04-30	01:00:00	11:17, 12:59, 15:21, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	24.40	11.50	🔺 So So	12.90	3	❌ - 🔺	19		\N	2	\N	2026-03-02 12:05:33.420681	2026-03-09 12:48:46.217861	f
1476	2026-03-02	13:07:00	23:59,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	5.20	🔺 So So	4.80	1	❌ - 🔺	15		\N	2	\N	2026-03-02 13:07:19.80126	2026-03-03 02:09:08.151976	f
1474	2026-03-02	13:02:00	22:16, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	20.00	16.50	🔺 So So	3.50	1	❌ - 🔺	15		\N	2	\N	2026-03-02 13:02:21.402911	2026-03-03 02:09:37.699047	f
1125	2025-02-26	01:55:00	18:32, 21:31, 23:58, 4:38, 8:22, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.50	6.70	🔺 So So	13.80	5	❌ - 🔺	23	19:00 量體重	5.60	2	\N	2026-03-02 12:05:32.433535	2026-03-09 09:22:33.448707	f
1477	2026-03-01	12:38:00	20:57, 22:56, 2:47, 5:30, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	5.10	🔺 So So	19.90	4	❌ - 🔺	28	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-03-02 14:48:02.220171	2026-03-02 14:48:51.633489	f
1209	2025-03-12	12:00:00	20:14, 22:18, 1:01, 4:16, 7:48, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	25.60	17.40	🔺 So So	8.20	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:32.685198	2026-03-09 09:39:37.779706	f
1478	2026-03-02	01:14:00	12:38, 20:56, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	8.10	🔺 So So	16.90	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-03-02 14:49:48.906321	2026-03-02 14:50:22.845001	f
1324	2025-04-03	10:00:00	-	Wet	餐包	餐包	❌ No, not interested	60.00	50.00	🔺 So So	10.00	0	❌ - 🔺	13	均禾貓旅住宿	\N	2	\N	2026-03-02 12:05:33.017507	2026-03-09 10:37:09.26457	f
1330	2025-04-05	11:25:00	2:31, 5:39, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	8.10	💕 Love it So Much	61.90	2	💖 - 💕	44		\N	2	\N	2026-03-02 12:05:33.028447	2026-03-09 11:59:55.137055	f
1383	2025-04-15	10:30:00	19:47, 21:09, 22:14, 23:38, 3:03, 	Kibble	柏萊富	雞肉+豌豆 & 特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	48.40	43.50	🔺 So So	4.90	5	❌ - 🔺	23	加 好味小姐凍乾 1.7g	\N	2	\N	2026-03-02 12:05:33.189088	2026-03-09 12:23:47.711445	f
1380	2025-04-15	01:30:00	16:54, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	18.20	💕 Love it So Much	41.80	1	💖 - 💕	35		\N	2	\N	2026-03-02 12:05:33.183083	2026-03-09 12:24:41.400652	f
1464	2025-04-29	10:50:00	23:27, 00:58, 4:57, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	43.30	🔺 So So	36.70	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:33.410427	2026-03-09 12:45:41.87767	f
1471	2025-04-30	09:58:00	19:29, 20:58, 22:55, 2:53, 4:55, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	42.50	21.90	🔺 So So	20.60	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:33.424647	2026-03-09 12:48:23.090787	f
1470	2025-04-30	09:58:00	22:01, 2:56, 4:56, 7:14, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝) x2	💖 Yes, eat right away	100.00	61.50	🔺 So So	38.50	4	💖 - 🔺	31		\N	2	\N	2026-03-02 12:05:33.422759	2026-03-09 12:48:30.573277	f
1475	2026-03-02	13:05:00	22:16, 2:40, 9:57, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	7.80	🔺 So So	17.40	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-03-02 13:05:15.781555	2026-03-03 02:10:54.645749	f
1473	2026-03-02	13:00:00	22:17, 2:43, 9:58, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	14.50	💕 Love it So Much	90.50	3	💖 - 💕	46		\N	2	\N	2026-03-02 13:00:57.546486	2026-03-03 02:11:58.596106	f
1472	2025-04-30	10:33:00	22:01, 7:13, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	24.50	16.00	🔺 So So	8.50	2	❌ - 🔺	17	加 好味小姐凍乾 2.7g	\N	2	\N	2026-03-02 12:05:33.426644	2026-03-09 12:48:38.682619	f
1570	2025-05-12	00:40:00	10:00, 17:42, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.20	13.30	🔺 So So	7.90	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.217187	2026-03-09 13:37:57.588097	f
760	2026-01-26	01:22:00	-	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	47.40	❌ No!!!	22.60	0	💖 - ❌	18	23:50-2:00躁動 ＆ 快咬人	\N	2	\N	2026-02-23 13:47:08.218519	2026-03-10 14:04:11.074825	f
1489	2026-03-03	02:18:00	-	Freeze-Dried	ve 唯一	凍乾鮮肉貓用生食餐 鴨肉軟顆粒	❌ No, not interested	7.40	7.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-03 04:20:32.317186	2026-03-03 13:18:11.862628	f
1484	2026-03-03	02:05:00	11:07, 11:45, 13:38, 15:23, 16:49, 19:26, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	❌ No, not interested	105.00	25.10	💕 Love it So Much	79.90	6	❌ - 💕	42		\N	2	\N	2026-03-03 02:08:33.426648	2026-03-03 13:17:54.367145	f
1499	2026-03-03	03:07:00	13:35, 15:22, 16:47, 17:29, 21:05	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	20.00	8.10	💕 Love it So Much	11.90	5	💖 - 💕	43		\N	2	\N	2026-03-03 13:27:39.008835	2026-03-03 13:28:32.553107	f
1502	2026-03-03	02:13:00	13:37, 15:21, 19:24, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	16.70	🔺 So So	8.30	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-03-03 13:34:59.239866	2026-03-03 13:35:39.29192	f
1498	2026-03-03	13:11:00	00:54, 2:22, 4:59, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	12.20	🔺 So So	7.80	3	❌ - 🔺	19		\N	2	\N	2026-03-03 13:27:06.900059	2026-03-04 00:55:58.892772	f
1497	2026-03-03	13:19:00	-	Freeze-Dried	ve 唯一	凍乾鮮肉貓用生食餐 鴨肉軟顆粒	❌ No, not interested	7.40	7.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-03 13:19:25.089767	2026-03-04 00:57:38.502047	f
1492	2026-03-03	13:07:00	21:48, 00:55, 5:01,	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	28.00	💕 Love it So Much	52.00	3	💖 - 💕	39		\N	2	\N	2026-03-03 13:07:40.150112	2026-03-04 00:58:29.757218	f
1509	2026-03-04	01:02:00	10:24, 11:51, 17:05, 17:46, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	12.60	🔺 So So	7.40	4	❌ - 🔺	21		\N	2	\N	2026-03-04 01:02:33.52344	2026-03-04 13:39:14.110394	f
1503	2026-03-03	13:14:00	21:47, 00:53, 2:24, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	14.30	🔺 So So	11.10	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-03-03 13:36:02.269406	2026-03-04 00:56:54.943928	f
1515	2025-05-01	10:25:00	23:25, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	15.30	13.00	🔺 So So	2.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.041184	2026-03-09 13:22:43.547023	f
1510	2026-03-04	01:06:00	14:31, 17:47, 19:35, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	11.00	💕 Love it So Much	14.10	3	❌ - 💕	29	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-03-04 01:06:54.300233	2026-03-04 13:35:42.830991	f
1508	2026-03-04	01:00:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	7.20	❌ No!!!	2.80	0	💖 - ❌	18		\N	2	\N	2026-03-04 01:01:00.22833	2026-03-04 13:41:28.919107	f
1507	2026-03-04	00:54:00	11:52, 14:32, 17:07, 17:47, 19:37, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	31.10	💕 Love it So Much	98.90	5	💖 - 💕	50		\N	2	\N	2026-03-04 00:54:52.517291	2026-03-04 13:43:22.533013	f
2307	2026-03-04	13:35:00	22:24, 8:49, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	14.40	🔺 So So	10.80	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-03-04 13:38:10.199916	2026-03-05 01:06:11.369752	f
1013	2025-02-01	07:50:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	22.20	14.50	🔺 So So	7.70	0	❌ - 🔺	13	加 好味小姐凍乾 3.1g	\N	2	\N	2026-03-02 12:05:32.049331	2026-03-09 04:31:08.705698	f
2313	2026-03-05	01:04:00	17:19, 	Wet	ciao	imc-224 雙喵杯 鮪魚+雞肉+柴魚片	❌ No, not interested	35.00	23.70	🔺 So So	11.30	1	❌ - 🔺	15		\N	2	\N	2026-03-05 01:04:30.667895	2026-03-05 12:07:32.001515	f
1513	2025-05-01	10:25:00	23:25, 7:23,	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	32.70	🔺 So So	47.30	2	💖 - 🔺	27	邊吃邊埋沙	\N	2	\N	2026-03-04 11:51:05.035104	2026-03-09 13:22:35.40364	f
1514	2025-05-01	10:25:00	20:40, 21:21, 23:22, 3:46,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	39.90	6.70	💕 Love it So Much	33.20	4	❌ - 💕	38		\N	2	\N	2026-03-04 11:51:05.037461	2026-03-09 13:22:53.435127	f
1511	2025-05-01	00:55:00	-	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	🔺 No, not really. Ate A Little	80.00	59.30	❌ No!!!	20.70	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.025538	2026-03-09 13:23:02.325637	f
1512	2025-05-01	00:55:00	11:17, 14:29, 16:51, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	25.00	14.80	🔺 So So	10.20	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.031411	2026-03-09 13:23:10.357417	f
1520	2025-05-02	08:27:00	-	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝 x2	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.050781	2026-03-09 13:23:30.205528	f
1521	2025-05-02	08:27:00	18:41, 18:52, 19:53, 22:42, 00:31, 3:39, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	33.20	2.10	💕 Love it So Much	31.10	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:05.053651	2026-03-09 13:23:38.606561	f
1519	2025-05-02	08:27:00	18:42, 22:45, 3:43,	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	8.60	💕 Love it So Much	56.40	3	💖 - 💕	46		\N	2	\N	2026-03-04 11:51:05.04892	2026-03-09 13:23:46.67741	f
1518	2025-05-02	01:35:00	10:38, 13:35, 14:40, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.30	8.20	🔺 So So	13.10	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.047061	2026-03-09 13:23:56.499808	f
1517	2025-05-02	01:35:00	-	Wet	hello fresh 	好鮮原汁湯罐 清蒸雞肉	💖 Yes, eat right away	80.00	35.10	🔺 So So	44.90	0	💖 - 🔺	23		\N	2	\N	2026-03-04 11:51:05.045293	2026-03-09 13:24:07.219428	f
1516	2025-05-02	01:35:00	-	Wet	ciao	cs-185 貓用綜合營養湯罐 鮪魚	❌ No, not interested	120.00	120.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-04 11:51:05.043258	2026-03-09 13:24:39.630956	f
1524	2025-05-03	13:00:00	23:54, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉) x2	💖 Yes, eat right away	70.00	33.10	🔺 So So	36.90	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.06184	2026-03-09 13:24:53.942439	f
1525	2025-05-03	13:00:00	20:29, 23:50, 4:23, 7:35, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	38.20	10.40	🔺 So So	27.80	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.064034	2026-03-09 13:25:04.717301	f
1523	2025-05-03	00:30:00	15:18, 16:02, 19:03, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.80	12.40	🔺 So So	9.40	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.059825	2026-03-09 13:25:13.167833	f
1522	2025-05-03	00:30:00	11:01, 13:25, 15:19, 19:04, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	10.00	💕 Love it So Much	40.00	4	💖 - 💕	48		\N	2	\N	2026-03-04 11:51:05.057199	2026-03-09 13:25:22.875965	f
1528	2025-05-04	08:04:00	20:37, 23:53, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	21.10	🔺 So So	38.90	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.072978	2026-03-09 13:25:51.106618	f
1529	2025-05-04	13:54:00	23:55,  4:22, 	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片 x2	💖 Yes, eat right away	60.00	34.20	🔺 So So	25.80	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.075154	2026-03-09 13:25:59.354852	f
1530	2025-05-04	13:54:00	23:46, 23:53, 1:47, 4:20,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	33.40	6.30	💕 Love it So Much	27.10	4	❌ - 💕	38		\N	2	\N	2026-03-04 11:51:05.078157	2026-03-09 13:26:18.101289	f
1526	2025-05-04	01:50:00	-	Wet	金湯	愛貓湯罐 白身鮪魚&雞肉	🔺 No, not really. Ate A Little	80.00	58.00	❌ No!!!	22.00	0	🔺 - ❌	13	11:07(沒吃撥沙), 	\N	2	\N	2026-03-04 11:51:05.069268	2026-03-09 13:26:28.610562	f
1527	2025-05-04	01:50:00	11:07, 14:00, 17:54, 19:46, 20:35, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.30	7.60	💕 Love it So Much	13.70	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:05.071055	2026-03-09 13:26:36.772759	f
1534	2025-05-05	10:30:00	-	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	🔺 No, not really. Ate A Little	80.00	56.90	❌ No!!!	23.10	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.113124	2026-03-09 13:27:15.32543	f
1535	2025-05-05	14:26:00	23:41, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	❌ No, not interested	80.00	66.70	🔺 So So	13.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.116828	2026-03-09 13:27:24.12872	f
1533	2025-05-05	00:47:00	9:07, 16:53, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	22.60	12.70	🔺 So So	9.90	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.10862	2026-03-09 13:27:40.953374	f
1532	2025-05-05	03:30:00	14:18, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	34.30	🔺 So So	35.70	1	💖 - 🔺	25	15:40 新放一個	\N	2	\N	2026-03-04 11:51:05.106226	2026-03-09 13:27:54.522288	f
1531	2025-05-05	00:47:00	-	Wet	ciao	cc-82 貓用頂級奢華鮪魚 鮪魚+干貝 凍罐	🔺 No, not really. Ate A Little	60.00	48.80	❌ No!!!	11.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.080409	2026-03-13 12:56:42.639775	f
1555	2025-05-09	12:50:00	21:50, 1:59, 4:42, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	2.20	💕 Love it So Much	47.80	3	💖 - 💕	46		\N	2	\N	2026-03-04 11:51:05.167496	2026-03-09 13:32:51.343114	f
4570	2026-03-14	00:52:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	70.00	56.70	❌ No!!!	13.30	0	💖 - ❌	18	跟上跟下	\N	2	\N	2026-03-14 00:52:21.157651	2026-03-14 07:19:48.269638	f
1536	2025-05-05	10:30:00	21:26, 22:12, 23:39, 3:46, 8:06, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	39.70	8.10	🔺 So So	31.60	5	❌ - 🔺	30	加 好味小姐凍乾 2g	\N	2	\N	2026-03-04 11:51:05.119455	2026-03-09 13:27:06.946427	f
1539	2025-05-06	11:50:00	22:14, 23:17, 00:50, 8:30, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	17.30	💕 Love it So Much	62.70	4	💖 - 💕	48		\N	2	\N	2026-03-04 11:51:05.132318	2026-03-09 13:28:25.853426	f
1540	2025-05-06	11:50:00	21:34, 22:13, 23:15, 1:22, 3:34, 8:29, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	37.90	5.00	💕 Love it So Much	32.90	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:05.135896	2026-03-09 13:28:34.992329	f
1538	2025-05-06	01:10:00	17:08, 17:32,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.80	12.10	🔺 So So	9.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.126391	2026-03-09 13:28:44.232301	f
1537	2025-05-06	01:10:00	13:00, 17:33,	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	25.00	🔺 So So	25.00	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.122546	2026-03-09 13:28:54.013036	f
1545	2025-05-07	10:22:00	20:56, 22:42, 1:30, 2:08, 4:07, 8:27	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	34.10	9.10	💕 Love it So Much	25.00	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:05.14741	2026-03-09 13:29:18.943406	f
1546	2025-05-07	10:22:00	22:43, 8:28	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	28.80	22.50	🔺 So So	6.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.150577	2026-03-09 13:29:26.751848	f
1544	2025-05-07	10:22:00	22:44, 1:34, 2:10, 8:29	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	28.00	💕 Love it So Much	52.00	4	💖 - 💕	41		\N	2	\N	2026-03-04 11:51:05.143861	2026-03-09 13:29:35.66063	f
1542	2025-05-07	01:07:00	11:12, 15:08, 16:15, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	20.30	13.90	🔺 So So	6.40	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.139615	2026-03-09 13:29:44.155529	f
1541	2025-05-07	01:07:00	12:20, 	Wet	ciao	ic-216 貓用巧餐包 鮪魚+鰹魚乾+雞肉	💖 Yes, eat right away	40.00	17.20	🔺 So So	22.80	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.13785	2026-03-09 13:30:05.649761	f
1543	2025-05-07	03:10:00	12:18, 15:09, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	17.90	9.30	🔺 So So	8.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.141627	2026-03-09 13:30:14.442255	f
1548	2025-05-08	08:20:00	17:48	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚	💖 Yes, eat right away	35.00	7.90	💕 Love it So Much	27.10	1	💖 - 💕	42	吃完馬上吐	\N	2	\N	2026-03-04 11:51:05.154307	2026-03-09 13:31:03.70894	f
1550	2025-05-08	11:01:00	20:52, 21:43, 1:11, 3:37, 8:07,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	💖 Yes, eat right away	85.00	30.00	💕 Love it So Much	55.00	5	💖 - 💕	43		\N	2	\N	2026-03-04 11:51:05.15828	2026-03-09 13:31:14.076671	f
1551	2025-05-08	11:01:00	20:50, 21:42, 22:20, 1:09, 3:35, 8:07, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	40.40	6.90	💕 Love it So Much	33.50	6	❌ - 💕	42	加 好味小姐凍乾 2.1g	\N	2	\N	2026-03-04 11:51:05.160045	2026-03-09 13:31:22.736625	f
1549	2025-05-08	01:20:00	14:08, 17:47	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.40	12.90	🔺 So So	8.50	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.156448	2026-03-09 13:31:31.380959	f
1547	2025-05-08	01:20:00	14:09, 	Wet	ciao	ic-361 無穀餐包 鮪魚+雞肉+干貝 	💖 Yes, eat right away	40.00	8.80	💕 Love it So Much	31.20	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:05.152383	2026-03-09 13:32:01.528435	f
1557	2025-05-09	09:13:00	19:27, 20:39, 21:48, 23:30, 1:58, 7:38, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	41.10	16.00	💕 Love it So Much	25.10	6	❌ - 💕	35	加 好味小姐凍乾 1.9g	\N	2	\N	2026-03-04 11:51:05.171054	2026-03-09 13:32:34.070414	f
1556	2025-05-09	09:13:00	19:29, 2:00, 4:45, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	10.60	💕 Love it So Much	49.40	3	💖 - 💕	46		\N	2	\N	2026-03-04 11:51:05.169437	2026-03-09 13:32:42.434736	f
1554	2025-05-09	00:44:00	13:46, 17:08, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	24.20	18.30	🔺 So So	5.90	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.165876	2026-03-09 13:33:02.622764	f
1552	2025-05-09	00:44:00	-	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	🔺 No, not really. Ate A Little	70.00	40.50	❌ No!!!	29.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.162536	2026-03-09 13:33:11.363186	f
1553	2025-05-09	02:55:00	-	Kibble	吶一口	室內貓雙響宴	💖 Yes, eat right away	57.00	39.50	❌ No!!!	17.50	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.164282	2026-03-09 13:33:24.365073	f
1560	2025-05-10	11:15:00	20:43, 4:39, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	31.00	🔺 So So	49.00	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.17613	2026-03-09 13:34:03.721322	f
1561	2025-05-10	13:55:00	4:38	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚	💖 Yes, eat right away	35.00	1.80	💕 Love it So Much	33.20	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:05.178275	2026-03-09 13:34:11.33199	f
1558	2025-05-10	01:55:00	12:40, 19:07, 	Wet	金湯	愛貓湯罐 鮮嫩雞肉	💖 Yes, eat right away	80.00	36.40	🔺 So So	43.60	2	💖 - 🔺	27		5.90	2	\N	2026-03-04 11:51:05.172976	2026-03-09 13:34:20.709096	f
1559	2025-05-10	01:55:00	12:39, 16:54, 19:07, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	20.50	9.30	🔺 So So	11.20	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.174561	2026-03-09 13:34:28.390989	f
1565	2025-05-11	09:35:00	22:58, 1:40,  5:15, 6:54,	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	23.30	💕 Love it So Much	56.70	4	💖 - 💕	41		\N	2	\N	2026-03-04 11:51:05.204848	2026-03-09 13:35:50.362504	f
1567	2025-05-11	09:35:00	19:29, 21:57, 22:56, 1:37, 5:13, 6:52,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	33.10	4.10	💕 Love it So Much	29.00	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:05.209987	2026-03-09 13:35:58.787382	f
1566	2025-05-11	11:40:00	22:58, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝	💖 Yes, eat right away	30.00	8.80	💕 Love it So Much	21.20	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:05.207487	2026-03-09 13:36:09.116558	f
1564	2025-05-11	01:40:00	12:33, 13:42, 17:24, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.50	7.80	🔺 So So	13.70	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.183202	2026-03-09 13:36:26.31169	f
1568	2025-05-12	00:40:00	-	Wet	abao	台式熱炒 鮮食餐包 爆炒三鮮	❌ No, not interested	150.00	150.00	❌ No!!!	0.00	0	❌ - ❌	8	12:00 倒掉	\N	2	\N	2026-03-04 11:51:05.211972	2026-03-09 13:37:29.851931	f
1569	2025-05-12	00:40:00	-	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	60.20	❌ No!!!	19.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.215295	2026-03-09 13:37:38.785222	f
4254	2024-09-04	08:10:00	-	Wet	迷幻喵	8號 好火雞+胡蘿蔔	❌ No, not interested	125.00	125.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-13 14:01:58.241354	2026-03-16 14:25:30.379761	f
1572	2025-05-12	10:09:00	20:00, 00:25, 2:48, 7:46, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	20.00	💕 Love it So Much	65.00	4	💖 - 💕	48		\N	2	\N	2026-03-04 11:51:05.220893	2026-03-09 13:37:09.089811	f
1576	2025-05-13	10:28:00	2:40, 8:23, 	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	💖 Yes, eat right away	60.00	29.20	🔺 So So	30.80	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.22793	2026-03-09 13:38:29.672657	f
1578	2025-05-13	10:28:00	19:56, 21:05, 2:38, 8:22, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	48.60	26.70	🔺 So So	21.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.231881	2026-03-09 13:38:37.521664	f
1577	2025-05-13	12:04:00	8:23, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	🔺 No, not really. Ate A Little	80.00	56.60	🔺 So So	23.40	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.229691	2026-03-09 13:38:46.000727	f
1574	2025-05-13	00:33:00	10:44, 16:24, 17:46, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	23.80	🔺 So So	26.20	3	💖 - 🔺	29		\N	2	\N	2026-03-04 11:51:05.224493	2026-03-09 13:38:54.621997	f
1575	2025-05-13	00:33:00	16:24, 17:26, 17:46, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.00	17.90	🔺 So So	3.10	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.226198	2026-03-09 13:39:02.638183	f
1581	2025-05-14	08:04:00	-	Wet	ciao	cc-83 貓用頂級奢華鮪魚 鮪魚+鰹魚 凍罐	🔺 No, not really. Ate A Little	60.00	56.70	❌ No!!!	3.30	0	🔺 - ❌	13	20:20 一直叫想吃, 但就是不吃, => 倒掉	\N	2	\N	2026-03-04 11:51:05.236922	2026-03-09 13:39:32.51231	f
1582	2025-05-14	09:51:00	1:16, 4:30, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	21.90	💕 Love it So Much	48.10	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.23851	2026-03-09 13:39:41.982669	f
1583	2025-05-14	11:50:00	-	Wet	ciao	imc-244 雞肉濃湯杯 - 扇貝	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	20:20 一直叫想吃, 但就是不吃, => 倒掉	\N	2	\N	2026-03-04 11:51:05.240103	2026-03-09 13:39:51.594573	f
1584	2025-05-14	12:15:00	1:15, 8:37, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	🔺 No, not really. Ate A Little	85.00	54.80	🔺 So So	30.20	2	🔺 - 🔺	22		\N	2	\N	2026-03-04 11:51:05.24178	2026-03-09 13:40:03.426287	f
1585	2025-05-14	12:15:00	21:22, 22:38, 1:13, 4:28, 8:35, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	45.20	9.10	🔺 So So	36.10	5	❌ - 🔺	30		\N	2	\N	2026-03-04 11:51:05.243522	2026-03-09 13:40:11.519326	f
1579	2025-05-14	00:45:00	9:50, 14:28, 	Wet	oasy	雞胸肉鮮食	💖 Yes, eat right away	70.00	33.20	🔺 So So	36.80	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.23362	2026-03-09 13:40:25.764052	f
1580	2025-05-14	00:45:00	12:48, 16:41, 17:50, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	20.30	14.40	🔺 So So	5.90	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.235278	2026-03-09 13:40:41.631962	f
1588	2025-05-15	08:25:00	21:41, 1:46, 3:50, 7:53, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	🔺 No, not really. Ate A Little	80.00	32.70	🔺 So So	47.30	4	🔺 - 🔺	26		\N	2	\N	2026-03-04 11:51:05.248758	2026-03-09 13:41:18.332573	f
1591	2025-05-15	10:55:00	19:28, 23:59, 1:46, 3:49	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	46.20	23.90	🔺 So So	22.30	4	❌ - 🔺	21	加 好味小姐凍乾 1.7g	\N	2	\N	2026-03-04 11:51:05.255304	2026-03-09 13:41:27.75986	f
1589	2025-05-15	10:55:00	19:29, 1:47, 7:54, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	20.20	💕 Love it So Much	49.80	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:05.250428	2026-03-09 13:41:36.944038	f
1590	2025-05-15	13:30:00	22:44, 00:07, 	Kibble	柏萊富	雞肉+豌豆	💖 Yes, eat right away	8.70	2.00	🔺 So So	6.70	2	💖 - 🔺	34		\N	2	\N	2026-03-04 11:51:05.253602	2026-03-09 13:41:45.956763	f
1587	2025-05-15	01:05:00	12:08, 18:36, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	20.50	13.60	🔺 So So	6.90	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.247081	2026-03-09 13:41:58.210532	f
1586	2025-05-15	01:05:00	12:10, 	Wet	ciao	ic-536 貓用雞三味凍餐包 扇貝貝柱	💖 Yes, eat right away	60.00	26.10	🔺 So So	33.90	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.245134	2026-03-09 13:42:07.353574	f
1596	2025-05-16	08:12:00	17:15, 19:02, 19:14, 23:32, 6:56, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	18.50	💕 Love it So Much	31.50	5	🔺 - 💕	38		\N	2	\N	2026-03-04 11:51:05.272474	2026-03-09 13:42:41.789302	f
1599	2025-05-16	09:48:00	19:12, 20:29, 21:36, 00:42, 1:31, 3:20, 6:54, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	35.70	8.40	💕 Love it So Much	27.30	7	❌ - 💕	44		\N	2	\N	2026-03-04 11:51:05.278489	2026-03-09 13:42:52.22981	f
1597	2025-05-16	09:48:00	19:14, 23:33, 00:44, 3:22, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	17.50	💕 Love it So Much	42.50	4	💖 - 💕	41		\N	2	\N	2026-03-04 11:51:05.274802	2026-03-09 13:43:00.431701	f
1598	2025-05-16	09:48:00	6:55, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	40.30	32.90	🔺 So So	7.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.276852	2026-03-09 13:43:08.696715	f
1595	2025-05-16	01:37:00	17:13, 	Kibble	吶一口	室內貓雙響宴	💖 Yes, eat right away	17.40	8.40	🔺 So So	9.00	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.269328	2026-03-09 13:43:21.471205	f
1594	2025-05-16	01:37:00	13:03, 15:11, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	20.20	14.40	🔺 So So	5.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.267348	2026-03-09 13:43:29.823438	f
1592	2025-05-16	01:37:00	-	Wet	ciao	四連串包 多樂米濃湯 tcr-131 雞肉+鮪魚+干貝 x2	💖 Yes, eat right away	70.00	31.60	❌ No!!!	38.40	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.261524	2026-03-09 13:43:39.076688	f
1593	2025-05-16	02:50:00	13:04, 	Wet	litomon 怪獸部落	佛跳牆 - 龍鳳呈祥	🔺 No, not really. Ate A Little	80.00	61.10	🔺 So So	18.90	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.265438	2026-03-09 13:43:58.835913	f
1605	2025-05-17	11:30:00	21:50, 23:29, 1:34, 4:00, 7:00, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	22.80	19.40	🔺 So So	3.40	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:05.292617	2026-03-09 13:44:20.416085	f
1604	2025-05-17	11:30:00	19:45, 20:47, 4:01, 7:01, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	42.40	13.90	🔺 So So	28.50	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.286964	2026-03-09 13:44:28.947806	f
1602	2025-05-17	11:30:00	19:46, 4:03, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	❌ No, not interested	85.00	62.50	🔺 So So	22.50	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.2836	2026-03-09 13:44:37.476718	f
1603	2025-05-17	12:20:00	1:36, 4:02, 	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝 x2	💖 Yes, eat right away	60.00	23.30	🔺 So So	36.70	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.285302	2026-03-09 13:44:46.087997	f
1600	2025-05-17	01:15:00	10:59, 15:56, 	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚x2	💖 Yes, eat right away	70.00	7.20	💕 Love it So Much	62.80	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.280127	2026-03-09 13:44:55.034375	f
1601	2025-05-17	01:15:00	10:58, 13:34, 15:55, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	20.70	12.40	🔺 So So	8.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.281881	2026-03-09 13:45:10.449434	f
1608	2025-05-18	01:10:00	10:44, 14:20, 15:47, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	20.30	11.60	🔺 So So	8.70	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.298949	2026-03-09 13:46:11.099048	f
1609	2025-05-18	08:30:00	17:16, 18:15, 19:06, 21:00, 23:26, 00:34, 3:31, 6:27, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	52.30	7.60	💕 Love it So Much	44.70	8	❌ - 💕	46		\N	2	\N	2026-03-04 11:51:05.30113	2026-03-09 13:45:35.877483	f
1610	2025-05-18	09:20:00	00:36, 3:33, 6:29, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	❌ No, not interested	80.00	24.30	💕 Love it So Much	55.70	3	❌ - 💕	29		\N	2	\N	2026-03-04 11:51:05.303055	2026-03-09 13:45:48.478083	f
1611	2025-05-18	11:15:00	-	Wet	wellness	core dd寵鮮杯 (鮭魚丁+雞肉)	❌ No, not interested	79.00	79.00	❌ No!!!	0.00	0	❌ - ❌	8	22:00 倒掉, 聞一聞沒吃	\N	2	\N	2026-03-04 11:51:05.305419	2026-03-09 13:45:57.663403	f
1607	2025-05-18	07:30:00	21:02, 	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚	💖 Yes, eat right away	35.00	0.00	💕 Love it So Much	35.00	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:05.296974	2026-03-09 13:47:13.221021	f
1617	2025-05-19	12:05:00	00:29, 6:14, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) 	💖 Yes, eat right away	60.00	30.90	🔺 So So	29.10	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.317822	2026-03-09 13:47:47.258491	f
1613	2025-05-19	01:09:00	9:48, 12:11, 14:50, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	22.00	13.30	💕 Love it So Much	8.70	3	❌ - 💕	29		\N	2	\N	2026-03-04 11:51:05.309216	2026-03-09 13:47:57.233904	f
1612	2025-05-19	01:09:00	-	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	💖 Yes, eat right away	57.00	32.40	❌ No!!!	24.60	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.307341	2026-03-09 13:48:04.595253	f
1614	2025-05-19	01:09:00	-	Kibble	now	鮮肉無穀天然糧 成貓配方	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.310958	2026-03-09 13:48:12.893317	f
1615	2025-05-19	04:15:00	12:37, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	2.40	💕 Love it So Much	32.60	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:05.313119	2026-03-09 13:48:27.623891	f
1616	2025-05-19	07:35:00	18:15, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	🔺 No, not really. Ate A Little	85.00	59.50	🔺 So So	25.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.315048	2026-03-09 13:48:40.983845	f
1618	2025-05-19	07:35:00	18:12, 19:56, 00:26, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	53.30	23.80	🔺 So So	29.50	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.334129	2026-03-09 13:48:56.143587	f
1624	2025-05-20	09:36:00	20:42, 2:43	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	❌ No, not interested	70.00	38.10	🔺 So So	31.90	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.348054	2026-03-09 13:49:35.433895	f
1625	2025-05-20	10:15:00	-	Wet	無一物	蒸寵貓餐包 雞肉+雞軟骨	🔺 No, not really. Ate A Little	40.00	24.00	❌ No!!!	16.00	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.350073	2026-03-09 13:49:49.536842	f
1619	2025-05-20	23:53:00	-	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.337228	2026-03-09 13:50:00.605554	f
1626	2025-05-20	13:26:00	21:37, 22:58, 00:26, 2:39, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	49.80	13.30	🔺 So So	36.50	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.352262	2026-03-09 13:50:10.354958	f
1623	2025-05-20	00:02:00	16:57, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	23.10	17.50	🔺 So So	5.60	1	❌ - 🔺	15	加 好味小姐凍乾 2.2g	\N	2	\N	2026-03-04 11:51:05.346195	2026-03-09 13:50:24.954968	f
1622	2025-05-20	00:02:00	11:40, 16:56, 20:40, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.30	8.90	🔺 So So	12.40	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.344291	2026-03-09 13:50:46.512088	f
1620	2025-05-20	00:02:00	-	Wet	ciao	四連串包 tcr-145 乳酸菌 2000億個 雞肉& 鮭魚 x2	💖 Yes, eat right away	70.00	22.60	❌ No!!!	47.40	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.339395	2026-03-09 13:50:54.305103	f
1621	2025-05-20	04:08:00	-	Wet	hello fresh	好鮮原汁湯罐 清蒸雞肉	💖 Yes, eat right away	80.00	42.20	❌ No!!!	37.80	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.341975	2026-03-09 13:51:12.884438	f
1631	2025-05-21	09:45:00	-	Wet	有喵病	挑嘴湯罐 鮪魚+雞	🔺 No, not really. Ate A Little	85.00	62.40	❌ No!!!	22.60	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.377737	2026-03-09 13:51:55.87671	f
1633	2025-05-21	09:45:00	-	Kibble	preyer	乾 preyer 無穀鮭魚佐全肉骨凍乾	❌ No, not interested	19.80	19.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.382008	2026-03-09 13:52:12.262284	f
1630	2025-05-21	09:45:00	18:23, 23:30, 7:03,	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	❌ No, not interested	60.00	33.10	🔺 So So	26.90	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.372663	2026-03-09 13:52:22.283536	f
1627	2025-05-21	01:10:00	16:41, 	Wet	法麗	微湯汁系列 天然嫩雞肉	🔺 No, not really. Ate A Little	80.00	50.70	🔺 So So	29.30	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.355222	2026-03-09 13:52:40.945321	f
1629	2025-05-21	01:10:00	16:40,	Kibble	preyer	無穀鮭魚佐全肉骨凍乾	❌ No, not interested	18.50	18.20	🔺 So So	0.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.360384	2026-03-09 13:52:50.278878	f
1628	2025-05-21	01:10:00	10:16, 15:42, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	20.40	12.60	🔺 So So	7.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.357318	2026-03-09 13:52:58.591574	f
1637	2025-05-22	08:45:00	16:59, 18:00, 00:21, 2:17, 6:38, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	❌ No, not interested	60.00	24.40	🔺 So So	35.60	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:05.393286	2026-03-09 13:53:28.59794	f
1636	2025-05-22	08:45:00	2:17, 6:38, 	Wet	ciao	鰹魚燒晚餐包 ic-244	❌ No, not interested	50.00	43.70	🔺 So So	6.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.391219	2026-03-09 13:53:37.821179	f
1638	2025-05-22	08:45:00	16:56, 17:58, 20:09, 00:19, 2:14, 6:37, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	53.90	23.50	🔺 So So	30.40	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:05.404748	2026-03-09 13:53:46.244412	f
1635	2025-05-22	01:00:00	12:11, 13:51, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	20.90	11.80	🔺 So So	9.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.38905	2026-03-09 13:54:00.433395	f
1634	2025-05-22	01:00:00	12:13, 13:52, 	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚x2	💖 Yes, eat right away	70.00	9.00	💕 Love it So Much	61.00	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.384404	2026-03-09 13:54:09.003834	f
1641	2025-05-23	00:40:00	-	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.411785	2026-03-09 13:55:02.933969	f
1639	2025-05-23	00:40:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	4.60	❌ No!!!	30.40	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:05.407565	2026-03-09 13:55:22.222802	f
1640	2025-05-23	00:40:00	-	Wet	wellness	ss名廚特選主食罐 鮮鮪魚泥 + 鮮鮭魚泥	❌ No, not interested	79.00	79.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.409787	2026-03-09 13:55:30.285441	f
1670	2025-05-27	01:25:00	10:01, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	28.80	19.80	🔺 So So	9.00	1	❌ - 🔺	15	加 好味小姐凍乾 2g	\N	2	\N	2026-03-04 11:51:05.474067	2026-03-09 14:01:43.062304	f
1663	2025-05-26	09:30:00	-	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.459953	2026-03-09 13:59:32.970104	f
1673	2025-05-27	10:40:00	19:02, 1:57, 5:01, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	26.50	🔺 So So	33.50	3	💖 - 🔺	29		\N	2	\N	2026-03-04 11:51:05.479323	2026-03-09 14:01:01.411771	f
1644	2025-05-23	09:30:00	1:59, 	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片 x2	💖 Yes, eat right away	60.00	31.60	🔺 So So	28.40	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.418313	2026-03-09 13:54:31.19146	f
1643	2025-05-23	09:30:00	2:01, 7:31, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	39.60	🔺 So So	45.40	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.416332	2026-03-09 13:54:39.204705	f
1645	2025-05-23	09:30:00	17:47, 19:14, 21:12, 23:33, 1:34, 1:57,  4:58, 7:29, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	55.10	15.50	💕 Love it So Much	39.60	8	❌ - 💕	39		\N	2	\N	2026-03-04 11:51:05.420715	2026-03-09 13:54:48.010287	f
1642	2025-05-23	00:40:00	12:34, 15:10, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.60	14.40	🔺 So So	11.20	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.413871	2026-03-09 13:54:55.467663	f
1653	2025-05-24	11:50:00	22:14, 3:25, 	Wet	ciao	ic-361 無穀餐包 鮪魚+雞肉+干貝 	💖 Yes, eat right away	40.00	5.30	💕 Love it So Much	34.70	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.438793	2026-03-09 13:55:50.632433	f
1648	2025-05-24	00:40:00	-	Wet	petline	三時貓用湯包25g csp-5 雞肉, 鰹魚乾 x2	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.426876	2026-03-09 13:56:00.028392	f
1652	2025-05-24	11:50:00	3:24, 	Wet	ciao	tcr-202 貓用濃湯餐包 鰹魚+鮪魚+柴魚片	❌ No, not interested	40.00	26.00	🔺 So So	14.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.437018	2026-03-09 13:56:07.944432	f
1654	2025-05-24	11:50:00	20:37, 22:12, 00:18, 3:22, 6:59, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	55.10	25.70	🔺 So So	29.40	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:05.441041	2026-03-09 13:56:15.472009	f
1650	2025-05-24	00:40:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	0.00	💕 Love it So Much	40.00	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:05.432915	2026-03-09 13:56:23.067435	f
1651	2025-05-24	00:40:00	9:40, 14:38, 18:02	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	26.30	15.10	🔺 So So	11.20	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.435136	2026-03-09 13:56:31.18632	f
1647	2025-05-24	02:50:00	14:40, 	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚	💖 Yes, eat right away	35.00	5.40	💕 Love it So Much	29.60	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:05.424769	2026-03-09 13:57:04.254819	f
1649	2025-05-24	07:30:00	-	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.430485	2026-03-09 13:57:19.233215	f
1658	2025-05-25	09:25:00	23:35, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) 	💖 Yes, eat right away	60.00	27.80	🔺 So So	32.20	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.449749	2026-03-09 13:57:56.981131	f
1660	2025-05-25	20:30:00	4:48, 8:19, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	14.20	4.70	🔺 So So	9.50	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.454256	2026-03-09 13:58:07.425494	f
1656	2025-05-25	01:00:00	10:16, 14:25, 15:09, 17:24	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.60	8.00	🔺 So So	13.60	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.445768	2026-03-09 13:58:17.284786	f
1655	2025-05-25	01:00:00	10:19, 15:12, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	16.40	💕 Love it So Much	63.60	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.443529	2026-03-09 13:58:27.312471	f
1659	2025-05-25	09:25:00	18:20, 20:08, 21:30, 23:33, 1:00, 4:20, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	38.20	6.40	💕 Love it So Much	31.80	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:05.452268	2026-03-09 13:58:41.498681	f
1664	2025-05-26	09:30:00	17:40, 19:09, 00:29, 3:04, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	❌ No, not interested	60.00	11.00	💕 Love it So Much	49.00	4	❌ - 💕	38		\N	2	\N	2026-03-04 11:51:05.461752	2026-03-09 13:59:17.738943	f
1665	2025-05-26	09:30:00	4:05, 6:40, 	Wet	ciao	多樂米濃湯罐 a-45 (雞肉+鰹魚+吻仔魚)	🔺 No, not really. Ate A Little	80.00	42.40	🔺 So So	37.60	2	🔺 - 🔺	22		\N	2	\N	2026-03-04 11:51:05.463614	2026-03-09 13:59:25.013718	f
1667	2025-05-26	09:30:00	19:08, 21:45, 22:45, 00:27, 6:37,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	24.90	4.40	🔺 So So	20.50	5	❌ - 🔺	30		\N	2	\N	2026-03-04 11:51:05.467482	2026-03-09 13:59:40.810638	f
1666	2025-05-26	09:30:00	3:02, 6:37, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	42.30	30.70	🔺 So So	11.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.465633	2026-03-09 13:59:51.132599	f
1668	2025-05-26	13:30:00	-	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	21.50	21.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.470291	2026-03-09 13:59:59.074335	f
1662	2025-05-26	00:53:00	9:48, 12:54, 14:48, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	28.40	16.60	🔺 So So	11.80	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.458052	2026-03-09 14:00:06.574859	f
1661	2025-05-26	00:53:00	9:50, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	🔺 No, not really. Ate A Little	80.00	50.20	🔺 So So	29.80	1	🔺 - 🔺	20	4:23 吃完馬上吐	\N	2	\N	2026-03-04 11:51:05.456083	2026-03-09 14:00:13.721954	f
1674	2025-05-27	10:40:00	-	Wet	wellness	core+ 化毛配方 鮮雞肉泥	❌ No, not interested	79.00	79.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.480935	2026-03-09 14:00:53.732975	f
1676	2025-05-27	10:40:00	18:58, 5:35, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	42.30	22.60	🔺 So So	19.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.491326	2026-03-09 14:01:10.173841	f
1677	2025-05-27	10:40:00	20:55, 1:53, 3:31, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	41.30	23.20	🔺 So So	18.10	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.493097	2026-03-09 14:01:18.077787	f
1675	2025-05-27	11:46:00	1:55, 3:32, 5:02, 	Wet	tuna	愛貓天然食 雞肉+鮪魚	💖 Yes, eat right away	70.00	23.50	💕 Love it So Much	46.50	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:05.489479	2026-03-09 14:01:26.504567	f
1669	2025-05-27	01:25:00	10:02, 16:44, 	Wet	ciao	ic-216 貓用巧餐包 鮪魚+鰹魚乾+雞肉	💖 Yes, eat right away	40.00	12.30	🔺 So So	27.70	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.472062	2026-03-09 14:01:35.463656	f
1671	2025-05-27	05:40:00	-	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.40	22.00	❌ No!!!	3.40	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.475881	2026-03-09 14:02:24.533498	f
1672	2025-05-27	06:20:00	16:45, 	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚	❌ No, not interested	35.00	19.80	🔺 So So	15.20	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.477645	2026-03-09 14:02:36.759463	f
1680	2025-05-28	09:30:00	20:36, 1:48, 6:15, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	20.40	💕 Love it So Much	54.60	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:05.49919	2026-03-09 14:03:00.001828	f
1681	2025-05-28	09:30:00	-	Wet	汪喵星球	無膠慢燉純湯罐 鮮甜鰹魚湯	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.500884	2026-03-09 14:03:07.737098	f
1682	2025-05-28	09:30:00	19:47, 20:35, 00:28, 1:46, 6:14, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	46.20	12.70	🔺 So So	33.50	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:05.502571	2026-03-09 14:03:15.942013	f
1679	2025-05-28	00:25:00	9:24, 14:37, 17:04, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	26.00	14.90	🔺 So So	11.10	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.497474	2026-03-09 14:03:23.812068	f
1678	2025-05-28	00:25:00	9:25, 14:38, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	31.20	🔺 So So	48.80	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.494726	2026-03-09 14:03:31.756375	f
1687	2025-05-29	09:00:00	00:06, 3:15, 6:22, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	❌ No, not interested	75.00	36.00	🔺 So So	39.00	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.512035	2026-03-09 14:04:40.636311	f
1688	2025-05-29	09:00:00	00:03, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	36.70	29.30	🔺 So So	7.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.513632	2026-03-09 14:04:48.69876	f
1686	2025-05-29	09:00:00	17:51, 22:10, 00:06, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	39.30	🔺 So So	45.70	3	💖 - 🔺	29		\N	2	\N	2026-03-04 11:51:05.510333	2026-03-09 14:04:57.209062	f
1684	2025-05-29	00:19:00	11:36, 14:02, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	26.80	16.10	🔺 So So	10.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.507009	2026-03-09 14:05:06.163898	f
1683	2025-05-29	00:19:00	11:38, 14:03, 	Wet	ciao	ic-536 貓用雞三味凍餐包 扇貝貝柱	💖 Yes, eat right away	60.00	25.10	🔺 So So	34.90	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.50433	2026-03-09 14:05:14.588695	f
1685	2025-05-29	07:30:00	-	Kibble	璞斯	體態管理全齡貓 鴨肉	💖 Yes, eat right away	20.30	13.90	❌ No!!!	6.40	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.508636	2026-03-09 14:05:22.802895	f
1692	2025-05-30	11:00:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	❌ No, not interested	75.00	75.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.520572	2026-03-09 14:05:50.184117	f
1695	2025-05-30	11:00:00	19:27, 6:43, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	40.70	18.20	🔺 So So	22.50	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.526421	2026-03-09 14:06:00.061529	f
1693	2025-05-30	11:00:00	19:28, 6:45, 	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮 x2	💖 Yes, eat right away	70.00	18.00	💕 Love it So Much	52.00	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.522277	2026-03-09 14:06:06.963706	f
1694	2025-05-30	12:30:00	-	Wet	ciao	旨定貓罐 白身鮪魚1000億乳酸菌 a-135	🔺 No, not really. Ate A Little	85.00	72.50	❌ No!!!	12.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.524632	2026-03-09 14:06:15.666789	f
1696	2025-05-30	12:50:00	20:50, 4:22, 9:28,	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.30	10.60	🔺 So So	14.70	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.528122	2026-03-09 14:06:24.519263	f
1691	2025-05-30	00:24:00	9:08, 9:48, 13:39, 17:40, 19:01, 23:32, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	28.60	14.50	🔺 So So	14.10	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:05.519025	2026-03-09 14:06:32.39776	f
1690	2025-05-30	00:24:00	9:49, 13:40, 18:19, 	Wet	ciao	近海鰹魚罐93號 (干貝味) 	💖 Yes, eat right away	80.00	37.60	🔺 So So	42.40	3	💖 - 🔺	29		\N	2	\N	2026-03-04 11:51:05.517446	2026-03-09 14:06:47.226843	f
1700	2025-05-31	09:14:00	19:45, 23:19, 1:04, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	24.00	💕 Love it So Much	56.00	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:05.535542	2026-03-09 14:07:10.783603	f
1701	2025-05-31	12:40:00	23:20, 2:36, 	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	💖 Yes, eat right away	60.00	29.70	🔺 So So	30.30	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.537201	2026-03-09 14:07:20.466256	f
1702	2025-05-31	12:40:00	21:39, 23:17, 1:02, 2:35, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	34.00	11.50	🔺 So So	22.50	4	❌ - 🔺	21	加 好味小姐凍乾 2g	\N	2	\N	2026-03-04 11:51:05.538967	2026-03-09 14:07:27.965725	f
1697	2025-05-31	01:55:00	15:31, 	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚 x2	💖 Yes, eat right away	70.00	22.40	💕 Love it So Much	47.60	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:05.529748	2026-03-09 14:07:36.559577	f
1699	2025-05-31	01:55:00	13:27, 16:33, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	30.80	26.10	🔺 So So	4.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.533682	2026-03-09 14:07:44.971296	f
1698	2025-05-31	01:55:00	15:29, 19:43, 22:05, 6:24, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	30.50	14.60	🔺 So So	15.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.531336	2026-03-09 14:07:53.055542	f
1708	2025-06-01	09:00:00	17:00, 19:37, 21:03, 7:44, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	33.20	15.30	🔺 So So	17.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.5521	2026-03-10 02:25:18.478623	f
1707	2025-06-01	09:00:00	19:39, 23:51,	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	20.50	💕 Love it So Much	49.50	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.55035	2026-03-10 02:25:26.565042	f
1709	2025-06-01	09:00:00	17:52, 23:49, 2:10, 4:50	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	33.40	9.00	🔺 So So	24.40	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.553824	2026-03-10 02:25:35.340347	f
1710	2025-06-01	09:00:00	 2:12, 	Wet	t.n.a 悠遊	厚肉肉 有料湯肉貓罐 - ｑ雞腿	🔺 No, not really. Ate A Little	80.00	73.40	🔺 So So	6.60	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.589468	2026-03-10 02:25:45.002176	f
1703	2025-06-01	00:39:00	9:34, 	Wet	tuna	愛貓天然食 雞肉+鮪魚	🔺 No, not really. Ate A Little	70.00	48.20	🔺 So So	21.80	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.541461	2026-03-10 02:25:52.994451	f
1705	2025-06-01	00:39:00	9:34, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	15.30	14.70	🔺 So So	0.60	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.545385	2026-03-10 02:26:00.890162	f
1704	2025-06-01	00:39:00	9:32, 15:02, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	19.20	12.10	🔺 So So	7.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.543469	2026-03-10 02:26:10.905837	f
1706	2025-06-01	08:35:00	-	Wet	kattovit 康特維	胃腸保健 營養肉汁	🔺 No, not really. Ate A Little	135.00	104.20	❌ No!!!	30.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.548246	2026-03-10 02:26:28.09096	f
1712	2025-06-02	00:50:00	9:41, 11:22, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	24.70	💕 Love it So Much	50.30	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.595329	2026-03-10 02:28:15.372922	f
1713	2025-06-02	00:50:00	9:40, 14:14,	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	22.40	14.60	🔺 So So	7.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.598256	2026-03-10 02:28:23.185454	f
1718	2025-06-02	08:30:00	17:30, 19:31, 20:36, 23:07, 00:08, 2:33, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	35.20	11.40	🔺 So So	23.80	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:05.610716	2026-03-10 02:27:21.107572	f
1719	2025-06-02	08:30:00	18:59, 6:11, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	34.50	25.30	🔺 So So	9.20	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.613337	2026-03-10 02:27:30.36751	f
1716	2025-06-02	08:30:00	17:38, 	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	70.00	34.00	🔺 So So	36.00	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.605855	2026-03-10 02:27:38.873109	f
1717	2025-06-02	11:05:00	00:10, 2:35, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	40.40	🔺 So So	44.60	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.607971	2026-03-10 02:27:46.465302	f
1714	2025-06-02	00:50:00	11:21	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.50	19.60	🔺 So So	0.90	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.600982	2026-03-10 02:28:43.336885	f
1725	2025-06-03	10:20:00	3:26, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉) x2	🔺 No, not really. Ate A Little	70.00	42.90	🔺 So So	27.10	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.627027	2026-03-10 02:29:32.276503	f
1727	2025-06-03	10:20:00	20:04, 23:37, 3:23, 7:19, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	35.40	15.20	🔺 So So	20.20	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.631612	2026-03-10 02:29:40.775218	f
1728	2025-06-03	10:20:00	7:20, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	29.10	27.80	🔺 So So	1.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.634943	2026-03-10 02:29:53.524571	f
1726	2025-06-03	10:20:00	23:38, 3:25, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	19.80	💕 Love it So Much	50.20	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.62937	2026-03-10 02:30:01.281306	f
1724	2025-06-03	00:30:00	12:07, 17:26, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	14.90	7.20	🔺 So So	7.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.624926	2026-03-10 02:30:08.748762	f
1723	2025-06-03	00:30:00	11:28, 14:15, 17:27, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	26.10	13.80	🔺 So So	12.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.622124	2026-03-10 02:30:16.848316	f
1720	2025-06-03	00:30:00	-	Wet	惜時	mico 咪渴機能湯罐 鮪魚+雞肉 	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.615764	2026-03-10 02:30:25.189546	f
1733	2025-06-04	11:00:00	8:27, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	🔺 No, not really. Ate A Little	80.00	44.10	🔺 So So	35.90	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.646114	2026-03-10 02:36:40.760044	f
1735	2025-06-04	11:00:00	22:08, 23:42, 3:18, 7:26, 8:27, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	23.40	5.50	🔺 So So	17.90	5	❌ - 🔺	30		\N	2	\N	2026-03-04 11:51:05.650209	2026-03-10 02:34:28.6157	f
1732	2025-06-04	08:15:00	17:06, 3:19,	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮 x2	💖 Yes, eat right away	70.00	20.50	💕 Love it So Much	49.50	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.644084	2026-03-10 02:34:38.31827	f
1734	2025-06-04	11:00:00	20:13, 21:20, 23:41, 3:17, 8:26, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	38.80	15.90	🔺 So So	22.90	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:05.648185	2026-03-10 02:39:17.037582	f
1731	2025-06-04	00:35:00	9:22, 11:18, 14:53, 17:05, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	27.30	12.60	🔺 So So	14.70	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.641999	2026-03-10 02:39:30.119856	f
1729	2025-06-04	00:35:00	14:54, 	Wet	sheba	鮪魚, 雞肉及鰹魚片口味 餐包	💖 Yes, eat right away	70.00	39.80	🔺 So So	30.20	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.63769	2026-03-10 02:39:44.019872	f
1730	2025-06-04	04:11:00	14:53, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝	💖 Yes, eat right away	30.00	12.70	🔺 So So	17.30	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.640015	2026-03-10 02:40:16.056592	f
1741	2025-06-05	08:10:00	17:35, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	19.30	💕 Love it So Much	45.70	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:05.662866	2026-03-10 02:42:43.487333	f
1738	2025-06-05	00:35:00	13:54, 15:18, 18:05, 19:07, 21:49, 3:47, 6:53, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	26.70	9.80	💕 Love it So Much	16.90	7	❌ - 💕	37		\N	2	\N	2026-03-04 11:51:05.65666	2026-03-10 02:42:52.129773	f
1737	2025-06-05	00:35:00	12:33, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.90	22.60	🔺 So So	3.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.654628	2026-03-10 02:43:00.26887	f
1736	2025-06-05	00:35:00	10:03, 15:20, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	21.00	🔺 So So	39.00	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:05.652615	2026-03-10 02:43:10.603359	f
1740	2025-06-05	02:20:00	-	Wet	凱特美廚	貓咪易開胃主食餐包 喵咪歌喉讚 鴨肉+鮪魚	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.660832	2026-03-10 02:43:22.208435	f
1739	2025-06-05	02:20:00	13:54, 	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚	💖 Yes, eat right away	35.00	8.40	💕 Love it So Much	26.60	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:05.658775	2026-03-10 02:43:29.772361	f
1743	2025-06-05	09:35:00	18:04, 00:20, 3:48, 6:52, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	47.20	23.70	🔺 So So	23.50	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.668317	2026-03-10 02:44:24.598955	f
1742	2025-06-05	09:35:00	3:49, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	🔺 No, not really. Ate A Little	75.00	58.10	🔺 So So	16.90	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.666088	2026-03-10 02:44:33.048899	f
1748	2025-06-06	09:20:00	-	Wet	奇境	野生鮪魚燉雞湯	🔺 No, not really. Ate A Little	55.00	32.20	❌ No!!!	22.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.697316	2026-03-10 03:18:27.687997	f
1746	2025-06-06	00:30:00	17:20, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.00	20.00	🔺 So So	1.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.692428	2026-03-10 03:18:52.09605	f
1747	2025-06-06	00:30:00	-	Kibble	柏萊富	棒吉 本能覺醒 五種肉 幼貓	❌ No, not interested	15.40	15.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.694876	2026-03-10 03:19:02.113052	f
1745	2025-06-06	00:30:00	13:45, 15:39, 17:19, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	14.90	7.60	🔺 So So	7.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.689514	2026-03-10 03:19:12.985399	f
1744	2025-06-06	00:30:00	13:47, 15:40, 17:20, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	22.00	🔺 So So	28.00	3	💖 - 🔺	29		5.90	2	\N	2026-03-04 11:51:05.67053	2026-03-10 03:19:21.079993	f
1749	2025-06-06	12:00:00	-	Wet	ciao	ic-536 貓用雞三味凍餐包 扇貝貝柱	🔺 No, not really. Ate A Little	60.00	38.40	❌ No!!!	21.60	0	🔺 - ❌	13	23:36 倒掉	\N	2	\N	2026-03-04 11:51:05.699653	2026-03-10 03:20:35.522803	f
1762	2025-06-07	12:20:00	4:09, 	Wet	ciao	四連串包 tcr-145 乳酸菌 2000億個 雞肉& 鮭魚 x2	💖 Yes, eat right away	70.00	29.40	💕 Love it So Much	40.60	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:05.727612	2026-03-10 03:23:16.412945	f
1774	2025-06-09	00:40:00	9:50, 12:59, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	9.50	💕 Love it So Much	60.50	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.750194	2026-03-10 03:53:00.754171	f
1772	2025-06-08	08:40:00	18:05, 19:16, 1:15, 8:23,	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	40.50	10.60	🔺 So So	29.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.746036	2026-03-10 03:50:07.336495	f
1750	2025-06-06	09:20:00	18:35, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	24.90	22.20	🔺 So So	2.70	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.702267	2026-03-10 03:18:37.438008	f
1755	2025-06-06	15:00:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮 x2	🔺 No, not really. Ate A Little	70.00	55.50	❌ No!!!	14.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.713643	2026-03-10 03:19:43.340369	f
1754	2025-06-06	15:00:00	-	Wet	ciao	布丁杯 鮪魚 imc-151	🔺 No, not really. Ate A Little	65.00	36.30	❌ No!!!	28.70	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.711304	2026-03-10 03:19:50.706609	f
1751	2025-06-06	14:51:00	6:45, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	56.10	49.80	🔺 So So	6.30	1	❌ - 🔺	15	22:51 換新飼料	\N	2	\N	2026-03-04 11:51:05.704505	2026-03-10 03:19:59.124553	f
1753	2025-06-06	14:30:00	-	Wet	soupurr 喵湯寶貓餐包	鮮味雞湯佐蝦肉	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.70906	2026-03-10 03:20:24.559295	f
1759	2025-06-07	00:40:00	13:30, 19:22, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	24.80	16.10	🔺 So So	8.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.72172	2026-03-10 03:22:09.570029	f
1757	2025-06-07	00:40:00	-	Wet	rico 瑞可	味覺系貓用主食罐 鮪魚雞肉	❌ No, not interested	82.00	82.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.717749	2026-03-10 03:22:22.687717	f
1756	2025-06-07	00:40:00	-	Wet	ciao	ic-554 高湯鮮味餐包 鰹魚高湯+雞肉+吻仔魚	❌ No, not interested	30.00	30.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.715823	2026-03-10 03:22:31.413252	f
1760	2025-06-07	00:40:00	15:26, 19:21, 	Kibble	吶一口	田園貓雙響宴	❌ No, not interested	11.00	5.70	🔺 So So	5.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.723544	2026-03-10 03:22:49.245838	f
1763	2025-06-07	12:20:00	20:35, 00:34, 4:08, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	35.70	16.20	🔺 So So	19.50	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.729357	2026-03-10 03:22:57.954931	f
1765	2025-06-07	12:20:00	-	Kibble	奇境	澳洲尖吻鱸&鮪魚	❌ No, not interested	29.00	29.00	❌ No!!!	0.00	0	❌ - ❌	8	待確認, 是否喜歡	\N	2	\N	2026-03-04 11:51:05.732927	2026-03-10 03:23:07.003093	f
1764	2025-06-07	12:20:00	3:54, 	Kibble	吶一口	田園貓雙響宴	❌ No, not interested	19.70	17.50	🔺 So So	2.20	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.731148	2026-03-10 03:23:25.648576	f
1758	2025-06-07	00:40:00	19:22, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	41.70	🔺 So So	43.30	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.719669	2026-03-10 03:23:38.787082	f
1771	2025-06-08	08:40:00	19:17, 1:17, 	Wet	kattovit 康特維	腎臟保健 營養肉汁 雞肉&鴨肉 湯罐	❌ No, not interested	43.60	6.50	💕 Love it So Much	37.10	2	❌ - 💕	34		\N	2	\N	2026-03-04 11:51:05.744132	2026-03-10 03:49:44.540786	f
1773	2025-06-08	08:40:00	6:03, 	Kibble	奇境	澳洲牛肉	❌ No, not interested	20.50	15.50	🔺 So So	5.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.748348	2026-03-10 03:49:58.789434	f
1770	2025-06-08	08:40:00	-	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	🔺 No, not really. Ate A Little	80.00	49.00	❌ No!!!	31.00	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.742311	2026-03-10 03:50:16.583904	f
1766	2025-06-08	00:40:00	-	Wet	hello fresh	好鮮原汁湯罐 清蒸雞肉	💖 Yes, eat right away	50.00	24.80	❌ No!!!	25.20	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.734723	2026-03-10 03:50:53.883189	f
1769	2025-06-08	03:36:00	-	Kibble	鮮時	薛先生 乾糧 雞肉+鯡魚+鮭魚	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.740518	2026-03-10 03:51:48.236287	f
1768	2025-06-08	03:36:00	16:35, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.00	15.20	🔺 So So	5.80	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.738779	2026-03-10 03:52:00.429466	f
1767	2025-06-08	00:40:00	-	Kibble	奇境	澳洲尖吻鱸&鮪魚	❌ No, not interested	23.10	23.10	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.73684	2026-03-10 03:52:14.502802	f
1775	2025-06-09	00:40:00	14:45, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.60	17.70	🔺 So So	3.90	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.75206	2026-03-10 03:53:08.803603	f
1782	2025-06-09	09:50:00	-	Kibble	特百滋	凍乾雙響宴 成幼貓 低敏海魚+雞肉	❌ No, not interested	20.30	20.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.841323	2026-03-10 03:53:17.037347	f
1783	2025-06-09	09:50:00	-	Kibble	杜莎	ec2 化毛配方 鮮雞佐鴨	❌ No, not interested	15.90	15.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.846637	2026-03-10 03:53:25.387261	f
1781	2025-06-09	09:50:00	-	Kibble	安娜美廚	29號 腸胃保健配方 阿拉斯加鱈魚	❌ No, not interested	28.40	28.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.836812	2026-03-10 03:54:21.706499	f
1784	2025-06-09	09:50:00	1:34, 	Kibble	吶一口	原野收穫 新鮮雞肉&火雞肉&生鮮鮭魚	❌ No, not interested	20.30	11.30	🔺 So So	9.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.851199	2026-03-10 03:54:29.934245	f
1780	2025-06-09	09:50:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	30.90	30.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.828593	2026-03-10 03:54:37.434233	f
1779	2025-06-09	09:50:00	20:10, 1:37, 3:56, 	Wet	ciao	原湯杯54號 (雞肉+蟹肉+吻仔魚)	💖 Yes, eat right away	60.00	20.00	💕 Love it So Much	40.00	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:05.81935	2026-03-10 03:54:45.036615	f
1778	2025-06-09	07:50:00	-	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	31.60	❌ No!!!	18.40	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.809781	2026-03-10 03:54:52.708698	f
1776	2025-06-09	01:50:00	-	Wet	kattovit 康特維	腎臟保健 營養肉汁 雞肉&鴨肉 湯罐	❌ No, not interested	42.00	42.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.793111	2026-03-10 03:57:49.676016	f
1785	2025-06-09	07:50:00	17:10, 20:10, 3:52, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	44.10	23.90	🔺 So So	20.20	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.855158	2026-03-10 04:05:13.984256	f
1777	2025-06-09	07:50:00	21:30, 	Kibble	貓樂園	無穀天然高蛋白無敵貓糧 鮮雞蜂王乳	🔺 No, not really. Ate A Little	21.50	17.10	🔺 So So	4.40	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.800281	2026-03-10 04:06:41.640744	f
1786	2025-06-10	00:27:00	16:24, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	🔺 No, not really. Ate A Little	60.00	32.10	🔺 So So	27.90	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.86096	2026-03-10 04:09:08.250351	f
1791	2025-06-10	09:50:00	20:39, 00:40, 3:08, 5:07, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	34.20	16.60	🔺 So So	17.60	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.897438	2026-03-10 04:07:54.221774	f
1792	2025-06-10	09:50:00	23:05,	Kibble	吶一口	原野收穫 新鮮雞肉&火雞肉&生鮮鮭魚	❌ No, not interested	38.50	25.40	🔺 So So	13.10	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.907764	2026-03-10 04:08:13.654825	f
1790	2025-06-10	09:50:00	3:09, 	Wet	kattovit 康特維	腎臟保健 營養肉汁 雞肉&鴨肉 湯罐	❌ No, not interested	55.30	9.70	💕 Love it So Much	45.60	1	❌ - 💕	32		\N	2	\N	2026-03-04 11:51:05.892895	2026-03-10 04:08:23.120956	f
1789	2025-06-10	09:50:00	-	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	🔺 No, not really. Ate A Little	75.00	49.20	❌ No!!!	25.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:05.890329	2026-03-10 04:08:31.529055	f
1787	2025-06-10	00:27:00	16:23, 	Kibble	吶一口	原野收穫 新鮮雞肉&火雞肉&生鮮鮭魚	❌ No, not interested	26.70	22.20	🔺 So So	4.50	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:05.868251	2026-03-10 04:08:47.95433	f
1788	2025-06-10	00:27:00	12:09, 13:49, 15:23, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	21.10	8.60	🔺 So So	12.50	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.877809	2026-03-10 04:08:57.799496	f
1797	2025-06-11	09:40:00	22:06, 23:19, 00:25, 2:45, 4:36, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	48.60	18.90	💕 Love it So Much	29.70	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:05.924376	2026-03-10 04:09:31.874658	f
1796	2025-06-11	09:40:00	22:08,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	22.80	💕 Love it So Much	47.20	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:05.921467	2026-03-10 04:09:43.117158	f
1795	2025-06-11	00:32:00	14:50, 15:29, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.10	18.00	🔺 So So	7.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.919293	2026-03-10 04:09:55.022583	f
1794	2025-06-11	00:32:00	10:45, 15:31, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	70.00	15.10	💕 Love it So Much	54.90	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.913242	2026-03-10 04:10:12.53306	f
1799	2025-06-12	00:30:00	10:14, 11:21, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	20.60	13.10	🔺 So So	7.50	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.934819	2026-03-10 04:10:31.085203	f
1802	2025-06-12	09:30:00	21:00, 21:38, 3:15, 4:47, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	43.80	22.50	🔺 So So	21.30	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.94165	2026-03-10 04:10:39.334598	f
1801	2025-06-12	09:30:00	21:41, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	5.50	💕 Love it So Much	59.50	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:05.938833	2026-03-10 04:10:48.42554	f
1798	2025-06-12	00:30:00	10:16, 	Wet	axia	新金罐濃厚5號- 鮪, 柴	💖 Yes, eat right away	70.00	34.80	🔺 So So	35.20	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:05.929374	2026-03-10 04:10:58.220197	f
1800	2025-06-12	07:20:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮 	💖 Yes, eat right away	35.00	5.40	❌ No!!!	29.60	0	💖 - ❌	25	幾乎吃光	\N	2	\N	2026-03-04 11:51:05.936925	2026-03-10 04:11:05.708644	f
1806	2025-06-13	09:50:00	20:39, 22:13, 23:13, 3:26, 7:34, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	46.30	23.50	💕 Love it So Much	22.80	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:05.957164	2026-03-10 04:11:35.19865	f
1807	2025-06-13	09:50:00	19:34, 00:34, 3:25, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	31.80	18.00	🔺 So So	13.80	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.96766	2026-03-10 04:12:46.547972	f
1804	2025-06-13	00:30:00	9:56, 11:14, 15:18, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	22.10	16.30	🔺 So So	5.80	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.950449	2026-03-10 04:12:55.88179	f
1803	2025-06-13	00:30:00	10:09, 15:19, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	14.40	💕 Love it So Much	45.60	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.945303	2026-03-10 04:13:03.821952	f
1809	2025-06-14	23:47:00	13:44, 15:51, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.40	12.60	🔺 So So	8.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:05.97334	2026-03-10 04:16:41.607595	f
1811	2025-06-14	11:10:00	00:40, 3:40, 	Wet	ciao	原湯杯53號 (雞肉+蟹肉棒+柴魚片)	💖 Yes, eat right away	60.00	15.90	💕 Love it So Much	44.10	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.982371	2026-03-10 04:16:29.069077	f
1812	2025-06-14	11:10:00	20:40, 21:59, 00:39, 3:38, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	44.80	20.70	🔺 So So	24.10	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:05.985427	2026-03-10 04:16:22.38723	f
1808	2025-06-14	23:47:00	-	Wet	ciao	ic-204 日本餐包 鰹魚+雞肉+木魚片 鰹魚湯底	💖 Yes, eat right away	40.00	11.00	❌ No!!!	29.00	0	💖 - ❌	18	凌晨5:14 突然被咬	\N	2	\N	2026-03-04 11:51:05.970252	2026-03-10 04:16:53.513426	f
1810	2025-06-14	05:55:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮	💖 Yes, eat right away	35.00	3.60	❌ No!!!	31.40	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:05.977415	2026-03-10 04:17:02.708817	f
1817	2025-06-15	09:00:00	19:43, 22:29, 23:39, 4:39, 8:19, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	40.40	12.30	🔺 So So	28.10	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:06.006113	2026-03-10 04:17:26.536072	f
1815	2025-06-15	09:00:00	-	Wet	奇境	牧場純雞燉雞湯	🔺 No, not really. Ate A Little	55.00	34.40	❌ No!!!	20.60	0	🔺 - ❌	13	21:45 倒掉	\N	2	\N	2026-03-04 11:51:05.997045	2026-03-10 04:17:37.956516	f
1813	2025-06-15	00:03:00	-	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚 x2	💖 Yes, eat right away	70.00	28.30	❌ No!!!	41.70	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:05.987505	2026-03-10 04:17:47.393291	f
1816	2025-06-15	13:46:00	23:42, 4:42, 	Wet	ciao	布丁杯 鮪魚 imc-151	💖 Yes, eat right away	65.00	11.00	💕 Love it So Much	54.00	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.001106	2026-03-10 04:17:59.174798	f
1814	2025-06-15	00:03:00	10:43, 12:30, 16:08, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.60	8.60	🔺 So So	13.00	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:05.993487	2026-03-10 04:18:06.62789	f
1822	2025-06-16	10:05:00	-	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	🔺 No, not really. Ate A Little	75.00	37.00	❌ No!!!	38.00	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.023274	2026-03-10 04:18:51.885068	f
1820	2025-06-16	00:50:00	-	Kibble	諾樂 nulo	金牌無穀 成貓配方 鮭魚+扁豆	❌ No, not interested	22.20	22.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.018323	2026-03-10 04:19:01.892662	f
1818	2025-06-16	00:50:00	-	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	🔺 No, not really. Ate A Little	70.00	44.50	❌ No!!!	25.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.009308	2026-03-10 04:19:11.147923	f
1819	2025-06-16	00:50:00	10:40, 11:30, 15:51, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	23.30	14.50	🔺 So So	8.80	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.013689	2026-03-10 04:19:19.421244	f
1821	2025-06-16	07:55:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	4.10	❌ No!!!	30.90	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.020373	2026-03-10 04:20:00.809755	f
1830	2025-06-17	08:40:00	1:18, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉)	💖 Yes, eat right away	35.00	10.50	💕 Love it So Much	24.50	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.049327	2026-03-10 04:20:43.87291	f
1837	2025-06-18	07:30:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	8.20	❌ No!!!	26.80	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.067222	2026-03-10 04:23:33.564648	f
1843	2025-06-19	00:19:00	9:00, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.50	18.60	🔺 So So	2.90	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.081303	2026-03-10 04:24:23.661679	f
1829	2025-06-17	03:00:00	15:51, 	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮	💖 Yes, eat right away	35.00	6.20	💕 Love it So Much	28.80	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.045354	2026-03-10 04:21:36.242629	f
1833	2025-06-17	08:40:00	17:33, 23:58, 1:15, 2:16, 	Kibble	喵探長	派大雞無穀凍乾糧	❌ No, not interested	33.60	25.40	🔺 So So	8.20	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.059327	2026-03-10 04:20:34.800317	f
1836	2025-06-18	02:30:00	-	Kibble	喵探長	派大雞無穀凍乾糧	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.065087	2026-03-10 04:23:22.330254	f
1852	2025-06-20	01:00:00	-	Kibble	瑪恩吉	無穀優護處方 泌尿道及磷酸銨鎂 處方貓糧	❌ No, not interested	20.60	20.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.110319	2026-03-10 04:27:36.515838	f
1842	2025-06-19	00:19:00	9:01, 	Wet	ciao	魚三味貓餐包 ic-415 鮪魚+雞肉+吻仔魚	🔺 No, not really. Ate A Little	60.00	44.00	🔺 So So	16.00	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.07919	2026-03-10 04:24:32.238692	f
1838	2025-06-18	11:05:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	8.20	❌ No!!!	26.80	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.069025	2026-03-10 04:22:35.916852	f
1824	2025-06-16	10:05:00	18:33, 3:28, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	46.90	24.20	🔺 So So	22.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.029667	2026-03-10 04:18:34.193853	f
1825	2025-06-16	10:05:00	-	Kibble	曙光	天然無穀鮪魚雞肉餐	❌ No, not interested	15.50	15.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.033149	2026-03-10 04:18:42.035641	f
1823	2025-06-16	13:08:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	9.00	❌ No!!!	26.00	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.027318	2026-03-10 04:19:35.116802	f
1832	2025-06-17	08:40:00	17:33, 18:44, 21:30, 22:18, 1:17, 2:17, 4:24, 6:42, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	40.10	18.10	💕 Love it So Much	22.00	8	❌ - 💕	39		\N	2	\N	2026-03-04 11:51:06.054635	2026-03-10 04:20:23.404699	f
1826	2025-06-17	00:20:00	9:20, 	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	🔺 No, not really. Ate A Little	60.00	41.60	🔺 So So	18.40	1	🔺 - 🔺	20	8:30 吃到一半就吐, 可能餓太久/9:02 吃完又吐	\N	2	\N	2026-03-04 11:51:06.036531	2026-03-10 04:20:54.525404	f
1827	2025-06-17	00:20:00	8:51, 9:20, 15:50, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	31.50	19.20	🔺 So So	12.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.038506	2026-03-10 04:21:14.904669	f
1831	2025-06-17	13:30:00	1:19, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	31.50	💕 Love it So Much	48.50	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.051322	2026-03-10 04:21:55.603583	f
1841	2025-06-18	11:05:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.077073	2026-03-10 04:22:20.469742	f
1840	2025-06-18	11:05:00	21:11, 00:47, 3:20, 4:49, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	44.20	23.10	🔺 So So	21.10	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.074756	2026-03-10 04:22:28.78167	f
1839	2025-06-18	13:15:00	00:50, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	🔺 No, not really. Ate A Little	70.00	31.80	🔺 So So	38.20	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.070815	2026-03-10 04:22:43.968414	f
1834	2025-06-18	00:45:00	-	Wet	astkatta	冰島經典低磷餐包 鮮燉雞肉泥	💖 Yes, eat right away	50.00	24.30	❌ No!!!	25.70	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.061328	2026-03-10 04:22:53.134391	f
1835	2025-06-18	00:45:00	9:16, 12:46, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	23.00	15.60	🔺 So So	7.40	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.063187	2026-03-10 04:23:09.128109	f
1846	2025-06-19	11:05:00	4:33, 	Wet	ciao	原湯杯54號 (雞肉+蟹肉+吻仔魚)	💖 Yes, eat right away	60.00	8.40	💕 Love it So Much	51.60	1	💖 - 💕	42	00:22 一直叫, 放在面前又狂吃, 可能沒很愛？	\N	2	\N	2026-03-04 11:51:06.088861	2026-03-10 04:23:54.97696	f
1849	2025-06-19	11:05:00	-	Kibble	吶一口	原野收穫 新鮮雞肉&火雞肉&生鮮鮭魚	❌ No, not interested	33.00	33.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.098385	2026-03-10 04:24:03.667927	f
1848	2025-06-19	11:05:00	19:02, 20:37, 21:42, 22:30, 4:32, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	39.90	20.00	🔺 So So	19.90	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:06.095097	2026-03-10 04:24:13.483543	f
1847	2025-06-19	15:58:00	4:35, 	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	0.00	💕 Love it So Much	40.00	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.092622	2026-03-10 04:24:43.550608	f
1844	2025-06-19	00:19:00	15:17, 	Kibble	吶一口	原野收穫 新鮮雞肉&火雞肉&生鮮鮭魚	❌ No, not interested	20.00	16.70	🔺 So So	3.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.085017	2026-03-10 04:25:01.728249	f
1845	2025-06-19	07:30:00	-	Wet	ciao	布丁杯 雞肉 imc-153	🔺 No, not really. Ate A Little	65.00	53.50	❌ No!!!	11.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.086996	2026-03-10 04:25:21.770403	f
1856	2025-06-20	11:00:00	-	Wet	喵樂	肉食控鮮肉湯罐 嫩雞鮭魚	🔺 No, not really. Ate A Little	80.00	52.80	❌ No!!!	27.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.121479	2026-03-10 04:26:07.077203	f
1855	2025-06-20	15:50:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.119611	2026-03-10 04:26:36.694169	f
1854	2025-06-20	01:00:00	-	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚	💖 Yes, eat right away	35.00	8.90	❌ No!!!	26.10	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.11762	2026-03-10 04:26:46.104016	f
1851	2025-06-20	01:00:00	13:10, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.60	19.10	🔺 So So	6.50	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.107513	2026-03-10 04:26:53.334675	f
1850	2025-06-20	01:00:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	🔺 No, not really. Ate A Little	80.00	43.90	❌ No!!!	36.10	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.104506	2026-03-10 04:27:43.96383	f
1857	2025-06-20	15:58:00	1:40, 	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮	💖 Yes, eat right away	35.00	10.60	💕 Love it So Much	24.40	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.127454	2026-03-10 04:27:55.454698	f
1853	2025-06-20	07:40:00	-	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝) 	🔺 No, not really. Ate A Little	50.00	42.30	❌ No!!!	7.70	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.112147	2026-03-10 04:28:36.265065	f
1885	2025-06-24	05:15:00	17:25,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	🔺 No, not really. Ate A Little	70.00	33.30	🔺 So So	36.70	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.20576	2026-03-10 04:35:09.790927	f
1880	2025-06-23	07:30:00	17:55, 19:19, 00:09, 7:58	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.50	17.30	🔺 So So	17.20	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.191957	2026-03-10 04:33:18.681086	f
1871	2025-06-22	00:20:00	-	Wet	petline	懷石 白身鮪魚+干貝 kp3	🔺 No, not really. Ate A Little	40.00	29.50	❌ No!!!	10.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.165331	2026-03-10 04:31:42.985429	f
1869	2025-06-21	12:50:00	23:43, 1:47, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	36.20	18.90	🔺 So So	17.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.155207	2026-03-10 04:29:58.954231	f
1864	2025-06-21	07:40:00	-	Wet	法麗	關節保健主食罐 鮪魚佐蕃茄	❌ No, not interested	40.20	40.20	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 沒吃, 狂撥沙	\N	2	\N	2026-03-04 11:51:06.145136	2026-03-10 04:30:53.180857	f
1860	2025-06-20	11:00:00	-	Freeze-Dried	ve 唯一	凍乾鮮肉貓用生食餐 火雞肉	❌ No, not interested	15.70	15.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.137067	2026-03-10 04:26:26.75339	f
1859	2025-06-20	09:30:00	21:09, 22:50, 1:38, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	35.70	20.50	🔺 So So	15.20	3	❌ - 🔺	19	後面追加的量, 忘了/憑印象寫	\N	2	\N	2026-03-04 11:51:06.131587	2026-03-10 04:25:55.428069	f
1858	2025-06-20	11:00:00	21:11, 6:11, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	44.80	28.40	🔺 So So	16.40	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.129545	2026-03-10 04:26:16.505686	f
1866	2025-06-21	08:20:00	-	Wet	tuna	愛貓天然食 雞肉+鮪魚	🔺 No, not really. Ate A Little	70.00	57.20	❌ No!!!	12.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.149264	2026-03-10 04:29:22.243448	f
1867	2025-06-21	12:50:00	23:45, 4:01, 	Wet	ciao	imc-245 雞肉濃湯杯貓罐 - 雞肉+銀魚	💖 Yes, eat right away	70.00	19.80	💕 Love it So Much	50.20	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:06.151076	2026-03-10 04:29:35.270328	f
1870	2025-06-21	12:50:00	-	Kibble	歐那特	多種魚	❌ No, not interested	20.70	20.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.160441	2026-03-10 04:29:43.433449	f
1868	2025-06-21	12:50:00	20:37, 23:07, 4:00, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	39.40	27.40	🔺 So So	12.00	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.153349	2026-03-10 04:29:51.252407	f
1863	2025-06-21	00:43:00	11:26, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	22.20	20.60	🔺 So So	1.60	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.143288	2026-03-10 04:30:13.015862	f
1861	2025-06-21	00:43:00	-	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	🔺 No, not really. Ate A Little	60.00	35.70	❌ No!!!	24.30	0	🔺 - ❌	13		6.20	2	\N	2026-03-04 11:51:06.139412	2026-03-10 04:30:24.134706	f
1862	2025-06-21	00:43:00	13:27, 14:38, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	20.00	13.90	🔺 So So	6.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.141401	2026-03-10 04:30:31.781212	f
1865	2025-06-21	07:40:00	-	Wet	ciao	ic-204 日本餐包 鰹魚+雞肉+木魚片 鰹魚湯底	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.14722	2026-03-10 04:31:01.304687	f
1876	2025-06-22	15:45:00	1:13, 4:08,	Kibble	吶一口	室內貓雙響宴	💖 Yes, eat right away	21.40	5.90	🔺 So So	15.50	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:06.17932	2026-03-10 04:31:33.839336	f
1872	2025-06-22	00:20:00	9:12, 12:57, 13:54, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.20	11.90	🔺 So So	8.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.167435	2026-03-10 04:31:52.228805	f
1875	2025-06-22	07:00:00	17:08, 19:09, 19:50, 23:05, 4:07	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.10	13.40	🔺 So So	23.70	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:06.175354	2026-03-10 04:32:01.118195	f
1873	2025-06-22	07:00:00	-	Wet	喜耀	嫩雞片佐燉魚濃湯	💖 Yes, eat right away	34.00	8.90	❌ No!!!	25.10	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.16939	2026-03-10 04:32:09.873289	f
1874	2025-06-22	07:00:00	23:06, 4:09,	Wet	ciao	原湯杯53號 (雞肉+蟹肉棒+柴魚片)	❌ No, not interested	60.00	25.30	🔺 So So	34.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.173335	2026-03-10 04:32:39.298047	f
1877	2025-06-23	00:26:00	12:11, 14:18, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	💖 Yes, eat right away	85.00	38.40	🔺 So So	46.60	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:06.181208	2026-03-10 04:32:51.315848	f
1878	2025-06-23	00:26:00	11:09, 12:10, 14:17,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	15.50	8.00	🔺 So So	7.50	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.186306	2026-03-10 04:33:02.250771	f
1881	2025-06-23	07:30:00	16:15, 22:17, 2:09, 6:05, 7:56, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.50	1.20	🔺 So So	24.30	5	❌ - 🔺	30		\N	2	\N	2026-03-04 11:51:06.194671	2026-03-10 04:33:09.847667	f
1879	2025-06-23	07:30:00	16:16, 00:10, 2:10, 7:59, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	13.00	💕 Love it So Much	67.00	4	💖 - 💕	48		\N	2	\N	2026-03-04 11:51:06.190072	2026-03-10 04:33:34.245793	f
1888	2025-06-24	11:04:00	20:58, 1:23, 7:52,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.30	15.00	🔺 So So	10.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.216403	2026-03-10 04:33:54.746075	f
1886	2025-06-24	11:04:00	1:25, 4:38, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	28.80	💕 Love it So Much	51.20	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:06.208445	2026-03-10 04:34:02.32371	f
1884	2025-06-24	00:40:00	12:16, 18:37,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	16.50	9.40	🔺 So So	7.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.202098	2026-03-10 04:34:20.494166	f
1882	2025-06-24	00:40:00	-	Wet	法麗	室內貓排毛 鮪魚佐蟹肉	🔺 No, not really. Ate A Little	80.00	57.90	❌ No!!!	22.10	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.198129	2026-03-10 04:34:28.582739	f
1883	2025-06-24	05:15:00	17:24, 18:38, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	18.80	13.00	🔺 So So	5.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.200258	2026-03-10 04:34:53.093353	f
1890	2025-06-25	00:40:00	-	Wet	catit 嘿卡堤	海鑽貓餐包 鮪魚佐雞肉	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.22105	2026-03-10 04:36:13.729677	f
1891	2025-06-25	00:40:00	11:37, 	Wet	喵愛我	滋養肉汁 雞肉	💖 Yes, eat right away	73.50	32.60	🔺 So So	40.90	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:06.226442	2026-03-10 04:36:21.117252	f
1889	2025-06-25	00:40:00	-	Wet	踏踏寵膳 	土雞煲補補主食餐包 - 嫩燉虱目魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-04 11:51:06.219211	2026-03-10 04:36:45.631124	f
1892	2025-06-25	00:40:00	11:36, 12:10, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.70	13.70	🔺 So So	7.00	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.228526	2026-03-10 04:36:56.299247	f
2314	2026-03-05	01:09:00	12:01, 15:46, 18:31, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	13.80	🔺 So So	6.20	3	❌ - 🔺	19		\N	2	\N	2026-03-05 01:09:56.168435	2026-03-05 12:00:26.07385	f
1903	2025-06-27	01:00:00	-	Wet	astkatta	冰島經典低磷餐包 鮮燉雞肉絲	🔺 No, not really. Ate A Little	50.00	33.40	❌ No!!!	16.60	0	🔺 - ❌	13	一直喵喵叫就是不吃,	\N	2	\N	2026-03-04 11:51:06.264175	2026-03-10 04:39:13.57493	f
1902	2025-06-26	11:02:00	00:10, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	💖 Yes, eat right away	29.20	21.00	🔺 So So	8.20	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:06.25947	2026-03-10 04:37:34.656472	f
1895	2025-06-25	08:00:00	18:23, 20:35, 8:03, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	29.70	20.00	🔺 So So	9.70	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.236222	2026-03-10 04:35:40.334302	f
1893	2025-06-25	08:05:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	29.20	❌ No!!!	45.80	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.230861	2026-03-10 04:35:48.120231	f
1894	2025-06-25	08:05:00	-	Wet	喵愛我	滋養肉汁 雞肉	❌ No, not interested	68.40	68.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.234351	2026-03-10 04:35:55.736156	f
1896	2025-06-25	08:00:00	22:50, 00:36, 3:52, 8:04, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	21.50	12.60	🔺 So So	8.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.240124	2026-03-10 04:36:04.928399	f
1901	2025-06-26	12:03:00	00:08, 3:25, 6:02, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.70	16.80	🔺 So So	23.90	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.257411	2026-03-10 04:37:41.606875	f
1897	2025-06-26	00:50:00	11:02, 14:23, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉) x2	💖 Yes, eat right away	70.00	29.10	💕 Love it So Much	40.90	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:06.243215	2026-03-10 04:37:51.631877	f
1898	2025-06-26	00:50:00	11:01, 14:22	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.30	14.70	🔺 So So	6.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.247212	2026-03-10 04:38:02.217536	f
1899	2025-06-26	07:30:00	-	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	🔺 No, not really. Ate A Little	60.00	34.40	❌ No!!!	25.60	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.249099	2026-03-10 04:38:12.88041	f
1900	2025-06-26	12:03:00	6:03, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	12.40	💕 Love it So Much	57.60	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.253165	2026-03-10 04:38:25.917049	f
1909	2025-06-27	12:10:00	23:50, 3:19, 	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	25.10	13.50	🔺 So So	11.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.286221	2026-03-10 04:38:51.996348	f
1905	2025-06-27	02:17:00	14:32, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	17.90	🔺 So So	2.10	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.273405	2026-03-10 04:39:41.960827	f
1906	2025-06-27	07:40:00	-	Wet	ciao	ic-203 日本餐包 鰹魚+雞肉+干貝	💖 Yes, eat right away	40.00	18.60	❌ No!!!	21.40	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.27733	2026-03-10 04:39:54.986126	f
1908	2025-06-27	07:40:00	18:14, 23:46, 7:52, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	27.20	10.70	🔺 So So	16.50	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.28432	2026-03-10 04:40:04.308795	f
1916	2025-06-28	11:30:00	22:33, 23:38, 3:40, 6:02, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	28.70	13.90	🔺 So So	14.80	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.307303	2026-03-10 04:40:29.06311	f
1915	2025-06-28	11:30:00	21:59, 23:39, 1:34, 6:04, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	26.50	💕 Love it So Much	58.50	4	💖 - 💕	41		\N	2	\N	2026-03-04 11:51:06.303251	2026-03-10 04:40:37.911259	f
1910	2025-06-28	00:45:00	-	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	36.80	❌ No!!!	13.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.291328	2026-03-10 04:40:48.025422	f
1911	2025-06-28	00:45:00	22:34, 1:31, 3:39, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	9.30	🔺 So So	10.70	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.293509	2026-03-10 04:40:56.510941	f
1912	2025-06-28	02:25:00	-	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	16.00	12.40	❌ No!!!	3.60	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.295471	2026-03-10 04:41:07.281295	f
1913	2025-06-28	07:10:00	-	Wet	ciao	ic47 多樂米鮪魚沾醬 x2	🔺 No, not really. Ate A Little	40.00	19.60	❌ No!!!	20.40	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.29811	2026-03-10 04:41:29.424533	f
1914	2025-06-28	07:10:00	-	Wet	惜時	in 機能湯 白身鮪魚&蝦肉&燒汁	❌ No, not interested	80.00	0.00	❌ No!!!	80.00	0	❌ - ❌	15		\N	2	\N	2026-03-04 11:51:06.300446	2026-03-10 04:41:37.683326	f
1921	2025-06-29	11:20:00	19:45, 21:17, 23:57, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	❌ No, not interested	80.00	25.20	💕 Love it So Much	54.80	3	❌ - 💕	29	19:45(拿到前面才吃, 待觀察)	\N	2	\N	2026-03-04 11:51:06.321506	2026-03-10 04:42:15.323787	f
1922	2025-06-29	11:20:00	16:51, 21:15, 23:56, 4:06, 8:09, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	33.40	16.40	🔺 So So	17.00	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:06.323991	2026-03-10 04:42:26.523938	f
1920	2025-06-29	07:30:00	-	Wet	ciao	tcr-203 貓用濃湯餐包 - 鰹魚+鮪魚+三種鮮味	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.318571	2026-03-10 04:42:35.459557	f
1919	2025-06-29	07:30:00	16:53, 	Wet	ciao	ic-205 雞肉+干貝 (鰹魚湯底)	💖 Yes, eat right away	40.00	7.40	💕 Love it So Much	32.60	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.316606	2026-03-10 04:42:42.271763	f
1918	2025-06-29	00:35:00	10:07, 11:11, 12:43, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.00	12.40	🔺 So So	8.60	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.312421	2026-03-10 04:42:50.540803	f
1917	2025-06-29	00:35:00	10:08, 	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚 x2	💖 Yes, eat right away	70.00	25.30	💕 Love it So Much	44.70	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.309551	2026-03-10 04:42:58.308374	f
1927	2025-06-30	11:10:00	8:38, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	🔺 No, not really. Ate A Little	85.00	43.30	🔺 So So	41.70	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.338218	2026-03-10 04:43:22.411776	f
1924	2025-06-30	00:50:00	10:06, 12:43, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	19.80	14.80	🔺 So So	5.00	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.33033	2026-03-10 04:43:59.675093	f
1923	2025-06-30	00:50:00	-	Wet	ciao	ic-204 日本餐包 鰹魚+雞肉+木魚片 鰹魚湯底	💖 Yes, eat right away	40.00	9.20	❌ No!!!	30.80	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.327259	2026-03-10 04:44:07.359697	f
1925	2025-06-30	07:40:00	-	Wet	petline	sm-1 三時貓用慕斯餐包25g 雞肉+鰹魚 x2	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.332316	2026-03-10 04:44:19.579569	f
1926	2025-06-30	07:40:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	🔺 No, not really. Ate A Little	70.00	32.70	❌ No!!!	37.30	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.335562	2026-03-10 04:44:56.718906	f
1929	2025-06-30	11:10:00	23:18, 00:09, 3:37, 8:35, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.80	25.60	🔺 So So	9.20	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.344255	2026-03-10 04:43:42.62651	f
1932	2025-07-01	00:45:00	-	Wet	踏踏	貓咪機能型主食–鮮燉鴨胸140g	❌ No, not interested	140.00	140.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.354065	2026-03-10 07:22:04.934658	f
1936	2025-07-01	10:35:00	16:16, 17:27, 19:42, 21:10, 23:56, 3:39, 7:13, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	46.50	18.90	💕 Love it So Much	27.60	7	❌ - 💕	37		\N	2	\N	2026-03-04 11:51:06.367369	2026-03-10 07:21:35.916905	f
1935	2025-07-01	10:35:00	3:42, 7:14, 	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	💖 Yes, eat right away	80.00	26.80	💕 Love it So Much	53.20	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:06.363683	2026-03-10 07:21:44.873088	f
1928	2025-06-30	07:20:00	3:39, 8:37, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	31.00	🔺 So So	19.00	2	🔺 - 🔺	22		\N	2	\N	2026-03-04 11:51:06.341311	2026-03-10 07:21:55.344456	f
1933	2025-07-01	00:45:00	14:37, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	23.00	20.00	🔺 So So	3.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.356895	2026-03-10 07:22:16.178243	f
1931	2025-07-01	00:45:00	-	Wet	hello fresh	好鮮原汁湯罐 清蒸雞肉 & 牛肉	💖 Yes, eat right away	80.00	36.20	❌ No!!!	43.80	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.351474	2026-03-10 07:22:26.739405	f
1934	2025-07-01	06:50:00	16:17, 21:10, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	5.60	💕 Love it So Much	29.40	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.360446	2026-03-10 07:22:53.533136	f
1938	2025-07-02	00:30:00	10:40, 12:38, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.70	13.40	🔺 So So	8.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.374168	2026-03-10 07:23:41.254207	f
1937	2025-07-02	00:30:00	-	Wet	迷幻喵	迷幻喵 點心b罐 鮭魚+雞肉	🔺 No, not really. Ate A Little	80.00	71.10	❌ No!!!	8.90	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.371955	2026-03-10 07:24:22.226284	f
1939	2025-07-02	02:30:00	12:40, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	❌ No, not interested	60.00	49.60	🔺 So So	10.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.377319	2026-03-10 07:24:32.348591	f
1940	2025-07-02	07:13:00	-	Wet	奇境	牧場純雞燉雞湯	🔺 No, not really. Ate A Little	55.00	41.70	❌ No!!!	13.30	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.380868	2026-03-10 07:24:47.298452	f
1942	2025-07-02	07:13:00	17:13, 17:40, 20:52, 00:07, 2:54, 6:02, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	39.80	7.80	💕 Love it So Much	32.00	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:06.387353	2026-03-10 07:24:54.664835	f
1944	2025-07-03	00:30:00	10:07, 11:26, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	15.50	11.30	🔺 So So	4.20	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.39349	2026-03-10 07:25:14.70038	f
1943	2025-07-03	00:30:00	10:07, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	15.80	💕 Love it So Much	44.20	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.389572	2026-03-10 07:25:23.416443	f
1946	2025-07-03	07:30:00	8:18, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉)	🔺 No, not really. Ate A Little	35.00	16.00	🔺 So So	19.00	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.403301	2026-03-10 07:25:38.920108	f
1945	2025-07-03	07:30:00	-	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚 x2	🔺 No, not really. Ate A Little	70.00	30.50	❌ No!!!	39.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.397162	2026-03-10 07:25:46.88161	f
1947	2025-07-03	07:30:00	21:11, 2:17, 8:16, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	42.40	20.50	🔺 So So	21.90	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.407609	2026-03-10 07:25:53.988001	f
1948	2025-07-04	00:30:00	-	Wet	ciao	ic-205 雞肉+干貝 (鰹魚湯底)	💖 Yes, eat right away	40.00	17.30	❌ No!!!	22.70	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.413962	2026-03-10 07:26:24.254094	f
1951	2025-07-04	12:35:00	4:05, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	60.00	🔺 So So	25.00	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.421567	2026-03-10 07:26:34.653168	f
1952	2025-07-04	07:10:00	17:11, 19:03, 20:35, 21:03, 00:24, 4:01, 8:23,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	43.10	14.80	💕 Love it So Much	28.30	7	❌ - 💕	37		\N	2	\N	2026-03-04 11:51:06.423633	2026-03-10 07:27:05.996244	f
1950	2025-07-04	07:10:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	4.30	❌ No!!!	30.70	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.419551	2026-03-10 07:27:13.92992	f
1949	2025-07-04	00:30:00	14:40, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.60	18.20	🔺 So So	2.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.416488	2026-03-10 07:27:28.437567	f
1954	2025-07-05	00:35:00	11:16, 	Wet	ciao	ic-203 日本餐包 鰹魚+雞肉+干貝	💖 Yes, eat right away	40.00	9.70	💕 Love it So Much	30.30	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.43573	2026-03-10 07:28:00.918269	f
1953	2025-07-05	00:35:00	-	Wet	法麗	全照護主食罐 雞肉佐鮪魚慕斯	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.429441	2026-03-10 07:28:09.685898	f
1955	2025-07-05	00:35:00	11:15, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.20	17.90	🔺 So So	2.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.438342	2026-03-10 07:28:28.787466	f
1956	2025-07-05	07:10:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮	🔺 No, not really. Ate A Little	35.00	15.60	❌ No!!!	19.40	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.455688	2026-03-10 07:28:37.031026	f
1957	2025-07-05	07:10:00	8:23, 	Wet	ciao	原湯杯54號 (雞肉+蟹肉+吻仔魚)	💖 Yes, eat right away	60.00	20.90	🔺 So So	39.10	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:06.460347	2026-03-10 07:28:44.458692	f
1958	2025-07-05	07:10:00	15:30, 19:12, 21:13, 00:35, 4:32	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	47.40	24.30	🔺 So So	23.10	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:06.467689	2026-03-10 07:28:51.755393	f
1962	2025-07-06	07:15:00	-	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	9.70	❌ No!!!	20.30	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.483492	2026-03-10 07:29:20.97056	f
1961	2025-07-06	00:30:00	10:31, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	18.70	18.10	🔺 So So	0.60	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.478405	2026-03-10 07:29:37.350956	f
1960	2025-07-06	00:30:00	-	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	30.00	13.40	❌ No!!!	16.60	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.474854	2026-03-10 07:29:45.032616	f
1963	2025-07-06	12:55:00	22:11, 3:52, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	20.20	💕 Love it So Much	64.80	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.486317	2026-03-10 07:29:58.18483	f
1969	2025-07-07	13:38:00	6:21, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	🔺 No, not really. Ate A Little	80.00	49.30	🔺 So So	30.70	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.525284	2026-03-10 07:30:18.753456	f
1966	2025-07-07	00:55:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	22.70	22.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.501499	2026-03-10 07:30:40.653998	f
1967	2025-07-07	01:58:00	11:25, 12:01, 13:30, 	Kibble	璞斯	體態管理全齡貓 鴨肉	💖 Yes, eat right away	31.50	12.80	💕 Love it So Much	18.70	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:06.510636	2026-03-10 07:30:51.687244	f
1970	2025-07-07	07:15:00	17:19, 19:25, 21:37, 6:21, 8:34, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	38.00	17.50	💕 Love it So Much	20.50	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:06.535902	2026-03-10 07:30:59.543047	f
1968	2025-07-07	07:15:00	17:20, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	🔺 No, not really. Ate A Little	60.00	36.70	🔺 So So	23.30	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.516488	2026-03-10 07:31:07.645171	f
1975	2025-07-08	13:35:00	4:34, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	42.50	39.50	🔺 So So	3.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.553458	2026-03-10 07:31:35.11716	f
1976	2025-07-08	13:35:00	4:34, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	26.60	18.20	🔺 So So	8.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.560029	2026-03-10 07:31:43.045851	f
1974	2025-07-08	13:35:00	4:36, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	🔺 No, not really. Ate A Little	60.00	35.50	🔺 So So	24.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.549639	2026-03-10 07:31:51.601173	f
1972	2025-07-08	00:40:00	14:29, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.50	17.10	🔺 So So	3.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.54255	2026-03-10 07:31:59.903635	f
1971	2025-07-08	00:40:00	-	Wet	迷幻喵	迷幻喵 點心a罐 鮮嫩雞肉 	🔺 No, not really. Ate A Little	80.00	63.10	❌ No!!!	16.90	0	🔺 - ❌	13	間斷地打噴嚏, 右眼紅紅的流眼淚, 幾乎整天都在睡	\N	2	\N	2026-03-04 11:51:06.539396	2026-03-10 07:32:08.868822	f
1973	2025-07-08	07:20:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	4.50	❌ No!!!	30.50	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.545431	2026-03-10 07:32:35.335481	f
1981	2025-07-09	08:14:00	-	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	🔺 No, not really. Ate A Little	60.00	41.00	❌ No!!!	19.00	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.578512	2026-03-10 07:32:58.128857	f
1980	2025-07-09	08:14:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮	💖 Yes, eat right away	35.00	0.00	💕 Love it So Much	35.00	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:06.573555	2026-03-10 07:33:05.61279	f
1982	2025-07-09	08:14:00	17:49, 21:33, 23:54, 4:31, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.30	14.00	🔺 So So	26.30	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.580958	2026-03-10 07:33:13.518309	f
1977	2025-07-09	00:50:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	3.80	❌ No!!!	31.20	0	💖 - ❌	25	一次吃光/間斷地打噴嚏, 右眼紅紅的流眼淚/打噴嚏頻率有比7/8低, 右眼比較不紅, 但還是會流淚/睡覺時間變長	\N	2	\N	2026-03-04 11:51:06.562139	2026-03-10 07:33:22.258163	f
1979	2025-07-09	00:50:00	8:59, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.40	13.00	🔺 So So	8.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.568423	2026-03-10 07:33:30.692447	f
1978	2025-07-09	02:50:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	5.10	❌ No!!!	29.90	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.564165	2026-03-10 07:33:38.998205	f
1986	2025-07-10	11:00:00	9:05, 	Wet	ciao	原湯杯54號 (雞肉+蟹肉+吻仔魚)	💖 Yes, eat right away	60.00	17.10	💕 Love it So Much	42.90	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.627286	2026-03-10 07:34:02.677684	f
1983	2025-07-10	00:45:00	9:11, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	15.40	💕 Love it So Much	44.60	1	💖 - 💕	35	右眼好很多，但還是有點流眼淚（透明), 也有點打噴嚏/15:00 => 整體看起來都好很多, 右眼沒有流眼淚, 也沒打噴嚏, 食慾有增加. 也比較有活動力	\N	2	\N	2026-03-04 11:51:06.586901	2026-03-10 07:34:14.689858	f
1984	2025-07-10	00:45:00	9:09, 11:26, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.10	15.30	🔺 So So	5.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.589215	2026-03-10 07:34:22.426052	f
1987	2025-07-10	06:50:00	17:19, 20:21, 21:57, 5:00, 9:03	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.50	22.50	🔺 So So	18.00	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:06.632614	2026-03-10 07:34:34.575397	f
1985	2025-07-10	06:50:00	-	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚	🔺 No, not really. Ate A Little	35.00	15.50	❌ No!!!	19.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.59449	2026-03-10 07:34:42.682088	f
1996	2025-07-12	11:09:00	22:00, 7:32,	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	4.60	💕 Love it So Much	60.40	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.676317	2026-03-10 07:36:36.950821	f
1988	2025-07-11	01:13:00	-	Wet	ciao	ic-201 餐包 鮪魚, 雞肉, 干貝	💖 Yes, eat right away	40.00	14.10	❌ No!!!	25.90	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.638552	2026-03-10 07:35:31.245553	f
1989	2025-07-11	01:13:00	13:25, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.50	18.00	🔺 So So	3.50	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.640998	2026-03-10 07:35:38.685426	f
1990	2025-07-11	07:25:00	-	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	30.00	13.60	❌ No!!!	16.40	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.646348	2026-03-10 07:35:50.572996	f
1992	2025-07-11	07:25:00	18:50, 22:01, 4:06, 7:45, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	42.80	21.90	🔺 So So	20.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.655476	2026-03-10 07:35:58.24167	f
1991	2025-07-11	11:25:00	22:02, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝 x2	🔺 No, not really. Ate A Little	60.00	38.50	🔺 So So	21.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.6518	2026-03-10 07:36:15.688855	f
1993	2025-07-12	00:30:00	-	Wet	金湯	愛貓湯罐 鮮嫩雞肉 & 南瓜	🔺 No, not really. Ate A Little	80.00	49.80	🔺 So So	30.20	0	🔺 - 🔺	18		6.10	2	\N	2026-03-04 11:51:06.661587	2026-03-10 07:36:54.253481	f
1994	2025-07-12	00:30:00	9:11, 11:23, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.20	14.90	🔺 So So	5.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.664019	2026-03-10 07:37:05.712083	f
1995	2025-07-12	07:00:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.669457	2026-03-10 07:37:17.001687	f
2001	2025-07-13	11:19:00	22:44, 	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	💖 Yes, eat right away	60.00	5.20	💕 Love it So Much	54.80	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.695385	2026-03-10 07:37:48.321863	f
1998	2025-07-13	02:00:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	6.80	❌ No!!!	28.20	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.680818	2026-03-10 07:38:00.840411	f
1999	2025-07-13	02:00:00	11:34, 14:27, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	13.50	🔺 So So	6.50	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.685449	2026-03-10 07:38:08.638943	f
2000	2025-07-13	07:00:00	-	Wet	ciao	imc-223 果凍杯 鮪魚+雞肉+吻仔魚	💖 Yes, eat right away	35.00	6.40	❌ No!!!	28.60	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.690009	2026-03-10 07:38:23.917458	f
2006	2025-07-14	11:18:00	4:24,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	42.30	🔺 So So	42.70	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.715286	2026-03-10 07:38:43.842316	f
2004	2025-07-14	01:06:00	10:32, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	22.40	18.40	🔺 So So	4.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:06.704541	2026-03-10 07:38:52.433674	f
2003	2025-07-14	01:06:00	10:34, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	🔺 No, not really. Ate A Little	60.00	28.90	🔺 So So	31.10	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.700658	2026-03-10 07:39:04.313454	f
2005	2025-07-14	07:05:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮	💖 Yes, eat right away	35.00	11.00	❌ No!!!	24.00	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.709441	2026-03-10 07:39:30.023158	f
2007	2025-07-14	07:05:00	16:33, 19:46, 21:30, 22:35, 1:22, 4:23, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	45.20	17.50	💕 Love it So Much	27.70	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:06.717362	2026-03-10 07:39:37.642462	f
2010	2025-07-15	10:00:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	11.90	❌ No!!!	23.10	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.737088	2026-03-10 07:40:06.625524	f
2012	2025-07-15	10:00:00	19:32, 20:47, 21:41, 1:56, 5:00, 8:24, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.90	17.60	💕 Love it So Much	17.30	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:06.745068	2026-03-10 07:40:16.416424	f
2011	2025-07-15	11:56:00	5:02, 	Wet	ciao	布丁杯 鮪魚 imc-151	💖 Yes, eat right away	65.00	25.20	💕 Love it So Much	39.80	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:06.742853	2026-03-10 07:40:23.970536	f
2009	2025-07-15	01:06:00	10:12, 11:12, 12:03, 14:52, 17:51, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.00	10.70	💕 Love it So Much	10.30	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:06.727879	2026-03-10 07:40:32.002168	f
2008	2025-07-15	01:06:00	11:13, 17:52, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	21.20	💕 Love it So Much	38.80	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:06.721453	2026-03-10 07:40:39.167814	f
2016	2025-07-16	11:00:00	-	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.757314	2026-03-10 07:41:00.373964	f
2017	2025-07-16	11:00:00	23:58, 4:53, 	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	❌ No, not interested	60.00	30.20	🔺 So So	29.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.760209	2026-03-10 07:41:08.786744	f
2013	2025-07-16	00:50:00	10:25, 	Wet	ciao	ic-552 高湯鮮味餐包 雞肉+鰹魚柴魚片+鮪魚高湯	💖 Yes, eat right away	30.00	2.10	💕 Love it So Much	27.90	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.747414	2026-03-10 07:41:16.507696	f
2014	2025-07-16	00:50:00	10:24, 12:19, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	13.60	🔺 So So	6.40	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.7503	2026-03-10 07:41:24.496437	f
2015	2025-07-16	07:20:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	5.80	❌ No!!!	29.20	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.754369	2026-03-10 07:41:41.556094	f
2018	2025-07-16	07:20:00	16:56, 18:01, 20:43, 23:55, 4:51, 8:40, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	38.90	13.00	🔺 So So	25.90	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:06.762305	2026-03-10 07:41:48.705032	f
2022	2025-07-17	08:00:00	-	Wet	喵樂	肉食控鮮肉湯罐 嫩雞鮪魚	🔺 No, not really. Ate A Little	80.00	41.20	❌ No!!!	38.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.792589	2026-03-10 07:42:13.854205	f
2023	2025-07-17	12:35:00	4:38, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	8.10	💕 Love it So Much	51.90	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.796136	2026-03-10 07:42:24.906895	f
2019	2025-07-17	00:55:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	💖 Yes, eat right away	80.00	49.00	❌ No!!!	31.00	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.769606	2026-03-10 07:42:38.740455	f
2020	2025-07-17	00:55:00	10:05, 11:45, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	22.80	16.80	🔺 So So	6.00	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.778406	2026-03-10 07:42:50.425764	f
2024	2025-07-17	07:05:00	15:30, 17:16, 18:45, 21:07, 1:23, 4:36, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	42.80	25.50	💕 Love it So Much	17.30	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:06.799657	2026-03-10 07:42:57.546454	f
2021	2025-07-17	07:05:00	-	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.785863	2026-03-10 07:43:04.863943	f
2029	2025-07-18	12:00:00	23:47, 6:01, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	7.40	💕 Love it So Much	57.60	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.81451	2026-03-10 07:43:37.542124	f
2025	2025-07-18	00:30:00	9:32, 11:36, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	💖 Yes, eat right away	85.00	38.30	🔺 So So	46.70	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:06.803811	2026-03-10 07:43:44.797309	f
2026	2025-07-18	00:30:00	9:31, 11:21, 11:35, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	21.60	17.20	🔺 So So	4.40	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.806438	2026-03-10 07:43:52.427302	f
2027	2025-07-18	07:20:00	-	Wet	ciao	ic50 多樂米干貝沾醬 20g x2	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.808652	2026-03-10 07:44:08.072232	f
2028	2025-07-18	07:30:00	18:52,	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮	💖 Yes, eat right away	35.00	4.40	💕 Love it So Much	30.60	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.812436	2026-03-10 07:44:16.580601	f
2031	2025-07-19	01:00:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	8.30	❌ No!!!	26.70	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.821806	2026-03-10 07:44:55.880254	f
2067	2025-07-25	01:03:00	-	Kibble	法米納	鴨肉蘋果 天然藜麥無穀機能系列 qc7-1	❌ No, not interested	16.20	16.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.018022	2026-03-10 07:52:58.683068	f
2034	2025-07-19	11:05:00	19:20, 4:09, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	❌ No, not interested	85.00	38.70	🔺 So So	46.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.833232	2026-03-10 07:44:40.323387	f
2032	2025-07-19	01:00:00	10:07, 12:45, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	21.00	17.20	🔺 So So	3.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.827601	2026-03-10 07:44:48.385221	f
2035	2025-07-19	11:05:00	19:18, 20:24, 22:29, 4:07, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	38.10	24.40	🔺 So So	13.70	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.842276	2026-03-10 07:45:07.957822	f
2033	2025-07-19	07:05:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	11.70	❌ No!!!	23.30	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.831336	2026-03-10 07:45:29.651443	f
2038	2025-07-20	07:35:00	17:30	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝	💖 Yes, eat right away	30.00	4.60	💕 Love it So Much	25.40	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:06.852527	2026-03-10 07:45:59.418743	f
2036	2025-07-20	01:20:00	9:53, 	Wet	axia	金罐特選1號 鮪+雞+蟹棒	🔺 No, not really. Ate A Little	70.00	40.60	🔺 So So	29.40	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.846372	2026-03-10 07:46:10.51976	f
2037	2025-07-20	01:20:00	9:50, 10:33, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.10	14.50	🔺 So So	6.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.850269	2026-03-10 07:46:18.34242	f
2040	2025-07-20	07:35:00	17:30, 20:25, 21:29, 1:45, 4:09, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	39.40	12.90	🔺 So So	26.50	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:06.857534	2026-03-10 07:46:45.028927	f
2041	2025-07-21	01:00:00	-	Wet	pramy 普拉	經典貓餐包 黃金鮮鮪+放山雞	🔺 No, not really. Ate A Little	70.00	37.90	❌ No!!!	32.10	0	🔺 - ❌	13		6.10	2	\N	2026-03-04 11:51:06.859529	2026-03-10 07:47:04.580005	f
2042	2025-07-21	01:00:00	9:07, 11:21, 12:12, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.30	11.50	🔺 So So	9.80	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.863156	2026-03-10 07:47:11.96968	f
2043	2025-07-21	07:05:00	-	Wet	ciao	ic-211 貓用巧餐包-鮪魚+扇貝	💖 Yes, eat right away	40.00	9.00	❌ No!!!	31.00	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.865362	2026-03-10 07:47:19.907606	f
2045	2025-07-21	07:05:00	17:15, 20:16, 23:28, 00:36, 4:26, 6:41, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.00	12.60	💕 Love it So Much	24.40	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:06.873432	2026-03-10 07:47:39.16491	f
2044	2025-07-21	12:20:00	23:30, 4:27, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	15.60	💕 Love it So Much	44.40	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:06.8693	2026-03-10 07:47:59.693635	f
2048	2025-07-22	10:00:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	8.40	❌ No!!!	26.60	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.887556	2026-03-10 07:48:26.441258	f
2050	2025-07-22	10:00:00	19:07, 19:57, 21:00, 00:20,	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	39.70	23.10	🔺 So So	16.60	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.893504	2026-03-10 07:48:36.032349	f
2046	2025-07-22	00:50:00	-	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	🔺 No, not really. Ate A Little	60.00	42.40	❌ No!!!	17.60	0	🔺 - ❌	13	20:05 吐	\N	2	\N	2026-03-04 11:51:06.876749	2026-03-10 07:48:44.546514	f
2049	2025-07-22	13:05:00	00:21, 4:49, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	10.00	💕 Love it So Much	55.00	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.889728	2026-03-10 07:48:53.550005	f
2047	2025-07-22	00:50:00	9:13, 12:12, 14:34, 17:58, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	22.50	10.40	💕 Love it So Much	12.10	4	❌ - 💕	31		\N	2	\N	2026-03-04 11:51:06.885116	2026-03-10 07:49:03.83302	f
2054	2025-07-23	08:00:00	17:47, 2:33, 	Wet	喵愛我	滋養肉汁 雞肉	💖 Yes, eat right away	70.80	12.10	💕 Love it So Much	58.70	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.918349	2026-03-10 07:49:26.631937	f
2055	2025-07-23	15:00:00	4:26, 8:17, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	10.50	💕 Love it So Much	49.50	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:06.923385	2026-03-10 07:49:43.582782	f
2053	2025-07-23	01:00:00	10:36, 13:28, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.80	17.80	🔺 So So	3.00	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.913061	2026-03-10 07:49:50.937585	f
2052	2025-07-23	01:00:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-94 鮪魚	🔺 No, not really. Ate A Little	60.00	27.50	❌ No!!!	32.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.905102	2026-03-10 07:49:58.588053	f
2051	2025-07-23	01:00:00	-	Wet	貓姬	成貓肉泥杯 雞肉+鮪魚 cp-790	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.898356	2026-03-10 07:50:17.107007	f
2064	2025-07-24	17:13:00	4:07, 8:50, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	29.50	13.30	🔺 So So	16.20	2	💖 - 🔺	27	準備要睡覺, 但阿吉很躁動, 懷疑乾乾沒吃飽	\N	2	\N	2026-03-04 11:51:06.987967	2026-03-10 07:50:54.91802	f
2059	2025-07-24	00:45:00	10:10, 12:39, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.80	19.20	🔺 So So	2.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.954945	2026-03-10 07:51:02.829992	f
2058	2025-07-24	00:45:00	1:06, 	Wet	喵愛我	滋養肉汁 雞肉	🔺 No, not really. Ate A Little	67.10	34.90	🔺 So So	32.20	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.946677	2026-03-10 07:51:10.575608	f
2057	2025-07-24	00:45:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	7.00	❌ No!!!	28.00	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:06.928886	2026-03-10 07:51:22.935571	f
2062	2025-07-24	01:11:00	1:04,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	40.20	🔺 So So	44.80	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:06.974393	2026-03-10 07:51:32.871091	f
2063	2025-07-24	01:11:00	15:22, 22:54, 8:49, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	44.50	36.50	🔺 So So	8.00	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:06.982227	2026-03-10 07:51:40.121081	f
2061	2025-07-24	07:00:00	-	Wet	ciao	ic-552 高湯鮮味餐包 雞肉+鰹魚柴魚片+鮪魚高湯	🔺 No, not really. Ate A Little	30.00	14.90	❌ No!!!	15.10	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:06.964573	2026-03-10 07:51:49.571696	f
2060	2025-07-24	06:55:00	-	Wet	里奧納多	鴨肉 精燉湯包	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:06.961752	2026-03-10 07:51:59.529287	f
2066	2025-07-25	01:03:00	12:56, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.80	16.00	🔺 So So	4.80	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:07.009852	2026-03-10 07:52:50.042113	f
2065	2025-07-25	01:03:00	-	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝	💖 Yes, eat right away	30.00	13.40	❌ No!!!	16.60	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:06.996101	2026-03-10 07:53:06.788003	f
2070	2025-07-25	05:20:00	17:04, 22:38, 1:28, 3:12,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	42.00	22.30	🔺 So So	19.70	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:07.044399	2026-03-10 07:53:19.235377	f
2068	2025-07-25	05:20:00	-	Wet	ciao	極鮮合味系列 貓餐杯 nc-92 鰹魚	🔺 No, not really. Ate A Little	85.00	53.60	❌ No!!!	31.40	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.034286	2026-03-10 07:53:26.579752	f
2074	2025-07-26	11:17:00	3:51,	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	24.80	🔺 So So	35.20	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:07.083864	2026-03-10 07:53:50.485238	f
2071	2025-07-26	00:43:00	-	Wet	axia	金罐特選1號 鮪+雞+蟹棒	🔺 No, not really. Ate A Little	70.00	58.90	❌ No!!!	11.10	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.059996	2026-03-10 07:53:59.561094	f
2072	2025-07-26	00:43:00	13:11,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	22.20	15.00	🔺 So So	7.20	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:07.065352	2026-03-10 07:54:08.325373	f
2073	2025-07-26	07:15:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮	🔺 No, not really. Ate A Little	35.00	9.60	❌ No!!!	25.40	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.076102	2026-03-10 07:54:17.259495	f
2075	2025-07-26	07:15:00	17:18, 20:10, 21:29, 23:47, 00:25, 2:15, 3:49, 8:42, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	40.20	6.90	💕 Love it So Much	33.30	8	❌ - 💕	46		\N	2	\N	2026-03-04 11:51:07.094776	2026-03-10 07:54:30.483364	f
2079	2025-07-27	14:00:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.122858	2026-03-10 07:55:00.308051	f
2076	2025-07-27	01:14:00	-	Wet	schesir 雪詩雅	雞肉貓罐頭	🔺 No, not really. Ate A Little	85.00	61.10	❌ No!!!	23.90	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.102678	2026-03-10 07:55:08.431306	f
2077	2025-07-27	01:14:00	10:50, 13:14,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	26.90	20.90	🔺 So So	6.00	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.109654	2026-03-10 07:55:16.712734	f
2078	2025-07-27	07:40:00	-	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	🔺 No, not really. Ate A Little	65.00	38.50	❌ No!!!	26.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.112962	2026-03-10 07:55:23.842499	f
2080	2025-07-27	07:40:00	16:53, 18:15, 20:09, 22:38, 23:25, 1:56, 8:05, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	45.70	17.30	💕 Love it So Much	28.40	7	❌ - 💕	37		\N	2	\N	2026-03-04 11:51:07.128213	2026-03-10 07:55:31.310088	f
2084	2025-07-28	09:30:00	18:27, 21:06, 22:36, 00:33, 2:28, 4:31, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.60	10.20	💕 Love it So Much	27.40	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:07.182726	2026-03-10 07:55:55.412616	f
2089	2025-07-29	10:15:00	19:18, 20:56, 4:01, 7:23, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.90	29.30	🔺 So So	11.60	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:07.28344	2026-03-10 07:57:01.698062	f
2082	2025-07-28	01:10:00	9:38, 15:54, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.40	12.60	🔺 So So	8.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.151729	2026-03-10 07:56:13.082732	f
2081	2025-07-28	01:10:00	15:56, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	20.70	💕 Love it So Much	39.30	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.142071	2026-03-10 07:56:20.613944	f
2083	2025-07-28	09:30:00	4:34, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	29.50	💕 Love it So Much	50.50	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.173544	2026-03-10 07:56:33.481899	f
2088	2025-07-29	10:15:00	4:03, 	Wet	ciao	nc-91 極鮮合味貓罐 鮪魚	🔺 No, not really. Ate A Little	85.00	49.10	🔺 So So	35.90	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.263152	2026-03-10 07:57:12.635329	f
2090	2025-07-29	15:41:00	00:53, 4:02, 7;24, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	30.30	16.10	🔺 So So	14.20	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.291827	2026-03-10 07:57:20.11676	f
2085	2025-07-29	01:18:00	-	Wet	凱茲	火雞無穀主食餐包	🔺 No, not really. Ate A Little	85.00	68.30	❌ No!!!	16.70	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.200581	2026-03-10 07:57:28.46025	f
2086	2025-07-29	01:18:00	9:46, 12:46, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	22.60	14.80	🔺 So So	7.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.222625	2026-03-10 07:57:38.214979	f
2087	2025-07-29	03:35:00	-	Wet	喵愛我	滋養肉汁 鴨肉	🔺 No, not really. Ate A Little	71.80	38.70	❌ No!!!	33.10	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.23799	2026-03-10 07:57:50.973392	f
2095	2025-07-30	11:05:00	00:19, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	18.70	💕 Love it So Much	51.30	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.334466	2026-03-10 07:58:19.66055	f
2096	2025-07-30	11:05:00	20:48, 00:17, 4:12, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	36.60	22.20	🔺 So So	14.40	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.347299	2026-03-10 07:58:51.843939	f
2093	2025-07-30	03:10:00	12:34, 14:30, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	22.50	11.30	🔺 So So	11.20	2	💖 - 🔺	27	一直叫想吃	\N	2	\N	2026-03-04 11:51:07.309216	2026-03-10 07:59:16.008458	f
2094	2025-07-30	03:10:00	-	Wet	brit 咘莉	極致補水貓湯包 新鮮嫩雞肉	❌ No, not interested	75.00	75.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.325082	2026-03-10 07:59:27.817489	f
2101	2025-07-31	07:20:00	16:29, 23:43, 3:51, 5:29, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	38.80	17.00	🔺 So So	21.80	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:07.439776	2026-03-10 08:00:01.064219	f
2099	2025-07-31	07:20:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	4.90	❌ No!!!	30.10	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:07.405187	2026-03-10 08:00:10.207243	f
2097	2025-07-31	00:32:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x2	🔺 No, not really. Ate A Little	70.00	38.50	❌ No!!!	31.50	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.355652	2026-03-10 08:00:18.149225	f
2098	2025-07-31	00:32:00	9:21, 11:53, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	13.80	🔺 So So	6.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.368186	2026-03-10 08:00:28.188851	f
2103	2025-07-31	17:30:00	-	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝 x2	🔺 No, not really. Ate A Little	60.00	43.60	❌ No!!!	16.40	0	🔺 - ❌	13	一直叫想吃	\N	2	\N	2026-03-04 11:51:07.494999	2026-03-10 08:00:40.388647	f
2102	2025-07-31	16:55:00	-	Kibble	尊爵 	天然糧 挑嘴貓 機能天然糧	❌ No, not interested	40.40	40.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.48256	2026-03-10 08:00:51.272436	f
2100	2025-07-31	11:30:00	1:08,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	45.20	🔺 So So	39.80	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.42315	2026-03-10 08:01:14.390585	f
2111	2025-08-01	07:40:00	-	Kibble	曙光	天然無穀火雞肉餐	❌ No, not interested	25.50	25.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.536974	2026-03-10 08:17:40.2797	f
2118	2025-08-02	07:05:00	-	Wet	奇境	野生鮪魚燉雞湯	🔺 No, not really. Ate A Little	55.00	45.60	❌ No!!!	9.40	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.568285	2026-03-10 08:24:39.722005	f
2125	2025-08-03	01:45:00	-	Kibble	曙光	無穀滋養火雞肉食譜	❌ No, not interested	17.80	17.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.591739	2026-03-10 08:27:50.697419	f
2133	2025-08-04	12:40:00	22:56, 	Wet	ciao	布丁杯 鮪魚 imc-151	🔺 No, not really. Ate A Little	65.00	33.50	🔺 So So	31.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.631278	2026-03-10 08:33:21.268395	f
2132	2025-08-04	07:12:00	-	Wet	喵愛我	滋養肉汁 雞肉	💖 Yes, eat right away	42.10	4.30	❌ No!!!	37.80	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:07.628774	2026-03-10 08:34:01.758748	f
2109	2025-08-01	11:10:00	7:08,	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	31.70	💕 Love it So Much	48.30	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.527298	2026-03-10 08:11:07.070273	f
2106	2025-08-01	01:00:00	-	Kibble	尊爵	天然糧 化毛貓 機能天然糧	❌ No, not interested	40.90	40.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.518223	2026-03-10 08:11:18.59063	f
2105	2025-08-01	01:00:00	12:26, 14:36, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	20.00	9.70	🔺 So So	10.30	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.511649	2026-03-10 08:11:38.189693	f
2104	2025-08-01	01:00:00	14:37, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	27.00	💕 Love it So Much	53.00	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.49962	2026-03-10 08:12:07.978574	f
2110	2025-08-01	07:40:00	15:56, 21:03, 22:00, 7:07, 8:50, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	36.80	14.20	🔺 So So	22.60	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:07.530257	2026-03-10 08:12:23.993869	f
2112	2025-08-01	07:40:00	-	Freeze-Dried	可蒂毛毛	凍乾探險隊 滋補嫩香鴨	💖 Yes, eat right away	4.80	0.00	💕 Love it So Much	4.80	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.539022	2026-03-10 08:17:32.388076	f
2108	2025-08-01	07:40:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.524457	2026-03-10 08:17:48.979741	f
2121	2025-08-02	11:35:00	20:46, 21:40, 23:00, 2:10, 6:50, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	44.40	20.00	💕 Love it So Much	24.40	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:07.575324	2026-03-10 08:18:53.450563	f
2120	2025-08-02	11:35:00	8:17, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	🔺 No, not really. Ate A Little	85.00	43.10	🔺 So So	41.90	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.573228	2026-03-10 08:19:03.871856	f
2115	2025-08-02	01:41:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	0.00	💕 Love it So Much	40.00	0	💖 - 💕	40	一口氣全部吃光	\N	2	\N	2026-03-04 11:51:07.547511	2026-03-10 08:19:17.295385	f
2114	2025-08-02	01:41:00	-	Wet	迷幻喵	迷幻喵 點心c罐 新鮮鮭魚肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 直接撥沙	\N	2	\N	2026-03-04 11:51:07.542888	2026-03-10 08:19:48.080431	f
2117	2025-08-02	01:41:00	-	Kibble	曙光	無榖滋養雞肉食譜	❌ No, not interested	16.60	16.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.562337	2026-03-10 08:23:04.059356	f
2113	2025-08-02	01:41:00	-	Wet	yammi 亞米	高湯特餐 鮮嫩鮪魚雞肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.540929	2026-03-10 08:23:12.481071	f
2116	2025-08-02	01:41:00	12:12, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.00	18.50	🔺 So So	2.50	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:07.556253	2026-03-10 08:24:00.397868	f
2127	2025-08-03	12:25:00	2:16,	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	🔺 No, not really. Ate A Little	80.00	43.50	🔺 So So	36.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.603321	2026-03-10 08:27:03.516602	f
2122	2025-08-03	01:45:00	-	Wet	貓姬	成貓肉湯杯 雞肉+扇貝 cp-819	🔺 No, not really. Ate A Little	60.00	26.70	❌ No!!!	33.30	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.579028	2026-03-10 08:27:14.169316	f
2123	2025-08-03	01:45:00	10:10, 12:41, 15:54, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	27.10	16.10	🔺 So So	11.00	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.58334	2026-03-10 08:27:21.742498	f
2124	2025-08-03	01:45:00	-	Freeze-Dried	可蒂毛毛	凍乾探險隊 滋補嫩香鴨	💖 Yes, eat right away	2.20	0.00	💕 Love it So Much	2.20	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.58857	2026-03-10 08:27:29.556473	f
2126	2025-08-03	07:55:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	8.00	❌ No!!!	27.00	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:07.598893	2026-03-10 08:28:02.696897	f
2128	2025-08-03	07:55:00	19:45, 00:10, 2:14, 4:19, 7:01	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	44.30	11.80	🔺 So So	32.50	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:07.607279	2026-03-10 08:28:10.209699	f
2134	2025-08-04	07:12:00	17:42, 19:45, 22:55, 4:54, 8:31,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	43.70	32.30	🔺 So So	11.40	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:07.633227	2026-03-10 08:28:40.943566	f
2129	2025-08-04	01:29:00	-	Wet	ciao	ic-555 高湯鮮味餐包 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	8.90	❌ No!!!	21.10	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:07.610988	2026-03-10 08:32:42.157627	f
2130	2025-08-04	01:29:00	11:22, 12:41,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	23.10	16.40	🔺 So So	6.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.621616	2026-03-10 08:32:51.143973	f
2131	2025-08-04	01:29:00	-	Freeze-Dried	可蒂毛毛	凍乾探險隊 滋補嫩香鴨	💖 Yes, eat right away	3.50	0.00	💕 Love it So Much	3.50	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.626499	2026-03-10 08:33:00.921882	f
2136	2025-08-04	15:30:00	3:13, 8:32,	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	25.00	9.40	🔺 So So	15.60	2	💖 - 🔺	27	一直叫	\N	2	\N	2026-03-04 11:51:07.640484	2026-03-10 08:33:32.995476	f
2135	2025-08-04	07:12:00	-	Freeze-Dried	可蒂毛毛	凍乾探險隊 滋補嫩香鴨	💖 Yes, eat right away	2.80	0.50	💕 Love it So Much	2.30	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.638356	2026-03-10 08:33:43.964572	f
2138	2025-08-05	01:04:00	11:15, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.70	16.10	🔺 So So	4.60	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:07.644598	2026-03-10 08:34:45.595344	f
2137	2025-08-05	01:04:00	-	Wet	ciao	ic-201 餐包 鮪魚, 雞肉, 干貝	💖 Yes, eat right away	40.00	14.90	❌ No!!!	25.10	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:07.642498	2026-03-10 08:35:20.842433	f
2140	2025-08-05	07:10:00	-	Wet	ciao	imc-224 雙喵杯 鮪魚+雞肉+柴魚片	🔺 No, not really. Ate A Little	35.00	17.10	❌ No!!!	17.90	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.651152	2026-03-10 08:35:45.196072	f
2139	2025-08-05	07:10:00	-	Wet	可蒂毛毛	呼呼室內包 鮮雞x鬼頭刀(肉絲泥主食餐包)	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.64892	2026-03-10 08:36:24.881127	f
2159	2025-08-07	08:00:00	-	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	23.70	23.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.742606	2026-03-10 08:39:46.097023	f
2145	2025-08-05	14:55:00	-	Kibble	曙光	無穀雞肉貓餐食	❌ No, not interested	16.00	16.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.667294	2026-03-10 08:35:01.372509	f
2167	2025-08-08	13:58:00	00:16, 2:02, 4:24, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	29.00	💕 Love it So Much	51.00	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:07.787791	2026-03-10 08:41:21.84523	f
2144	2025-08-05	14:55:00	-	Freeze-Dried	可蒂毛毛	嘉義溫體火雞	💖 Yes, eat right away	4.80	0.00	💕 Love it So Much	4.80	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.664299	2026-03-10 08:34:53.329608	f
2143	2025-08-05	14:55:00	3:46, 7:08, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	26.20	21.10	🔺 So So	5.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.660623	2026-03-10 08:35:09.875708	f
2142	2025-08-05	07:10:00	16:58, 19:59, 20:22, 00:38, 3:47, 7:08, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	41.20	28.80	🔺 So So	12.40	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:07.658384	2026-03-10 08:35:51.674666	f
2151	2025-08-06	08:30:00	-	Kibble	法米納	天然頂級無穀系列 野豬蘋果	❌ No, not interested	50.90	50.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.696511	2026-03-10 08:37:05.301794	f
2149	2025-08-06	08:30:00	3:30, 7:35, 	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	💖 Yes, eat right away	57.00	20.30	🔺 So So	36.70	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:07.685403	2026-03-10 08:37:14.008907	f
2147	2025-08-06	01:40:00	10:38,	Wet	ciao	ic-359 法式濃湯系列餐包 雞肉+干貝	💖 Yes, eat right away	40.00	3.00	💕 Love it So Much	37.00	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:07.676576	2026-03-10 08:37:22.275071	f
2148	2025-08-06	02:40:00	-	Wet	ciao	ic-359 法式濃湯系列餐包 雞肉+干貝	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.680285	2026-03-10 08:37:31.751322	f
2146	2025-08-06	01:40:00	10:37, 13:53, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	24.20	15.80	🔺 So So	8.40	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.671303	2026-03-10 08:38:42.48075	f
2150	2025-08-06	07:52:00	17:48, 19:31, 22:00, 00:00, 3:27, 7:33, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	37.60	9.00	💕 Love it So Much	28.60	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:07.690432	2026-03-10 08:38:49.632253	f
2155	2025-08-07	08:00:00	-	Kibble	耐吉斯	p23 凍乾填心雞肉餐	❌ No, not interested	17.00	17.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.724521	2026-03-10 08:39:16.704772	f
2158	2025-08-07	08:00:00	21:52, 4:05, 	Wet	axia	金罐特選1號 鮪+雞+蟹棒	❌ No, not interested	70.00	46.60	🔺 So So	23.40	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.736238	2026-03-10 08:39:24.236436	f
2156	2025-08-07	08:00:00	-	Kibble	toma-pro 優格	吃貨拼盤 爐烤火鴨雞佐蘋果	❌ No, not interested	17.20	17.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.729506	2026-03-10 08:39:31.755874	f
2157	2025-08-07	08:00:00	-	Kibble	冠能	成貓 挑嘴貓鮮鮭雙口感配方	❌ No, not interested	18.60	18.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.734065	2026-03-10 08:39:38.56755	f
2153	2025-08-07	00:42:00	10:30, 12:42, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	11.70	🔺 So So	8.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.712675	2026-03-10 08:40:10.037319	f
2154	2025-08-07	00:42:00	-	Kibble	法米納	天然藜麥無穀機能系列 鴨肉蔓越莓 qc5	❌ No, not interested	18.20	18.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.718599	2026-03-10 08:40:18.51402	f
2152	2025-08-07	00:42:00	-	Wet	法麗	室內貓排毛 鮪魚佐鮭魚	🔺 No, not really. Ate A Little	80.00	53.70	❌ No!!!	26.30	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.70255	2026-03-10 08:40:27.158965	f
2169	2025-08-08	10:00:00	18:02, 20:39, 00:14, 1:59, 4:21, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.80	13.10	💕 Love it So Much	24.70	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:07.793443	2026-03-10 08:40:54.937958	f
2166	2025-08-08	10:00:00	-	Wet	nuevo 新歡	精選菲力貓罐系列 4號雞肉鮮湯凍	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.781558	2026-03-10 08:41:03.610101	f
2168	2025-08-08	10:00:00	-	Freeze-Dried	可蒂毛毛	凍乾探險隊 滋補嫩香鴨	💖 Yes, eat right away	3.40	0.00	💕 Love it So Much	3.40	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.790251	2026-03-10 08:41:12.753174	f
2165	2025-08-08	10:00:00	-	Wet	ciao	imc-223 果凍杯 鮪魚+雞肉+吻仔魚	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.778016	2026-03-10 08:41:30.21773	f
2162	2025-08-08	00:45:00	9:33, 13:38, 15:54, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.20	12.90	🔺 So So	7.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.766657	2026-03-10 08:41:40.349757	f
2164	2025-08-08	00:45:00	-	Wet	喵愛我	滋養肉汁 雞肉	❌ No, not interested	96.50	96.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.775542	2026-03-10 08:41:48.297071	f
2161	2025-08-08	00:45:00	-	Wet	tuna	愛貓天然食 雞肉+鮪魚	🔺 No, not really. Ate A Little	70.00	47.40	❌ No!!!	22.60	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.760071	2026-03-10 08:41:56.391242	f
2163	2025-08-08	00:45:00	-	Kibble	法米納	天然低gi系列 雞肉石榴	❌ No, not interested	50.60	50.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.769857	2026-03-10 08:42:07.67432	f
2173	2025-08-09	11:45:00	23:18, 1;12, 4:17, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	36.30	21.00	🔺 So So	15.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.808418	2026-03-10 08:42:59.774745	f
2172	2025-08-09	11:45:00	23:20, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	15.20	💕 Love it So Much	44.80	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.805842	2026-03-10 08:43:07.973374	f
2171	2025-08-09	00:36:00	10:45, 12:41, 15:14, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	13.50	🔺 So So	6.90	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.803532	2026-03-10 08:43:21.949276	f
2170	2025-08-09	00:36:00	13:40, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	23.40	🔺 So So	26.60	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.798564	2026-03-10 08:43:32.139735	f
2175	2025-08-10	01:00:00	10:05, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	24.30	20.30	🔺 So So	4.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:07.815355	2026-03-10 08:43:50.137435	f
2174	2025-08-10	01:00:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮 x2	💖 Yes, eat right away	70.00	29.30	❌ No!!!	40.70	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:07.812661	2026-03-10 08:44:03.19271	f
2176	2025-08-10	04:08:00	-	Kibble	曙光	無穀滋養鴨肉食譜	🔺 No, not really. Ate A Little	18.40	14.90	🔺 So So	3.50	0	🔺 - 🔺	18		\N	2	\N	2026-03-04 11:51:07.81929	2026-03-10 08:44:13.421647	f
2177	2025-08-10	07:30:00	-	Wet	ciao	ic-556 高湯鮮味餐包 鰹魚+鮪魚柴魚片+干貝高湯	💖 Yes, eat right away	30.00	10.00	❌ No!!!	20.00	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:07.822803	2026-03-10 08:44:28.310658	f
2207	2025-08-15	09:50:00	1:11, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	18.30	💕 Love it So Much	41.70	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.949228	2026-03-10 08:49:30.283513	f
2180	2025-08-10	07:30:00	20:32, 00:00, 3:43, 7:31, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	52.40	25.30	🔺 So So	27.10	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:07.836379	2026-03-10 08:44:20.538312	f
2179	2025-08-10	07:30:00	-	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	40.80	40.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.832378	2026-03-10 08:44:35.66234	f
2178	2025-08-10	07:30:00	-	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	33.10	❌ No!!!	46.90	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:07.827499	2026-03-10 08:44:43.085886	f
2181	2025-08-10	07:30:00	-	Kibble	法米納	天然頂級無穀系列 羊肉藍莓	❌ No, not interested	51.90	51.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.84058	2026-03-10 08:44:52.820372	f
2184	2025-08-11	08:35:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	5.30	❌ No!!!	29.70	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:07.854501	2026-03-10 08:45:18.703235	f
2187	2025-08-11	08:35:00	16:33, 19:17, 21:10, 22:37, 00:46, 4:39, 8:37, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.80	16.80	💕 Love it So Much	18.00	7	❌ - 💕	37		\N	2	\N	2026-03-04 11:51:07.865425	2026-03-10 08:45:26.225903	f
2186	2025-08-11	08:35:00	-	Kibble	希爾斯	乾 希爾斯 處方食品 貓用d/d 鴨肉及豌豆	❌ No, not interested	19.40	19.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:07.861871	2026-03-10 08:45:34.783915	f
2185	2025-08-11	13:15:00	4:39, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	45.50	🔺 So So	39.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.859589	2026-03-10 08:45:42.356957	f
2183	2025-08-11	01:00:00	9:59, 12:26, 13:54,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	17.20	9.30	🔺 So So	7.90	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.850375	2026-03-10 08:46:01.629891	f
2182	2025-08-11	01:00:00	-	Wet	mamamia	貓餐罐 鮮嫩純雞肉	🔺 No, not really. Ate A Little	85.00	64.80	❌ No!!!	20.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.847519	2026-03-10 08:46:09.257055	f
2190	2025-08-12	10:15:00	04:06,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	70.00	21.30	💕 Love it So Much	48.70	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.877678	2026-03-10 08:46:36.059946	f
2189	2025-08-12	00:40:00	12:13, 14:29, 17:19, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	16.00	6.00	🔺 So So	10.00	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.874451	2026-03-10 08:46:52.780373	f
2195	2025-08-13	11:20:00	23:08, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	🔺 No, not really. Ate A Little	80.00	33.50	🔺 So So	46.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:07.899666	2026-03-10 08:47:19.799544	f
2193	2025-08-13	00:45:00	9:14, 12:39, 19:21, 21:13, 23:06, 2:02, 7:07, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.30	6.20	💕 Love it So Much	14.10	7	❌ - 💕	37		\N	2	\N	2026-03-04 11:51:07.887767	2026-03-10 08:47:34.71976	f
2192	2025-08-13	00:45:00	-	Wet	nature 養生湯罐	白身鮪魚+蔬菜	🔺 No, not really. Ate A Little	80.00	48.80	❌ No!!!	31.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.885495	2026-03-10 08:47:42.918786	f
2194	2025-08-13	07:30:00	-	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝	💖 Yes, eat right away	30.00	5.90	❌ No!!!	24.10	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:07.891644	2026-03-10 08:47:57.55518	f
2196	2025-08-13	07:30:00	16:30, 19:21, 21:15, 23:07, 00:15, 2:04, 4:18, 7:06, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	27.90	3.80	💕 Love it So Much	24.10	8	❌ - 💕	46		\N	2	\N	2026-03-04 11:51:07.903447	2026-03-10 08:48:05.398253	f
2198	2025-08-14	01:23:00	14:23, 17:33, 19:29, 00:06, 3:21, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.50	16.80	🔺 So So	23.70	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:07.914481	2026-03-10 08:48:30.54954	f
2197	2025-08-14	01:23:00	-	Wet	惜時	bistro cat 特級銀貓健康餐罐 鮮嫩雞肉	🔺 No, not really. Ate A Little	80.00	75.30	❌ No!!!	4.70	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.909626	2026-03-10 08:48:38.344737	f
2199	2025-08-14	02:41:00	23:00, 00:08,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	31.70	21.20	🔺 So So	10.50	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.91957	2026-03-10 08:48:46.606106	f
2201	2025-08-14	06:35:00	00:09,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	💖 Yes, eat right away	85.00	36.60	🔺 So So	48.40	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:07.925863	2026-03-10 08:48:55.612462	f
2200	2025-08-14	06:35:00	-	Wet	ciao	imc-224 雙喵杯 鮪魚+雞肉+柴魚片	💖 Yes, eat right away	35.00	6.40	❌ No!!!	28.60	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:07.923459	2026-03-10 08:49:03.049285	f
2202	2025-08-14	06:35:00	-	Freeze-Dried	可蒂毛毛	嘉義溫體火雞	💖 Yes, eat right away	3.30	0.80	💕 Love it So Much	2.50	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.929548	2026-03-10 08:49:09.975218	f
2208	2025-08-15	09:50:00	19:37, 20:56, 22:02, 1:08, 4:10, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	39.90	11.60	💕 Love it So Much	28.30	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:07.953527	2026-03-10 08:49:37.987029	f
2203	2025-08-15	01:53:00	-	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	🔺 No, not really. Ate A Little	57.00	37.60	❌ No!!!	19.40	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.933953	2026-03-10 08:49:52.150019	f
2205	2025-08-15	01:53:00	-	Kibble	璞斯	無穀營養雞肉配方	🔺 No, not really. Ate A Little	21.30	14.50	❌ No!!!	6.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.942562	2026-03-10 08:50:00.767672	f
2204	2025-08-15	01:53:00	11:13, 12:23, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.30	14.70	🔺 So So	5.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.939556	2026-03-10 08:50:10.669337	f
2206	2025-08-15	07:30:00	-	Wet	貓姬	成貓肉泥杯 雞肉+鮪魚+鰹魚片 cp-806	🔺 No, not really. Ate A Little	60.00	42.70	❌ No!!!	17.30	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.947138	2026-03-10 08:50:50.685325	f
2212	2025-08-16	11:40:00	23:41, 3:48, 7:52, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.60	21.30	🔺 So So	19.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:07.973471	2026-03-10 08:51:24.346751	f
2211	2025-08-16	11:40:00	19:58, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	19.60	💕 Love it So Much	30.40	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.969137	2026-03-10 08:51:31.084618	f
2210	2025-08-16	01:14:00	13:28, 15:48,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.60	15.80	🔺 So So	4.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.963681	2026-03-10 08:51:38.368475	f
2209	2025-08-16	01:14:00	-	Wet	ciao	多樂米濃湯罐 a-45 (雞肉+鰹魚+吻仔魚)	🔺 No, not really. Ate A Little	80.00	43.20	❌ No!!!	36.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:07.96024	2026-03-10 08:51:46.17646	f
2213	2025-08-17	01:00:00	10:15, 	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝	💖 Yes, eat right away	30.00	5.70	💕 Love it So Much	24.30	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:07.981638	2026-03-10 08:52:37.838493	f
2225	2025-08-19	01:36:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  雞柳海鮮	💖 Yes, eat right away	35.00	12.80	❌ No!!!	22.20	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:08.050384	2026-03-10 08:55:44.376883	f
2214	2025-08-17	01:00:00	14:16,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	24.00	20.90	🔺 So So	3.10	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:07.985544	2026-03-10 08:52:19.535119	f
2215	2025-08-17	01:00:00	10:15, 12:06,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	22.10	18.00	🔺 So So	4.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.995636	2026-03-10 08:52:26.591075	f
2218	2025-08-17	06:25:00	16:21, 17:27, 20:27, 21:34, 22:56, 00:17, 2:19, 4:00, 8:18,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	38.20	6.20	💕 Love it So Much	32.00	9	❌ - 💕	48		\N	2	\N	2026-03-04 11:51:08.01318	2026-03-10 08:52:45.072205	f
2216	2025-08-17	06:25:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g	💖 Yes, eat right away	20.00	0.00	💕 Love it So Much	20.00	0	💖 - 💕	40	一下子就吃完	\N	2	\N	2026-03-04 11:51:08.003399	2026-03-10 08:52:53.321521	f
2220	2025-08-18	01:30:00	12:12, 16:46, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.20	18.10	🔺 So So	2.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:08.021692	2026-03-10 08:54:07.928986	f
2224	2025-08-18	12:00:00	21:12, 22:39, 3:42, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	38.50	20.40	🔺 So So	18.10	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:08.046662	2026-03-10 08:53:32.313287	f
2223	2025-08-18	12:00:00	-	Kibble	go	低致敏鴨肉	❌ No, not interested	20.30	20.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.042265	2026-03-10 08:53:40.125775	f
2222	2025-08-18	12:00:00	-	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	🔺 No, not really. Ate A Little	80.00	39.70	❌ No!!!	40.30	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.039406	2026-03-10 08:53:48.185384	f
2221	2025-08-18	09:25:00	-	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	21.60	❌ No!!!	38.40	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:08.029987	2026-03-10 08:54:00.259603	f
2219	2025-08-18	01:30:00	-	Wet	ciao	ic-552 高湯鮮味餐包 雞肉+鰹魚柴魚片+鮪魚高湯	💖 Yes, eat right away	30.00	5.80	❌ No!!!	24.20	0	💖 - ❌	25	3:42 吃完乾乾馬上吐	\N	2	\N	2026-03-04 11:51:08.016443	2026-03-10 08:54:15.081064	f
2229	2025-08-19	10:10:00	18:46, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	5.70	💕 Love it So Much	29.30	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:08.076807	2026-03-10 08:54:48.14103	f
2232	2025-08-19	10:10:00	18:45, 20:10, 23:54, 1:38, 4:27, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.70	23.20	🔺 So So	17.50	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:08.109763	2026-03-10 08:54:56.630212	f
2231	2025-08-19	13:15:00	1:41, 5:09, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	🔺 No, not really. Ate A Little	85.00	43.60	🔺 So So	41.40	2	🔺 - 🔺	22		\N	2	\N	2026-03-04 11:51:08.093766	2026-03-10 08:55:12.19111	f
2228	2025-08-19	01:36:00	11:11, 16:16,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.00	18.20	🔺 So So	2.80	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:08.06957	2026-03-10 08:55:19.216756	f
2227	2025-08-19	01:36:00	-	Kibble	希爾斯	完美體重 機肉特調食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.065779	2026-03-10 08:55:27.214554	f
2226	2025-08-19	01:36:00	-	Wet	冠能	成貓 挑嘴貓潤毛鮭魚主食餐包	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.053077	2026-03-10 08:55:34.496578	f
2236	2025-08-20	08:15:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	🔺 No, not really. Ate A Little	60.00	33.40	❌ No!!!	26.60	0	🔺 - ❌	13	一直叫, 倒掉開新罐頭	\N	2	\N	2026-03-04 11:51:08.126309	2026-03-10 08:56:09.238845	f
2238	2025-08-20	08:15:00	17:27, 19:59, 23:26, 00:45, 7:52, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	39.70	16.10	🔺 So So	23.60	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:08.132769	2026-03-10 08:56:17.176762	f
2233	2025-08-20	01:05:00	10:23, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	1.30	💕 Love it So Much	28.70	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:08.113391	2026-03-10 08:56:40.924426	f
2234	2025-08-20	01:05:00	10:08, 15:24, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	18.30	🔺 So So	1.70	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:08.120664	2026-03-10 08:56:48.590391	f
2235	2025-08-20	07:40:00	-	Wet	ciao	tcr-203 貓用濃湯餐包 - 鰹魚+鮪魚+三種鮮味	🔺 No, not really. Ate A Little	40.00	33.70	❌ No!!!	6.30	0	🔺 - ❌	13	一直叫, 倒掉開新罐頭	\N	2	\N	2026-03-04 11:51:08.123215	2026-03-10 08:56:55.745134	f
2242	2025-08-21	12:50:00	23:46, 00:42, 8:37, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	17.80	💕 Love it So Much	47.20	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:08.148548	2026-03-10 08:57:25.654382	f
2244	2025-08-21	07:00:00	15:52, 18:31, 20:10, 20:42, 23:44, 3:04,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.50	22.50	🔺 So So	15.00	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:08.158685	2026-03-10 08:57:33.030568	f
2241	2025-08-21	07:00:00	-	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 	💖 Yes, eat right away	30.00	2.30	❌ No!!!	27.70	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:08.1438	2026-03-10 08:57:40.693974	f
2243	2025-08-21	07:00:00	00:39, 3:06, 8:36, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	21.10	10.90	🔺 So So	10.20	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:08.153505	2026-03-10 08:57:48.793566	f
2239	2025-08-21	01:09:00	-	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	🔺 No, not really. Ate A Little	70.00	34.80	❌ No!!!	35.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.136621	2026-03-10 08:57:56.994382	f
2240	2025-08-21	01:09:00	10:15, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.50	17.50	🔺 So So	3.00	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:08.141458	2026-03-10 08:58:08.796476	f
2245	2025-08-22	00:45:00	-	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	🔺 No, not really. Ate A Little	60.00	36.70	❌ No!!!	23.30	0	🔺 - ❌	13		6.30	2	\N	2026-03-04 11:51:08.161209	2026-03-10 08:59:07.530412	f
2246	2025-08-22	00:45:00	11:43, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	23.70	21.30	🔺 So So	2.40	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:08.165026	2026-03-10 08:59:15.399257	f
2248	2025-08-22	07:10:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	🔺 No, not really. Ate A Little	75.00	42.60	🔺 So So	32.40	0	🔺 - 🔺	18		\N	2	\N	2026-03-04 11:51:08.174665	2026-03-10 08:59:25.708338	f
2247	2025-08-22	07:10:00	-	Wet	葛雷特	舒卡貓湯罐系列 4號 雞肉&鮪魚	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	完全不吃, 倒掉/改放ciao a-231	\N	2	\N	2026-03-04 11:51:08.170648	2026-03-10 08:59:32.745674	f
2251	2025-08-22	12:05:00	23:00, 2:52, 7:39, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	45.10	32.70	🔺 So So	12.40	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:08.186286	2026-03-10 08:58:59.978957	f
2250	2025-08-22	07:10:00	16:55, 18:04, 22:15, 22:58, 2:55, 7:40, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.80	18.30	🔺 So So	16.50	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:08.183783	2026-03-10 08:59:41.829918	f
2256	2025-08-23	11:30:00	23:47, 4:03, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	25.90	💕 Love it So Much	54.10	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:08.207751	2026-03-10 09:00:23.31774	f
2254	2025-08-23	01:22:00	15:30, 20:01, 21:24, 23:45, 00:42, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	25.90	10.80	💕 Love it So Much	15.10	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:08.197571	2026-03-10 09:00:31.891053	f
2253	2025-08-23	01:22:00	16:37, 21:22, 4:01,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.30	7.50	🔺 So So	13.80	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:08.193992	2026-03-10 09:00:39.094014	f
2252	2025-08-23	01:22:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	5.20	❌ No!!!	29.80	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:08.191494	2026-03-10 09:00:48.289452	f
2255	2025-08-23	07:40:00	16:39,	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	30.00	4.70	💕 Love it So Much	25.30	1	💖 - 💕	42		\N	2	\N	2026-03-04 11:51:08.202523	2026-03-10 09:01:02.624344	f
2261	2025-08-24	13:00:00	00:00, 2:52, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	28.70	💕 Love it So Much	51.30	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:08.225614	2026-03-10 09:01:17.279276	f
2258	2025-08-24	01:05:00	10:00, 14:11, 23:59, 8:37, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	19.80	6.20	🔺 So So	13.60	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:08.213385	2026-03-10 09:01:25.393641	f
2257	2025-08-24	01:05:00	-	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝 x2	🔺 No, not really. Ate A Little	60.00	38.90	❌ No!!!	21.10	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.210063	2026-03-10 09:01:33.374571	f
2259	2025-08-24	01:05:00	18:24, 19:52, 22:02, 2:49, 6:57, 8:38, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	30.00	10.90	💕 Love it So Much	19.10	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:08.21845	2026-03-10 09:01:40.212622	f
2260	2025-08-24	07:15:00	18:27, 	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	💖 Yes, eat right away	60.00	25.00	🔺 So So	35.00	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:08.220993	2026-03-10 09:01:47.236492	f
2266	2025-08-25	12:50:00	4:38, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	34.40	🔺 So So	45.60	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:08.248164	2026-03-10 09:02:08.991044	f
2262	2025-08-25	01:00:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	30.00	❌ No!!!	30.00	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:08.229753	2026-03-10 09:02:17.187176	f
2263	2025-08-25	01:00:00	10:23, 15:50, 23:47, 4:36, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	7.10	🔺 So So	12.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:08.23575	2026-03-10 09:02:23.798563	f
2264	2025-08-25	01:00:00	20:46, 2:49,	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	37.40	27.40	🔺 So So	10.00	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:08.24044	2026-03-10 09:02:32.851123	f
2265	2025-08-25	07:25:00	-	Wet	ciao	布丁杯 鰹魚 imc-152	🔺 No, not really. Ate A Little	65.00	38.20	❌ No!!!	26.80	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.245353	2026-03-10 09:02:47.972356	f
2270	2025-08-26	07:05:00	-	Wet	貓爪村	舒壓罐 貓薄荷鮪魚雞 肉絲	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙的動作出現	\N	2	\N	2026-03-04 11:51:08.267693	2026-03-10 09:03:19.690554	f
2272	2025-08-26	07:05:00	-	Wet	ciao	tsc-119 啾嚕奢華果凍杯  鮪魚海鮮	💖 Yes, eat right away	35.00	10.00	❌ No!!!	25.00	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:08.279621	2026-03-10 09:03:26.854187	f
2271	2025-08-26	07:05:00	-	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	❌ No, not interested	75.00	75.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.272244	2026-03-10 09:03:34.950714	f
2268	2025-08-26	00:50:00	9:20, 18:08, 00:00, 4:04, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.50	14.30	🔺 So So	11.20	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:08.257155	2026-03-10 09:03:59.759562	f
2269	2025-08-26	00:50:00	23:57, 00:39, 2:49, 4:03,	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	24.10	10.20	🔺 So So	13.90	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:08.25975	2026-03-10 09:04:07.575665	f
2281	2025-08-27	11:50:00	23:30, 4:47,	Wet	ciao	ic-137 貓用六種機能湯餐包 - 雞肉+扇貝 x3	🔺 No, not really. Ate A Little	90.00	63.60	🔺 So So	26.40	2	🔺 - 🔺	22		\N	2	\N	2026-03-04 11:51:08.354595	2026-03-10 09:04:32.835915	f
2275	2025-08-27	01:00:00	11:04, 17:07, 19:50, 1:27, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	6.40	🔺 So So	14.00	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:08.311815	2026-03-10 09:04:41.147025	f
2274	2025-08-27	01:00:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	🔺 No, not really. Ate A Little	60.00	30.30	❌ No!!!	29.70	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.308146	2026-03-10 09:04:53.367561	f
2278	2025-08-27	01:00:00	-	Kibble	貪貪	蜂之糧 櫻桃鴨烏魚	❌ No, not interested	43.90	43.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.332891	2026-03-10 09:05:00.799797	f
2276	2025-08-27	01:00:00	23:29, 1:28, 4:44, 6:55,	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	29.20	18.10	🔺 So So	11.10	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:08.316834	2026-03-10 09:05:17.870517	f
2279	2025-08-27	07:20:00	-	Wet	ciao	綜合營養食罐 乳酸菌系列 - a-254 (鮪魚+雞肉+蟹肉)	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.340208	2026-03-10 09:05:24.437293	f
2280	2025-08-27	07:20:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	8.20	❌ No!!!	31.80	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:08.347561	2026-03-10 09:05:31.054056	f
2285	2025-08-28	11:50:00	1:03, 4:35, 	Wet	ciao	近海鰹魚罐93號 (干貝味) 	🔺 No, not really. Ate A Little	80.00	39.10	🔺 So So	40.90	2	🔺 - 🔺	22		\N	2	\N	2026-03-04 11:51:08.38408	2026-03-10 09:06:17.8197	f
2283	2025-08-28	00:55:00	10:00, 11:17,  	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.30	17.30	🔺 So So	4.00	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:08.36888	2026-03-10 09:06:54.974073	f
2282	2025-08-28	00:55:00	-	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	🔺 No, not really. Ate A Little	65.00	37.40	❌ No!!!	27.60	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.362387	2026-03-10 09:07:02.486464	f
2284	2025-08-28	06:55:00	-	Wet	axia	金罐9號高湯 - 雞肉	🔺 No, not really. Ate A Little	70.00	54.80	❌ No!!!	15.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.37409	2026-03-10 09:07:17.321161	f
2267	2025-08-26	00:50:00	-	Wet	ciao	ic-433 乳酸菌餐包 雞肉+干貝	💖 Yes, eat right away	40.00	7.90	❌ No!!!	32.10	0	💖 - ❌	25	00:02 吐, 吐出乾乾及凍乾	\N	2	\N	2026-03-04 11:51:08.252528	2026-03-13 13:15:42.277314	f
2359	2026-03-06	12:42:00	21:50, 8:59, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	16.70	🔺 So So	3.70	2	❌ - 🔺	17		\N	2	\N	2026-03-06 12:42:54.340251	2026-03-07 01:17:28.694669	f
2364	2026-03-07	01:23:00	10:11, 16:54, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	17.70	🔺 So So	2.30	2	❌ - 🔺	17		\N	2	\N	2026-03-07 01:23:51.844227	2026-03-07 12:41:32.839658	f
2360	2026-03-06	12:45:00	3:03, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.00	17.10	🔺 So So	2.90	1	❌ - 🔺	15		\N	2	\N	2026-03-06 12:46:09.028964	2026-03-07 01:18:26.922523	f
2288	2025-08-28	11:50:00	4:34, 	Kibble	安柏希雅	鴨肉&火雞肉	❌ No, not interested	14.10	10.80	🔺 So So	3.30	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:08.404149	2026-03-10 09:06:25.492204	f
2342	2026-03-05	01:12:00	12:02, 13:48, 17:18, 19:47, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	17.50	🔺 So So	7.90	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-03-05 11:40:23.992387	2026-03-05 12:02:34.357058	f
2303	2025-08-31	07:15:00	-	Wet	惜時	bristo cat 特級銀貓健康餐罐 白身鮪魚+雞肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.479534	2026-03-10 09:11:26.342633	f
2343	2026-03-05	12:00:00	20:50, 21:38, 23:40, 2:28, 5:01, 6:48, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.30	11.20	🔺 So So	9.10	6	❌ - 🔺	25		\N	2	\N	2026-03-05 12:01:50.822682	2026-03-06 02:51:45.033037	f
2345	2026-03-05	12:06:00	2:27,	Freeze-Dried	索美達	凍乾生食貓貓餐 - 紐西蘭北島放牧雞	❌ No, not interested	10.00	9.80	🔺 So So	0.20	1	❌ - 🔺	15		\N	2	\N	2026-03-05 12:06:19.3882	2026-03-06 02:52:48.110345	f
2287	2025-08-28	11:50:00	16:09, 19:20, 22:10, 23:09, 1:00, 2:31, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.30	16.70	💕 Love it So Much	20.60	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:08.399438	2026-03-10 09:06:34.320745	f
2367	2026-03-07	12:35:00	21:41, 22:45, 00:32, 1:43, 03:29, 7:54,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	23.80	💕 Love it So Much	81.20	6	💖 - 💕	52		\N	2	\N	2026-03-07 12:40:28.131402	2026-03-08 02:22:33.891969	f
2365	2026-03-07	01:25:00	17:55, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	5.90	🔺 So So	4.30	1	❌ - 🔺	15		\N	2	\N	2026-03-07 01:25:21.515048	2026-03-07 12:46:49.755546	f
2292	2025-08-29	10:30:00	22:56, 1:19, 6:44, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	38.30	🔺 So So	46.70	3	💖 - 🔺	29		\N	2	\N	2026-03-04 11:51:08.426573	2026-03-10 09:07:51.208208	f
2374	2026-03-08	02:33:00	11:14, 15:57, 	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	🔺 No, not really. Ate A Little	65.00	36.80	🔺 So So	28.20	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 02:33:32.937547	2026-03-08 12:24:57.195198	f
2375	2026-03-08	02:33:00	11:16, 14:16, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	20.80	🔺 So So	39.20	2	💖 - 🔺	27		\N	2	\N	2026-03-08 02:34:03.126007	2026-03-08 12:25:46.446465	f
2358	2026-03-06	12:40:00	00:32, 1:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	16.20	🔺 So So	8.90	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.1g	\N	2	\N	2026-03-06 12:40:41.11403	2026-03-07 01:18:03.202498	f
2293	2025-08-29	07:10:00	17:05, 19:45, 21:07, 22:54, 1:17, 4:15, 6:41, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	33.60	6.90	💕 Love it So Much	26.70	7	❌ - 💕	44		\N	2	\N	2026-03-04 11:51:08.431002	2026-03-10 09:08:00.092394	f
2291	2025-08-29	07:10:00	-	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 	💖 Yes, eat right away	30.00	3.50	❌ No!!!	26.50	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:08.423381	2026-03-10 09:08:08.943822	f
2290	2025-08-29	23:08:00	7:44, 9:41, 12:31, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.50	12.80	🔺 So So	7.70	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:08.418656	2026-03-10 09:08:39.84491	f
2289	2025-08-29	23:08:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	5.10	❌ No!!!	29.90	0	💖 - ❌	25		\N	2	\N	2026-03-04 11:51:08.409785	2026-03-10 09:08:48.940237	f
2302	2025-08-31	00:50:00	16:57, 18:15, 21:17, 00:30, 4:08, 6:49, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	27.50	9.70	💕 Love it So Much	17.80	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:08.474433	2026-03-10 09:11:03.520843	f
2295	2025-08-30	01:10:00	-	Kibble	曙光	無穀滋養鴨肉食譜	🔺 No, not really. Ate A Little	20.80	14.50	❌ No!!!	6.30	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.438448	2026-03-10 09:09:40.033203	f
2294	2025-08-30	01:10:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-95 鰹魚	💖 Yes, eat right away	60.00	32.10	❌ No!!!	27.90	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:08.434065	2026-03-10 09:09:47.787771	f
2296	2025-08-30	06:35:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	🔺 No, not really. Ate A Little	75.00	56.80	❌ No!!!	18.20	0	🔺 - ❌	13		\N	2	\N	2026-03-04 11:51:08.443672	2026-03-10 09:09:55.450057	f
2297	2025-08-30	06:35:00	00:34, 5:01, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	32.70	🔺 So So	47.30	2	💖 - 🔺	27		\N	2	\N	2026-03-04 11:51:08.446178	2026-03-10 09:10:10.523204	f
2299	2025-08-30	06:35:00	14:38, 15:34, 16:53, 21:12, 22:39, 00:32, 2:49, 5:01, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.50	18.30	🔺 So So	16.20	8	❌ - 🔺	29		\N	2	\N	2026-03-04 11:51:08.462901	2026-03-10 09:10:17.932402	f
2298	2025-08-30	11:59:00	4:59, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	💖 Yes, eat right away	15.90	8.30	🔺 So So	7.60	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:08.452677	2026-03-10 09:10:39.453388	f
2300	2025-08-31	00:50:00	-	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	30.00	❌ No!!!	30.00	0	💖 - ❌	18		\N	2	\N	2026-03-04 11:51:08.466988	2026-03-10 09:11:10.88768	f
2301	2025-08-31	00:50:00	18:14, 00:29, 4:06, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	22.10	10.80	🔺 So So	11.30	3	❌ - 🔺	19		\N	2	\N	2026-03-04 11:51:08.4705	2026-03-10 09:11:18.970951	f
2304	2025-08-31	07:15:00	20:00,	Wet	cat-pool	美味雞肉煲	💖 Yes, eat right away	85.00	35.10	🔺 So So	49.90	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:08.489627	2026-03-10 09:11:35.029071	f
2305	2025-08-31	07:15:00	4:08, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	❌ No, not interested	80.00	47.40	🔺 So So	32.60	1	❌ - 🔺	15		\N	2	\N	2026-03-04 11:51:08.494075	2026-03-10 09:12:04.889645	f
2376	2026-03-08	02:40:00	15:55, 18:46, 20:10, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	12.80	🔺 So So	12.40	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-03-08 02:40:15.091628	2026-03-08 12:19:44.062755	f
2382	2026-03-08	12:22:00	21:04, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.50	23.40	🔺 So So	2.10	1	❌ - 🔺	15	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-03-08 12:22:21.000944	2026-03-09 01:19:43.22992	f
2408	2025-09-04	07:20:00	-	Wet	nature 養生湯罐	優選雞肉	💖 Yes, eat right away	80.00	47.50	❌ No!!!	32.50	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.251403	2026-03-10 09:29:39.219529	f
2413	2025-09-05	01:50:00	18:04, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.80	18.80	🔺 So So	2.00	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.265272	2026-03-10 09:31:00.945669	f
2414	2025-09-05	01:50:00	10:23, 12:27, 18:03, 22:21, 23:43, 3:49, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	16.00	1.00	💕 Love it So Much	15.00	6	❌ - 💕	42		\N	2	\N	2026-03-08 13:51:57.267509	2026-03-10 09:31:15.392105	f
2385	2025-09-01	01:19:00	13:07, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.20	20.40	🔺 So So	4.80	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.190397	2026-03-10 09:13:29.624182	f
2395	2025-09-02	11:45:00	23:33, 7:41, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	9.30	🔺 So So	10.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.225996	2026-03-10 09:15:46.543395	f
2405	2025-09-04	01:10:00	-	Wet	ciao	多樂米濃湯罐 a-57 泌尿保健 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	51.40	❌ No!!!	28.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.245111	2026-03-10 09:30:06.180556	f
2410	2025-09-04	07:20:00	15:32, 17:08, 23:05, 1:40, 3:27, 6:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	36.90	5.80	💕 Love it So Much	31.10	6	❌ - 💕	42		\N	2	\N	2026-03-08 13:51:57.257852	2026-03-10 09:29:31.292334	f
2388	2025-09-01	12:05:00	22:29, 00:55, 7:51, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	13.50	💕 Love it So Much	46.50	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:57.206801	2026-03-10 09:12:40.405474	f
2390	2025-09-01	12:05:00	22:28, 00:54, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	14.90	8.60	🔺 So So	6.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.212693	2026-03-10 09:13:19.621001	f
2384	2025-09-01	01:19:00	-	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	30.80	❌ No!!!	34.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.145387	2026-03-10 09:13:37.840706	f
2386	2025-09-01	07:15:00	-	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	🔺 No, not really. Ate A Little	70.00	45.30	❌ No!!!	24.70	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.195439	2026-03-10 09:15:05.576244	f
2389	2025-09-01	07:15:00	17:21, 19:16, 22:28, 7:49, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	30.40	17.10	🔺 So So	13.30	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.210138	2026-03-10 09:15:14.404136	f
2387	2025-09-01	07:15:00	-	Wet	原點	鴨肉鮮食貓餐包	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.198215	2026-03-10 09:15:22.717831	f
2391	2025-09-02	01:30:00	-	Wet	ciao	ic-414 貓用魚三味餐包 銀魚+雞肉	💖 Yes, eat right away	60.00	43.30	❌ No!!!	16.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.214983	2026-03-10 09:16:03.079099	f
2392	2025-09-02	01:30:00	10:09, 16:46, 20:35, 4:14, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	26.70	15.20	🔺 So So	11.50	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.218043	2026-03-10 09:16:10.744463	f
2393	2025-09-02	07:20:00	-	Wet	ciao	法式濃湯系列餐包 ic-359 雞肉+干貝	💖 Yes, eat right away	40.00	13.80	❌ No!!!	26.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.221599	2026-03-10 09:16:27.278619	f
2401	2025-09-03	10:50:00	00:16, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	0.00	💕 Love it So Much	80.00	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:57.238188	2026-03-10 09:16:42.079507	f
2398	2025-09-03	07:30:00	-	Wet	mamamia 貓餐罐	雞肉+白身鮪魚+蝦肉	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	撥沙	\N	2	\N	2026-03-08 13:51:57.231926	2026-03-10 09:16:50.000561	f
2402	2025-09-03	07:30:00	18:22, 00:14, 6:12, 7:30, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	31.50	21.20	🔺 So So	10.30	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.239808	2026-03-10 09:16:56.965122	f
2400	2025-09-03	07:30:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	🔺 No, not really. Ate A Little	60.00	46.20	❌ No!!!	13.80	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.236033	2026-03-10 09:17:04.182461	f
2397	2025-09-03	01:00:00	9:49, 11:17, 21:43, 3:13, 6:11, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	17.10	6.20	💕 Love it So Much	10.90	5	❌ - 💕	33		\N	2	\N	2026-03-08 13:51:57.229984	2026-03-10 09:17:11.622291	f
2403	2025-09-03	19:25:00	7:31	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片	💖 Yes, eat right away	30.00	19.10	🔺 So So	10.90	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.241436	2026-03-10 09:17:23.471453	f
2396	2025-09-03	01:00:00	9:51, 	Wet	ciao	ic-433 乳酸菌餐包 雞肉+干貝	💖 Yes, eat right away	40.00	7.00	💕 Love it So Much	33.00	1	💖 - 💕	42	3:25 吐	\N	2	\N	2026-03-08 13:51:57.228137	2026-03-10 09:17:39.395856	f
2399	2025-09-03	07:30:00	-	Wet	axia	金罐特選4號 鮪+雞+扇貝	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	撥沙	\N	2	\N	2026-03-08 13:51:57.23412	2026-03-10 09:18:03.723376	f
2409	2025-09-04	07:20:00	17:09, 21:37,	Freeze-Dried	可蒂毛毛	嘉義溫體火雞	❌ No, not interested	4.20	2.40	🔺 So So	1.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.253499	2026-03-10 09:29:23.81174	f
2407	2025-09-04	01:10:00	10:05, 21:37, 9:17, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.70	9.50	🔺 So So	11.20	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.249685	2026-03-10 09:29:48.405414	f
2406	2025-09-04	01:10:00	-	Kibble	原點	皇極鮮肉 鮮雞成貓配方	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.247118	2026-03-10 09:29:57.755531	f
2404	2025-09-04	01:10:00	-	Wet	凱茲	n413 嫩燉菲力 菲力雞肉+鮪魚主食餐盒	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.243103	2026-03-10 09:30:14.931023	f
2411	2025-09-04	11:15:00	23:06, 3:28, 9:19 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	❌ No, not interested	80.00	28.20	💕 Love it So Much	51.80	3	❌ - 💕	29		\N	2	\N	2026-03-08 13:51:57.260122	2026-03-10 09:30:22.905374	f
2418	2025-09-05	10:55:00	22:21, 23:45, 00:48, 3:52, 8:37, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	34.00	5.20	💕 Love it So Much	28.80	5	❌ - 💕	40		\N	2	\N	2026-03-08 13:51:57.276942	2026-03-10 09:30:43.467262	f
2415	2025-09-05	01:50:00	11:22, 	Freeze-Dried	誠實貓	誠實貓 鴨柳	💖 Yes, eat right away	8.50	0.00	💕 Love it So Much	8.50	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:57.269525	2026-03-10 09:31:24.535316	f
2412	2025-09-05	01:50:00	12:29, 	Wet	ciao	高湯鮮味餐包 ic-551 鮪魚+吻仔魚+鮪魚高湯	💖 Yes, eat right away	30.00	2.10	💕 Love it So Much	27.90	1	💖 - 💕	42		6.30	2	\N	2026-03-08 13:51:57.262601	2026-03-10 09:31:32.726809	f
2419	2025-09-06	01:30:00	10:55, 	Wet	ciao	原湯杯53號 (雞肉+蟹肉棒+柴魚片)	💖 Yes, eat right away	60.00	19.30	💕 Love it So Much	40.70	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:57.278625	2026-03-10 09:32:11.219591	f
2449	2025-09-10	02:02:00	21:05, 00:22, 1:17, 5:26, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.20	5.80	🔺 So So	15.40	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.362434	2026-03-10 09:39:32.958367	f
2444	2025-09-09	05:30:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g	💖 Yes, eat right away	20.00	0.00	❌ No!!!	20.00	0	💖 - ❌	25	全部吃完	\N	2	\N	2026-03-08 13:51:57.341115	2026-03-10 09:38:16.477506	f
2422	2025-09-06	01:30:00	10:50, 	Freeze-Dried	誠實貓	鴨柳	❌ No, not interested	8.00	0.00	💕 Love it So Much	8.00	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:57.285462	2026-03-10 09:33:01.639133	f
2431	2025-09-07	12:55:00	2:52, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	17.90	💕 Love it So Much	42.10	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:57.305914	2026-03-10 09:34:39.411096	f
2455	2025-09-11	01:00:00	13:59, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.30	20.20	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.392894	2026-03-10 09:40:39.091554	f
2420	2025-09-06	01:30:00	16:23, 00:20, 1:36, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.30	11.10	🔺 So So	9.20	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.280746	2026-03-10 09:32:29.510715	f
2425	2025-09-06	11:30:00	20:56, 23:09, 00:21, 1:37, 4:12, 8:36,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.80	5.70	💕 Love it So Much	16.10	6	❌ - 💕	35		\N	2	\N	2026-03-08 13:51:57.291958	2026-03-10 09:32:18.9909	f
2424	2025-09-06	11:30:00	23:09, 1:37,	Wet	ciao 	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	22.00	💕 Love it So Much	58.00	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:57.289577	2026-03-10 09:32:36.972128	f
2426	2025-09-06	11:30:00	-	Freeze-Dried	誠實貓	雞塊	💖 Yes, eat right away	3.10	0.00	❌ No!!!	3.10	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.293904	2026-03-10 09:32:46.949939	f
2421	2025-09-06	01:30:00	19:26, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	15.60	6.20	🔺 So So	9.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.283725	2026-03-10 09:32:54.368227	f
2423	2025-09-06	07:10:00	19:27,	Wet	ciao	布丁杯 鮪魚 imc-151	💖 Yes, eat right away	65.00	33.00	🔺 So So	32.00	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.287765	2026-03-10 09:33:14.585517	f
2430	2025-09-07	07:30:00	-	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	💖 Yes, eat right away	50.00	38.30	❌ No!!!	11.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.303651	2026-03-10 09:33:52.268836	f
2432	2025-09-07	07:30:00	17:27, 18:45, 20:54, 23:00, 1:26, 2;49, 6:11, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	34.50	4.80	💕 Love it So Much	29.70	7	❌ - 💕	44		\N	2	\N	2026-03-08 13:51:57.307549	2026-03-10 09:33:59.178582	f
2427	2025-09-07	01:05:00	-	Wet	hello fresh	好鮮原汁湯罐 清蒸雞肉	💖 Yes, eat right away	50.00	21.50	❌ No!!!	28.50	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.295732	2026-03-10 09:34:08.783687	f
2429	2025-09-07	01:05:00	10:00, 12:06, 14:54,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	31.80	14.50	🔺 So So	17.30	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.301239	2026-03-10 09:34:17.508471	f
2428	2025-09-07	01:05:00	6:12, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.50	14.90	🔺 So So	5.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.297732	2026-03-10 09:34:25.389599	f
2438	2025-09-08	08:00:00	17:25, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	20.20	13.50	🔺 So So	6.70	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.329412	2026-03-10 09:35:10.783966	f
2437	2025-09-08	07:30:00	15:59, 21:55, 23:34, 1:13, 3:37, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	45.10	19.00	🔺 So So	26.10	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:57.324281	2026-03-10 09:35:26.923063	f
2434	2025-09-08	01:15:00	11:04, 11:56, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	21.40	15.10	🔺 So So	6.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.31387	2026-03-10 09:35:34.498692	f
2433	2025-09-08	01:15:00	-	Wet	cat-pool	海鮮盛宴	💖 Yes, eat right away	85.00	52.00	❌ No!!!	33.00	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.310562	2026-03-10 09:35:43.767228	f
2439	2025-09-08	14:20:00	-	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	23.30	23.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.331128	2026-03-10 09:36:03.657403	f
2436	2025-09-08	12:36:00	21:57, 1:15, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	20.20	💕 Love it So Much	49.80	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:57.319513	2026-03-10 09:36:12.99133	f
2447	2025-09-09	10:10:00	20:06, 20:59, 23:39, 00:23, 02:31, 5:23, 8:48, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	34.60	8.20	💕 Love it So Much	26.40	7	❌ - 💕	44		\N	2	\N	2026-03-08 13:51:57.345947	2026-03-10 09:36:47.729394	f
2446	2025-09-09	10:10:00	23:40, 02:31, 8:50, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	28.70	💕 Love it So Much	51.30	3	💖 - 💕	39		\N	2	\N	2026-03-08 13:51:57.344317	2026-03-10 09:36:55.160336	f
2441	2025-09-09	01:30:00	12:12, 15:57,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	20.00	12.90	🔺 So So	7.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.335102	2026-03-10 09:37:03.415181	f
2440	2025-09-09	01:30:00	-	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	42.60	❌ No!!!	37.40	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.333029	2026-03-10 09:37:11.802614	f
2445	2025-09-09	06:10:00	14:37,	Wet	ciao	ic-552 高湯鮮味餐包 雞肉+鰹魚柴魚片+鮪魚高湯	❌ No, not interested	30.00	17.40	🔺 So So	12.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.3427	2026-03-10 09:37:26.55247	f
2443	2025-09-09	03:02:00	-	Freeze-Dried	哩賀毛孩	特選雞胸肉	💖 Yes, eat right away	4.00	1.40	❌ No!!!	2.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.339169	2026-03-10 09:37:39.364412	f
2442	2025-09-09	03:02:00	11:02, 14:35, 23:38,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	15.10	4.60	🔺 So So	10.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.337383	2026-03-10 09:37:47.072492	f
2451	2025-09-10	07:30:00	-	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	54.80	❌ No!!!	25.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.372926	2026-03-10 09:39:06.693386	f
2450	2025-09-10	02:02:00	10:36, 14:01,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	15.20	7.10	🔺 So So	8.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.366318	2026-03-10 09:39:15.487362	f
2448	2025-09-10	02:02:00	-	Wet	汪喵星球	點心罐 清爽美味嫩雞絲	💖 Yes, eat right away	80.00	51.00	❌ No!!!	29.00	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.347458	2026-03-10 09:39:23.699849	f
2453	2025-09-10	07:30:00	16:47, 20:36, 00:23, 5:29, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	29.30	12.90	🔺 So So	16.40	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.383865	2026-03-10 09:39:55.681184	f
2454	2025-09-11	01:00:00	-	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	29.40	❌ No!!!	30.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.387832	2026-03-10 09:40:47.398079	f
2473	2025-09-13	10:50:00	00:17, 5:46,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	11.50	💕 Love it So Much	58.50	2	💖 - 💕	44		\N	2	\N	2026-03-08 13:51:57.505993	2026-03-10 10:16:27.290817	f
2458	2025-09-11	11:20:00	20:35, 3:27, 8:02, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	35.30	🔺 So So	44.70	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:57.406716	2026-03-10 09:40:21.303755	f
2459	2025-09-11	07:00:00	17:24, 18:02, 23:47, 00:46, 3:25, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	45.40	17.80	🔺 So So	27.60	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:57.410493	2026-03-10 09:40:56.483517	f
2457	2025-09-11	07:00:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	8.50	❌ No!!!	26.50	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.401191	2026-03-10 09:41:03.045512	f
2464	2025-09-12	11:05:00	1:27, 6:57, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	🔺 No, not really. Ate A Little	80.00	39.20	🔺 So So	40.80	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:57.472797	2026-03-10 09:41:28.540086	f
2467	2025-09-12	11:05:00	-	Freeze-Dried	誠實貓	雞塊	💖 Yes, eat right away	3.80	0.00	💕 Love it So Much	3.80	0	💖 - 💕	40		\N	2	\N	2026-03-08 13:51:57.483282	2026-03-10 09:41:37.285166	f
2466	2025-09-12	16:46:00	1:26, 3:04, 6:56, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	26.20	12.00	🔺 So So	14.20	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.479193	2026-03-10 09:41:51.699519	f
2472	2025-09-13	07:00:00	5:45, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	34.80	28.70	🔺 So So	6.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.50311	2026-03-10 10:16:34.912323	f
2469	2025-09-13	00:50:00	15:35,	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	12.80	9.00	🔺 So So	3.80	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.490413	2026-03-10 10:16:44.35741	f
2465	2025-09-12	07:15:00	16:52, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	36.40	32.40	🔺 So So	4.00	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.475876	2026-03-10 09:42:30.480245	f
2463	2025-09-12	07:15:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	4.80	❌ No!!!	30.20	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.467517	2026-03-10 09:42:36.950105	f
2470	2025-09-13	00:50:00	20:40, 23:22, 00:16, 5:44,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	35.20	15.20	🔺 So So	20.00	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.493983	2026-03-10 10:16:55.650806	f
2468	2025-09-13	00:50:00	-	Wet	litomon 怪獸部落	鮮肉煲 鮮雞絲	🔺 No, not really. Ate A Little	80.00	58.90	❌ No!!!	21.10	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.48593	2026-03-10 10:17:29.561436	f
2471	2025-09-13	07:00:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-94 鮪魚	💖 Yes, eat right away	60.00	36.70	❌ No!!!	23.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.498091	2026-03-10 10:18:35.900919	f
2479	2025-09-14	13:10:00	00:05, 	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	34.40	🔺 So So	35.60	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.561181	2026-03-10 10:19:15.621236	f
2480	2025-09-14	07:20:00	19:11, 20:22, 00:04, 00:52, 3:31,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	38.60	15.90	🔺 So So	22.70	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:57.565193	2026-03-10 10:19:25.287167	f
2478	2025-09-14	07:20:00	-	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	30.00	9.10	❌ No!!!	20.90	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.524015	2026-03-10 10:19:35.94655	f
2476	2025-09-14	01:30:00	10:30, 14:58, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	13.30	🔺 So So	6.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.51517	2026-03-10 10:19:55.081384	f
2477	2025-09-14	01:30:00	-	Freeze-Dried	哩賀毛孩	特選雞胸肉	❌ No, not interested	4.50	4.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.518271	2026-03-10 10:20:15.274676	f
2474	2025-09-14	01:30:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-44 鰹魚+鰹魚乾	💖 Yes, eat right away	35.00	9.30	❌ No!!!	25.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.509669	2026-03-10 10:20:24.264159	f
2483	2025-09-15	10:10:00	19:54, 22:51, 00:49, 3:15, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	35.70	15.70	🔺 So So	20.00	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.578231	2026-03-10 10:21:07.786845	f
2485	2025-09-15	10:10:00	21:59, 00:51, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	44.70	🔺 So So	35.30	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:57.584762	2026-03-10 10:21:19.185716	f
2482	2025-09-15	00:35:00	11:13, 21:57,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.30	9.40	🔺 So So	10.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.575332	2026-03-10 10:21:30.328298	f
2481	2025-09-15	00:35:00	-	Wet	ciao	法式濃湯系列餐包 ic-359 雞肉+干貝	💖 Yes, eat right away	40.00	6.50	❌ No!!!	33.50	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.56953	2026-03-10 10:21:39.976087	f
2484	2025-09-15	07:40:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚	💖 Yes, eat right away	35.00	4.70	❌ No!!!	30.30	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.581128	2026-03-10 10:22:01.47587	f
2491	2025-09-16	10:12:00	4:41,	Kibble	皇家	幼貓專用乾糧 k36	❌ No, not interested	20.60	17.20	🔺 So So	3.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.611578	2026-03-10 10:22:19.711705	f
2488	2025-09-16	00:55:00	12:34, 17:28, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.80	20.00	🔺 So So	0.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.602458	2026-03-10 10:22:54.48111	f
2489	2025-09-16	00:55:00	10:44, 23:36, 3:45, 7:50, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	43.60	15.90	🔺 So So	27.70	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.606133	2026-03-10 10:23:15.399595	f
2486	2025-09-16	00:55:00	-	Wet	cat-pool	香雞鮪魚燉牛肝	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.590971	2026-03-10 10:23:28.465769	f
2487	2025-09-16	00:55:00	11:24, 17:30	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	10.50	💕 Love it So Much	49.50	2	💖 - 💕	44	11:24=> 拿到前面才吃	\N	2	\N	2026-03-08 13:51:57.593548	2026-03-10 10:23:37.817214	f
2490	2025-09-16	10:12:00	-	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	43.10	❌ No!!!	36.90	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.609399	2026-03-10 10:23:48.883651	f
2492	2025-09-17	00:50:00	10:16, 11:00, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	13.90	💕 Love it So Much	46.10	2	💖 - 💕	44		\N	2	\N	2026-03-08 13:51:57.614234	2026-03-10 10:25:13.542856	f
2493	2025-09-17	00:50:00	10:58, 13:55, 	Kibble	皇家	幼貓專用乾糧 k36	❌ No, not interested	15.00	13.30	🔺 So So	1.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.622034	2026-03-10 10:25:45.728096	f
2520	2025-09-21	00:20:00	9:43, 	Wet	金湯	愛貓湯罐 鮮嫩雞肉	💖 Yes, eat right away	80.00	38.50	🔺 So So	41.50	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.726763	2026-03-10 12:53:52.241984	f
2514	2025-09-19	07:30:00	-	Kibble	心靈雞湯	幼母貓配方 美國特選雞肉佐火雞肉	❌ No, not interested	30.20	30.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.717275	2026-03-10 10:30:24.365959	f
2515	2025-09-20	00:35:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	💖 Yes, eat right away	80.00	44.40	❌ No!!!	35.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.718725	2026-03-10 12:19:57.410957	f
2509	2025-09-19	00:50:00	-	Wet	ciao	魚三味貓餐包 ic-415 鮪魚+雞肉+吻仔魚	💖 Yes, eat right away	60.00	41.30	❌ No!!!	18.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.709527	2026-03-10 10:29:53.188556	f
2518	2025-09-20	10:20:00	18:57, 21:04, 4:00, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	29.60	🔺 So So	40.40	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:57.723312	2026-03-10 12:51:59.376732	f
2494	2025-09-17	00:50:00	10:16, 12:40, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	16.30	12.60	🔺 So So	3.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.659859	2026-03-10 10:25:03.375535	f
2503	2025-09-18	07:15:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-44 鰹魚+鰹魚乾	💖 Yes, eat right away	35.00	18.70	❌ No!!!	16.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.698133	2026-03-10 10:28:33.143124	f
2498	2025-09-17	10:45:00	00:55, 5:58,	Kibble	皇家	幼貓專用乾糧 k36	❌ No, not interested	38.50	32.90	🔺 So So	5.60	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.671274	2026-03-10 10:24:27.47206	f
2497	2025-09-17	10:45:00	19:57, 22:47, 00:53, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	32.60	17.60	🔺 So So	15.00	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.668402	2026-03-10 10:24:37.58879	f
2499	2025-09-17	22:10:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	15.80	13.30	❌ No!!!	2.50	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.673522	2026-03-10 10:24:49.092538	f
2495	2025-09-17	07:20:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	7.60	❌ No!!!	27.40	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.662761	2026-03-10 10:26:00.181086	f
2507	2025-09-18	09:35:00	-	Kibble	紐崔斯	無穀養生室內貓(火雞+雞+鴨)	❌ No, not interested	18.10	18.10	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.706457	2026-03-10 10:27:03.239294	f
2504	2025-09-18	11:15:00	23:13, 4:19,	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	🔺 No, not really. Ate A Little	60.00	27.40	🔺 So So	32.60	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:57.701292	2026-03-10 10:27:12.569078	f
2508	2025-09-18	14:05:00	-	Kibble	愛肯拿	無穀配方 草原盛宴 放養鴨肉+薑黃	❌ No, not interested	20.00	19.60	❌ No!!!	0.40	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.708036	2026-03-10 10:27:22.447013	f
2502	2025-09-18	00:58:00	9:43, 14:42, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	19.70	15.70	🔺 So So	4.00	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.688608	2026-03-10 10:27:31.439475	f
2506	2025-09-18	11:15:00	-	Kibble	心靈雞湯	美國特選雞肉佐火雞肉	❌ No, not interested	15.80	15.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.704552	2026-03-10 10:27:41.665619	f
2505	2025-09-18	11:15:00	23:11, 4:17, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	24.80	9.50	🔺 So So	15.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.702987	2026-03-10 10:27:51.895934	f
2501	2025-09-18	00:58:00	9:44, 14:44, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	15.50	💕 Love it So Much	49.50	2	💖 - 💕	44		\N	2	\N	2026-03-08 13:51:57.686029	2026-03-10 10:28:05.234348	f
2500	2025-09-18	00:58:00	-	Wet	汪喵星球	營養罐 鮮嫩雞肉餐	❌ No, not interested	55.00	55.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.683293	2026-03-10 10:28:14.357528	f
2512	2025-09-19	12:30:00	22:34, 2:56, 7:53,	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	35.10	🔺 So So	44.90	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:57.714285	2026-03-10 10:29:21.958789	f
2516	2025-09-20	00:35:00	9:19, 14:43, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.90	9.30	🔺 So So	11.60	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.720281	2026-03-10 12:19:05.455331	f
2510	2025-09-19	00:50:00	9:45, 11:15, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	19.40	8.20	🔺 So So	11.20	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.711023	2026-03-10 10:29:42.602029	f
2519	2025-09-20	10:20:00	18:56, 19:06, 21:02, 00:19, 3:59, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.20	11.00	🔺 So So	29.20	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:57.725141	2026-03-10 12:51:45.745343	f
2517	2025-09-20	00:35:00	1:16, 	Kibble	心靈雞湯	成貓 大西洋鮭魚佐雞肉	❌ No, not interested	29.50	25.20	🔺 So So	4.30	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.721781	2026-03-10 12:52:08.875092	f
2524	2025-09-21	10:30:00	19:51, 00:28, 2:54,	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味) x2	💖 Yes, eat right away	120.00	60.20	🔺 So So	59.80	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:57.732852	2026-03-10 12:52:34.2584	f
2525	2025-09-21	10:30:00	19:49, 22:41, 00:27, 2:51, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	30.60	18.40	🔺 So So	12.20	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.734483	2026-03-10 12:52:43.419448	f
2526	2025-09-21	22:10:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	3.00	❌ No!!!	32.00	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.736603	2026-03-10 12:53:30.746724	f
2521	2025-09-21	00:20:00	9:42, 13:35, 17:36, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	16.90	2.20	🔺 So So	14.70	3	❌ - 🔺	26		\N	2	\N	2026-03-08 13:51:57.728299	2026-03-10 12:53:43.4936	f
2522	2025-09-21	00:20:00	9:23, 2;53, 	Kibble	皇家	豹貓成貓 bg04	❌ No, not interested	21.20	13.80	🔺 So So	7.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.729774	2026-03-10 12:54:19.427068	f
2523	2025-09-21	07:45:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚	💖 Yes, eat right away	35.00	11.70	❌ No!!!	23.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.731329	2026-03-10 12:54:36.984501	f
2528	2025-09-22	01:10:00	13:09, 22:05,	Kibble	皇家	豹貓成貓 bg04	❌ No, not interested	21.70	19.30	🔺 So So	2.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.740096	2026-03-10 12:55:19.919365	f
2527	2025-09-22	01:10:00	-	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	💖 Yes, eat right away	60.00	36.30	❌ No!!!	23.70	0	💖 - ❌	18		6.40	2	\N	2026-03-08 13:51:57.738386	2026-03-10 12:55:31.281546	f
2529	2025-09-22	01:10:00	14:59, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.40	17.50	🔺 So So	2.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.741725	2026-03-10 12:55:41.323446	f
2543	2025-09-24	00:38:00	-	Kibble	皇家	bsk38 英國短毛幼貓專用乾糧	❌ No, not interested	15.80	15.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.777634	2026-03-10 12:59:58.582744	f
2548	2025-09-25	01:10:00	-	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片	💖 Yes, eat right away	30.00	8.90	❌ No!!!	21.10	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.78577	2026-03-10 13:01:49.713241	f
2534	2025-09-23	01:12:00	-	Wet	cat-pool	美味雞肉煲	💖 Yes, eat right away	85.00	54.40	❌ No!!!	30.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.763554	2026-03-10 12:57:03.14069	f
2544	2025-09-24	07:00:00	-	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	33.50	❌ No!!!	26.50	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.779382	2026-03-10 12:59:11.95849	f
2563	2025-09-27	01:30:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	53.90	❌ No!!!	26.10	0	💖 - ❌	18	4:44 吃完馬上吐	\N	2	\N	2026-03-08 13:51:57.81041	2026-03-10 13:06:21.833781	f
2536	2025-09-23	06:47:00	-	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	32.80	❌ No!!!	32.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.766677	2026-03-10 12:58:11.168685	f
2530	2025-09-22	07:15:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	8.90	❌ No!!!	26.10	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.743505	2026-03-10 12:56:00.081011	f
2551	2025-09-25	07:00:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	4.50	❌ No!!!	30.50	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.790878	2026-03-10 13:02:27.658519	f
2542	2025-09-24	00:38:00	10:40, 13:52, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.10	15.00	🔺 So So	6.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.776166	2026-03-10 12:59:47.558318	f
2531	2025-09-22	12:35:00	-	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	🔺 No, not really. Ate A Little	70.00	54.50	❌ No!!!	15.50	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.745645	2026-03-10 12:55:02.673656	f
2533	2025-09-22	14:10:00	1:13, 7:21,	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	26.90	💕 Love it So Much	53.10	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:57.762028	2026-03-10 12:55:10.481208	f
2532	2025-09-22	07:15:00	18:31, 20:33, 22:04, 23:29, 1:11, 7:20, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	45.30	7.00	💕 Love it So Much	38.30	6	❌ - 💕	42		\N	2	\N	2026-03-08 13:51:57.760219	2026-03-10 12:55:50.278419	f
2537	2025-09-23	11:12:00	-	Wet	ciao	多樂米濃湯罐 a-57 泌尿保健 雞肉+鮪魚+干貝	🔺 No, not really. Ate A Little	80.00	71.40	❌ No!!!	8.60	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.768398	2026-03-10 12:56:46.430642	f
2535	2025-09-23	01:12:00	10:17, 12:07, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.20	17.40	🔺 So So	12.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.765105	2026-03-10 12:56:55.377732	f
2539	2025-09-23	11:29:00	19:29, 	Kibble	皇家	豹貓成貓 bg04	❌ No, not interested	16.40	14.80	🔺 So So	1.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.77144	2026-03-10 12:57:27.928694	f
2538	2025-09-23	06:47:00	16:27, 21:45, 23:05, 2:46, 8:12,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	50.40	15.80	🔺 So So	34.60	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:57.769893	2026-03-10 12:57:52.031998	f
2545	2025-09-24	10:30:00	22:32, 1:08, 4:30, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	19.70	💕 Love it So Much	55.30	3	💖 - 💕	39		\N	2	\N	2026-03-08 13:51:57.78092	2026-03-10 12:58:44.544014	f
2547	2025-09-24	13:35:00	22:32, 4:28, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	15.00	8.20	🔺 So So	6.80	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:57.783994	2026-03-10 12:58:54.931237	f
2546	2025-09-24	07:00:00	16:14, 20:19, 22:31, 23:16, 1:06, 7:40,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	52.40	18.20	🔺 So So	34.20	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:57.782431	2026-03-10 12:59:03.356744	f
2541	2025-09-24	00:38:00	-	Wet	自然小貓	無膠肉湯罐 雞肉佐番茄雞湯	💖 Yes, eat right away	80.00	50.60	❌ No!!!	29.40	0	💖 - ❌	18	13:53 => 聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:57.774542	2026-03-10 12:59:21.603503	f
2552	2025-09-25	11:15:00	-	Wet	tuna	愛貓天然食 雞肉+鮪魚	🔺 No, not really. Ate A Little	70.00	50.50	❌ No!!!	19.50	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.7924	2026-03-10 13:01:33.116433	f
2549	2025-09-25	01:10:00	13:51, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	15.40	13.50	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.787623	2026-03-10 13:01:41.112662	f
2550	2025-09-25	02:33:00	10:33, 12:08, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	15.50	9.50	🔺 So So	6.00	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:57.789292	2026-03-10 13:02:00.558455	f
2553	2025-09-25	07:00:00	22:19, 4:44, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.80	12.30	🔺 So So	11.50	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.79393	2026-03-10 13:02:18.802004	f
2560	2025-09-26	10:10:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	❌ No, not interested	75.00	75.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.805628	2026-03-10 13:02:56.041703	f
2556	2025-09-26	01:20:00	10:18, 12:36, 	Wet	ciao	a-53 多樂米濃湯罐 雞肉+鮪魚+墨魚	💖 Yes, eat right away	80.00	31.80	🔺 So So	48.20	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:57.799211	2026-03-10 13:03:06.124817	f
2557	2025-09-26	01:20:00	12:35, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.30	17.40	🔺 So So	3.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.800665	2026-03-10 13:03:14.491421	f
2561	2025-09-26	13:00:00	21:54, 22:47, 3:54, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	23.70	🔺 So So	36.30	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:57.807262	2026-03-10 13:03:27.063292	f
2555	2025-09-26	01:20:00	-	Wet	kattovit 康特維	腸胃保健 火雞肉	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.797685	2026-03-10 13:03:38.962385	f
2558	2025-09-26	07:30:00	21:52, 7:53, 	Kibble	皇家	in27 室內成貓專用乾糧	❌ No, not interested	21.90	17.80	🔺 So So	4.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.802282	2026-03-10 13:03:57.501386	f
2562	2025-09-26	07:35:00	16:27, 21:53, 22:46, 23:56, 3:52, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	42.70	24.60	🔺 So So	18.10	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:57.808903	2026-03-10 13:04:05.7213	f
2559	2025-09-26	07:35:00	16:28, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	4.00	💕 Love it So Much	31.00	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:57.804036	2026-03-10 13:04:14.133013	f
2564	2025-09-27	01:30:00	10:15, 13:39, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	22.80	12.20	🔺 So So	10.60	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.812028	2026-03-10 13:06:13.192415	f
2565	2025-09-27	01:30:00	-	Kibble	皇家	in27 室內成貓專用乾糧	❌ No, not interested	17.70	17.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.81356	2026-03-10 13:06:29.600275	f
2569	2025-09-27	10:30:00	-	Wet	ciao	法式濃湯系列餐包 ic-359 雞肉+干貝	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:57.81994	2026-03-10 13:05:39.773733	f
2592	2025-09-30	01:30:00	-	Wet	天然密碼	永恆無穀主食罐(貓薄荷) 雞肉與白鰹魚	🔺 No, not really. Ate A Little	80.00	62.40	❌ No!!!	17.60	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.856355	2026-03-10 13:12:15.144498	f
2598	2025-10-01	02:00:00	-	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片	💖 Yes, eat right away	30.00	9.20	❌ No!!!	20.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.887992	2026-03-10 13:13:44.047887	f
2596	2025-09-30	09:45:00	-	Wet	cat-pool	美味雞肉煲	💖 Yes, eat right away	85.00	44.70	❌ No!!!	40.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.862768	2026-03-10 13:12:51.0373	f
2584	2025-09-29	00:50:00	-	Wet	axia	純罐23號 鮪, 雞	🔺 No, not really. Ate A Little	65.00	55.90	❌ No!!!	9.10	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.843326	2026-03-10 13:10:56.181839	f
2595	2025-09-30	01:30:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:57.861269	2026-03-10 13:12:24.405459	f
2578	2025-09-28	03:40:00	-	Kibble	希爾斯	成貓 雞肉特調食譜	❌ No, not interested	16.70	16.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.833911	2026-03-10 13:08:59.44942	f
2573	2025-09-27	10:30:00	-	Kibble	皇家	s37 絕育成貓專用乾糧	❌ No, not interested	19.80	19.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.82634	2026-03-10 13:05:02.426575	f
2574	2025-09-27	10:30:00	-	Kibble	科克蘭	雞肉&米配方貓乾糧	❌ No, not interested	18.10	18.10	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.827894	2026-03-10 13:05:10.922698	f
2572	2025-09-27	10:30:00	3:05, 7:21,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	18.10	9.70	🔺 So So	8.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.824662	2026-03-10 13:05:19.000338	f
2571	2025-09-27	10:30:00	20:21, 00:06, 3:08, 4:40, 7:25,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	42.40	12.80	🔺 So So	29.60	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:57.82305	2026-03-10 13:05:26.971808	f
2568	2025-09-27	11:30:00	-	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:57.818328	2026-03-10 13:05:48.679803	f
2570	2025-09-27	12:30:00	4:42, 	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	29.30	🔺 So So	40.70	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.821497	2026-03-10 13:05:58.17217	f
2566	2025-09-27	01:30:00	-	Kibble	皇家	l40 體重控制成貓專用乾糧	❌ No, not interested	14.20	14.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.815184	2026-03-10 13:06:05.400766	f
2567	2025-09-27	06:40:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	8.70	❌ No!!!	26.30	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.8168	2026-03-10 13:06:52.397402	f
2581	2025-09-28	14:00:00	23:59, 4:53, 7;50,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	❌ No, not interested	60.00	41.00	🔺 So So	19.00	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.838547	2026-03-10 13:08:34.427508	f
2576	2025-09-28	01:00:00	9:56, 12:51, 16:49, 22:58, 23:57, 4:50, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	41.00	23.20	🔺 So So	17.80	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:57.830891	2026-03-10 13:08:42.878011	f
2575	2025-09-28	01:00:00	-	Wet	汪喵星球	點心罐 鮭魚菲力燴嫩雞	🔺 No, not really. Ate A Little	80.00	56.00	❌ No!!!	24.00	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.829373	2026-03-10 13:08:50.811746	f
2583	2025-09-28	07:52:00	20:11, 4;52, 7:48,	Kibble	法米納	無穀鯡魚甜橙 oc1	💖 Yes, eat right away	20.60	12.20	🔺 So So	8.40	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:57.841691	2026-03-10 13:09:11.561425	f
2580	2025-09-28	07:05:00	20:19, 	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉	💖 Yes, eat right away	35.00	8.60	💕 Love it So Much	26.40	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:57.837003	2026-03-10 13:09:31.660971	f
2579	2025-09-28	07:05:00	-	Wet	ciao	ic50 多樂米干貝沾醬 20g	💖 Yes, eat right away	20.00	0.00	❌ No!!!	20.00	0	💖 - ❌	25	一下子吃完	\N	2	\N	2026-03-08 13:51:57.835358	2026-03-10 13:09:44.280285	f
2577	2025-09-28	03:40:00	-	Kibble	希爾斯	幼貓 雞肉特調食譜	❌ No, not interested	16.20	16.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.832329	2026-03-10 13:09:58.455522	f
2586	2025-09-29	00:50:00	5:44, 	Kibble	法米納	qc5 天然藜麥無穀機能 鴨肉蔓越莓	❌ No, not interested	48.20	38.20	🔺 So So	10.00	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.846726	2026-03-10 13:10:38.58144	f
2585	2025-09-29	00:50:00	14:59, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	22.90	15.70	🔺 So So	7.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.844987	2026-03-10 13:10:46.936122	f
2589	2025-09-29	12:55:00	00:59, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	50.00	🔺 So So	30.00	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.851758	2026-03-10 13:11:06.136845	f
2591	2025-09-29	07:40:00	00:58,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	11.10	10.00	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.854796	2026-03-10 13:11:19.573083	f
2588	2025-09-29	07:40:00	-	Wet	喵tom 料理	鮪魚+雞肉+蟹肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:57.850258	2026-03-10 13:11:26.631956	f
2587	2025-09-29	07:40:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.84862	2026-03-10 13:11:41.515823	f
2594	2025-09-30	01:30:00	11:24, 15:18, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	19.10	11.90	🔺 So So	7.20	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.859645	2026-03-10 13:12:07.977982	f
2593	2025-09-30	01:30:00	9:49, 20:23, 1:03, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.20	13.70	🔺 So So	6.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.858099	2026-03-10 13:12:32.731197	f
2597	2025-09-30	09:45:00	19:32, 23:41, 00:19, 1:02, 7:56, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	31.90	5.30	🔺 So So	26.60	5	❌ - 🔺	30		\N	2	\N	2026-03-08 13:51:57.864374	2026-03-10 13:12:43.031747	f
2599	2025-10-01	02:00:00	17:08, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.70	14.90	🔺 So So	5.80	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.88987	2026-03-10 13:13:36.11779	f
2600	2025-10-01	02:00:00	11:42, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.70	20.00	🔺 So So	0.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.891556	2026-03-10 13:13:50.705658	f
2601	2025-10-01	02:00:00	-	Kibble	希爾斯	成貓 敏感胃腸與皮膚 雞肉與米	❌ No, not interested	21.80	21.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.893166	2026-03-10 13:13:58.446336	f
2602	2025-10-01	08:35:00	-	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	🔺 No, not really. Ate A Little	60.00	48.80	❌ No!!!	11.20	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:57.8947	2026-03-10 13:14:32.517468	f
2629	2025-10-05	03:45:00	11:46, 17:02, 20:16, 1:14, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	💖 Yes, eat right away	31.10	16.90	🔺 So So	14.20	4	💖 - 🔺	31		\N	2	\N	2026-03-08 13:51:57.938581	2026-03-10 13:20:29.02067	f
2635	2025-10-06	07:22:00	-	Wet	ciao	ciao imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	0.00	❌ No!!!	35.00	0	💖 - ❌	25	馬上吃光	\N	2	\N	2026-03-08 13:51:57.948439	2026-03-10 13:21:43.11189	f
2630	2025-10-05	11:00:00	1:16, 	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	40.00	🔺 So So	30.00	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.940405	2026-03-10 13:19:52.751859	f
2621	2025-10-04	01:25:00	8:35, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓	❌ No, not interested	23.10	19.80	🔺 So So	3.30	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.925326	2026-03-10 13:19:03.382908	f
2620	2025-10-04	01:25:00	-	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	30.00	2.20	❌ No!!!	27.80	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:57.923648	2026-03-10 13:19:13.160004	f
2627	2025-10-05	01:20:00	15:15,	Wet	克勞德博士	菲力貓罐 7號雞肉鮭魚	🔺 No, not really. Ate A Little	70.00	51.60	🔺 So So	18.40	1	🔺 - 🔺	20	20:26, 20:55 吐	\N	2	\N	2026-03-08 13:51:57.935384	2026-03-10 13:20:08.862459	f
2609	2025-10-02	07:30:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	13.70	❌ No!!!	21.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.906041	2026-03-10 13:15:40.379036	f
2619	2025-10-03	07:40:00	8:18, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.90	20.80	🔺 So So	0.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.922022	2026-03-10 13:16:19.803338	f
2616	2025-10-03	12:15:00	4:13, 8:46, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	29.40	💕 Love it So Much	50.60	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:57.917272	2026-03-10 13:17:03.374024	f
2618	2025-10-03	07:40:00	17:50, 00:19, 8:17, 	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓	❌ No, not interested	16.60	3.30	🔺 So So	13.30	3	❌ - 🔺	26		\N	2	\N	2026-03-08 13:51:57.920403	2026-03-10 13:17:31.801468	f
2625	2025-10-04	11:00:00	21:09, 3;38, 8:36, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	17.50	💕 Love it So Much	57.50	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:57.931892	2026-03-10 13:18:28.177295	f
2605	2025-10-01	08:35:00	8:16, 	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	18.30	14.20	🔺 So So	4.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.899541	2026-03-10 13:14:23.992773	f
2603	2025-10-01	13:10:00	8:19,	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	30.60	🔺 So So	49.40	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.896317	2026-03-10 13:14:08.903785	f
2604	2025-10-01	08:35:00	19:02, 21:06, 23:50, 4:42, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	41.20	13.40	🔺 So So	27.80	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.897935	2026-03-10 13:14:16.799992	f
2610	2025-10-02	12:45:00	4:26, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	47.40	🔺 So So	32.60	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.907711	2026-03-10 13:14:59.389044	f
2606	2025-10-02	00:45:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-94 鮪魚	💖 Yes, eat right away	60.00	26.90	❌ No!!!	33.10	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.901119	2026-03-10 13:15:09.446805	f
2607	2025-10-02	00:45:00	22:36, 8:12, 	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	20.00	14.50	🔺 So So	5.50	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.902605	2026-03-10 13:15:18.027533	f
2608	2025-10-02	00:45:00	11:06, 12:19, 16:21	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.30	6.00	🔺 So So	14.30	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.90425	2026-03-10 13:15:31.267266	f
2611	2025-10-02	07:30:00	18:58, 21:24, 4:23, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	31.90	9.40	🔺 So So	22.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:57.909337	2026-03-10 13:15:49.292888	f
2614	2025-10-03	01:05:00	-	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	19.50	19.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.914068	2026-03-10 13:16:34.410705	f
2612	2025-10-03	01:05:00	9:31, 	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉	💖 Yes, eat right away	35.00	6.20	💕 Love it So Much	28.80	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:57.911002	2026-03-10 13:16:41.423497	f
2613	2025-10-03	01:05:00	9:57, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.00	12.90	🔺 So So	8.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.912535	2026-03-10 13:16:48.685809	f
2617	2025-10-03	07:40:00	20:12, 21:51, 00:21, 4:10, 8:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	38.70	4.10	💕 Love it So Much	34.60	5	❌ - 💕	40		\N	2	\N	2026-03-08 13:51:57.918888	2026-03-10 13:17:22.224272	f
2624	2025-10-04	06:40:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	12.60	❌ No!!!	22.40	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.930328	2026-03-10 13:18:45.036073	f
2622	2025-10-04	01:25:00	11:33,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	12.90	🔺 So So	7.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.926991	2026-03-10 13:18:53.401303	f
2623	2025-10-04	01:25:00	18:51, 5:07,	Kibble	天然密碼	全齡貓配方-阿拉斯加鮭魚	❌ No, not interested	20.40	17.00	🔺 So So	3.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.928723	2026-03-10 13:19:23.162117	f
2631	2025-10-05	11:00:00	20:48, 21:08, 22:03, 23:23, 1;16, 4:43, 8:27, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	42.80	7.80	💕 Love it So Much	35.00	7	❌ - 💕	44		\N	2	\N	2026-03-08 13:51:57.942097	2026-03-10 13:20:00.771028	f
2628	2025-10-05	01:20:00	10:08, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	14.70	🔺 So So	5.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.936995	2026-03-10 13:20:20.127786	f
2636	2025-10-06	10:50:00	1:34, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	29.40	💕 Love it So Much	50.60	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:57.949948	2026-03-10 13:20:59.693167	f
2634	2025-10-06	02:00:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	14.90	14.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.946934	2026-03-10 13:21:09.409023	f
2632	2025-10-06	02:00:00	-	Wet	nature 養生湯罐	優選雞肉	💖 Yes, eat right away	80.00	55.20	❌ No!!!	24.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.943727	2026-03-10 13:21:17.899935	f
2633	2025-10-06	02:00:00	10:36, 13:52, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.20	6.20	🔺 So So	14.00	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.945419	2026-03-10 13:21:27.801315	f
3093	2025-12-12	12:50:00	-	Wet	莉莉廚房	雞肉+火腿撕絲罐	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.502339	2026-03-11 04:10:14.37536	f
2660	2025-10-10	00:30:00	9:25, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	21.40	21.00	🔺 So So	0.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.01893	2026-03-10 15:07:51.050097	f
2666	2025-10-11	01:26:00	9:58, 11:24, 16:12,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.40	8.70	🔺 So So	12.70	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.028358	2026-03-10 15:09:38.926047	f
2670	2025-10-12	01:25:00	-	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	20.70	20.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.035363	2026-03-10 15:12:21.290087	f
2642	2025-10-07	06:30:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	10.20	❌ No!!!	24.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.989951	2026-03-10 13:22:56.710033	f
2655	2025-10-09	01:15:00	10:33, 14:55, 17:04, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	28.50	19.00	🔺 So So	9.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.011111	2026-03-10 15:05:06.893473	f
2663	2025-10-10	10:35:00	19:02, 20:58, 4:30, 7:24, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	21.00	🔺 So So	29.00	4	💖 - 🔺	31		\N	2	\N	2026-03-08 13:51:58.023547	2026-03-10 15:08:40.407452	f
2651	2025-10-08	11:15:00	23:55, 1:55, 4:58,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	42.00	19.30	🔺 So So	22.70	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.004929	2026-03-10 13:23:36.95264	f
2665	2025-10-11	01:26:00	10:00, 	Wet	ciao	多樂米燒鰹魚濃湯罐 a-48 燒鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	30.60	🔺 So So	49.40	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.026684	2026-03-10 15:09:49.687309	f
2650	2025-10-08	11:15:00	-	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	30.70	❌ No!!!	49.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.00328	2026-03-10 13:23:46.60706	f
2637	2025-10-06	07:22:00	17:10, 22:20, 1:33, 5:48, 9:42, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.40	5.00	🔺 So So	32.40	5	❌ - 🔺	30		\N	2	\N	2026-03-08 13:51:57.951472	2026-03-10 13:22:00.253059	f
2639	2025-10-07	01:45:00	10:32, 	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉	💖 Yes, eat right away	35.00	3.70	💕 Love it So Much	31.30	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:57.95456	2026-03-10 13:22:32.924217	f
2649	2025-10-08	07:10:00	17:24, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	35.30	🔺 So So	24.70	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.001744	2026-03-10 13:24:26.984946	f
2638	2025-10-06	07:22:00	20:15, 22:18,	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓	❌ No, not interested	15.40	6.50	🔺 So So	8.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:57.953094	2026-03-10 13:21:35.510652	f
2641	2025-10-07	01:45:00	12:03, 13:07, 18:42,  8:08, 	Kibble	法米納	oc3/lc3 天然海洋系列 低穀鱈魚甜橙	❌ No, not interested	25.70	14.50	💕 Love it So Much	11.20	4	❌ - 💕	31		\N	2	\N	2026-03-08 13:51:57.98807	2026-03-10 13:22:40.768121	f
2640	2025-10-07	01:45:00	10:30, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	🔺 No, not really. Ate A Little	25.60	24.40	❌ No!!!	1.20	1	🔺 - ❌	15		\N	2	\N	2026-03-08 13:51:57.956104	2026-03-10 13:22:49.904985	f
2643	2025-10-07	10:25:00	8:12, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	36.60	🔺 So So	43.40	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:57.991626	2026-03-10 13:23:07.37268	f
2644	2025-10-07	10:25:00	18:40, 19:34, 21:28, 21:57, 1:19, 5:10, 8:11,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	44.90	38.40	🔺 So So	6.50	7	❌ - 🔺	27		\N	2	\N	2026-03-08 13:51:57.993446	2026-03-10 13:23:15.340044	f
2645	2025-10-08	00:50:00	-	Wet	eatmee	貓罐 鮮嫩雞肉拌魷魚	💖 Yes, eat right away	80.00	53.00	❌ No!!!	27.00	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:57.995158	2026-03-10 13:23:56.983849	f
2654	2025-10-09	01:15:00	-	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓	❌ No, not interested	25.90	25.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.009481	2026-03-10 15:04:52.701539	f
2656	2025-10-09	06:50:00	-	Wet	星晴湯罐	雞肉+鮭魚 射手座	🔺 No, not really. Ate A Little	70.00	54.70	❌ No!!!	15.30	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.012647	2026-03-10 15:05:22.321309	f
2652	2025-10-08	07:10:00	17:23, 20:06, 21:05, 23:52, 1:53, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	28.00	12.20	🔺 So So	15.80	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:58.006419	2026-03-10 13:24:35.172489	f
2647	2025-10-08	00:50:00	-	Kibble	希爾斯	室內成貓 特調雞肉食譜	❌ No, not interested	16.90	16.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.998382	2026-03-10 13:24:50.620286	f
2658	2025-10-09	10:20:00	20:25, 21:35, 00:09, 1:23, 4:54, 8:20, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	44.30	21.60	🔺 So So	22.70	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:58.015849	2026-03-10 15:06:12.373326	f
2657	2025-10-09	10:20:00	21:37, 1:25, 8:21, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	17.10	💕 Love it So Much	62.90	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:58.014255	2026-03-10 15:06:43.455223	f
2662	2025-10-10	06:50:00	-	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉	💖 Yes, eat right away	35.00	19.20	❌ No!!!	15.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.022041	2026-03-10 15:07:27.832223	f
2661	2025-10-10	06:15:00	14:15, 18:35, 19:00, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.00	7.60	🔺 So So	15.40	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.020396	2026-03-10 15:07:39.769432	f
2659	2025-10-10	00:30:00	9:49, 	Wet	ciao	布丁杯 鰹魚 imc-152	💖 Yes, eat right away	65.00	16.90	💕 Love it So Much	48.10	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:58.017366	2026-03-10 15:08:04.116593	f
2664	2025-10-10	11:35:00	20:31, 23:44, 00:24, 7:23, 8:00, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	32.60	3.00	💕 Love it So Much	29.60	5	❌ - 💕	40		\N	2	\N	2026-03-08 13:51:58.025095	2026-03-10 15:08:21.670158	f
2668	2025-10-11	11:05:00	19:30, 22:45, 2:51, 5:24, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	39.90	8.90	🔺 So So	31.00	4	❌ - 🔺	28		\N	2	\N	2026-03-08 13:51:58.03208	2026-03-10 15:09:27.726273	f
2671	2025-10-12	01:25:00	10:09, 11:02, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.80	15.90	🔺 So So	4.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.037001	2026-03-10 15:12:12.453575	f
2669	2025-10-12	01:25:00	-	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	40.60	❌ No!!!	29.40	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.033689	2026-03-10 15:12:31.270451	f
2685	2025-10-14	01:37:00	-	Kibble	法米納	天然南瓜無穀系列 鴨肉哈密瓜	❌ No, not interested	20.80	20.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.096786	2026-03-10 15:15:34.112923	f
2697	2025-10-15	04:05:00	-	Wet	法麗	微湯汁系列 天然嫩雞肉	💖 Yes, eat right away	80.00	46.20	❌ No!!!	33.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.117796	2026-03-10 15:23:59.973237	f
2702	2025-10-16	00:50:00	-	Wet	好運喵喵	嫩雞鮪魚鮮肉燉罐	💖 Yes, eat right away	70.00	43.40	❌ No!!!	26.60	0	💖 - ❌	18	22:00 還沒進臥室, 就在哭夭....	\N	2	\N	2026-03-08 13:51:58.126545	2026-03-10 15:25:19.969495	f
2700	2025-10-15	10:45:00	2:52, 8:41, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	32.30	🔺 So So	47.70	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.123128	2026-03-10 15:23:27.234991	f
2679	2025-10-13	07:20:00	-	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉	💖 Yes, eat right away	35.00	14.60	❌ No!!!	20.40	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.050073	2026-03-10 15:13:12.568844	f
2692	2025-10-14	10:11:00	-	Kibble	canidae 良善	無穀全齡貓 - 鮪魚(室內貓專用)	❌ No, not interested	18.00	18.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.109185	2026-03-10 15:15:07.373549	f
2672	2025-10-12	07:20:00	-	Wet	ciao	ciao imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	8.00	❌ No!!!	27.00	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:58.038617	2026-03-10 15:12:03.9346	f
2677	2025-10-13	01:28:00	-	Kibble	法米納	qc5 天然藜麥無穀機能 鴨肉蔓越莓	❌ No, not interested	15.50	15.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.046913	2026-03-10 15:14:01.059968	f
2673	2025-10-12	11:00:00	21:20, 5:32, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	29.40	💕 Love it So Much	50.60	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:58.040405	2026-03-10 15:11:39.445697	f
2674	2025-10-12	07:20:00	17:45, 21:19, 23:58, 5:29, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	46.60	8.20	🔺 So So	38.40	4	❌ - 🔺	28		\N	2	\N	2026-03-08 13:51:58.042035	2026-03-10 15:11:54.573204	f
2675	2025-10-13	01:28:00	10:21, 10:49, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	25.30	🔺 So So	34.70	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.043592	2026-03-10 15:12:57.620734	f
2681	2025-10-13	07:20:00	16:54, 19:12, 20:59, 21:30, 00:45, 5:46, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	46.30	10.50	🔺 So So	35.80	6	❌ - 🔺	32		\N	2	\N	2026-03-08 13:51:58.089703	2026-03-10 15:13:04.945133	f
2678	2025-10-13	07:20:00	-	Wet	貓大餐	慕斯金罐 雞肉+蝦	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:58.048499	2026-03-10 15:13:35.824158	f
2676	2025-10-13	01:28:00	10:47, 12:22, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	14.50	🔺 So So	5.50	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.045304	2026-03-10 15:13:45.214014	f
2680	2025-10-13	09:50:00	-	Wet	ciao	a-53 多樂米濃湯罐 雞肉+鮪魚+墨魚	💖 Yes, eat right away	80.00	40.90	❌ No!!!	39.10	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.087862	2026-03-10 15:14:16.884781	f
2693	2025-10-14	10:11:00	-	Kibble	canidae 良善	無穀全齡貓 - 鮮雞	❌ No, not interested	15.10	15.10	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.110915	2026-03-10 15:14:45.101671	f
2691	2025-10-14	10:11:00	-	Kibble	aatu 奧圖	乾 aatu 奧圖 超級8 鴨肉無穀全齡貓糧	❌ No, not interested	15.50	15.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.107421	2026-03-10 15:15:15.010714	f
2683	2025-10-14	01:37:00	11:37, 13:07, 15:34, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	5.80	💕 Love it So Much	14.60	3	❌ - 💕	29		\N	2	\N	2026-03-08 13:51:58.093364	2026-03-10 15:15:24.96616	f
2682	2025-10-14	01:37:00	10:20, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	1.00	💕 Love it So Much	34.00	1	💖 - 💕	42	22:00 進房有叫，但沒有攻擊，有陪玩約20分鐘/23:00再進房，有叫一下，就自己出臥室了	\N	2	\N	2026-03-08 13:51:58.091525	2026-03-10 15:15:42.529977	f
2684	2025-10-14	01:37:00	-	Kibble	倍適選	幼貓呵護成長配方及雞肉口味	❌ No, not interested	37.80	37.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.095039	2026-03-10 15:15:53.326848	f
2686	2025-10-14	05:50:00	-	Wet	貓主子	金槍魚與雞肉專用貓罐	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.098592	2026-03-10 15:16:18.951896	f
2687	2025-10-14	05:50:00	15:35, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	💖 Yes, eat right away	50.00	29.60	🔺 So So	20.40	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.100472	2026-03-10 15:16:26.003113	f
2688	2025-10-14	05:50:00	-	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.102237	2026-03-10 15:16:34.223715	f
2689	2025-10-14	05:50:00	19:35, 20:22, 9:08, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	12.00	💕 Love it So Much	63.00	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:58.103947	2026-03-10 15:16:49.954327	f
2698	2025-10-15	08:14:00	-	Wet	凱茲	n405 嫩燉菲力 菲力火雞肉+鮭魚主食餐盒	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:58.119646	2026-03-10 15:23:00.487342	f
2699	2025-10-15	08:14:00	-	Wet	ciao	ic-136 貓用六種機能湯餐包 - 鰹魚+雞肉+鰹魚片	💖 Yes, eat right away	30.00	10.80	❌ No!!!	19.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.121357	2026-03-10 15:23:10.725779	f
2701	2025-10-15	10:45:00	20:21, 22:26, 2:51, 4:38, 8:39, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	56.80	17.80	🔺 So So	39.00	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:58.124955	2026-03-10 15:23:19.517599	f
2695	2025-10-15	01:15:00	17:16, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	11.80	6.30	🔺 So So	5.50	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.114303	2026-03-10 15:23:36.182837	f
2694	2025-10-15	01:15:00	10:07, 11:24	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉)	💖 Yes, eat right away	35.00	5.90	💕 Love it So Much	29.10	2	💖 - 💕	44	23:00 進房門看了一下自己出去客廳睡/23:30 跑進來叫一下	\N	2	\N	2026-03-08 13:51:58.112584	2026-03-10 15:24:18.693832	f
2705	2025-10-16	06:40:00	-	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	34.20	❌ No!!!	25.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.131535	2026-03-10 15:24:55.602771	f
2704	2025-10-16	02:18:00	-	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉	💖 Yes, eat right away	35.00	12.70	❌ No!!!	22.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.129883	2026-03-10 15:25:04.566514	f
2703	2025-10-16	00:50:00	12:10,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.30	16.70	🔺 So So	3.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.128211	2026-03-10 15:25:12.242804	f
2706	2025-10-16	10:55:00	23:22	Wet	ciao	近海鰹魚罐93號 (干貝味) 	💖 Yes, eat right away	80.00	41.20	🔺 So So	38.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.133227	2026-03-10 15:26:27.171796	f
2730	2025-10-20	01:40:00	-	Wet	axia	金罐特選濃厚6號 鮪+雞+蟹棒	💖 Yes, eat right away	70.00	38.40	❌ No!!!	31.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.195364	2026-03-10 15:33:27.838841	f
2719	2025-10-18	06:30:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	3.10	❌ No!!!	31.90	0	💖 - ❌	25	一下子就吃光	\N	2	\N	2026-03-08 13:51:58.15507	2026-03-10 15:29:44.576109	f
2711	2025-10-17	07:15:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚	💖 Yes, eat right away	35.00	6.90	❌ No!!!	28.10	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:58.141673	2026-03-10 15:27:40.487387	f
2727	2025-10-19	11:00:00	19:52, 21:55, 23:47, 1:11, 5:37, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	56.30	6.30	💕 Love it So Much	50.00	5	❌ - 💕	40	00:12 追加10.7g	\N	2	\N	2026-03-08 13:51:58.190082	2026-03-10 15:30:30.759716	f
2714	2025-10-17	07:15:00	17:06, 22:17, 00:37, 4:42, 7:30, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	55.60	20.30	🔺 So So	35.30	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:58.146596	2026-03-10 15:27:31.54828	f
2728	2025-10-19	11:00:00	-	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	19.60	19.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.191794	2026-03-10 15:30:38.756208	f
2715	2025-10-17	07:15:00	-	Kibble	天然密碼	低敏雞肉 室內貓&絕育貓配方	❌ No, not interested	17.60	17.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.148294	2026-03-10 15:27:24.34505	f
2716	2025-10-18	00:50:00	-	Wet	好運喵喵	嫩雞鮮肉燉罐	🔺 No, not really. Ate A Little	70.00	40.40	❌ No!!!	29.60	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.150005	2026-03-10 15:29:11.254458	f
2709	2025-10-17	01:25:00	10:20,	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	30.00	🔺 So So	30.00	1	💖 - 🔺	25	22:30 進房一直叫	\N	2	\N	2026-03-08 13:51:58.138342	2026-03-10 15:27:59.100633	f
2708	2025-10-16	06:40:00	-	Kibble	法米納	天然熱帶水果系列 雞肉芒果 ftc1	❌ No, not interested	51.70	51.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.136617	2026-03-10 15:24:46.103402	f
2707	2025-10-16	06:40:00	16:05, 17:53, 19:44, 20:53, 23:21, 00:54, 4:29, 9:10, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	57.40	7.20	💕 Love it So Much	50.20	8	❌ - 💕	46		\N	2	\N	2026-03-08 13:51:58.134883	2026-03-10 15:25:42.644005	f
2710	2025-10-17	01:25:00	12:24, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.60	15.60	🔺 So So	5.00	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.140066	2026-03-10 15:27:50.975175	f
2713	2025-10-17	13:35:00	-	Wet	ciao	多樂米燒鰹魚濃湯罐 a-48 燒鰹魚+雞肉+柴魚片	🔺 No, not really. Ate A Little	80.00	61.90	❌ No!!!	18.10	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.144986	2026-03-10 15:28:12.276007	f
2712	2025-10-17	09:30:00	-	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	🔺 No, not really. Ate A Little	80.00	80.00	❌ No!!!	0.00	0	🔺 - ❌	13	吃幾口後, 開始撥沙	\N	2	\N	2026-03-08 13:51:58.143379	2026-03-10 15:28:26.066351	f
2721	2025-10-18	10:45:00	20:12, 2:51, 4:31,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	47.60	12.00	🔺 So So	35.60	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.1585	2026-03-10 15:29:03.700881	f
2717	2025-10-18	00:50:00	-	Wet	petline	懷石貓罐(k13)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.151642	2026-03-10 15:29:20.161783	f
2718	2025-10-18	00:50:00	12:03, 15:37, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.50	7.10	🔺 So So	13.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.153341	2026-03-10 15:29:34.286246	f
2723	2025-10-19	01:00:00	9:53, 11:56, 13:43, 14:11, 16:44, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	19.80	4.40	💕 Love it So Much	15.40	5	❌ - 💕	40		\N	2	\N	2026-03-08 13:51:58.161937	2026-03-10 15:30:09.321672	f
2726	2025-10-19	11:00:00	23:49, 5:39, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	44.30	🔺 So So	35.70	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.188113	2026-03-10 15:30:47.518984	f
2725	2025-10-19	09:50:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.165255	2026-03-10 15:30:59.244136	f
2724	2025-10-19	07:00:00	-	Wet	ciao	四連串包 多樂米濃湯 tcr-131 雞肉+鮪魚+干貝	💖 Yes, eat right away	35.00	16.30	❌ No!!!	18.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.163533	2026-03-10 15:31:20.488603	f
2733	2025-10-20	07:30:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	8.50	❌ No!!!	26.50	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:58.200241	2026-03-10 15:32:42.332075	f
2735	2025-10-20	07:30:00	16:55, 18:18, 20:43, 2:43, 5:25, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	61.70	27.80	🔺 So So	33.90	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:58.203767	2026-03-10 15:32:53.007694	f
2732	2025-10-20	01:40:00	14:07, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	18.90	12.00	🔺 So So	6.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.198602	2026-03-10 15:33:02.173625	f
2729	2025-10-20	01:40:00	-	Wet	go	豐醬無穀鮪魚	❌ No, not interested	71.00	71.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.193547	2026-03-10 15:33:10.04194	f
2731	2025-10-20	01:40:00	9:47, 23:17, 8:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	12.20	🔺 So So	13.20	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.19699	2026-03-10 15:33:20.577128	f
2734	2025-10-20	11:50:00	23:18, 2:45, 5:27, 	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	💖 Yes, eat right away	50.00	28.70	🔺 So So	21.30	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:58.202074	2026-03-10 15:33:44.651642	f
2740	2025-10-21	09:10:00	17:31, 	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	❌ No, not interested	70.00	52.90	🔺 So So	17.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.212593	2026-03-10 15:34:08.529323	f
2741	2025-10-21	09:10:00	17:30, 23:40, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	43.60	37.80	🔺 So So	5.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.214557	2026-03-10 15:34:16.83516	f
2737	2025-10-21	01:15:00	12:06, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	35.60	27.20	🔺 So So	8.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.207195	2026-03-10 15:34:51.386959	f
2736	2025-10-21	01:15:00	12:08,	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉	💖 Yes, eat right away	35.00	5.10	💕 Love it So Much	29.90	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:58.205444	2026-03-10 15:34:59.624106	f
2739	2025-10-21	07:00:00	-	Wet	ciao	全魚宴餐包 tcr-174 鮪魚+鰹魚+柴魚	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:58.210769	2026-03-10 15:35:15.471075	f
2738	2025-10-21	07:00:00	-	Wet	汪喵星球	點心罐 清爽美味嫩雞絲	💖 Yes, eat right away	80.00	54.50	❌ No!!!	25.50	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.208886	2026-03-10 15:35:23.960177	f
2775	2025-10-26	01:30:00	-	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.299564	2026-03-10 15:47:11.037991	f
2774	2025-10-26	01:30:00	9:40,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	19.80	15.60	🔺 So So	4.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.298028	2026-03-10 15:46:37.120192	f
2764	2025-10-25	02:00:00	-	Wet	喵樂	喵罐 鮭魚鮪魚燒	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	5:30 被咬	\N	2	\N	2026-03-08 13:51:58.259111	2026-03-10 15:44:09.314369	f
2751	2025-10-23	01:10:00	-	Wet	ciao	ic-356 法式濃湯系列餐包 鰹魚+鮪魚	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		6.80	2	\N	2026-03-08 13:51:58.233129	2026-03-10 15:39:57.369971	f
2758	2025-10-24	23:50:00	12:43, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉)	💖 Yes, eat right away	35.00	13.70	🔺 So So	21.30	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.247802	2026-03-10 15:42:25.292446	f
2773	2025-10-26	01:30:00	-	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉	💖 Yes, eat right away	35.00	12.50	❌ No!!!	22.50	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.296331	2026-03-10 15:47:19.623453	f
2744	2025-10-22	01:30:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	💖 Yes, eat right away	80.00	52.60	❌ No!!!	27.40	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.220427	2026-03-10 15:36:23.500043	f
2746	2025-10-22	07:40:00	-	Wet	atas cat 愛達思	鮮嫩雞肉+鮪魚	🔺 No, not really. Ate A Little	80.00	60.40	❌ No!!!	19.60	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.223896	2026-03-10 15:37:52.124443	f
2763	2025-10-24	07:40:00	21:09, 7:44, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.30	17.00	🔺 So So	3.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.257281	2026-03-10 15:41:18.164476	f
2755	2025-10-23	06:55:00	-	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉	💖 Yes, eat right away	35.00	18.00	❌ No!!!	17.00	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.24221	2026-03-10 15:39:32.72054	f
2743	2025-10-21	15:51:00	3:56, 5:54, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	❌ No, not interested	50.00	30.30	🔺 So So	19.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.218576	2026-03-10 15:34:33.61108	f
2772	2025-10-25	11:20:00	-	Kibble	自然平衡	特級田園全貓配方	❌ No, not interested	41.40	41.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.294665	2026-03-10 15:43:26.895288	f
2753	2025-10-23	01:10:00	9:41, 11:49,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.30	10.90	🔺 So So	10.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.237857	2026-03-10 15:39:49.520326	f
2742	2025-10-21	09:10:00	20:17, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	26.10	10.40	🔺 So So	15.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.216391	2026-03-10 15:34:24.881398	f
2748	2025-10-22	07:40:00	16:46, 19:01, 00:09, 1:23, 4:47, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	52.00	5.20	💕 Love it So Much	46.80	5	❌ - 💕	40		\N	2	\N	2026-03-08 13:51:58.227627	2026-03-10 15:36:14.535677	f
2745	2025-10-22	01:30:00	10:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.00	11.70	🔺 So So	9.30	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.222102	2026-03-10 15:36:31.59516	f
2749	2025-10-22	07:40:00	-	Kibble	自然平衡	無穀鴨肉心血管保健成貓配方	❌ No, not interested	45.20	45.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.229359	2026-03-10 15:38:00.380218	f
2750	2025-10-22	07:40:00	-	Kibble	嘿卡堤	三鮮凍乾糧 室內貓雞肉配方 catit	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.231204	2026-03-10 15:38:08.377034	f
2754	2025-10-23	06:40:00	-	Wet	汪喵星球	慢燉純湯罐 溫潤清雞湯	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.239931	2026-03-10 15:39:41.625723	f
2752	2025-10-23	01:10:00	9:43, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	31.00	🔺 So So	29.00	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.235487	2026-03-10 15:40:06.438556	f
2756	2025-10-23	11:10:00	00:34, 7:40,	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	💖 Yes, eat right away	80.00	36.30	🔺 So So	43.70	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.244094	2026-03-10 15:40:34.898267	f
2762	2025-10-24	07:40:00	17:42, 20:23, 22:59, 00:33, 4:10, 7:42, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	57.70	6.80	💕 Love it So Much	50.90	6	❌ - 💕	42		\N	2	\N	2026-03-08 13:51:58.255013	2026-03-10 15:41:07.662677	f
2760	2025-10-24	07:40:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	18.10	❌ No!!!	16.90	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.25129	2026-03-10 15:41:26.283939	f
2759	2025-10-24	23:50:00	12:41, 15:21,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.40	12.10	🔺 So So	12.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.249565	2026-03-10 15:41:42.854471	f
2761	2025-10-24	11:00:00	4:12, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	35.40	🔺 So So	44.60	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.253052	2026-03-10 15:42:35.522279	f
2771	2025-10-25	11:20:00	-	Wet	pramy 普拉	經典貓餐包 黃金鮮鮪+放山雞	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.293031	2026-03-10 15:43:08.838744	f
2769	2025-10-25	11:20:00	19:29, 21:31, 22:20, 1:21, 4:07, 7:04, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	56.40	19.80	🔺 So So	36.60	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:58.289648	2026-03-10 15:43:17.903039	f
2770	2025-10-25	11:20:00	19:31, 7:05, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	❌ No, not interested	80.00	29.00	💕 Love it So Much	51.00	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:58.291367	2026-03-10 15:43:35.141848	f
2767	2025-10-25	02:00:00	-	Kibble	卡娜芙	腸胃保健 雞肉	❌ No, not interested	21.80	21.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.264235	2026-03-10 15:43:44.604594	f
2768	2025-10-25	02:00:00	-	Kibble	天然密碼	無穀鮭魚, 鯡魚和曼哈頓魚 全齡貓配方	❌ No, not interested	19.60	19.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.287756	2026-03-10 15:43:52.900957	f
2765	2025-10-25	02:00:00	10:42, 14:39, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	🔺 No, not really. Ate A Little	50.00	34.80	🔺 So So	15.20	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:58.260756	2026-03-10 15:44:21.131121	f
2766	2025-10-25	02:00:00	10:40, 14:38, 17:02, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.80	11.30	🔺 So So	14.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.262482	2026-03-10 15:44:35.26112	f
2776	2025-10-26	07:30:00	-	Wet	atas cat 愛達思	白肉鮪魚+鮭魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.301158	2026-03-10 15:47:40.20056	f
2777	2025-10-26	07:30:00	-	Wet	ciao	四連串包 鮪魚+蟹棒 高湯 tcr-133 x2	🔺 No, not really. Ate A Little	70.00	53.10	❌ No!!!	16.90	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.302793	2026-03-10 15:48:12.165083	f
2811	2025-10-31	01:05:00	-	Wet	hello fresh	好鮮原汁湯罐 清蒸雞肉	💖 Yes, eat right away	80.00	54.30	❌ No!!!	25.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.355726	2026-03-10 16:04:54.733739	f
2789	2025-10-28	01:00:00	-	Wet	切爾蔓	添愛無穀貓餐包 鮪魚 cp-cm-15	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.321689	2026-03-10 15:52:28.597077	f
2783	2025-10-27	01:06:00	-	Kibble	烘焙客	貓無穀 鷹嘴豆鴨	❌ No, not interested	21.30	21.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.312253	2026-03-10 15:50:59.599378	f
2809	2025-10-30	11:00:00	19:53, 20:56, 21:28, 23:30, 4:57, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	46.10	14.10	🔺 So So	32.00	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:58.352534	2026-03-10 16:00:13.935621	f
2791	2025-10-28	01:00:00	11:43, 13:05, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.20	8.00	🔺 So So	13.20	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.324959	2026-03-10 15:52:20.757657	f
2793	2025-10-28	12:00:00	21:37, 4:17, 	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	33.50	🔺 So So	36.50	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.327908	2026-03-10 15:52:56.720707	f
2803	2025-10-29	07:30:00	20:13, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	23.50	20.50	🔺 So So	3.00	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.343402	2026-03-10 15:54:43.227136	f
2795	2025-10-29	00:55:00	-	Wet	想比比	低磷慕斯罐 卜蜂雞肉餐	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.331008	2026-03-10 15:54:13.21138	f
2808	2025-10-30	11:00:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	5.80	5.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.350973	2026-03-10 16:00:24.264538	f
2779	2025-10-26	07:30:00	-	Kibble	嘿卡堤	三鮮凍乾糧 體重控制貓雞肉配方	❌ No, not interested	49.70	49.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.306071	2026-03-10 15:48:02.883617	f
2778	2025-10-26	10:38:00	8:01, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	36.90	🔺 So So	43.10	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.304443	2026-03-10 15:47:30.551405	f
2780	2025-10-26	07:30:00	15:50, 18:28, 19:09, 23:22, 00:09, 1:26, 3:45, 7:59, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	56.40	16.60	💕 Love it So Much	39.80	8	❌ - 💕	39		\N	2	\N	2026-03-08 13:51:58.307684	2026-03-10 15:47:52.727963	f
2784	2025-10-27	07:20:00	-	Wet	axia	黑罐 水煮餐包 鮪魚, 鰹魚	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.313858	2026-03-10 15:49:12.193722	f
2785	2025-10-27	07:20:00	-	Wet	惜時	my cat 我的貓 (鮪魚+雞肉) 2號機能餐	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.315421	2026-03-10 15:50:21.672857	f
2786	2025-10-27	07:20:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	12.50	❌ No!!!	22.50	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.317069	2026-03-10 15:50:32.080841	f
2781	2025-10-27	01:06:00	-	Wet	克勞德博士	菲力貓罐 2號雞肉	🔺 No, not really. Ate A Little	70.00	54.00	❌ No!!!	16.00	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.309282	2026-03-10 15:50:40.167035	f
2782	2025-10-27	01:06:00	10:02, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.50	16.80	🔺 So So	4.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.310744	2026-03-10 15:50:49.500142	f
2787	2025-10-27	11:35:00	23:52, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	34.30	🔺 So So	25.70	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.318685	2026-03-10 15:51:10.15496	f
2788	2025-10-27	07:20:00	16:51, 19:31, 23:50, 00:49, 3:24, 8:44, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	57.20	19.50	🔺 So So	37.70	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:58.320184	2026-03-10 15:51:28.772214	f
2790	2025-10-28	01:00:00	-	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	66.50	❌ No!!!	13.50	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.323276	2026-03-10 15:52:36.439492	f
2794	2025-10-28	12:00:00	20:00, 21:36, 23:33, 4:15, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	38.70	15.50	🔺 So So	23.20	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.329444	2026-03-10 15:52:48.423775	f
2792	2025-10-28	07:00:00	-	Wet	喜耀	鮮鮪佐燉雞濃湯	🔺 No, not really. Ate A Little	34.00	22.20	❌ No!!!	11.80	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.326439	2026-03-10 15:53:05.924777	f
2798	2025-10-29	00:55:00	9:03, 12:34, 15:04, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.90	10.00	🔺 So So	15.90	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.335808	2026-03-10 15:54:04.514788	f
2797	2025-10-29	00:55:00	9:04, 	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉	💖 Yes, eat right away	35.00	16.20	🔺 So So	18.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.334094	2026-03-10 15:54:22.450649	f
2802	2025-10-29	07:30:00	17:47, 20:12, 23:10, 2:45, 5:23,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.30	11.20	🔺 So So	26.10	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:58.341908	2026-03-10 15:54:34.6059	f
2799	2025-10-29	07:30:00	-	Wet	axia	妙喵16號片狀- 鮪, 干貝	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:58.337409	2026-03-10 15:55:05.098816	f
2796	2025-10-29	00:55:00	-	Wet	pramy 普拉	補水救星 燉雞湯+離氨酸	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.332551	2026-03-10 15:55:18.739444	f
2805	2025-10-30	00:50:00	9:17, 13:10,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	19.80	🔺 So So	5.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.346437	2026-03-10 16:00:04.211812	f
2807	2025-10-30	11:00:00	20:57, 4:58, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	30.40	🔺 So So	49.60	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.349455	2026-03-10 16:00:33.507142	f
2804	2025-10-30	00:50:00	-	Wet	tuna	愛貓天然食 雞肉+鮪魚	🔺 No, not really. Ate A Little	70.00	57.40	❌ No!!!	12.60	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.344869	2026-03-10 16:00:44.74063	f
2806	2025-10-30	06:55:00	-	Wet	ciao	ic-238 鰹魚燒晚餐包 化毛配方 鰹魚+柴魚片+干貝	🔺 No, not really. Ate A Little	50.00	42.10	❌ No!!!	7.90	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.347926	2026-03-10 16:04:00.655362	f
2812	2025-10-31	01:05:00	9:29, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.90	16.90	🔺 So So	8.00	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.357437	2026-03-10 16:04:38.29645	f
2810	2025-10-31	01:05:00	-	Wet	亞米亞米	yami yami 精緻貓罐 白身鮪魚+鮮雞	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.354021	2026-03-10 16:05:06.817804	f
2813	2025-10-31	07:30:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝	💖 Yes, eat right away	35.00	7.10	❌ No!!!	27.90	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:58.359124	2026-03-10 16:05:23.682731	f
2848	2025-11-04	09:30:00	18:52, 21:17, 1:01, 3:08, 7:30,	Kibble	開放農場	混凍乾無穀寵糧 放養跑山雞&火雞	💖 Yes, eat right away	41.90	29.40	🔺 So So	12.50	5	💖 - 🔺	33		\N	2	\N	2026-03-08 13:51:58.438045	2026-03-11 01:36:53.204385	f
2845	2025-11-04	00:50:00	-	Kibble	瑞威	天然平衡 全齡貓糧 3號海洋魚貝 亮毛護膚	❌ No, not interested	62.80	62.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.433086	2026-03-11 01:35:53.842947	f
2831	2025-11-03	01:10:00	10:21, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	41.00	🔺 So So	39.00	1	💖 - 🔺	25	10:15 吐, 吐食物出來(餓太久, 吃太快)	\N	2	\N	2026-03-08 13:51:58.411327	2026-03-11 01:34:13.105615	f
2824	2025-11-02	02:00:00	10:34, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	31.00	🔺 So So	19.00	1	🔺 - 🔺	20	00:32 一直叫	\N	2	\N	2026-03-08 13:51:58.400498	2026-03-11 01:33:16.963149	f
2833	2025-11-03	01:10:00	10:19, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.00	16.70	🔺 So So	4.30	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.414485	2026-03-11 01:34:40.044086	f
2826	2025-11-02	06:30:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	14.10	14.10	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.403546	2026-03-11 01:32:48.689817	f
2817	2025-11-01	01:10:00	-	Wet	ciao	魚三味貓餐包 ic-415 鮪魚+雞肉+吻仔魚	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.389416	2026-03-11 01:31:51.455065	f
2841	2025-11-04	00:50:00	-	Wet	三洋食品	貓之玉手箱餐包 #72雞肉	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.427013	2026-03-11 01:36:03.459743	f
2836	2025-11-03	07:05:00	17:52,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	7.00	💕 Love it So Much	28.00	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:58.419142	2026-03-11 01:34:56.91736	f
2816	2025-10-31	11:15:00	20:13, 23:23, 5:12, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	13.20	3.30	🔺 So So	9.90	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.387681	2026-03-10 16:05:47.384739	f
2814	2025-10-31	11:15:00	23:25, 5:14, 7:07, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	11.40	💕 Love it So Much	63.60	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:58.360648	2026-03-10 16:05:58.383307	f
2821	2025-11-01	11:10:00	1:45,	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	🔺 No, not really. Ate A Little	80.00	42.80	🔺 So So	37.20	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:58.395961	2026-03-11 01:30:55.825681	f
2818	2025-11-01	01:10:00	14:30, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	26.60	🔺 So So	33.40	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.391048	2026-03-11 01:31:05.087776	f
2820	2025-11-01	01:10:00	12:03, 14:28, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	15.40	🔺 So So	4.60	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.394422	2026-03-11 01:31:14.442204	f
2822	2025-11-01	11:50:00	-	Wet	喵愛我	滋養肉汁 雞肉	💖 Yes, eat right away	135.00	90.20	❌ No!!!	44.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.397429	2026-03-11 01:31:23.816324	f
2823	2025-11-01	11:50:00	20:40, 23:07, 1:42	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	48.90	25.40	🔺 So So	23.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.399031	2026-03-11 01:31:33.056526	f
2819	2025-11-01	01:10:00	9:59, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	16.70	8.30	🔺 So So	8.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.392653	2026-03-11 01:31:42.986451	f
2830	2025-11-02	09:35:00	18:47, 19:44, 22:13, 22:57, 1:52, 2:20, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.30	17.40	🔺 So So	16.90	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:58.409854	2026-03-11 01:32:28.293869	f
2829	2025-11-02	09:35:00	22:16, 2:22, 6:22, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	48.40	34.90	🔺 So So	13.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.408265	2026-03-11 01:32:39.887241	f
2827	2025-11-02	06:30:00	-	Wet	ciao	ic-215 鮮湯餐包 雞肉, 干貝, 甜蝦	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.405166	2026-03-11 01:32:57.164209	f
2825	2025-11-02	02:00:00	12:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.60	18.40	🔺 So So	3.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.402075	2026-03-11 01:33:07.603018	f
2839	2025-11-03	11:20:00	-	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	29.80	❌ No!!!	45.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.423916	2026-03-11 01:33:43.297919	f
2838	2025-11-03	11:20:00	-	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.422306	2026-03-11 01:33:52.635354	f
2840	2025-11-03	11:20:00	20:31, 00:09, 3:51, 4:42, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	39.00	15.10	🔺 So So	23.90	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.425441	2026-03-11 01:34:03.949596	f
2832	2025-11-03	01:10:00	-	Kibble	自然平衡	無穀鮭魚皮膚保健成貓配方	❌ No, not interested	39.60	39.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.412917	2026-03-11 01:34:22.541402	f
2834	2025-11-03	01:10:00	11:06, 12:36, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	14.30	6.50	🔺 So So	7.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.416125	2026-03-11 01:34:30.593487	f
2837	2025-11-03	07:35:00	17:51, 19:01, 20:30, 21:28, 4:41, 	Kibble	瑞威	天然平衡 全齡貓糧 2號森林燉雞 - 腸胃保健	💖 Yes, eat right away	61.50	49.40	🔺 So So	12.10	5	💖 - 🔺	33		\N	2	\N	2026-03-08 13:51:58.420744	2026-03-11 01:34:48.31549	f
2835	2025-11-03	07:05:00	-	Wet	ciao	純粹餐包 鮪魚, 雞肉, 鮪魚節 ic-573	❌ No, not interested	30.00	30.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.417596	2026-03-11 01:35:05.078966	f
2844	2025-11-04	00:50:00	10:40, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	26.30	17.90	🔺 So So	8.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.431497	2026-03-11 01:35:41.763092	f
2842	2025-11-04	00:50:00	-	Wet	海饌	海饌純肉罐 鮪魚&人工蟹肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.428476	2026-03-11 01:36:11.780921	f
2843	2025-11-04	00:50:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	43.80	❌ No!!!	26.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.429989	2026-03-11 01:36:21.562988	f
2846	2025-11-04	10:15:00	3:11, 7:32,	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	💖 Yes, eat right away	70.00	25.00	💕 Love it So Much	45.00	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:58.43478	2026-03-11 01:36:31.698117	f
2847	2025-11-04	10:15:00	22:47, 1:02, 3:10, 7:31	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	39.10	19.70	🔺 So So	19.40	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.436416	2026-03-11 01:36:43.769189	f
3127	2025-12-17	23:01:00	-	Wet	三洋食品	美食家 #31 鮪魚+oligo	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.569921	2026-03-11 04:19:18.473179	f
2880	2025-11-09	07:15:00	-	Wet	咪碼	貓罐 白身鮪魚+雞肉	🔺 No, not really. Ate A Little	80.00	62.20	❌ No!!!	17.80	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.59211	2026-03-11 01:45:50.911875	f
2854	2025-11-05	07:30:00	-	Wet	axia	樂妙喵 貓罐 雞肉mt-5	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.447954	2026-03-11 01:38:00.835778	f
2870	2025-11-08	01:00:00	-	Wet	sheba	金罐 香嫩雞絲 (湯汁)	💖 Yes, eat right away	85.00	50.30	❌ No!!!	34.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.5085	2026-03-11 01:43:13.868233	f
2857	2025-11-06	00:55:00	-	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	43.20	❌ No!!!	16.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.452968	2026-03-11 01:39:50.083289	f
2869	2025-11-07	15:55:00	2:49, 5:04, 8:40,	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	21.00	14.60	🔺 So So	6.40	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:58.506945	2026-03-11 01:42:13.826792	f
2882	2025-11-09	10:10:00	00:26, 3:37, 8:19,	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	21.60	💕 Love it So Much	58.40	3	💖 - 💕	39		\N	2	\N	2026-03-08 13:51:58.59639	2026-03-11 01:44:47.401645	f
2852	2025-11-05	02:10:00	11:24, 14:41, 4:49, 	Kibble	開放農場	混凍乾無穀寵糧 放養跑山雞&火雞	❌ No, not interested	21.20	17.80	🔺 So So	3.40	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.444732	2026-03-11 01:38:12.05165	f
2865	2025-11-07	23:45:00	15:27, 	Kibble	超越巔峰	無穀貓糧 化毛配方 火雞肉+雞肉+鴨肉	❌ No, not interested	20.00	18.60	🔺 So So	1.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.500558	2026-03-11 01:41:15.602057	f
2867	2025-11-07	12:58:00	23:58, 5:07, 	Wet	sheba	金罐 鮪魚及蟹肉(湯汁)	💖 Yes, eat right away	85.00	45.20	🔺 So So	39.80	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.503854	2026-03-11 01:41:33.798442	f
2851	2025-11-05	02:10:00	10:30, 14:40, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	16.80	13.90	🔺 So So	2.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.442989	2026-03-11 01:37:27.262376	f
2856	2025-11-05	07:30:00	17:13, 23:10, 2:41,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.60	3.20	🔺 So So	27.40	3	❌ - 🔺	26		\N	2	\N	2026-03-08 13:51:58.451357	2026-03-11 01:37:49.985477	f
2849	2025-11-05	02:10:00	11:24, 14:42, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	41.30	🔺 So So	8.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.439575	2026-03-11 01:38:23.214964	f
2853	2025-11-05	07:30:00	-	Wet	原味饕饕	原肉湯汁 - 雞肉	🔺 No, not really. Ate A Little	135.00	104.30	❌ No!!!	30.70	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.446362	2026-03-11 01:38:40.278411	f
2858	2025-11-06	00:55:00	12:35,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.20	11.70	🔺 So So	8.50	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.488212	2026-03-11 01:39:33.716667	f
2859	2025-11-06	00:55:00	9:57, 15:52, 22:09, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	17.00	10.60	🔺 So So	6.40	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.490438	2026-03-11 01:39:41.894255	f
2861	2025-11-06	11:35:00	22:10, 00:23, 4:12,	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	❌ No, not interested	80.00	39.00	🔺 So So	41.00	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.494111	2026-03-11 01:39:59.437962	f
2862	2025-11-06	07:00:00	18:48, 00:21, 4:11,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.80	17.00	🔺 So So	20.80	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.495883	2026-03-11 01:40:15.613296	f
2864	2025-11-07	23:45:00	11:44, 13:11, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	14.90	🔺 So So	5.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.499024	2026-03-11 01:41:06.094845	f
2868	2025-11-07	08:30:00	20:53, 22:39, 5:06, 8:42,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	41.50	17.00	🔺 So So	24.50	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.505428	2026-03-11 01:41:44.964944	f
2866	2025-11-07	08:30:00	20:00, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	16.60	💕 Love it So Much	48.40	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:58.502246	2026-03-11 01:41:54.439668	f
2875	2025-11-08	11:20:00	20:48, 22:55, 23:55, 00:34, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	32.00	18.40	🔺 So So	13.60	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.516663	2026-03-11 01:42:52.514976	f
2876	2025-11-08	11:20:00	20:48, 00:35, 4:20, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	12.40	🔺 So So	12.70	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.518352	2026-03-11 01:43:02.506289	f
2871	2025-11-08	01:00:00	9:53, 18:14, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.50	17.30	🔺 So So	3.20	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.509982	2026-03-11 01:43:27.266418	f
2873	2025-11-08	05:50:00	-	Kibble	開放農場	混凍乾無穀寵糧 放養跑山雞&火雞	❌ No, not interested	23.40	23.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.513283	2026-03-11 01:43:42.465423	f
2872	2025-11-08	05:50:00	18:16,	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	6.90	💕 Love it So Much	28.10	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:58.511543	2026-03-11 01:43:51.179911	f
2877	2025-11-09	01:25:00	11:53, 	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	💖 Yes, eat right away	60.00	25.80	🔺 So So	34.20	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:58.530336	2026-03-11 01:44:24.247261	f
2878	2025-11-09	01:25:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	15.70	15.10	🔺 So So	0.60	0	❌ - 🔺	13		\N	2	\N	2026-03-08 13:51:58.588245	2026-03-11 01:44:33.920018	f
2881	2025-11-09	09:50:00	-	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.593842	2026-03-11 01:45:00.750018	f
2879	2025-11-09	01:25:00	15:10, 00:25, 3:36, 8:17, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	22.60	12.30	🔺 So So	10.30	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.590301	2026-03-11 01:45:12.386527	f
2883	2025-11-09	07:15:00	15:27, 17:50, 19:16, 21:39, 22:51, 00:23, 8:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	35.10	2.80	💕 Love it So Much	32.30	7	❌ - 💕	44		\N	2	\N	2026-03-08 13:51:58.598019	2026-03-11 01:45:38.182101	f
2884	2025-11-10	01:50:00	-	Wet	axia	妙喵11號片狀 - 鮪魚 mmf-11	🔺 No, not really. Ate A Little	70.00	55.90	❌ No!!!	14.10	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.59956	2026-03-11 01:47:03.15138	f
2894	2025-11-11	01:22:00	11:03, 13:35, 15:26	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	18.10	9.30	🔺 So So	8.80	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:58.795046	2026-03-11 02:35:34.58892	f
2910	2025-11-13	01:04:00	10:00, 14:21, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.20	9.30	🔺 So So	10.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.002767	2026-03-11 02:51:42.659516	f
2890	2025-11-10	07:45:00	16:00, 17:21, 20:14, 22:03, 	Kibble	瑞威	天然平衡 全齡貓糧 2號森林燉雞 - 腸胃保健	❌ No, not interested	46.10	33.80	🔺 So So	12.30	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.696902	2026-03-11 01:47:30.51636	f
2896	2025-11-11	12:25:00	-	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	44.00	❌ No!!!	31.00	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:58.890802	2026-03-11 02:35:08.254383	f
2901	2025-11-12	00:25:00	12:43, 	Wet	禮加樂 regalos	鮪魚+雞肉 餐包	❌ No, not interested	70.00	61.40	🔺 So So	8.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.899953	2026-03-11 02:46:05.116273	f
2909	2025-11-13	01:04:00	14:23, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x2	💖 Yes, eat right away	70.00	18.00	💕 Love it So Much	52.00	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:59.000988	2026-03-11 02:51:51.108983	f
2905	2025-11-12	11:20:00	-	Wet	瑞威	煲包湯 養氣土雞湯	❌ No, not interested	50.00	0.00	❌ No!!!	50.00	0	❌ - ❌	15		\N	2	\N	2026-03-08 13:51:58.993891	2026-03-11 02:45:25.983587	f
2912	2025-11-13	10:18:00	16:52, 18:14, 19:24, 21:00, 5:16, 8:07,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	43.40	1.60	💕 Love it So Much	41.80	6	❌ - 💕	42		\N	2	\N	2026-03-08 13:51:59.006549	2026-03-11 02:51:27.37995	f
2899	2025-11-11	14:40:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.50	24.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.896615	2026-03-11 02:35:00.932798	f
2889	2025-11-10	11:15:00	00:43, 5:07, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	36.10	🔺 So So	43.90	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:58.695186	2026-03-11 01:47:49.407461	f
2888	2025-11-10	07:45:00	-	Wet	ciao	鰹魚燒晚餐 ic-281 (雞肉+鰹魚+蟹肉+干貝)	🔺 No, not really. Ate A Little	50.00	43.20	❌ No!!!	6.80	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:58.69337	2026-03-11 01:46:26.712344	f
2885	2025-11-10	01:50:00	12:11, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	19.20	13.10	🔺 So So	6.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.601134	2026-03-11 01:46:35.862797	f
2886	2025-11-10	01:50:00	-	Kibble	囍碗	無穀貓糧	❌ No, not interested	26.20	26.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.688373	2026-03-11 01:46:44.895118	f
2887	2025-11-10	07:45:00	-	Wet	ciao	純粹餐包鮪魚雞肉扇貝 ic-571	❌ No, not interested	30.00	30.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.691429	2026-03-11 01:46:52.729015	f
2891	2025-11-10	16:30:00	00:42, 5:06, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.10	5.00	🔺 So So	16.10	2	❌ - 🔺	24		\N	2	\N	2026-03-08 13:51:58.789008	2026-03-11 01:47:14.721028	f
2897	2025-11-11	06:45:00	20:21, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	23.90	20.70	🔺 So So	3.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.892858	2026-03-11 02:26:38.69968	f
2898	2025-11-11	12:25:00	-	Kibble	瑞威	天然平衡 全齡貓糧 2號森林燉雞 - 腸胃保健	❌ No, not interested	13.30	13.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.894864	2026-03-11 02:34:50.386953	f
2892	2025-11-11	01:22:00	11:04, 	Wet	sheba	金罐 鮪魚及白身魚(湯汁)	💖 Yes, eat right away	85.00	49.40	🔺 So So	35.60	1	💖 - 🔺	25	1:00 一直叫	\N	2	\N	2026-03-08 13:51:58.791467	2026-03-11 02:35:16.802728	f
2893	2025-11-11	01:22:00	15:27, 16:12, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.50	7.40	🔺 So So	13.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:58.793384	2026-03-11 02:35:26.36241	f
2907	2025-11-12	11:20:00	21:41, 22:46, 1:06, 2:23, 6:54,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.00	24.10	🔺 So So	12.90	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:58.997626	2026-03-11 02:43:53.782393	f
2904	2025-11-12	11:20:00	-	Wet	nature 養生湯罐	白身鮪魚+雞肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:58.992121	2026-03-11 02:45:35.820944	f
2906	2025-11-12	12:00:00	22:47, 1:07, 	Wet	ciao	a-53 多樂米濃湯罐 雞肉+鮪魚+墨魚	🔺 No, not really. Ate A Little	80.00	43.20	🔺 So So	36.80	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:58.995856	2026-03-11 02:45:49.283107	f
2908	2025-11-12	11:20:00	19:41, 21:42, 00:43, 2:25, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	26.70	10.70	🔺 So So	16.00	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.999316	2026-03-11 02:45:57.541449	f
2902	2025-11-12	00:25:00	12:17, 12:42, 16:15, 17:23, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	11.80	🔺 So So	8.20	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:58.988381	2026-03-11 02:46:16.490806	f
2903	2025-11-12	06:10:00	16:17, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	20.70	💕 Love it So Much	44.30	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:58.990379	2026-03-11 02:46:31.723076	f
2900	2025-11-12	00:25:00	-	Wet	莉莉廚房	聖誕火雞饗宴 	🔺 No, not really. Ate A Little	85.00	75.30	❌ No!!!	9.70	0	🔺 - ❌	13	關燈後，準備睡覺的時候叫	\N	2	\N	2026-03-08 13:51:58.898208	2026-03-11 02:46:47.69033	f
2913	2025-11-13	10:18:00	8:08,	Kibble	瑞威	7號 河畔雞鴨 泌尿腎臟配方	❌ No, not interested	16.80	16.60	🔺 So So	0.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.008251	2026-03-11 02:51:19.60318	f
2919	2025-11-14	10:30:00	22:01, 3:07, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	14.20	💕 Love it So Much	65.80	2	💖 - 💕	44		\N	2	\N	2026-03-08 13:51:59.01933	2026-03-11 02:52:15.260951	f
2917	2025-11-14	07:30:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	🔺 No, not really. Ate A Little	75.00	50.90	❌ No!!!	24.10	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.015115	2026-03-11 02:52:23.16093	f
2918	2025-11-14	07:30:00	-	Wet	axia	新金罐濃厚7號- 鮪, 牛	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.01698	2026-03-11 02:52:30.160115	f
2920	2025-11-14	07:30:00	17:37, 21:59, 23:03, 3:05, 5:04,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	38.30	20.30	🔺 So So	18.00	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.021199	2026-03-11 02:52:37.279684	f
2916	2025-11-14	01:30:00	-	Kibble	歐那特	新鮮多種魚+雞肉	❌ No, not interested	16.90	16.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.013427	2026-03-11 02:52:54.978484	f
2914	2025-11-14	01:30:00	10:12, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	70.00	22.90	💕 Love it So Much	47.10	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:59.009971	2026-03-11 02:53:02.255447	f
2915	2025-11-14	01:30:00	10:12, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.70	17.40	🔺 So So	4.30	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.011723	2026-03-11 02:53:10.113045	f
2942	2025-11-18	11:45:00	5:09, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	25.40	💕 Love it So Much	54.60	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:59.101848	2026-03-11 03:01:37.443494	f
2953	2025-11-20	01:20:00	9:14, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.80	19.40	🔺 So So	1.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.118792	2026-03-11 03:03:56.677662	f
2948	2025-11-19	07:10:00	-	Wet	axia	金罐7號高湯 - 鮪魚	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.111124	2026-03-11 03:02:13.942425	f
2926	2025-11-15	10:55:00	-	Wet	金湯	愛貓湯罐 鮮嫩雞肉	🔺 No, not really. Ate A Little	80.00	63.60	❌ No!!!	16.40	0	🔺 - ❌	13	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:59.030993	2026-03-11 02:57:46.583455	f
2924	2025-11-15	01:00:00	9:04, 13:03,	Wet	禮加樂 regalos	濃郁鮪魚罐頭	💖 Yes, eat right away	80.00	53.80	🔺 So So	26.20	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.027919	2026-03-11 02:56:55.41312	f
2943	2025-11-18	11:45:00	21:19, 23:51, 4:33, 5:08, 9:15	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	51.10	10.20	🔺 So So	40.90	5	❌ - 🔺	30		\N	2	\N	2026-03-08 13:51:59.103395	2026-03-11 03:01:30.356849	f
2949	2025-11-19	10:50:00	23:34, 7:29, 	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	14.80	💕 Love it So Much	55.20	2	💖 - 💕	44		\N	2	\N	2026-03-08 13:51:59.112681	2026-03-11 03:03:00.084785	f
2954	2025-11-20	10:50:00	22:33, 9:16,	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	❌ No, not interested	80.00	29.30	💕 Love it So Much	50.70	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:59.120504	2026-03-11 03:03:32.225552	f
2929	2025-11-16	00:38:00	9:34, 	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片 x2	💖 Yes, eat right away	60.00	27.90	🔺 So So	32.10	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.035907	2026-03-11 02:59:01.27082	f
2932	2025-11-16	09:30:00	-	Wet	axia	新金罐濃厚1號-鮪魚	💖 Yes, eat right away	70.00	39.80	❌ No!!!	30.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.040625	2026-03-11 02:58:19.709784	f
2946	2025-11-19	03:15:00	-	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	45.70	❌ No!!!	19.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.108072	2026-03-11 03:02:31.422903	f
2921	2025-11-14	07:30:00	-	Kibble	紐頓	乾 紐頓 t24 鮭魚+鱒魚配方	❌ No, not interested	21.60	21.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.022874	2026-03-11 02:52:44.697098	f
2922	2025-11-14	07:30:00	-	Kibble	紐頓	乾 紐頓 t22 火雞肉+雞肉配方	❌ No, not interested	21.60	21.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.024586	2026-03-11 02:56:11.685166	f
2925	2025-11-15	01:00:00	9:03, 13:01,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	22.00	2.80	💕 Love it So Much	19.20	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.029465	2026-03-11 02:56:46.924598	f
2931	2025-11-16	09:30:00	00:34, 5:28,	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	❌ No, not interested	80.00	37.80	🔺 So So	42.20	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.039117	2026-03-11 02:57:06.390321	f
2927	2025-11-15	12:14:00	1:31, 4:48, 	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	❌ No, not interested	70.00	27.60	🔺 So So	42.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.032618	2026-03-11 02:57:17.046542	f
2923	2025-11-15	01:00:00	-	Wet	自然核心	貓屋罐頭 鮪魚(黑色)+蟹肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 直接走掉	\N	2	\N	2026-03-08 13:51:59.026151	2026-03-11 02:57:25.494215	f
2928	2025-11-15	10:55:00	19:06, 21:57, 23:38, 1:29, 4:47, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	33.20	0.70	💕 Love it So Much	32.50	5	❌ - 💕	40		\N	2	\N	2026-03-08 13:51:59.034176	2026-03-11 02:57:35.705515	f
2933	2025-11-16	09:30:00	18:52, 20:43, 00:33, 5:25,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	50.90	10.70	🔺 So So	40.20	4	❌ - 🔺	28		\N	2	\N	2026-03-08 13:51:59.042147	2026-03-11 02:58:45.151677	f
2930	2025-11-16	00:38:00	9:33, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.10	10.00	🔺 So So	11.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.037502	2026-03-11 02:58:52.551253	f
2934	2025-11-17	01:24:00	-	Wet	銀湯匙	貓罐頭 濃郁鮪魚 tw tmp 123	💖 Yes, eat right away	70.00	40.40	❌ No!!!	29.60	0	💖 - ❌	18	2:20 很躁動，咬人/10:00 聞一聞在撥沙	\N	2	\N	2026-03-08 13:51:59.088356	2026-03-11 03:00:17.834916	f
2935	2025-11-17	01:24:00	9:59, 13:21,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	13.60	🔺 So So	6.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.090359	2026-03-11 03:00:25.390928	f
2936	2025-11-17	08:35:00	8:05,	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	23.70	💕 Love it So Much	51.30	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:59.092109	2026-03-11 03:00:45.396809	f
2939	2025-11-17	08:35:00	17:55, 23:38, 8:02	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	49.50	32.00	🔺 So So	17.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.097216	2026-03-11 03:00:54.753831	f
2938	2025-11-17	08:35:00	19:56, 21:52, 22:42, 4:27, 8:01,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.70	8.80	🔺 So So	21.90	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.095384	2026-03-11 03:01:05.876998	f
2940	2025-11-18	01:25:00	10:12, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	18.80	💕 Love it So Much	41.20	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:59.098765	2026-03-11 03:01:44.88524	f
2941	2025-11-18	01:25:00	10:10, 12:11, 18:52, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.50	9.30	🔺 So So	11.20	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.100336	2026-03-11 03:01:52.310373	f
2947	2025-11-19	03:15:00	-	Kibble	瑞威	天然平衡 全齡貓糧 2號森林燉雞 - 腸胃保健	❌ No, not interested	16.90	16.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.109593	2026-03-11 03:02:24.01924	f
2944	2025-11-19	01:17:00	10:32, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	46.90	🔺 So So	33.10	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.105071	2026-03-11 03:02:39.605365	f
2945	2025-11-19	01:17:00	10:31, 17:13, 18:09, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.30	10.00	🔺 So So	11.30	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.106573	2026-03-11 03:02:48.685427	f
2950	2025-11-19	10:50:00	20:18, 23:33, 00:37, 2;41, 7:28, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	51.60	21.80	🔺 So So	29.80	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.114231	2026-03-11 03:03:08.695773	f
2955	2025-11-20	10:50:00	20:14, 20:55, 22:32, 4:42, 9:15	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	39.70	8.20	🔺 So So	31.50	5	❌ - 🔺	30		\N	2	\N	2026-03-08 13:51:59.122116	2026-03-11 03:03:39.77202	f
2951	2025-11-20	01:20:00	-	Wet	pramy 普拉	經典貓餐包 放山雞+黃金鮮鮪	💖 Yes, eat right away	70.00	44.90	❌ No!!!	25.10	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.115717	2026-03-11 03:04:08.400901	f
2952	2025-11-20	01:20:00	11:27, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.00	10.40	🔺 So So	10.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.117211	2026-03-11 03:04:16.239281	f
2973	2025-11-24	01:45:00	9:55, 	Wet	姆吉	2號無穀鮮肉餐包 鮪魚雞肉 mc-rm2	❌ No, not interested	70.00	58.30	🔺 So So	11.70	1	❌ - 🔺	15	5:40 咬人	\N	2	\N	2026-03-08 13:51:59.150655	2026-03-11 03:09:28.779052	f
2988	2025-11-26	01:00:00	-	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	🔺 No, not really. Ate A Little	50.00	41.60	❌ No!!!	8.40	0	🔺 - ❌	13	5:30 有攻擊人	\N	2	\N	2026-03-08 13:51:59.194944	2026-03-11 03:35:13.271884	f
2983	2025-11-25	01:50:00	10:47, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 雞肉全貓配方(試吃包)	❌ No, not interested	20.80	19.70	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.16743	2026-03-11 03:33:24.875455	f
2971	2025-11-23	10:20:00	3:24, 8:42, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	29.00	💕 Love it So Much	51.00	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:59.147226	2026-03-11 03:07:37.060459	f
2987	2025-11-25	08:40:00	5:18, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 雞肉全貓配方(試吃包)	❌ No, not interested	50.90	48.70	🔺 So So	2.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.193228	2026-03-11 03:32:44.916822	f
2963	2025-11-22	11:10:00	23:57, 7:33,	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	31.80	🔺 So So	48.20	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.134527	2026-03-11 03:05:48.587465	f
2980	2025-11-24	07:50:00	21:33, 23:35, 5:20, 9:21, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	45.10	28.20	🔺 So So	16.90	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.162496	2026-03-11 03:08:56.257881	f
2966	2025-11-23	02:20:00	-	Wet	axia	妙喵慕斯軟包2號 - 鮪, 雞, 雪蟹 mmc-2	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.139314	2026-03-11 03:06:57.638924	f
2956	2025-11-21	01:15:00	-	Wet	金湯	愛貓湯罐 白身鮪魚&雞肉	💖 Yes, eat right away	80.00	58.50	❌ No!!!	21.50	0	💖 - ❌	18	12:03 聞一聞, 再撥沙, 然後就沒再回頭吃	\N	2	\N	2026-03-08 13:51:59.12377	2026-03-11 03:05:04.044594	f
2979	2025-11-24	07:50:00	17:10, 18:22, 23:36, 00:54, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	53.80	37.70	🔺 So So	16.10	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.160889	2026-03-11 03:08:48.146347	f
2965	2025-11-22	07:30:00	-	Kibble	mon petit 貓倍麗	成貓乾糧 鮮魚什錦泌尿保健配方	🔺 No, not really. Ate A Little	20.00	19.80	❌ No!!!	0.20	0	🔺 - ❌	13	感覺飼料比較硬？	\N	2	\N	2026-03-08 13:51:59.13755	2026-03-11 03:06:09.103368	f
2989	2025-11-26	01:00:00	9:13, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	19.30	🔺 So So	0.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.196533	2026-03-11 03:34:51.000539	f
2981	2025-11-25	01:50:00	-	Wet	禮加樂 regalos	鮪魚雞肉罐頭	💖 Yes, eat right away	80.00	45.80	❌ No!!!	34.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.164098	2026-03-11 03:33:09.369121	f
2976	2025-11-24	07:50:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	🔺 No, not really. Ate A Little	60.00	46.80	❌ No!!!	13.20	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.155752	2026-03-11 03:09:02.712146	f
2974	2025-11-24	01:45:00	11:57, 15:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.50	13.10	🔺 So So	7.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.152504	2026-03-11 03:09:21.552451	f
2958	2025-11-21	07:25:00	23:15, 01:00, 4:46, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	14.80	💕 Love it So Much	45.20	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:59.126911	2026-03-11 03:04:46.995697	f
2957	2025-11-21	01:15:00	9:45, 12:03, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.00	16.10	🔺 So So	6.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.125405	2026-03-11 03:04:56.118615	f
2959	2025-11-21	11:00:00	-	Wet	sheba	金罐 香嫩雞絲 (湯汁)	💖 Yes, eat right away	85.00	50.00	❌ No!!!	35.00	0	💖 - ❌	18	12:03 聞一聞, 再撥沙, 然後就沒再回頭吃	\N	2	\N	2026-03-08 13:51:59.128386	2026-03-11 03:05:24.796938	f
2960	2025-11-21	11:00:00	20:08, 23:13, 1:39, 4:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	49.40	14.50	🔺 So So	34.90	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.129901	2026-03-11 03:05:33.157406	f
2962	2025-11-22	01:25:00	10:06, 12:55, 15:35,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.30	6.70	💕 Love it So Much	13.60	3	❌ - 💕	29		\N	2	\N	2026-03-08 13:51:59.133048	2026-03-11 03:05:56.516457	f
2964	2025-11-22	07:30:00	18:15, 23:55, 7:31, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	46.50	24.70	🔺 So So	21.80	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.136037	2026-03-11 03:06:16.477471	f
2968	2025-11-23	02:20:00	13:32, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	🔺 No, not really. Ate A Little	75.00	51.00	🔺 So So	24.00	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:59.142414	2026-03-11 03:07:04.906602	f
2969	2025-11-23	02:20:00	3:22, 	Kibble	dibaq 迪貝可	自然嗑天然貓糧 成貓配方 雞肉	❌ No, not interested	16.20	7.80	🔺 So So	8.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.144041	2026-03-11 03:07:12.302402	f
2967	2025-11-23	02:20:00	-	Wet	銀湯匙	貓罐頭 濃郁鮪魚 tw tmp 123	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.140755	2026-03-11 03:07:19.327909	f
2972	2025-11-23	10:20:00	16:07, 18:20, 20:04, 21:02, 23:27, 8:41, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	44.80	19.20	🔺 So So	25.60	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:59.149076	2026-03-11 03:07:28.894494	f
2970	2025-11-23	02:20:00	10:40, 13:30, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	24.00	4.00	🔺 So So	20.00	2	❌ - 🔺	24		\N	2	\N	2026-03-08 13:51:59.145619	2026-03-11 03:08:03.05981	f
2975	2025-11-24	01:45:00	11:59, 13:30, 14:44,	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	💖 Yes, eat right away	21.90	12.90	🔺 So So	9.00	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:59.154126	2026-03-11 03:09:14.246279	f
2978	2025-11-24	13:40:00	5:22, 	Wet	sheba	金罐 鮪魚及白身魚(湯汁)	💖 Yes, eat right away	85.00	39.20	🔺 So So	45.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.159024	2026-03-11 03:09:44.012699	f
2977	2025-11-24	11:00:00	-	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:59.157386	2026-03-11 03:09:52.448958	f
2984	2025-11-25	08:40:00	00:16, 8:54, 	Wet	ciao	ic-506 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	🔺 No, not really. Ate A Little	60.00	22.40	🔺 So So	37.60	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:59.187796	2026-03-11 03:32:28.686371	f
2986	2025-11-25	08:40:00	18:04, 21:39, 00:14, 3:41, 8:53, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	42.80	15.50	🔺 So So	27.30	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.191527	2026-03-11 03:32:37.193971	f
2982	2025-11-25	01:50:00	10:49, 14:47, 15:30, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.20	10.70	🔺 So So	12.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.165742	2026-03-11 03:33:17.348845	f
3008	2025-11-29	01:00:00	19:00, 20:55, 8:29, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	30.90	15.00	🔺 So So	15.90	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.228245	2026-03-11 03:38:37.223463	f
3018	2025-11-30	12:40:00	1:17, 5:15, 7:20, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	28.40	💕 Love it So Much	51.60	3	💖 - 💕	39		\N	2	\N	2026-03-08 13:51:59.245122	2026-03-11 03:41:12.120663	f
3020	2025-11-30	09:00:00	-	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	36.80	30.50	❌ No!!!	6.30	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.248768	2026-03-11 03:43:22.658445	f
3003	2025-11-28	00:25:00	23:26,	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	21.00	14.60	🔺 So So	6.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.21966	2026-03-11 03:37:37.856648	f
3001	2025-11-28	00:25:00	13:29,	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	44.40	🔺 So So	25.60	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.21639	2026-03-11 03:37:20.231554	f
2995	2025-11-27	01:20:00	-	Wet	tuna	愛貓天然食 白身鮪魚+蝦肉	💖 Yes, eat right away	70.00	46.90	❌ No!!!	23.10	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.20633	2026-03-11 03:36:24.047646	f
2991	2025-11-26	07:15:00	00:37, 3:35,	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(800g包裝)	❌ No, not interested	21.70	14.90	🔺 So So	6.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.199754	2026-03-11 03:35:25.936723	f
3013	2025-11-30	01:20:00	-	Wet	sheba	金罐 鮮煮雞胸肉 湯汁	💖 Yes, eat right away	85.00	50.80	❌ No!!!	34.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.236889	2026-03-11 03:39:45.695375	f
3021	2025-12-01	02:10:00	-	Wet	cate	貓餐包 雞肉 (泰國)	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.288003	2026-03-11 03:55:23.728719	f
3010	2025-11-29	07:00:00	-	Kibble	kaniva 卡咪哇	無穀全齡貓 雞, 鮪, 米配方	❌ No, not interested	42.90	42.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.231548	2026-03-11 03:38:08.012721	f
3011	2025-11-29	07:30:00	4:33, 8:31, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	🔺 No, not really. Ate A Little	70.00	40.30	🔺 So So	29.70	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:59.233292	2026-03-11 03:39:02.523302	f
2996	2025-11-27	01:20:00	14:10, 00:58, 1:49, 5:45, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.80	6.70	💕 Love it So Much	15.10	4	❌ - 💕	31		\N	2	\N	2026-03-08 13:51:59.207993	2026-03-11 03:36:16.642794	f
3015	2025-11-30	01:20:00	10:31, 16:43, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.40	14.30	🔺 So So	9.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.240135	2026-03-11 03:40:00.228941	f
2999	2025-11-27	11:15:00	00:59, 5:46	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	25.60	💕 Love it So Much	54.40	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:59.213067	2026-03-11 03:36:41.22789	f
3023	2025-12-01	02:10:00	5:47,	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	16.40	14.70	🔺 So So	1.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.291726	2026-03-11 03:55:14.393285	f
2992	2025-11-26	08:20:00	00:39,	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	🔺 No, not really. Ate A Little	40.00	2.10	💕 Love it So Much	37.90	1	🔺 - 💕	37		\N	2	\N	2026-03-08 13:51:59.201356	2026-03-11 03:34:35.375988	f
2994	2025-11-26	12:00:00	22:44, 3:38,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	70.00	23.60	💕 Love it So Much	46.40	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:59.204701	2026-03-11 03:34:42.894093	f
2993	2025-11-26	08:20:00	18:12, 19:57, 3:37,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	50.80	24.40	🔺 So So	26.40	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.203168	2026-03-11 03:35:03.315626	f
2998	2025-11-27	07:25:00	15:40,	Wet	ciao	tsc-42z 貓用肉泥寒天果凍 鮪魚+沙丁魚 x2	💖 Yes, eat right away	70.00	35.10	🔺 So So	34.90	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.211262	2026-03-11 03:36:00.946206	f
3000	2025-11-27	06:10:00	15:15, 15:39, 18:55, 20:46, 21:44,  1:48, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	52.00	40.00	🔺 So So	12.00	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:59.21476	2026-03-11 03:36:09.366187	f
2997	2025-11-27	01:20:00	-	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(800g包裝)	❌ No, not interested	22.30	22.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.209619	2026-03-11 03:36:31.092521	f
3005	2025-11-28	10:50:00	20:51, 1:32, 5:15	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	33.90	10.40	🔺 So So	23.50	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.223051	2026-03-11 03:37:11.924466	f
3002	2025-11-28	00:25:00	13:27, 16:01, 16:50, 18:27, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	31.30	12.80	🔺 So So	18.50	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.218041	2026-03-11 03:37:30.688541	f
3009	2025-11-29	07:00:00	-	Wet	海兒廚房	朝市場貓用餐包 鰹魚+白身魚口味	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-08 13:51:59.229888	2026-03-11 03:38:14.802684	f
3006	2025-11-29	01:00:00	-	Wet	axia	新金罐濃厚3號  鮪魚+吻仔魚	💖 Yes, eat right away	70.00	36.70	❌ No!!!	33.30	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.224919	2026-03-11 03:38:22.419531	f
3007	2025-11-29	01:00:00	4:31,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.70	8.80	🔺 So So	11.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.226577	2026-03-11 03:38:29.35781	f
3016	2025-11-30	01:20:00	-	Kibble	自然小貓	低碳無穀凍乾糧系列 - 鮮魚佐鮭魚全貓配方(試吃包)	❌ No, not interested	21.30	21.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.241741	2026-03-11 03:39:38.231618	f
3014	2025-11-30	01:20:00	10:31, 1:15, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	21.40	20.80	🔺 So So	0.60	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.238503	2026-03-11 03:39:52.856722	f
3017	2025-11-30	09:00:00	-	Wet	禮加樂 regalos	濃郁鮪魚罐頭	💖 Yes, eat right away	80.00	48.10	❌ No!!!	31.90	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.243425	2026-03-11 03:41:20.432344	f
3019	2025-11-30	09:00:00	19:33, 00:19, 1:16, 5:14, 7:18, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	34.50	9.70	🔺 So So	24.80	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.246743	2026-03-11 03:42:56.638167	f
3022	2025-12-01	02:10:00	-	Wet	atas cat 愛達思	鮮嫩雞肉+蟹肉	💖 Yes, eat right away	80.00	53.30	❌ No!!!	26.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.289955	2026-03-11 03:55:32.954233	f
3038	2025-12-03	09:17:00	4:04, 6:16, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(800g包裝)	❌ No, not interested	24.90	19.80	🔺 So So	5.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.31812	2026-03-11 03:58:21.080506	f
3055	2025-12-06	04:05:00	22:45, 8:38,	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	💖 Yes, eat right away	34.40	22.90	🔺 So So	11.50	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.388284	2026-03-11 04:03:08.881297	f
3052	2025-12-05	07:00:00	-	Kibble	梅亞奶奶	私房無穀鮮嫩雞	❌ No, not interested	15.30	7.20	❌ No!!!	8.10	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.343535	2026-03-11 04:01:26.151852	f
3049	2025-12-05	07:00:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	4.40	❌ No!!!	30.60	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:59.338388	2026-03-11 04:02:19.34963	f
3042	2025-12-04	01:16:00	-	Kibble	梅亞奶奶	鄉村天然寵糧 低敏無穀野撈鮭魚	❌ No, not interested	21.00	21.00	❌ No!!!	0.00	0	❌ - ❌	8	很認真聞飼料, 但沒吃	\N	2	\N	2026-03-08 13:51:59.32563	2026-03-11 03:59:11.852834	f
3044	2025-12-04	11:40:00	-	Wet	sheba	金罐 鮪魚及蟹肉(湯汁)	🔺 No, not really. Ate A Little	85.00	58.20	❌ No!!!	26.80	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.329401	2026-03-11 03:58:48.004237	f
3032	2025-12-02	11:20:00	-	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	52.50	52.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.307111	2026-03-11 03:56:32.103568	f
3036	2025-12-03	09:17:00	-	Wet	ciao	多樂米燒鰹魚濃湯罐 a-48 燒鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	49.00	❌ No!!!	31.00	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.314399	2026-03-11 03:57:57.849734	f
3028	2025-12-02	01:01:00	-	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	22.00	22.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.300418	2026-03-11 03:57:08.215238	f
3025	2025-12-01	09:25:00	5:48,	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	31.40	🔺 So So	38.60	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.295199	2026-03-11 03:55:52.187744	f
3033	2025-12-02	11:20:00	19:20, 20:11, 23:18, 1:07, 3:31, 8:26	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	43.60	10.80	🔺 So So	32.80	6	❌ - 🔺	32		\N	2	\N	2026-03-08 13:51:59.309214	2026-03-11 03:56:24.192536	f
3034	2025-12-03	02:00:00	-	Wet	歐哈吶	無穀貓湯罐 雞肉	🔺 No, not really. Ate A Little	80.00	53.70	❌ No!!!	26.30	0	🔺 - ❌	13	19:50 有吐, 吐出食物原型/20:25 吐, 吐出肉泥	\N	2	\N	2026-03-08 13:51:59.310947	2026-03-11 03:57:40.10221	f
3047	2025-12-05	01:30:00	13:52, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	28.10	22.20	🔺 So So	5.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.33499	2026-03-11 04:01:56.712131	f
3027	2025-12-02	01:01:00	16:55, 	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	39.20	🔺 So So	30.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.298654	2026-03-11 03:56:42.881477	f
3053	2025-12-06	02:20:00	12:08, 	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-94 鮪魚	💖 Yes, eat right away	60.00	22.90	🔺 So So	37.10	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.345191	2026-03-11 04:03:19.903359	f
3045	2025-12-04	11:40:00	20:44, 23:56, 2:22, 5:20, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	46.40	20.80	🔺 So So	25.60	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.331345	2026-03-11 03:58:40.879514	f
3024	2025-12-01	02:10:00	12:28, 16:11,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.30	9.20	🔺 So So	12.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.29347	2026-03-11 03:55:42.968562	f
3026	2025-12-01	09:25:00	00:30, 3:25, 5:47,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	49.80	28.00	🔺 So So	21.80	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.29706	2026-03-11 03:56:04.597724	f
3030	2025-12-02	01:01:00	-	Kibble	kaniva 卡咪哇	全齡室內貓配方	❌ No, not interested	44.00	44.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.303638	2026-03-11 03:56:51.372056	f
3029	2025-12-02	01:01:00	16:54, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	22.40	15.20	🔺 So So	7.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.302024	2026-03-11 03:57:00.493475	f
3035	2025-12-03	02:00:00	10:47, 16:07, 17:13, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.20	8.30	🔺 So So	11.90	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.312607	2026-03-11 03:57:48.268647	f
3037	2025-12-03	09:17:00	20:39, 4:04, 6:17,	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	7.40	💕 Love it So Much	67.60	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:59.316198	2026-03-11 03:58:05.860053	f
3039	2025-12-03	09:17:00	19:44, 20:38, 22:19, 23:58, 1:40, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	41.40	9.20	🔺 So So	32.20	5	❌ - 🔺	30		\N	2	\N	2026-03-08 13:51:59.319912	2026-03-11 03:58:13.578258	f
3043	2025-12-04	11:10:00	23:57, 5:21,	Wet	oasy	雞肉佐哈姆鮮食	🔺 No, not really. Ate A Little	70.00	50.40	🔺 So So	19.60	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:59.327587	2026-03-11 03:58:55.164043	f
3041	2025-12-04	01:16:00	13:34, 14:02, 16:32, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.70	9.00	🔺 So So	12.70	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.32374	2026-03-11 03:59:04.552025	f
3040	2025-12-04	01:16:00	14:04, 	Wet	ciao	啾嚕雪花膏 鮪魚 cs-191	💖 Yes, eat right away	80.00	34.20	🔺 So So	45.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.321964	2026-03-11 03:59:31.953983	f
3051	2025-12-05	07:00:00	15:55, 2:36,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	52.20	28.50	🔺 So So	23.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.341768	2026-03-11 04:01:18.506696	f
3050	2025-12-05	07:00:00	7:15,	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	32.40	🔺 So So	47.60	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.340136	2026-03-11 04:01:33.063249	f
3046	2025-12-05	01:30:00	-	Wet	kisspure 親純	白身鮪魚 & 雞肉	🔺 No, not really. Ate A Little	80.00	70.00	❌ No!!!	10.00	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.332994	2026-03-11 04:01:41.633103	f
3048	2025-12-05	01:30:00	-	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	17.70	17.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.336659	2026-03-11 04:01:48.740798	f
3056	2025-12-06	04:05:00	19:32, 00:49, 4:01, 6:06, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.50	1.90	💕 Love it So Much	19.60	4	❌ - 💕	38		\N	2	\N	2026-03-08 13:51:59.390414	2026-03-11 04:02:59.79563	f
3057	2025-12-06	10:35:00	22:46, 6:07, 	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	💖 Yes, eat right away	80.00	32.80	🔺 So So	47.20	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.392183	2026-03-11 04:03:39.654138	f
3068	2025-12-08	07:30:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g	💖 Yes, eat right away	20.00	0.00	❌ No!!!	20.00	0	💖 - ❌	25	吃光光	\N	2	\N	2026-03-08 13:51:59.411163	2026-03-11 04:05:14.195424	f
3076	2025-12-09	12:20:00	23:06, 1:12, 5:48,	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	34.00	🔺 So So	36.00	3	💖 - 🔺	29		\N	2	\N	2026-03-08 13:51:59.428258	2026-03-11 04:07:35.262122	f
3072	2025-12-08	09:50:00	4:19, 	Kibble	梅亞奶奶	私房無穀鮮嫩雞	❌ No, not interested	24.80	21.90	🔺 So So	2.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.421203	2026-03-11 04:05:52.650182	f
3058	2025-12-07	01:50:00	-	Wet	銀湯匙	餐包 濃郁肉湯 鮪魚	💖 Yes, eat right away	60.00	35.40	❌ No!!!	24.60	0	💖 - ❌	18	15:28 => 聞一聞後, 開始撥沙	\N	2	\N	2026-03-08 13:51:59.393831	2026-03-11 04:04:39.544397	f
3062	2025-12-07	10:30:00	2:26, 5:52, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 x3	💖 Yes, eat right away	90.00	46.90	🔺 So So	43.10	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.400857	2026-03-11 04:04:15.805885	f
3065	2025-12-08	02:20:00	-	Wet	原始叢林	雞肉凍罐 雞肉+鮪魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.405962	2026-03-11 04:05:28.277869	f
3063	2025-12-07	10:30:00	20:13, 21:22, 2:23, 5:51, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	43.80	19.00	🔺 So So	24.80	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.402528	2026-03-11 04:04:07.435135	f
3061	2025-12-07	08:20:00	-	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	11.80	❌ No!!!	18.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.399149	2026-03-11 04:04:23.567329	f
3059	2025-12-07	01:50:00	13:20, 15:28, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.80	11.50	🔺 So So	9.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.395542	2026-03-11 04:04:32.516425	f
3071	2025-12-08	07:30:00	17:49, 22:25, 2:46	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	38.90	20.60	🔺 So So	18.30	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.419331	2026-03-11 04:05:05.541607	f
3067	2025-12-08	02:20:00	11:23, 	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	❌ No, not interested	23.50	23.00	🔺 So So	0.50	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.409457	2026-03-11 04:05:21.647875	f
3064	2025-12-08	02:20:00	-	Wet	axia	妙喵12號片狀 - 鮪, 蟹肉 mmf-12	🔺 No, not really. Ate A Little	70.00	59.60	❌ No!!!	10.40	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.404222	2026-03-11 04:05:35.143974	f
3066	2025-12-08	02:20:00	10:58,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.60	21.70	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.40771	2026-03-11 04:05:42.722938	f
3069	2025-12-08	07:30:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.413017	2026-03-11 04:06:22.011458	f
3077	2025-12-09	07:15:00	13:17, 23:04, 1:09, 3:13, 5:47,	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	51.20	36.90	🔺 So So	14.30	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.429936	2026-03-11 04:06:48.235397	f
3075	2025-12-09	07:15:00	16:36, 17:30, 3:11, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	59.60	50.80	🔺 So So	8.80	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.426583	2026-03-11 04:06:55.9124	f
3073	2025-12-09	00:45:00	13:18, 16:37, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	28.90	🔺 So So	21.10	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.422954	2026-03-11 04:07:05.854849	f
3074	2025-12-09	00:45:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	19.70	19.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.424898	2026-03-11 04:07:15.631825	f
3081	2025-12-10	01:00:00	-	Kibble	origen	愛貓守護8	❌ No, not interested	15.60	15.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.436975	2026-03-11 04:07:54.500554	f
3079	2025-12-10	01:00:00	10:27, 	Wet	axia	金罐8號 高湯 鰹魚	🔺 No, not really. Ate A Little	70.00	50.00	🔺 So So	20.00	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:59.433269	2026-03-11 04:08:01.990535	f
3080	2025-12-10	01:00:00	10:25, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	21.50	19.60	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.434959	2026-03-11 04:08:09.521385	f
3083	2025-12-10	09:45:00	23:46, 1:49, 5:18, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	9.30	💕 Love it So Much	70.70	3	💖 - 💕	46		\N	2	\N	2026-03-08 13:51:59.440456	2026-03-11 04:08:18.243811	f
3082	2025-12-10	06:00:00	16:34, 20:12, 1:47, 3:56, 5:16, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	56.60	38.80	🔺 So So	17.80	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.438668	2026-03-11 04:08:31.979184	f
3078	2025-12-10	01:00:00	9:02, 10:26,	Kibble	快樂貓	鮪魚雞肉貓飼料	💖 Yes, eat right away	20.90	16.10	🔺 So So	4.80	2	💖 - 🔺	27	10:26 => 拿到桌上後狂吃,	\N	2	\N	2026-03-08 13:51:59.431553	2026-03-11 04:08:44.091878	f
3084	2025-12-11	01:30:00	15:57, 	Wet	sheba	金罐 鮪魚及鮮蝦 (湯汁)	💖 Yes, eat right away	85.00	47.70	🔺 So So	37.30	1	💖 - 🔺	25	1:00 門口叫，叫完跑去吃乾乾/5:30 有咬人	\N	2	\N	2026-03-08 13:51:59.442276	2026-03-11 04:09:07.540046	f
3085	2025-12-11	01:30:00	14:01, 15:55, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	17.40	🔺 So So	2.60	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.444079	2026-03-11 04:09:15.043839	f
3086	2025-12-11	01:30:00	20:55, 1:05, 1:28, 3:30	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	40.10	32.00	🔺 So So	8.10	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.445762	2026-03-11 04:09:22.051963	f
3087	2025-12-11	01:30:00	1:05, 	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	39.40	38.00	🔺 So So	1.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.448064	2026-03-11 04:09:29.412481	f
3088	2025-12-11	09:00:00	23:30, 1:06, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	19.00	💕 Love it So Much	61.00	2	💖 - 💕	44		\N	2	\N	2026-03-08 13:51:59.492049	2026-03-11 04:09:37.779817	f
3089	2025-12-12	01:45:00	10:20, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	25.90	💕 Love it So Much	49.10	1	💖 - 💕	35	阿吉醒著的時候, 都會一直叫/10:20 => 吃完天然密碼接著吃	\N	2	\N	2026-03-08 13:51:59.494494	2026-03-11 04:10:30.52059	f
3090	2025-12-12	01:45:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	27.50	27.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.496626	2026-03-11 04:10:37.309552	f
3091	2025-12-12	02:10:00	14:08, 18:16, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	💖 Yes, eat right away	21.20	13.60	🔺 So So	7.60	2	💖 - 🔺	27	天然密碼有加排毛粉當誘食	\N	2	\N	2026-03-08 13:51:59.498605	2026-03-11 04:10:50.675639	f
3108	2025-12-15	01:10:00	-	Wet	銀湯匙	貓罐頭 濃郁鮪魚 tw tmp 123	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	1:30 咬人	\N	2	\N	2026-03-08 13:51:59.534203	2026-03-11 04:14:40.939387	f
3111	2025-12-15	10:00:00	21:51, 2;44, 	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	🔺 No, not really. Ate A Little	70.00	16.80	💕 Love it So Much	53.20	2	🔺 - 💕	39		\N	2	\N	2026-03-08 13:51:59.539149	2026-03-11 04:13:43.00903	f
3107	2025-12-14	09:35:00	5:17, 	Freeze-Dried	汪喵星球	凍乾主食餐 安心雞肉餐	❌ No, not interested	16.30	7.80	🔺 So So	8.50	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.532415	2026-03-11 04:12:36.131932	f
3098	2025-12-13	11:05:00	21:36, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	32.30	🔺 So So	47.70	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.515562	2026-03-11 04:11:44.960258	f
3100	2025-12-13	11:05:00	19:39, 22:31, 	Freeze-Dried	汪喵星球	凍乾主食餐 安心雞肉餐	❌ No, not interested	14.50	6.70	🔺 So So	7.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.519139	2026-03-11 04:12:00.620708	f
3097	2025-12-13	03:20:00	14:45	Freeze-Dried	汪喵星球	凍乾主食餐 安心雞肉餐	💖 Yes, eat right away	11.70	4.50	🔺 So So	7.20	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.513506	2026-03-11 04:11:19.828619	f
3125	2025-12-17	23:01:00	-	Kibble	梅亞奶奶	全齡貓 鄉村鴨	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.564867	2026-03-11 04:18:35.0165	f
3117	2025-12-16	02:10:00	18:05, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	17.90	🔺 So So	2.10	1	❌ - 🔺	15	柏萊富有加排毛粉當誘食/乾乾調整成, 早上放20, 晚上放30(不是放30, 把早上剩餘的20也加進來, 這樣晚餐量會浮動, 不好判定到底吃的量是多少)	\N	2	\N	2026-03-08 13:51:59.550216	2026-03-11 04:15:25.0495	f
3115	2025-12-16	02:10:00	-	Wet	法麗	室內貓排毛 鮪魚佐柴魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	1:28 被咬/白天還是會叫, 22:50 叫/23:00 餓吐, 只有看到晚上九點多餵的肉泥	\N	2	\N	2026-03-08 13:51:59.546013	2026-03-11 04:15:18.084776	f
3124	2025-12-17	23:01:00	-	Kibble	自然小貓	低碳無穀凍乾糧系列 - 海鮮全貓配方(試吃包)	🔺 No, not really. Ate A Little	20.70	19.50	❌ No!!!	1.20	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.563074	2026-03-11 04:18:57.818259	f
3113	2025-12-15	10:00:00	21:12, 21:49, 2:41, 8:50, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	17.30	0.90	💕 Love it So Much	16.40	4	❌ - 💕	38	天然密碼有加排毛粉當誘食	\N	2	\N	2026-03-08 13:51:59.542489	2026-03-11 04:14:31.581007	f
3103	2025-12-14	01:45:00	12:11, 13:41, 16:01, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.50	10.60	🔺 So So	10.90	3	❌ - 🔺	19	天然密碼有加排毛粉當誘食	\N	2	\N	2026-03-08 13:51:59.525299	2026-03-11 04:13:19.103096	f
3120	2025-12-16	11:20:00	20:37, 1:06, 6:45, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	20.40	💕 Love it So Much	59.60	3	💖 - 💕	39		\N	2	\N	2026-03-08 13:51:59.555857	2026-03-11 04:16:02.334652	f
3101	2025-12-14	23:01:00	13:43, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	24.20	🔺 So So	35.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.521581	2026-03-11 04:12:45.893538	f
3114	2025-12-15	10:00:00	21:51, 00:32, 5:28, 8:51, 	Freeze-Dried	汪喵星球	小方粒 凍乾主食餐 安心雞肉餐	❌ No, not interested	33.10	25.40	🔺 So So	7.70	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.544198	2026-03-11 04:14:23.291507	f
3095	2025-12-13	01:40:00	10:15, 	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片 x2	💖 Yes, eat right away	60.00	22.80	🔺 So So	37.20	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.509657	2026-03-11 04:11:29.342708	f
3105	2025-12-14	09:35:00	22:04, 1:12, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	19.20	💕 Love it So Much	60.80	2	💖 - 💕	44		\N	2	\N	2026-03-08 13:51:59.528876	2026-03-11 04:12:20.54232	f
3096	2025-12-13	01:40:00	10:14, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.40	8.90	🔺 So So	14.50	1	❌ - 🔺	15	天然密碼有加排毛粉當誘食	\N	2	\N	2026-03-08 13:51:59.511579	2026-03-11 04:11:37.823896	f
3099	2025-12-13	11:05:00	21:35, 4:29, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	37.90	14.40	🔺 So So	23.50	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.517362	2026-03-11 04:11:52.93639	f
3106	2025-12-14	09:35:00	21:00, 22:03, 1:10,  5:16, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	49.80	8.10	🔺 So So	41.70	4	❌ - 🔺	28		\N	2	\N	2026-03-08 13:51:59.530648	2026-03-11 04:12:27.628178	f
3102	2025-12-14	01:45:00	-	Wet	kisspure 親純	白雞肉	🔺 No, not really. Ate A Little	80.00	72.60	❌ No!!!	7.40	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.523509	2026-03-11 04:13:01.147964	f
3104	2025-12-14	01:45:00	13:42, 	Freeze-Dried	汪喵星球	凍乾主食餐 安心雞肉餐	❌ No, not interested	11.40	9.00	🔺 So So	2.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.527126	2026-03-11 04:13:09.05486	f
3112	2025-12-15	10:00:00	00:34, 	Wet	ciao	啾嚕奢華果凍杯 tsc-41 鮪魚 x2	🔺 No, not really. Ate A Little	70.00	41.60	🔺 So So	28.40	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:59.540852	2026-03-11 04:13:59.064312	f
3110	2025-12-15	01:10:00	10:45, 	Freeze-Dried	汪喵星球	小方粒 凍乾主食餐 安心雞肉餐	❌ No, not interested	20.00	14.50	🔺 So So	5.50	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.537515	2026-03-11 04:14:10.146682	f
3118	2025-12-16	02:10:00	-	Freeze-Dried	汪喵星球	小方粒 凍乾主食餐 安心雞肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.552356	2026-03-11 04:15:08.407499	f
3116	2025-12-16	02:10:00	10:39, 18:06, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	26.40	💕 Love it So Much	48.60	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:59.5482	2026-03-11 04:15:32.978511	f
3123	2025-12-16	11:20:00	1:51, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.20	0.00	💕 Love it So Much	4.20	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.560997	2026-03-11 04:15:43.30442	f
3121	2025-12-16	11:20:00	21:37, 1:03, 	Freeze-Dried	汪喵星球	小方粒 凍乾主食餐 安心雞肉餐	❌ No, not interested	10.00	9.20	🔺 So So	0.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.557516	2026-03-11 04:15:52.485036	f
3122	2025-12-16	06:35:00	19:19, 20:36, 1:03, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	30.30	26.20	🔺 So So	4.10	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.559206	2026-03-11 04:16:14.634715	f
3119	2025-12-16	06:35:00	1:04, 	Kibble	奇境	澳洲野生袋鼠 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.00	18.80	🔺 So So	1.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.554145	2026-03-11 04:16:22.606941	f
3126	2025-12-17	23:01:00	10:35, 14:46, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.30	💕 Love it So Much	6.70	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:59.567002	2026-03-11 04:18:50.502587	f
3152	2025-12-19	07:00:00	5:04, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	1.30	0.00	💕 Love it So Much	1.30	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.713676	2026-03-11 04:32:17.82048	f
3149	2025-12-19	23:45:00	14:30, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.40	0.00	💕 Love it So Much	2.40	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.708744	2026-03-11 04:35:05.209304	f
3142	2025-12-18	15:18:00	1:28, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.70	0.00	💕 Love it So Much	3.70	1	❌ - 💕	32	23:40 一直叫	\N	2	\N	2026-03-08 13:51:59.697404	2026-03-11 04:21:28.30293	f
3155	2025-12-19	07:50:00	19:31, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	💖 Yes, eat right away	35.00	3.00	💕 Love it So Much	32.00	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:59.718674	2026-03-11 04:31:10.511615	f
3141	2025-12-18	00:40:00	20:00, 1:26, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	7.00	0.00	💕 Love it So Much	7.00	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.695639	2026-03-11 04:21:46.146497	f
3136	2025-12-18	00:40:00	9:44, 14:53, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.10	💕 Love it So Much	6.90	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:59.603129	2026-03-11 04:20:53.242017	f
3145	2025-12-19	23:45:00	-	Wet	銀湯匙	多樂米-鮪魚(境內版- 包裝上都是泰文) tt-mp	💖 Yes, eat right away	60.00	32.60	❌ No!!!	27.40	0	💖 - ❌	18	9:00 一直叫/13:00 回家時，阿吉一直叫/19:00 掃地機器人打掃家裡時，有點躁動	\N	2	\N	2026-03-08 13:51:59.702366	2026-03-11 04:33:05.729177	f
3148	2025-12-19	23:45:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 小方粒 低敏鴨肉餐	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.707176	2026-03-11 04:32:53.630075	f
3150	2025-12-19	07:00:00	15:02, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.50	3.20	🔺 So So	1.30	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.710445	2026-03-11 04:32:31.973814	f
3160	2025-12-20	01:00:00	15:16, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.50	0.00	💕 Love it So Much	2.50	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.726748	2026-03-11 04:36:09.847511	f
3134	2025-12-17	10:40:00	5:11, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	5.60	4.20	🔺 So So	1.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.597344	2026-03-11 04:19:43.864079	f
3137	2025-12-18	00:40:00	9:45, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	43.50	🔺 So So	36.50	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.688149	2026-03-11 04:21:00.493994	f
3129	2025-12-17	23:01:00	11:13, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.80	0.00	💕 Love it So Much	2.80	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.587994	2026-03-11 04:18:42.594209	f
3154	2025-12-19	07:00:00	22:04, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.20	1.90	🔺 So So	1.30	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.717107	2026-03-11 04:31:55.137261	f
3131	2025-12-17	06:15:00	20:18, 21:36, 1:31, 5:09, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.10	4.30	🔺 So So	25.80	4	❌ - 🔺	28	21:20 撒排毛粉誘食/20:50 很躁動...感覺要咬人了	\N	2	\N	2026-03-08 13:51:59.592103	2026-03-11 04:18:14.269945	f
3128	2025-12-17	23:01:00	10:38, 14:47, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	70.00	29.30	💕 Love it So Much	40.70	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:59.575189	2026-03-11 04:19:05.053607	f
3133	2025-12-17	10:40:00	21:21, 5:09,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	3.30	0.00	💕 Love it So Much	3.30	2	❌ - 💕	34	剩屑屑	\N	2	\N	2026-03-08 13:51:59.595595	2026-03-11 04:19:32.031198	f
3132	2025-12-17	10:40:00	1:33, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	31.20	🔺 So So	48.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.593864	2026-03-11 04:19:56.739823	f
3144	2025-12-18	10:30:00	5:03, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	44.80	🔺 So So	30.20	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.700755	2026-03-11 04:20:36.695264	f
3140	2025-12-18	00:40:00	-	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	30.20	30.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.693939	2026-03-11 04:20:46.090007	f
3138	2025-12-18	00:40:00	9:20, 10:24, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	5.50	0.00	💕 Love it So Much	5.50	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.690305	2026-03-11 04:21:08.390326	f
3139	2025-12-18	00:40:00	17:27, 19:59, 21:19, 00:45, 5:01, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	10.00	🔺 So So	20.00	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.692152	2026-03-11 04:21:17.30192	f
3143	2025-12-18	10:30:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	3.10	3.10	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.69908	2026-03-11 04:21:36.587277	f
3135	2025-12-18	00:40:00	9:44, 13:33, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	13.90	🔺 So So	6.10	2	❌ - 🔺	17	撒汪喵排毛粉誘食	\N	2	\N	2026-03-08 13:51:59.601271	2026-03-11 04:21:53.552171	f
3153	2025-12-19	07:00:00	5:05, 	Freeze-Dried	汪喵星球	凍乾主食餐 小方粒 低敏鴨肉餐	❌ No, not interested	10.00	8.90	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.715504	2026-03-11 04:31:25.986569	f
3151	2025-12-19	07:00:00	19:57, 21:17, 23:11, 2:51, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	6.70	💕 Love it So Much	23.30	4	❌ - 💕	38		\N	2	\N	2026-03-08 13:51:59.712052	2026-03-11 04:32:08.387473	f
3147	2025-12-19	23:45:00	8:31, 9:37,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	1.30	💕 Love it So Much	8.70	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.705569	2026-03-11 04:32:44.702648	f
3146	2025-12-19	23:45:00	13:10, 13:39, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	15.10	🔺 So So	4.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.703988	2026-03-11 04:34:50.945347	f
3156	2025-12-19	09:55:00	19:59, 23:12, 5:06, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	25.20	💕 Love it So Much	54.80	3	💖 - 💕	39		\N	2	\N	2026-03-08 13:51:59.720267	2026-03-11 04:35:16.663496	f
3159	2025-12-20	01:00:00	9:56, 13:58, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	0.50	💕 Love it So Much	9.50	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.725187	2026-03-11 04:36:00.173263	f
3157	2025-12-20	01:00:00	15:15, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	51.50	🔺 So So	28.50	1	🔺 - 🔺	20	00:00 有叫，後來給了一匙排毛粉/4:40 被輕咬	\N	2	\N	2026-03-08 13:51:59.721865	2026-03-11 04:36:32.16116	f
3161	2025-12-20	09:15:00	19:36, 23:40, 1;16, 4:11, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	20.20	💕 Love it So Much	59.80	4	💖 - 💕	41		\N	2	\N	2026-03-08 13:51:59.728334	2026-03-11 04:37:03.701221	f
3170	2025-12-21	10:40:00	-	Wet	ciao	極致濃湯餐包 ic-504 鮪魚+雞肉+干貝	💖 Yes, eat right away	30.00	9.20	❌ No!!!	20.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.743721	2026-03-11 04:39:44.89903	f
3191	2025-12-23	09:40:00	18:41, 20:07,  21:29, 00:57, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	18.80	💕 Love it So Much	61.20	4	💖 - 💕	48		\N	2	\N	2026-03-08 13:51:59.800303	2026-03-11 04:53:10.050055	f
3195	2025-12-23	09:39:00	18:40, 6:07, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	7.60	2.00	💕 Love it So Much	5.60	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:59.806797	2026-03-11 04:53:37.296844	f
3176	2025-12-22	00:39:00	-	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	1.70	1.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.753447	2026-03-11 04:42:07.880689	f
3179	2025-12-22	11:30:00	3:57,	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	💖 Yes, eat right away	80.00	38.50	🔺 So So	41.50	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.75832	2026-03-11 04:45:52.659824	f
3164	2025-12-21	00:36:00	11:09, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	29.40	🔺 So So	20.60	1	💖 - 🔺	25	白天還是會叫...但遊戲之後, 就會去吃飯, 接著就睡覺了/晚上狀況相對穩定很多	\N	2	\N	2026-03-08 13:51:59.733329	2026-03-11 04:38:12.039372	f
3163	2025-12-20	09:15:00	17:57, 1:13, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	5.20	0.00	💕 Love it So Much	5.20	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.731553	2026-03-11 04:36:53.026204	f
3189	2025-12-23	01:45:00	15:45, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.60	2.20	🔺 So So	2.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.797315	2026-03-11 04:53:57.188488	f
3165	2025-12-21	00:36:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.735213	2026-03-11 04:38:03.862462	f
3174	2025-12-22	00:39:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.750298	2026-03-11 04:41:55.893254	f
3177	2025-12-22	00:39:00	13:37, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.50	0.00	💕 Love it So Much	3.50	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.755058	2026-03-11 04:43:13.772392	f
3169	2025-12-21	10:40:00	4:56, 	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	🔺 No, not really. Ate A Little	70.00	24.80	💕 Love it So Much	45.20	1	🔺 - 💕	30		\N	2	\N	2026-03-08 13:51:59.742029	2026-03-11 04:40:09.022422	f
3168	2025-12-21	02:05:00	-	Freeze-Dried	誠實貓	雞肉凍乾	💖 Yes, eat right away	2.10	0.00	❌ No!!!	2.10	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:59.740327	2026-03-11 04:37:35.489948	f
3162	2025-12-20	09:15:00	19:35, 20:54, 23:39, 1:14, 4:09, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	9.70	🔺 So So	20.30	5	❌ - 🔺	23		\N	2	\N	2026-03-08 13:51:59.729925	2026-03-11 04:36:42.587854	f
3167	2025-12-21	02:05:00	14:54,	Freeze-Dried	誠實貓	鴨肉凍乾	💖 Yes, eat right away	3.20	0.00	💕 Love it So Much	3.20	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:59.738595	2026-03-11 04:37:44.389864	f
3166	2025-12-21	00:36:00	15:12, 17:00	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	2.50	💕 Love it So Much	12.50	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.736885	2026-03-11 04:37:53.607153	f
3171	2025-12-21	10:40:00	20:26, 23:39, 00:37, 4:54, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	9.80	🔺 So So	20.20	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.745405	2026-03-11 04:39:03.324894	f
3172	2025-12-21	10:40:00	23:40, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	2.50	1.40	💕 Love it So Much	1.10	1	❌ - 💕	25		\N	2	\N	2026-03-08 13:51:59.747103	2026-03-11 04:39:56.102975	f
3178	2025-12-22	07:20:00	18:05, 	Wet	ciao	ic-312 巧餐包 奢華干貝+鮪魚+雞肉	💖 Yes, eat right away	35.00	6.80	💕 Love it So Much	28.20	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:59.756648	2026-03-11 04:41:19.830694	f
3181	2025-12-22	07:20:00	18:04, 23:37,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.40	2.80	💕 Love it So Much	7.60	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:59.761419	2026-03-11 04:41:35.537337	f
3175	2025-12-22	00:39:00	9:32, 11:37, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.20	10.40	🔺 So So	4.80	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.751889	2026-03-11 04:42:25.084388	f
3182	2025-12-22	11:30:00	19:29, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	1.70	0.00	💕 Love it So Much	1.70	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.762909	2026-03-11 04:43:34.020511	f
3180	2025-12-22	11:30:00	21:14, 00:39, 3:56,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	10.90	🔺 So So	19.10	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.759943	2026-03-11 04:43:46.640276	f
3193	2025-12-23	09:39:00	23:43, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	2.20	0.00	💕 Love it So Much	2.20	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.803433	2026-03-11 04:52:00.501658	f
3185	2025-12-23	00:39:00	-	Wet	axia	樂妙喵2號 鮪, 雞胸 mt-2	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.791171	2026-03-11 04:52:29.272781	f
3184	2025-12-23	00:39:00	16:43, 	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	4.40	💕 Love it So Much	35.60	1	💖 - 💕	42		\N	2	\N	2026-03-08 13:51:59.789505	2026-03-11 04:52:38.253988	f
3183	2025-12-23	00:39:00	-	Wet	pramy 普拉	經典貓餐包 黃金鮮鮪+放山雞	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.787747	2026-03-11 04:52:46.432793	f
3186	2025-12-23	00:39:00	12:36, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.20	15.50	🔺 So So	4.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.792678	2026-03-11 04:52:54.670259	f
3192	2025-12-23	09:39:00	-	Freeze-Dried	誠實貓	雞肉凍乾	💖 Yes, eat right away	2.70	0.00	❌ No!!!	2.70	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:59.801882	2026-03-11 04:53:19.51289	f
3194	2025-12-23	09:39:00	20:06, 21:28, 00:54, 6:06, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.20	10.30	🔺 So So	19.90	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.805182	2026-03-11 04:53:27.817513	f
3188	2025-12-23	01:45:00	-	Freeze-Dried	誠實貓	雞肉凍乾	💖 Yes, eat right away	3.10	0.00	❌ No!!!	3.10	0	💖 - ❌	25		\N	2	\N	2026-03-08 13:51:59.795794	2026-03-11 04:54:07.180624	f
3190	2025-12-23	02:00:00	12:37, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	❌ No, not interested	60.00	31.40	🔺 So So	28.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.798777	2026-03-11 04:54:20.862394	f
3187	2025-12-23	01:45:00	8:40, 16:41, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.10	7.60	💕 Love it So Much	7.50	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:59.794298	2026-03-11 04:54:33.254267	f
3211	2025-12-25	06:35:00	19:27, 	Wet	ciao	ic-595 綜合海鮮鮪魚和鰹魚系列 - 扇貝	🔺 No, not really. Ate A Little	40.00	22.70	🔺 So So	17.30	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:59.8326	2026-03-11 07:41:25.423679	f
3229	2025-12-27	09:30:00	22:22, 3:38, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	23.50	💕 Love it So Much	56.50	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:59.860845	2026-03-11 07:44:42.140652	f
3219	2025-12-26	09:36:00	17:55, 00:11, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉) x3	🔺 No, not really. Ate A Little	105.00	70.70	🔺 So So	34.30	2	🔺 - 🔺	22		\N	2	\N	2026-03-08 13:51:59.844961	2026-03-11 07:42:25.671332	f
3222	2025-12-26	09:36:00	20:41, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.50	0.00	💕 Love it So Much	3.50	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.849715	2026-03-11 07:43:02.14159	f
3208	2025-12-25	00:50:00	13:35, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	43.40	🔺 So So	26.60	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.82812	2026-03-11 07:40:19.031575	f
3198	2025-12-24	00:44:00	16:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.20	8.40	🔺 So So	6.80	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.811968	2026-03-11 07:37:27.162004	f
3205	2025-12-24	11:15:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	8.40	8.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.823442	2026-03-11 07:39:11.630148	f
3213	2025-12-25	09:55:00	19:26, 22:44, 4:20, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	15.80	🔺 So So	14.20	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.835664	2026-03-11 07:40:07.987027	f
3217	2025-12-26	00:50:00	12:18, 16:12, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	9.70	🔺 So So	10.30	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.84186	2026-03-11 07:42:18.160963	f
3227	2025-12-27	04:20:00	15:14,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.20	7.10	💕 Love it So Much	8.10	1	❌ - 💕	25		\N	2	\N	2026-03-08 13:51:59.857393	2026-03-11 07:43:32.583476	f
3210	2025-12-25	00:50:00	9:35, 13:36, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.30	11.60	🔺 So So	3.70	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.831076	2026-03-11 07:40:52.83114	f
3202	2025-12-24	11:15:00	-	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 直接撥沙	\N	2	\N	2026-03-08 13:51:59.818647	2026-03-11 07:39:22.327966	f
3207	2025-12-24	16:07:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	39.60	❌ No!!!	30.40	0	💖 - ❌	18		\N	2	\N	2026-03-08 13:51:59.826596	2026-03-11 07:38:10.349192	f
3209	2025-12-25	00:50:00	13:33, 16:47, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.20	14.70	🔺 So So	5.50	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.829584	2026-03-11 07:41:01.532509	f
3225	2025-12-27	04:20:00	-	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉	🔺 No, not really. Ate A Little	35.00	22.40	❌ No!!!	12.60	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.854327	2026-03-11 07:43:42.085665	f
3200	2025-12-24	03:20:00	15:23, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝	🔺 No, not really. Ate A Little	30.00	13.20	🔺 So So	16.80	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:59.815467	2026-03-11 07:37:07.721007	f
3197	2025-12-24	00:44:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.810118	2026-03-11 07:37:18.690407	f
3206	2025-12-24	15:55:00	5:25, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.50	0.00	💕 Love it So Much	3.50	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.825079	2026-03-11 07:38:23.149601	f
3203	2025-12-24	11:15:00	20:15, 3:04,	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	44.00	🔺 So So	36.00	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.820265	2026-03-11 07:38:51.178442	f
3204	2025-12-24	11:15:00	20:13, 21:51, 3:02,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	7.90	🔺 So So	22.10	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.821762	2026-03-11 07:38:59.562381	f
3201	2025-12-24	08:25:00	-	Wet	自然小貓	無膠肉湯罐 雞肉雞湯	🔺 No, not really. Ate A Little	80.00	63.30	❌ No!!!	16.70	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.81707	2026-03-11 07:39:37.633477	f
3212	2025-12-25	09:55:00	22:46, 4:22,	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	25.80	💕 Love it So Much	54.20	2	💖 - 💕	37		\N	2	\N	2026-03-08 13:51:59.834104	2026-03-11 07:40:28.137608	f
3215	2025-12-25	09:55:00	00:18, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	5.20	0.00	💕 Love it So Much	5.20	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.838679	2026-03-11 07:40:36.296925	f
3214	2025-12-25	09:55:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	11.60	11.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.837203	2026-03-11 07:40:44.91273	f
3216	2025-12-26	00:50:00	9:27, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	24.80	💕 Love it So Much	40.20	1	💖 - 💕	35	4:10 咬人	\N	2	\N	2026-03-08 13:51:59.840312	2026-03-11 07:41:56.51592	f
3218	2025-12-26	00:50:00	9:29, 13:59, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.10	7.20	💕 Love it So Much	7.90	2	❌ - 💕	27		\N	2	\N	2026-03-08 13:51:59.843388	2026-03-11 07:42:07.758665	f
3223	2025-12-26	09:36:00	21:24, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	1.50	0.00	💕 Love it So Much	1.50	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.851337	2026-03-11 07:42:38.837564	f
3220	2025-12-26	09:36:00	22:35, 00:09, 4:11, 6:23, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	6.00	🔺 So So	24.00	4	❌ - 🔺	28		\N	2	\N	2026-03-08 13:51:59.846504	2026-03-11 07:42:51.224843	f
3221	2025-12-26	09:36:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	7.20	7.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.848096	2026-03-11 07:43:11.011368	f
3224	2025-12-27	02:20:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-95 鰹魚	🔺 No, not really. Ate A Little	60.00	40.90	❌ No!!!	19.10	0	🔺 - ❌	13	19:55 有點躁動, 叫想引起我的注意	\N	2	\N	2026-03-08 13:51:59.852835	2026-03-11 07:43:54.959203	f
3228	2025-12-27	02:20:00	11:20,	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	3.20	0.00	💕 Love it So Much	3.20	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.859028	2026-03-11 07:44:03.745885	f
3231	2025-12-27	09:30:00	19:35, 21:08, 22:21, 3:36, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	12.40	🔺 So So	17.60	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:59.863987	2026-03-11 07:44:32.82904	f
3226	2025-12-27	04:20:00	15:12, 17:29, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	14.00	🔺 So So	6.00	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.855935	2026-03-11 07:45:42.979376	f
3263	2025-12-30	09:35:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	10.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.940734	2026-03-11 07:56:28.379862	f
3256	2025-12-29	09:30:00	4:53,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	12.00	8.50	🔺 So So	3.50	1	❌ - 🔺	15	3:30 有叫, 感覺有點快咬人了	\N	2	\N	2026-03-08 13:51:59.929919	2026-03-11 07:51:08.789277	f
3239	2025-12-28	02:30:00	-	Freeze-Dried	誠實貓	雞肉凍乾	🔺 No, not really. Ate A Little	3.60	1.60	❌ No!!!	2.00	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.900754	2026-03-11 07:47:21.28263	f
3246	2025-12-28	12:15:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	14.80	14.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.912887	2026-03-11 07:48:56.442928	f
3238	2025-12-28	02:30:00	11:45, 15:28, 16:19,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	23.20	19.20	🔺 So So	4.00	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.899066	2026-03-11 07:47:05.414256	f
3260	2025-12-30	01:20:00	10:14, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.10	0.00	💕 Love it So Much	2.10	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.93619	2026-03-11 07:55:03.216818	f
3252	2025-12-29	02:10:00	15:00,	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	6.20	3.50	🔺 So So	2.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.923057	2026-03-11 07:51:47.646606	f
3242	2025-12-28	10:00:00	19:50, 20:51, 4:17, 8:27, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	🔺 No, not really. Ate A Little	60.00	15.20	💕 Love it So Much	44.80	4	🔺 - 💕	36		\N	2	\N	2026-03-08 13:51:59.906053	2026-03-11 07:49:05.849048	f
3253	2025-12-29	07:25:00	17:18,	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	30.50	💕 Love it So Much	44.50	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:59.924655	2026-03-11 07:51:26.829154	f
3241	2025-12-28	06:30:00	-	Wet	自然小貓	無膠肉湯罐 雞肉佐番茄雞湯	🔺 No, not really. Ate A Little	80.00	59.20	❌ No!!!	20.80	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.904215	2026-03-11 07:46:52.601466	f
3233	2025-12-28	01:30:00	-	Wet	三洋食品	小玉傳說 御之手箱餐包 #70鮪魚	🔺 No, not really. Ate A Little	60.00	51.10	❌ No!!!	8.90	0	🔺 - ❌	13	4:30 咬人，躁動&叫/早上到傍晚, 蠻躁動的/吃後還是一直叫, 	6.90	2	\N	2026-03-08 13:51:59.890345	2026-03-11 07:47:57.897503	f
3232	2025-12-27	12:10:00	5:34, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	7.10	1.00	💕 Love it So Much	6.10	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.888286	2026-03-11 07:44:23.931819	f
3236	2025-12-28	02:30:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.30	20.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.895629	2026-03-11 07:47:13.396392	f
3240	2025-12-28	02:30:00	-	Freeze-Dried	誠實貓	鴨肉凍乾	🔺 No, not really. Ate A Little	4.90	2.50	❌ No!!!	2.40	0	🔺 - ❌	13		\N	2	\N	2026-03-08 13:51:59.90252	2026-03-11 07:47:30.122917	f
3235	2025-12-28	02:30:00	14:27, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	🔺 No, not really. Ate A Little	50.00	43.90	🔺 So So	6.10	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:59.893852	2026-03-11 07:47:38.845738	f
3237	2025-12-28	02:30:00	16:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.20	14.80	🔺 So So	0.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.897373	2026-03-11 07:47:46.57498	f
3234	2025-12-28	01:30:00	-	Wet	銀湯匙	多樂米-鮪魚, 雞胸肉(境內版- 包裝上都是泰文) tt-mc	🔺 No, not really. Ate A Little	60.00	45.70	❌ No!!!	14.30	0	🔺 - ❌	13	吃後還是一直叫, 	\N	2	\N	2026-03-08 13:51:59.892102	2026-03-11 07:48:05.312804	f
3247	2025-12-28	12:15:00	20:30, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.30	0.00	💕 Love it So Much	2.30	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.914533	2026-03-11 07:48:19.242183	f
3248	2025-12-28	12:15:00	22:25, 00:46	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.70	0.00	💕 Love it So Much	3.70	2	❌ - 💕	34		\N	2	\N	2026-03-08 13:51:59.916197	2026-03-11 07:48:27.967243	f
3243	2025-12-28	12:15:00	-	Wet	ciao	啾嚕雪花膏 鮪魚 cs-191	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.907673	2026-03-11 07:48:37.960922	f
3244	2025-12-28	12:15:00	4:15, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.30	15.40	🔺 So So	4.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.909368	2026-03-11 07:48:46.878656	f
3245	2025-12-28	10:00:00	18:00, 21:22, 23:55, 00:46, 1:28, 8:26, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	30.00	16.00	🔺 So So	14.00	6	❌ - 🔺	25		\N	2	\N	2026-03-08 13:51:59.911065	2026-03-11 07:49:16.868507	f
3254	2025-12-29	11:50:00	4:50,	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	🔺 No, not really. Ate A Little	60.00	29.50	🔺 So So	30.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-08 13:51:59.926335	2026-03-11 07:50:44.344408	f
3250	2025-12-29	02:10:00	12:22, 17:18, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	8.60	🔺 So So	11.40	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.919799	2026-03-11 07:50:51.619065	f
3251	2025-12-29	02:10:00	10:49, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.20	12.00	🔺 So So	3.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.921439	2026-03-11 07:51:37.28461	f
3249	2025-12-29	02:10:00	11:21, 	Wet	ciao	多樂米濃湯罐 11歲雞肉+鮪魚+扇貝(a-46)	💖 Yes, eat right away	80.00	49.00	🔺 So So	31.00	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.918022	2026-03-11 07:51:57.50339	f
3257	2025-12-30	01:20:00	16:07, 	Wet	ciao	ic-135 貓用六種機能湯餐包 - 鮪魚+雞肉+扇貝 x2	💖 Yes, eat right away	60.00	33.50	🔺 So So	26.50	1	💖 - 🔺	25		\N	2	\N	2026-03-08 13:51:59.931416	2026-03-11 07:54:34.048095	f
3259	2025-12-30	01:20:00	10:37,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	15.00	10.30	🔺 So So	4.70	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.934584	2026-03-11 07:54:44.546739	f
3264	2025-12-30	15:30:00	6:11	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	24.70	💕 Love it So Much	50.30	1	💖 - 💕	35		\N	2	\N	2026-03-08 13:51:59.942249	2026-03-11 07:55:38.134052	f
3265	2025-12-30	15:30:00	18:00,	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.10	0.00	💕 Love it So Much	2.10	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.943766	2026-03-11 07:55:48.567729	f
3266	2025-12-30	15:30:00	1:22,	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	5.60	0.00	💕 Love it So Much	5.60	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.945307	2026-03-11 07:55:56.837981	f
3261	2025-12-30	09:35:00	-	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	80.00	38.40	❌ No!!!	41.60	0	💖 - ❌	18	21:00 有點躁動&叫/23:10 吃完馬上吐, 補10克乾乾	\N	2	\N	2026-03-08 13:51:59.937678	2026-03-11 07:56:07.510216	f
3262	2025-12-30	09:35:00	19:24, 00:41, 6:09, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	40.90	12.80	🔺 So So	28.10	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.939214	2026-03-11 07:56:17.744087	f
3267	2025-12-31	02:05:00	-	Wet	金湯	愛貓湯罐 白身鮪魚&小麥草	💖 Yes, eat right away	80.00	54.90	❌ No!!!	25.10	0	💖 - ❌	18	5:30 叫 & 躁動/11:00 一直叫	\N	2	\N	2026-03-08 13:51:59.946906	2026-03-11 07:58:08.867669	f
3274	2025-12-31	11:35:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	13.00	13.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:52:00.008235	2026-03-11 07:58:46.234612	f
3275	2025-12-31	11:35:00	1:18, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.00	0.00	💕 Love it So Much	2.00	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:52:00.010175	2026-03-11 07:58:54.994499	f
3277	2025-09-02	11:45:00	4:14, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚) 	💖 Yes, eat right away	85.00	55.60	🔺 So So	29.40	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.290762	2026-03-10 09:15:54.756738	f
3279	2025-09-05	10:55:00	22:23, 3:54, 8:40, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	38.60	🔺 So So	46.40	3	💖 - 🔺	29		\N	2	\N	2026-03-08 14:01:20.3018	2026-03-10 09:30:52.984999	f
3278	2025-09-05	07:10:00	-	Wet	mon petit 貓倍麗	珍饌雞里肌肉餐盒 lc4	💖 Yes, eat right away	57.00	37.90	❌ No!!!	19.10	0	💖 - ❌	18		\N	2	\N	2026-03-08 14:01:20.29865	2026-03-10 09:31:39.94457	f
3280	2025-09-08	07:30:00	-	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	💖 Yes, eat right away	57.00	41.80	❌ No!!!	15.20	0	💖 - ❌	18		\N	2	\N	2026-03-08 14:01:20.307228	2026-03-10 09:35:19.895996	f
3281	2025-09-10	11:00:00	00:24,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	50.70	🔺 So So	34.30	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.320099	2026-03-10 09:38:57.730081	f
3282	2025-09-17	10:45:00	1:42, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	48.50	🔺 So So	36.50	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.362625	2026-03-10 10:24:18.228376	f
3283	2025-09-23	12:38:00	2:50, 	Wet	mon petit 貓倍麗	貓倍麗 嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	59.80	🔺 So So	25.20	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.365796	2026-03-10 12:57:11.3684	f
3284	2025-10-03	07:40:00	17:52, 	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	💖 Yes, eat right away	57.00	37.20	🔺 So So	19.80	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.368338	2026-03-10 13:16:26.785628	f
3285	2025-10-09	01:15:00	-	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	🔺 No, not really. Ate A Little	57.00	38.50	❌ No!!!	18.50	0	🔺 - ❌	13		\N	2	\N	2026-03-08 14:01:20.370851	2026-03-10 15:05:40.315073	f
3286	2025-10-11	11:05:00	19:31, 22:48, 5:25, 	Wet	mon petit 貓倍麗	貓倍麗 嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	38.50	🔺 So So	46.50	3	💖 - 🔺	29		\N	2	\N	2026-03-08 14:01:20.37383	2026-03-10 15:09:17.393626	f
3287	2025-10-18	10:45:00	-	Wet	mon petit 貓倍麗	貓倍麗 嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	61.40	❌ No!!!	23.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 14:01:20.37594	2026-03-10 15:28:52.546314	f
3288	2025-10-22	12:30:00	1:26, 4:49, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	47.70	🔺 So So	37.30	2	💖 - 🔺	27		\N	2	\N	2026-03-08 14:01:20.377859	2026-03-10 15:36:50.075552	f
3290	2025-10-29	11:20:00	2:47, 5:24,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	27.80	💕 Love it So Much	57.20	2	💖 - 💕	37		\N	2	\N	2026-03-08 14:01:20.382964	2026-03-10 15:53:26.922367	f
3289	2025-10-29	07:30:00	-	Wet	mon petit 貓倍麗	極上餐包 鮮鮪嫩雞 lp3-c	🔺 No, not really. Ate A Little	35.00	17.10	❌ No!!!	17.90	0	🔺 - ❌	13		\N	2	\N	2026-03-08 14:01:20.380298	2026-03-10 15:54:50.258881	f
3291	2025-11-02	09:35:00	18:48, 1:53, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	42.10	🔺 So So	42.90	2	💖 - 🔺	27		\N	2	\N	2026-03-08 14:01:20.384766	2026-03-11 01:32:19.341186	f
3293	2025-11-05	11:30:00	23:13, 5:22, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	26.40	💕 Love it So Much	58.60	2	💖 - 💕	37		\N	2	\N	2026-03-08 14:01:20.388754	2026-03-11 01:37:14.809679	f
3292	2025-11-05	02:10:00	-	Wet	mon petit 貓倍麗	極上餐包- 鮮鮪紅鯛	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 14:01:20.386526	2026-03-11 01:37:36.080651	f
3294	2025-11-06	07:00:00	-	Wet	mon petit 貓倍麗	奢華天然餐包 嚴選鮪魚+雞肉 nlp6	🔺 No, not really. Ate A Little	30.00	22.60	❌ No!!!	7.40	0	🔺 - ❌	13		\N	2	\N	2026-03-08 14:01:20.390531	2026-03-11 01:40:24.381998	f
3295	2025-11-07	23:45:00	-	Wet	mon petit 貓倍麗	珍饌雞里肌肉餐盒 lc4	💖 Yes, eat right away	57.00	36.00	❌ No!!!	21.00	0	💖 - ❌	18		\N	2	\N	2026-03-08 14:01:20.392239	2026-03-11 01:41:24.41663	f
3296	2025-11-08	11:20:00	23:56, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	47.00	🔺 So So	38.00	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.394015	2026-03-11 01:42:42.160491	f
3297	2025-11-11	06:45:00	-	Wet	mon petit 貓倍麗	鮪魚蟹肉鰹魚 極品上湯	💖 Yes, eat right away	40.00	20.30	❌ No!!!	19.70	0	💖 - ❌	18		\N	2	\N	2026-03-08 14:01:20.397214	2026-03-11 02:35:49.394822	f
3299	2025-11-17	12:45:00	8:05,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	54.30	🔺 So So	30.70	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.401369	2026-03-11 03:00:35.020586	f
3255	2025-12-29	09:30:00	19:44, 21:28, 23:50, 4:49, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	31.00	3.90	💕 Love it So Much	27.10	4	❌ - 💕	38	17:30 加1g排毛粉	\N	2	\N	2026-03-08 13:51:59.928095	2026-03-11 07:50:59.603133	f
3276	2025-12-31	11:35:00	1:18,	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.00	0.00	💕 Love it So Much	4.00	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:52:00.012298	2026-03-11 07:55:22.997252	f
3271	2025-12-31	03:10:00	15:50, 	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	3.60	0.00	💕 Love it So Much	3.60	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.953355	2026-03-11 07:57:27.681321	f
3270	2025-12-31	03:10:00	12:32, 17:21, 	Wet	ciao	ic-211 貓用巧餐包-鮪魚+扇貝	❌ No, not interested	40.00	11.90	🔺 So So	28.10	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.951672	2026-03-11 07:57:40.262659	f
3268	2025-12-31	02:05:00	12:31, 17:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	7.50	🔺 So So	12.90	2	❌ - 🔺	17		\N	2	\N	2026-03-08 13:51:59.948437	2026-03-11 07:57:58.828272	f
3273	2025-12-31	11:35:00	19:34, 22:22, 23:38, 3:11, 6:40, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	3.80	💕 Love it So Much	26.70	5	❌ - 💕	40		\N	2	\N	2026-03-08 13:51:59.988056	2026-03-11 07:58:35.267776	f
3272	2025-12-31	11:35:00	22:23, 6:41, 	Wet	ciao	ic-212 貓用巧餐包- 鰹魚+扇貝 x2	💖 Yes, eat right away	80.00	30.70	🔺 So So	49.30	2	💖 - 🔺	27		\N	2	\N	2026-03-08 13:51:59.954963	2026-03-11 07:59:15.893722	f
2590	2025-09-29	07:40:00	16:33, 18:19, 22:10, 5:47	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	36.30	6.40	🔺 So So	29.90	4	❌ - 🔺	28		\N	2	\N	2026-03-08 13:51:57.85331	2026-03-10 13:11:34.514327	f
2696	2025-10-15	01:15:00	11:23, 	Kibble	天然密碼	低敏雞肉 全齡貓配方	❌ No, not interested	16.00	14.60	🔺 So So	1.40	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:58.116075	2026-03-10 15:23:43.23033	f
3300	2025-11-22	01:25:00	10:08, 15:36,	Wet	mon petit 貓倍麗	嚴選金罐 極品鮪魚真鯛(特選鯛魚塊)	💖 Yes, eat right away	85.00	55.70	🔺 So So	29.30	2	💖 - 🔺	27		\N	2	\N	2026-03-08 14:01:20.403443	2026-03-11 03:06:24.245066	f
3301	2025-11-25	10:45:00	-	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	46.20	❌ No!!!	38.80	0	💖 - ❌	18		\N	2	\N	2026-03-08 14:01:20.405433	2026-03-11 03:32:54.921619	f
3302	2025-11-28	10:50:00	20:52, 23:28, 1:33, 5:18,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	31.90	💕 Love it So Much	53.10	4	💖 - 💕	41		\N	2	\N	2026-03-08 14:01:20.409357	2026-03-11 03:37:03.738297	f
3303	2025-12-02	11:20:00	23:21, 5:30, 8:28,	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	41.90	🔺 So So	43.10	3	💖 - 🔺	29		\N	2	\N	2026-03-08 14:01:20.411565	2026-03-11 03:57:22.537371	f
3304	2025-12-08	09:50:00	2:48, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	53.90	🔺 So So	31.10	1	💖 - 🔺	25		\N	2	\N	2026-03-08 14:01:20.417569	2026-03-11 04:06:00.909223	f
3305	2025-12-12	10:20:00	-	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	53.40	❌ No!!!	31.60	0	💖 - ❌	18		\N	2	\N	2026-03-08 14:01:20.420232	2026-03-11 04:10:06.930963	f
3109	2025-12-15	01:10:00	9:57, 14:05, 15:55, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.40	6.70	🔺 So So	14.70	3	❌ - 🔺	19	天然密碼有加排毛粉當誘食	\N	2	\N	2026-03-08 13:51:59.535884	2026-03-11 04:13:50.098099	f
3158	2025-12-20	01:00:00	15:14, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	16.40	🔺 So So	3.60	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.723523	2026-03-11 04:36:21.365441	f
3306	2025-12-22	00:39:00	11:35, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	56.00	🔺 So So	29.00	1	🔺 - 🔺	20	23:40開始斷斷續續地叫, 5:30躁動, 沒有去吃飯....	\N	2	\N	2026-03-08 14:01:20.422289	2026-03-11 04:42:39.001987	f
3307	2025-12-27	12:10:00	21:09, 5:37, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	46.10	🔺 So So	38.90	2	💖 - 🔺	27		\N	2	\N	2026-03-08 14:01:20.424292	2026-03-11 07:44:14.76723	f
3258	2025-12-30	01:20:00	10:16, 13:26, 16:06, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.30	10.70	🔺 So So	9.60	3	❌ - 🔺	19		\N	2	\N	2026-03-08 13:51:59.932928	2026-03-11 07:54:53.956454	f
695	2026-01-19	13:06:00	-	Kibble	go 	四種肉 無穀貓全糧	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:08.002061	2026-03-11 08:53:58.685775	f
4577	2026-03-14	12:30:00	23:19,  1:45, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.70	17.00	🔺 So So	3.70	2	❌ - 🔺	17		\N	2	\N	2026-03-14 12:30:17.295327	2026-03-15 01:30:32.260624	f
4575	2026-03-14	07:18:00	-	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	70.00	❌ No!!!	10.00	0	🔺 - ❌	13		\N	2	\N	2026-03-14 07:18:58.268714	2026-03-14 12:36:46.591633	f
5510	2026-03-17	12:31:00	21:19, 22:15, 00:19,  3;58	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	25.00	💕 Love it So Much	80.00	4	💖 - 💕	48		\N	2	\N	2026-03-17 12:31:29.459259	2026-03-18 01:25:42.484079	f
5302	2026-03-17	01:17:00	10:11, 13:33, 15:05, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	12.50	🔺 So So	12.50	3	❌ - 🔺	19	加誠實貓 雞塊 5g	\N	2	56	2026-03-17 01:17:42.494771	2026-03-17 12:34:18.183796	t
4574	2026-03-14	03:40:00	19:26, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.30	2.20	💕 Love it So Much	8.10	1	💖 - 💕	42		\N	2	53	2026-03-14 03:40:44.757024	2026-03-14 12:34:52.983548	t
5516	2026-03-18	01:28:00	15:45, 19:06, 20:15, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.80	12.50	🔺 So So	13.30	3	❌ - 🔺	19	加誠實貓 雞塊 5.6g	\N	2	56	2026-03-18 01:29:01.5148	2026-03-19 12:27:25.098886	t
4579	2026-03-14	12:35:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.80	10.80	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	53	2026-03-14 12:35:39.742337	2026-03-15 01:33:39.804322	t
4954	2026-03-16	01:41:00	10:27, 16:54, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	44.90	🔺 So So	40.10	2	💖 - 🔺	27		\N	2	\N	2026-03-16 01:41:47.21722	2026-03-16 13:12:33.940012	f
5514	2026-03-18	01:21:00	-	Wet	ciao	cc-86 貓用頂級奢華鮪魚 凍罐 (新版)	💖 Yes, eat right away	60.00	36.80	❌ No!!!	23.20	0	💖 - ❌	18		\N	2	\N	2026-03-18 01:21:23.268547	2026-03-18 13:06:05.450179	f
5515	2026-03-18	01:24:00	-	Kibble	安娜美廚	低脂- 體重管理配方 雞肉&雙魚	❌ No, not interested	23.60	23.60	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-18 01:24:58.823582	2026-03-19 01:00:10.659006	f
4953	2026-03-16	16:31:00	-	Kibble	柏萊富	棒吉 本能覺醒 5種肉	❌ No, not interested	20.70	20.70	❌ No!!!	0.00	0	❌ - ❌	8	很躁動	\N	2	\N	2026-03-15 16:32:07.723873	2026-03-16 01:42:19.0683	f
4957	2026-03-16	02:23:00	-	Kibble	柏萊富	棒吉 本能覺醒 5種肉	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-16 02:23:30.311543	2026-03-16 10:56:20.650572	f
4584	2026-03-15	07:20:00	15:26, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	7.70	🔺 So So	2.30	1	❌ - 🔺	15		\N	2	53	2026-03-15 07:20:33.254525	2026-03-16 01:43:39.485383	t
5304	2026-03-17	01:20:00	21:17,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	4.60	🔺 So So	5.40	1	❌ - 🔺	15		\N	2	53	2026-03-17 01:20:20.65196	2026-03-18 01:22:59.425708	t
1134	2025-02-28	01:40:00	9:46, 10:08, 11:12, 13:20, 15:11,	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	❌ No, not interested	75.00	13.90	💕 Love it So Much	61.10	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.460454	2026-03-09 09:25:21.006813	f
1178	2025-03-07	12:30:00	23:23, 1:32,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	❌ No, not interested	60.00	28.00	🔺 So So	32.00	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.59068	2026-03-09 09:34:02.191706	f
889	2025-01-01	14:00:00	23:46, 00:29, 4:23, 7:04, 9:58,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	40.30	17.20	💕 Love it So Much	23.10	5	❌ - 💕	33		\N	2	\N	2026-03-02 12:05:31.644371	2026-03-08 20:04:36.969114	f
3684	2026-03-13	12:35:00	-	Freeze-Dried	曙光	無穀鴨肉凍乾生食	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-13 12:35:23.858987	2026-03-14 00:55:45.243731	f
2378	2026-03-08	12:13:00	21:06, 22:46, 00:35, 3:27,	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	49.00	💕 Love it So Much	81.00	4	💖 - 💕	41		\N	2	\N	2026-03-08 12:13:35.698013	2026-03-09 01:21:03.860355	f
3309	2026-03-09	01:25:00	10:57, 13:23, 20:03, 21:00,	Kibble	天然密碼	無穀雞肉&火雞肉 幼貓及高活動量貓配方	❌ No, not interested	25.00	8.60	🔺 So So	16.40	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-03-09 01:25:46.890446	2026-03-09 13:08:24.428088	f
1186	2025-03-09	02:10:00	12:27, 15:05, 18:30, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	18.40	💕 Love it So Much	61.60	3	💖 - 💕	46		\N	2	\N	2026-03-02 12:05:32.607067	2026-03-09 09:36:22.688545	f
909	2025-01-06	09:45:00	18:29, 19:10, 00:13, 4:18, 6:19,	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	41.60	10.00	🔺 So So	31.60	5	❌ - 🔺	30	有加凍乾	\N	2	\N	2026-03-02 12:05:31.714142	2026-03-09 03:41:09.246526	f
915	2025-01-07	10:40:00	5:10, 5:44, 10:05	Wet	喵樂	喵罐 嫩雞鮪魚燒	🔺 No, not really. Ate A Little	80.00	50.90	🔺 So So	29.10	3	🔺 - 🔺	24		\N	2	\N	2026-03-02 12:05:31.729661	2026-03-09 03:43:34.134317	f
945	2025-01-14	14:40:00	-	Freeze-Dried	zimple	呼嚕凍乾	❌ No, not interested	3.70	0.00	💕 Love it So Much	3.70	0	❌ - 💕	30		\N	2	\N	2026-03-02 12:05:31.833001	2026-03-09 04:09:45.475365	f
949	2025-01-15	12:30:00	23:55, 7:26	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	❌ No, not interested	75.00	46.40	🔺 So So	28.60	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:31.840996	2026-03-09 04:10:31.884885	f
960	2025-01-18	12:20:00	20:30, 23:42, 23:58, 5:56	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	32.80	16.70	🔺 So So	16.10	4	❌ - 🔺	21	加 好味小姐凍乾 2.8g	\N	2	\N	2026-03-02 12:05:31.86382	2026-03-09 04:13:38.020389	f
1194	2025-03-10	10:00:00	18:21, 22:21, 00:26, 3:38, 9:55, 	Wet	ciao	a-113 多樂米濃湯罐 鰹魚+雞肉+柴魚片	🔺 No, not really. Ate A Little	80.00	14.20	💕 Love it So Much	65.80	5	🔺 - 💕	45		\N	2	\N	2026-03-02 12:05:32.622373	2026-03-09 09:36:46.505868	f
3310	2026-03-09	01:36:00	10:18, 13:24, 17:38, 18:17, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	21.20	💕 Love it So Much	58.80	4	💖 - 💕	41		\N	2	\N	2026-03-09 01:36:44.064127	2026-03-09 13:13:32.683238	f
1022	2025-02-03	14:20:00	5:57, 	Wet	oasy	雞肉佐哈姆鮮食	❌ No, not interested	82.10	68.20	🔺 So So	13.90	1	❌ - 🔺	15		\N	2	\N	2026-03-02 12:05:32.066945	2026-03-09 08:55:03.056809	f
1020	2025-02-03	02:55:00	14:14, 20:36, 	Wet	ciao	極致濃湯餐包 ic-504 鮪魚+雞肉+干貝	🔺 No, not really. Ate A Little	80.10	46.10	🔺 So So	34.00	2	🔺 - 🔺	22		\N	2	\N	2026-03-02 12:05:32.061857	2026-03-09 08:55:33.440778	f
1056	2025-02-11	12:08:00	4:41, 6;37,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	28.30	15.00	🔺 So So	13.30	2	❌ - 🔺	17	加 好味小姐凍乾 3.9g	\N	2	\N	2026-03-02 12:05:32.129651	2026-03-09 09:03:30.852595	f
1061	2025-02-13	02:20:00	15:09, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	89.20	52.50	🔺 So So	36.70	1	💖 - 🔺	25	凌晨有吐, 沒拍到切確時間, 但看起來像是吐出剛吃下的飼料	\N	2	\N	2026-03-02 12:05:32.13888	2026-03-09 09:07:34.958031	f
1089	2025-02-19	13:50:00	1:00, 9:33	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	❌ No, not interested	60.00	41.80	🔺 So So	18.20	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:32.261068	2026-03-09 09:13:02.796794	f
1117	2025-02-24	11:50:00	22:50, 3:25, 5:39,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	32.40	16.70	🔺 So So	15.70	3	❌ - 🔺	19	加 好味小姐凍乾 1.7g	\N	2	\N	2026-03-02 12:05:32.386986	2026-03-09 09:20:13.907954	f
1127	2025-02-26	11:50:00	8:23, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	43.90	33.10	🔺 So So	10.80	1	❌ - 🔺	15	加 好味小姐凍乾 4.2g	\N	2	\N	2026-03-02 12:05:32.439446	2026-03-09 09:21:57.887006	f
1207	2025-03-12	12:00:00	20:15, 22:19, 1:02, 7:50, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	17.30	💕 Love it So Much	52.70	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.646354	2026-03-09 09:39:45.887132	f
1224	2025-03-15	10:00:00	20:00, 21:53, 00:01, 2:34, 4:41, 8:23, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	❌ No, not interested	80.00	13.30	💕 Love it So Much	66.70	6	❌ - 💕	42		\N	2	\N	2026-03-02 12:05:32.719231	2026-03-09 09:46:01.419746	f
1234	2025-03-17	12:30:00	21:58, 00:46, 3:36, 8:42, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	11.20	💕 Love it So Much	48.80	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:32.737604	2026-03-09 09:47:54.011981	f
1232	2025-03-17	02:40:00	13:10, 15:04, 16:46, 18:50, 20:27	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	20.60	2.90	💕 Love it So Much	17.70	5	❌ - 💕	40		\N	2	\N	2026-03-02 12:05:32.733931	2026-03-09 09:48:02.919298	f
3312	2026-03-09	02:14:00	-	Freeze-Dried	索美達	凍乾生食貓貓餐 - 紐西蘭北島放牧雞	❌ No, not interested	11.90	11.90	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-09 02:15:04.79777	2026-03-10 01:24:34.321689	f
2626	2025-10-04	11:00:00	22:11, 23:31, 00:24, 5:04,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	38.60	5.50	🔺 So So	33.10	4	❌ - 🔺	28		\N	2	\N	2026-03-08 13:51:57.93359	2026-03-10 13:18:37.123574	f
2815	2025-10-31	07:30:00	17:21, 20:13, 21:31, 23:22, 00:03, 2:57, 5:13, 7:07, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	43.30	12.40	💕 Love it So Much	30.90	8	❌ - 💕	39		\N	2	\N	2026-03-08 13:51:58.362272	2026-03-10 16:05:33.817113	f
2380	2026-03-08	12:15:00	-	Kibble	alleva 艾雷雅	均衡照護無麩系列 農場饗宴&敏感護理 放養鮮鴨 成貓	❌ No, not interested	20.30	20.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 12:15:58.087025	2026-03-09 01:18:46.044973	f
3130	2025-12-17	06:15:00	14:45, 17:50, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	💖 Yes, eat right away	20.20	9.40	🔺 So So	10.80	2	💖 - 🔺	27	15:50 躁動, 會一直叫/天然密碼有拿到前面給阿吉聞	\N	2	\N	2026-03-08 13:51:59.590132	2026-03-11 04:18:04.239773	f
3269	2025-12-31	02:05:00	10:46, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	14.90	13.00	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:59.950025	2026-03-11 07:58:18.445118	f
1260	2025-03-22	12:15:00	21:09, 23:53, 1:15, 4:16, 7:48, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	25.50	💕 Love it So Much	54.50	5	💖 - 💕	43		\N	2	\N	2026-03-02 12:05:32.8246	2026-03-09 09:53:14.347789	f
1262	2025-03-22	12:15:00	20:49, 21:07, 23:50, 1:13, 4:14, 7:47	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	38.10	8.20	💕 Love it So Much	29.90	6	❌ - 💕	42	加 好味小姐凍乾 2.3g	\N	2	\N	2026-03-02 12:05:32.828447	2026-03-09 09:53:29.90747	f
1293	2025-03-28	12:40:00	22:22, 00:01, 1:18, 2:28, 3:49, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	15.30	💕 Love it So Much	34.70	5	💖 - 💕	43		\N	2	\N	2026-03-02 12:05:32.933427	2026-03-09 10:11:13.539561	f
1306	2025-03-31	02:40:00	11:53, 14:15, 16:16, 19:26, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	27.20	13.50	💕 Love it So Much	13.70	4	❌ - 💕	31		\N	2	\N	2026-03-02 12:05:32.981736	2026-03-09 10:14:32.591165	f
1347	2025-04-09	00:45:00	9:23, 11:13, 13:54, 15:07, 17:06, 18:54, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	25.40	9.40	💕 Love it So Much	16.00	6	❌ - 💕	35		\N	2	\N	2026-03-02 12:05:33.094495	2026-03-09 12:05:49.694271	f
1364	2025-04-12	12:05:00	22:10, 00:30, 6:25,	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	21.40	🔺 So So	28.60	3	💖 - 🔺	29		\N	2	\N	2026-03-02 12:05:33.126347	2026-03-09 12:14:02.296383	f
1397	2025-04-17	11:40:00	21:13, 23:04,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.70	18.30	🔺 So So	3.40	2	❌ - 🔺	17		\N	2	\N	2026-03-02 12:05:33.213948	2026-03-09 12:29:13.482058	f
1398	2025-04-17	11:40:00	19:11, 21:12, 1:49, 3:20, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	42.70	19.00	🔺 So So	23.70	4	❌ - 🔺	21	加 好味小姐凍乾 1.3g	\N	2	\N	2026-03-02 12:05:33.215694	2026-03-09 12:29:32.760914	f
1406	2025-04-19	03:30:00	14:43	Wet	ciao	tsc-43 貓用肉泥寒天果凍 鰹魚	💖 Yes, eat right away	35.00	2.90	💕 Love it So Much	32.10	1	💖 - 💕	42		\N	2	\N	2026-03-02 12:05:33.229745	2026-03-09 12:32:44.860867	f
1436	2025-04-24	09:10:00	18:13, 22:55, 00:52, 3:30, 8:01	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	38.60	11.10	🔺 So So	27.50	5	❌ - 🔺	23		\N	2	\N	2026-03-02 12:05:33.320677	2026-03-09 12:39:18.098697	f
1439	2025-04-25	08:35:00	22:39, 1:10, 1:57, 8:30, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝x2	💖 Yes, eat right away	60.00	9.40	💕 Love it So Much	50.60	4	💖 - 💕	48		\N	2	\N	2026-03-02 12:05:33.326081	2026-03-09 12:40:30.160692	f
2363	2026-03-07	01:21:00	13:00, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	17.90	🔺 So So	7.10	1	❌ - 🔺	15	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-03-07 01:22:09.6568	2026-03-07 12:43:38.68927	f
3308	2026-03-09	01:22:00	13:22, 15:37, 17:37, 18:15, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	12.10	🔺 So So	7.90	4	❌ - 🔺	21		\N	2	\N	2026-03-09 01:22:53.799708	2026-03-09 13:12:04.442524	f
2369	2026-03-07	12:45:00	22:45, 00:31, 1:41, 7:52, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	12.30	🔺 So So	12.90	4	❌ - 🔺	21	加汪喵 櫻桃鴨 5g	\N	2	\N	2026-03-07 12:45:17.54126	2026-03-08 02:21:25.377941	f
1562	2025-05-10	11:15:00	19:34, 20:42, 23:59, 00:48, 4:37, 7:57, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	36.70	4.40	💕 Love it So Much	32.30	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:05.179901	2026-03-09 13:34:36.585823	f
1563	2025-05-11	01:40:00	12:35, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	19.30	💕 Love it So Much	40.70	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:05.181523	2026-03-09 13:36:33.674301	f
1571	2025-05-12	08:00:00	20:00, 1:49, 7:45, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	🔺 No, not really. Ate A Little	70.00	41.10	🔺 So So	28.90	3	🔺 - 🔺	24		\N	2	\N	2026-03-04 11:51:05.218922	2026-03-09 13:36:58.354688	f
1573	2025-05-12	10:09:00	19:58, 21:09, 23:14, 00:23, 1:47, 2:47, 7:44, 	Kibble	璞斯	無穀營養雞肉配方	❌ No, not interested	41.50	5.50	💕 Love it So Much	36.00	7	❌ - 💕	44	加 好味小姐凍乾 1.7g	\N	2	\N	2026-03-04 11:51:05.22275	2026-03-09 13:37:19.78434	f
1632	2025-05-21	09:45:00	18:22, 19:42, 22:08, 23:29, 7:01,	Kibble	吶一口	室內貓雙響宴	❌ No, not interested	54.00	27.90	🔺 So So	26.10	5	❌ - 🔺	23		\N	2	\N	2026-03-04 11:51:05.380068	2026-03-09 13:52:04.358252	f
1657	2025-05-25	09:25:00	20:10, 1:02, 4:22, 4:50, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	23.40	💕 Love it So Much	56.60	4	💖 - 💕	41		\N	2	\N	2026-03-04 11:51:05.44781	2026-03-09 13:57:47.529382	f
1689	2025-05-29	09:00:00	17:50, 19:06, 20:31, 22:09, 3:13, 6:20, 	Kibble	璞斯	體態管理全齡貓 鴨肉	❌ No, not interested	40.10	13.80	💕 Love it So Much	26.30	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:05.515845	2026-03-09 14:04:32.215197	f
3311	2026-03-09	02:11:00	10:16, 15:46, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	4.10	🔺 So So	5.90	2	❌ - 🔺	17		\N	2	53	2026-03-09 02:11:50.217583	2026-03-09 13:06:18.889853	t
3316	2026-03-09	13:10:00	22:24, 00:57, 4:50,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	15.00	🔺 So So	10.40	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-03-09 13:10:57.568844	2026-03-10 01:24:07.739885	f
1715	2025-06-02	08:30:00	2:37, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	🔺 No, not really. Ate A Little	80.00	47.50	🔺 So So	32.50	1	🔺 - 🔺	20		\N	2	\N	2026-03-04 11:51:05.603584	2026-03-10 02:27:13.808633	f
3317	2026-03-09	13:12:00	2:15,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	18.00	🔺 So So	2.00	1	❌ - 🔺	15		\N	2	\N	2026-03-09 13:12:46.017386	2026-03-10 01:23:35.922873	f
3314	2026-03-09	13:03:00	22:26, 00:58, 2:16, 4:53,	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x3	💖 Yes, eat right away	105.00	27.40	💕 Love it So Much	77.60	4	💖 - 💕	41		\N	2	\N	2026-03-09 13:03:56.384053	2026-03-10 01:26:29.77281	f
1722	2025-06-03	00:30:00	10:03, 11:29, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	13.10	💕 Love it So Much	46.90	2	💖 - 💕	44		\N	2	\N	2026-03-04 11:51:05.619889	2026-03-10 02:31:31.609487	f
3318	2026-03-10	01:22:00	10:33, 12:04, 13:24, 16:04, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	21.50	💕 Love it So Much	58.50	4	💖 - 💕	41		\N	2	\N	2026-03-10 01:22:58.788077	2026-03-10 12:34:51.052767	f
1752	2025-06-06	14:30:00	-	Kibble	璞斯	無穀營養雞肉配方	🔺 No, not really. Ate A Little	34.60	31.60	❌ No!!!	3.00	0	🔺 - ❌	13	加 好味小姐凍乾 3g/一直喵喵叫, 很躁動, 感覺沒吃飽/乾乾吃膩？	\N	2	\N	2026-03-04 11:51:05.706818	2026-03-10 03:20:10.11094	f
4958	2026-03-16	10:20:00	20:47, 	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	27.00	💕 Love it So Much	43.00	1	💖 - 💕	35		\N	2	\N	2026-03-16 10:27:18.534627	2026-03-16 13:11:46.690972	f
5303	2026-03-17	01:18:00	12:30, 16:49, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	14.00	🔺 So So	6.00	2	❌ - 🔺	17		\N	2	\N	2026-03-17 01:19:07.152956	2026-03-17 12:32:03.546364	f
1793	2025-06-10	09:50:00	-	Freeze-Dried	原肉	原肉凍乾零食-酥鯛魚燒	💖 Yes, eat right away	1.70	0.00	💕 Love it So Much	1.70	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:05.911123	2026-03-10 04:08:03.204831	f
1805	2025-06-13	09:50:00	19:35, 5:07, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	21.90	💕 Love it So Much	58.10	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:05.952579	2026-03-10 04:11:26.144429	f
1907	2025-06-27	12:10:00	23:51, 3:23, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	22.00	💕 Love it So Much	58.00	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:06.282262	2026-03-10 04:38:59.591191	f
1959	2025-07-05	15:16:00	00:36, 8:21, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	💖 Yes, eat right away	24.20	19.00	🔺 So So	5.20	2	💖 - 🔺	27	一直叫, 很躁動...	\N	2	\N	2026-03-04 11:51:06.472588	2026-03-10 07:27:52.446484	f
1964	2025-07-06	07:15:00	17:00, 18:21, 20:44, 22:09, 00:06, 3:50, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	38.10	20.90	💕 Love it So Much	17.20	6	❌ - 💕	35		\N	2	\N	2026-03-04 11:51:06.491437	2026-03-10 07:29:28.261641	f
1965	2025-07-07	00:55:00	9:24, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	25.60	🔺 So So	34.40	1	💖 - 🔺	25	間斷地打噴嚏, 右眼紅紅的流眼淚, 有點沒精神, 有點嗜睡/8:40 嘔吐, 只有看到透明液體/9:30 嘔吐, 吐出剛剛吃下的食物	\N	2	\N	2026-03-04 11:51:06.495021	2026-03-10 07:30:27.348544	f
1997	2025-07-12	11:09:00	21:59, 23:07, 4:44, 7:31,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	40.30	19.50	🔺 So So	20.80	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:06.678586	2026-03-10 07:36:45.208184	f
2002	2025-07-13	07:00:00	17:16, 20:07, 21:02, 22:42, 1:42, 4:58, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	33.70	7.60	💕 Love it So Much	26.10	6	❌ - 💕	42		\N	2	\N	2026-03-04 11:51:06.697991	2026-03-10 07:38:16.182396	f
2030	2025-07-18	07:20:00	15:16, 15:26, 18:50, 19:26, 23:45, 3:54, 5:59, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	38.00	14.50	💕 Love it So Much	23.50	7	❌ - 💕	37		\N	2	\N	2026-03-04 11:51:06.817494	2026-03-10 07:43:59.536498	f
2056	2025-07-23	08:00:00	17:46, 22:04, 1:45, 2:31, 4:25, 8:16, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	43.00	20.50	🔺 So So	22.50	6	❌ - 🔺	25		\N	2	\N	2026-03-04 11:51:06.925726	2026-03-10 07:49:35.272314	f
2069	2025-07-25	12:00:00	22:39, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	15.00	💕 Love it So Much	45.00	1	💖 - 💕	35		\N	2	\N	2026-03-04 11:51:07.037355	2026-03-10 07:52:41.641949	f
2092	2025-07-30	00:42:00	9:20, 9:55, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	22.30	19.20	🔺 So So	3.10	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:07.30416	2026-03-10 07:58:33.884346	f
2119	2025-08-02	07:05:00	-	Freeze-Dried	可蒂毛毛	凍乾探險隊 嘉義溫體火雞	💖 Yes, eat right away	3.30	0.00	💕 Love it So Much	3.30	0	💖 - 💕	40		\N	2	\N	2026-03-04 11:51:07.570729	2026-03-10 08:24:17.241086	f
2141	2025-08-05	10:55:00	00:39, 7:10, 	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	24.10	💕 Love it So Much	55.90	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:07.654247	2026-03-10 08:34:34.050757	f
2160	2025-08-07	08:00:00	18:00, 21:50, 00:01, 1:40, 4:03,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	37.00	12.60	💕 Love it So Much	24.40	5	❌ - 💕	33		\N	2	\N	2026-03-04 11:51:07.7503	2026-03-10 08:39:55.177484	f
2188	2025-08-12	00:40:00	12:14, 14:31, 17:21, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	17.20	💕 Love it So Much	42.80	3	💖 - 💕	39		\N	2	\N	2026-03-04 11:51:07.872274	2026-03-10 08:46:44.068465	f
2191	2025-08-12	06:42:00	19:54, 21:41, 00:14, 7:57,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	31.30	11.70	🔺 So So	19.60	4	❌ - 🔺	21		\N	2	\N	2026-03-04 11:51:07.880588	2026-03-10 08:47:01.579424	f
2217	2025-08-17	10:15:00	22:58, 4:01, 8:20,	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	18.20	💕 Love it So Much	61.80	3	💖 - 💕	46		\N	2	\N	2026-03-04 11:51:08.010863	2026-03-10 08:52:09.940598	f
2249	2025-08-22	12:05:00	23:16, 2:56, 7:41, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	38.70	💕 Love it So Much	46.30	3	🔺 - 💕	34		\N	2	\N	2026-03-04 11:51:08.178037	2026-03-10 08:58:51.752493	f
2273	2025-08-26	11:50:00	00:41, 4:38, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	26.90	💕 Love it So Much	53.10	2	💖 - 💕	37		\N	2	\N	2026-03-04 11:51:08.29276	2026-03-10 09:03:10.263783	f
2456	2025-09-11	01:00:00	10:14, 13:58, 20:33,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	19.50	4.70	🔺 So So	14.80	3	❌ - 🔺	26		\N	2	\N	2026-03-08 13:51:57.397272	2026-03-10 09:40:29.672039	f
3323	2025-09-12	00:49:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	💖 Yes, eat right away	60.00	23.80	❌ No!!!	36.20	0	💖 - ❌	18		\N	2	\N	2026-03-10 09:53:32.44137	2026-03-10 09:54:40.261071	f
3321	2026-03-10	04:02:00	19:53,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	5.80	🔺 So So	4.20	1	💖 - 🔺	25		\N	2	53	2026-03-10 04:03:12.965626	2026-03-10 12:32:44.645597	t
2475	2025-09-14	01:30:00	6:35, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.30	12.10	🔺 So So	8.20	1	❌ - 🔺	15		\N	2	\N	2026-03-08 13:51:57.51269	2026-03-10 10:20:33.767382	f
3326	2025-09-19	07:30:00	18:06, 	Wet	ciao	ic-502 貓用極致濃湯肉塊餐包 - 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	30.00	5.00	💕 Love it So Much	25.00	1	💖 - 💕	42		\N	2	\N	2026-03-10 11:37:57.576657	2026-03-10 11:39:18.88526	f
3333	2026-03-10	12:33:00	23:37,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	7.70	🔺 So So	2.50	1	❌ - 🔺	15		\N	2	53	2026-03-10 12:33:27.79607	2026-03-11 01:21:30.150121	t
3320	2026-03-10	01:32:00	18:11, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.00	16.70	🔺 So So	3.30	1	❌ - 🔺	15		\N	2	\N	2026-03-10 01:32:20.480848	2026-03-10 12:30:55.769295	f
3329	2026-03-10	04:00:00	-	Freeze-Dried	ve 唯一	凍乾鮮肉貓用生食餐 鴨肉軟顆粒	❌ No, not interested	7.20	7.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-10 12:00:02.046525	2026-03-11 01:19:03.619445	f
3330	2026-03-10	12:27:00	22:08, 1:25, 3:36, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	42.60	🔺 So So	62.40	3	💖 - 🔺	29		\N	2	\N	2026-03-10 12:27:15.62747	2026-03-11 01:22:17.080369	f
2554	2025-09-25	07:00:00	17:44, 20:57, 3:06, 9:05	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	34.10	19.30	🔺 So So	14.80	4	❌ - 🔺	21		\N	2	\N	2026-03-08 13:51:57.795626	2026-03-10 13:02:10.640085	f
2582	2025-09-28	07:52:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 gc2	❌ No, not interested	51.20	51.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:57.840063	2026-03-10 13:09:23.190978	f
3332	2026-03-10	12:31:00	22:05, 3:32,	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.40	12.50	🔺 So So	7.90	2	❌ - 🔺	17		\N	2	\N	2026-03-10 12:31:39.021606	2026-03-11 05:41:39.313883	f
3339	2026-03-11	01:23:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-11 01:23:12.398926	2026-03-12 01:03:07.361709	f
3012	2025-11-29	11:00:00	-	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	❌ No, not interested	80.00	44.90	❌ No!!!	35.10	0	❌ - ❌	8	換地方後, 先吃乾乾, 就開始吃罐頭了	\N	2	\N	2026-03-08 13:51:59.23496	2026-03-11 03:39:14.646128	f
791	2026-01-29	00:50:00	10:23, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	8.10	🔺 So So	1.90	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:08.28624	2026-03-10 13:56:03.412466	f
761	2026-01-26	01:22:00	13:28, 17:35, 19:25, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.20	14.70	🔺 So So	15.50	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:08.220822	2026-03-10 14:04:02.012249	f
754	2026-01-25	01:20:00	10:27, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	6.40	🔺 So So	3.60	1	💖 - 🔺	25		\N	2	\N	2026-02-23 13:47:08.200888	2026-03-10 14:07:09.454089	f
2690	2025-10-14	10:11:00	19:32, 20:21, 23:52, 2:51, 9:07, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	46.30	5.30	💕 Love it So Much	41.00	5	❌ - 💕	40	00:07 補10.5g	\N	2	\N	2026-03-08 13:51:58.105618	2026-03-10 15:14:54.328211	f
2722	2025-10-19	01:00:00	9:54, 11:57, 	Wet	ciao	ic-238 鰹魚燒晚餐包 化毛配方 鰹魚+柴魚片+干貝	🔺 No, not really. Ate A Little	50.00	35.10	🔺 So So	14.90	2	🔺 - 🔺	22	00:54 開始叫，叫一下就停了/後來有加汪喵排毛粉，馬上跑來吃	\N	2	\N	2026-03-08 13:51:58.160217	2026-03-10 15:30:17.044661	f
2757	2025-10-23	06:55:00	16:12, 16:56, 20:23, 23:14, 00:34, 2:19, 4:57, 7:38,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	55.10	9.30	💕 Love it So Much	45.80	8	❌ - 💕	46		\N	2	\N	2026-03-08 13:51:58.246129	2026-03-10 15:39:21.131116	f
3094	2025-12-12	10:20:00	22:00, 23:19, 1:29, 3:55, 6:23, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	44.20	1.50	💕 Love it So Much	42.70	5	❌ - 💕	40	撒排毛粉誘食	\N	2	\N	2026-03-08 13:51:59.507309	2026-03-11 04:10:22.419456	f
3335	2025-10-08	00:50:00	-	Kibble	法米納	oc3/lc3 天然海洋系列 低穀鱈魚甜橙	❌ No, not interested	20.50	20.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-10 13:32:26.610788	2026-03-10 13:35:17.323205	f
3341	2026-03-11	02:28:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	6.00	❌ No!!!	4.00	0	💖 - ❌	18		\N	2	53	2026-03-11 02:28:44.322163	2026-03-11 12:23:46.348432	t
3199	2025-12-24	00:44:00	14:13, 	Freeze-Dried	誠實貓	雞肉凍乾	❌ No, not interested	2.70	0.00	💕 Love it So Much	2.70	1	❌ - 💕	32		\N	2	\N	2026-03-08 13:51:59.813756	2026-03-11 07:36:57.306427	f
2373	2026-03-08	02:25:00	-	Kibble	alleva 艾雷雅	均衡照護無麩系列 農場饗宴&敏感護理 放養鮮鴨 成貓	❌ No, not interested	20.20	20.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 02:25:27.667835	2026-03-08 12:14:52.577142	f
625	2026-01-11	11:35:00	19:30, 20:24, 21:33, 2:15, 7:36, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.50	12.70	🔺 So So	17.80	5	❌ - 🔺	23		\N	2	\N	2026-02-23 13:47:07.762806	2026-03-11 08:37:40.401636	f
657	2026-01-15	01:35:00	10:07, 14:19, 16:10, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	55.00	🔺 So So	50.00	3	💖 - 🔺	29		\N	2	\N	2026-02-23 13:47:07.874483	2026-03-11 08:45:23.846432	f
710	2026-01-21	01:17:00	15:48, 17:20, 18:22, 19:39, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	15.10	🔺 So So	4.90	4	❌ - 🔺	21		\N	2	\N	2026-02-23 13:47:08.049755	2026-03-11 08:56:46.642336	f
3298	2025-11-13	10:18:00	5:19, 8:08,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	28.50	💕 Love it So Much	56.50	2	💖 - 💕	37		\N	2	\N	2026-03-08 14:01:20.398972	2026-03-11 02:51:34.874558	f
3196	2025-12-24	00:44:00	10:10, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	44.70	🔺 So So	30.30	1	💖 - 🔺	25	00:05一直叫/有被外面的聲響影響到吃飯	\N	2	\N	2026-03-08 13:51:59.808419	2026-03-11 07:37:55.368561	f
542	2026-01-02	10:50:00	7:31, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	5.20	0.50	💕 Love it So Much	4.70	1	❌ - 💕	32		\N	2	\N	2026-02-23 13:47:07.522532	2026-03-11 08:13:16.916286	f
562	2026-01-05	01:45:00	9:37, 11:06, 17:08, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.40	16.20	🔺 So So	14.20	3	❌ - 🔺	19		\N	2	\N	2026-02-23 13:47:07.580715	2026-03-11 08:21:15.849636	f
591	2026-01-07	11:35:00	19:30,	Freeze-Dried	誠實貓	雞肉凍乾	💖 Yes, eat right away	2.50	0.00	💕 Love it So Much	2.50	1	💖 - 💕	42		\N	2	\N	2026-02-23 13:47:07.678592	2026-03-11 08:25:23.714713	f
606	2026-01-09	09:00:00	3:31, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	5.40	2.80	🔺 So So	2.60	1	❌ - 🔺	15		\N	2	\N	2026-02-23 13:47:07.71338	2026-03-11 08:33:38.862776	f
623	2026-01-11	01:00:00	-	Freeze-Dried	誠實貓	鴨肉凍乾	❌ No, not interested	4.50	2.60	❌ No!!!	1.90	0	❌ - ❌	8		\N	2	\N	2026-02-23 13:47:07.758935	2026-03-11 08:36:28.412529	f
750	2026-01-24	11:50:00	22:09, 00:57, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	1.20	💕 Love it So Much	8.80	2	❌ - 💕	34		\N	2	\N	2026-02-23 13:47:08.192725	2026-03-11 09:19:08.688433	f
3338	2026-03-11	01:12:00	10:31, 11:42,	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	❌ No, not interested	80.00	34.40	🔺 So So	45.60	2	❌ - 🔺	17	被外面的聲音影響沒馬上吃/拿到前面會吃, 可能還需要確認是否真的有喜歡	\N	2	\N	2026-03-11 01:13:12.58836	2026-03-11 12:25:18.387531	f
3389	2026-03-12	02:02:00	14:08, 18:17, 21:00	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.40	14.30	🔺 So So	6.10	3	❌ - 🔺	19		\N	2	\N	2026-03-12 02:02:26.735762	2026-03-12 13:01:34.831919	f
3368	2026-03-11	12:14:00	23:45, 1:22, 3:51, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	69.10	🔺 So So	60.90	3	💖 - 🔺	29		\N	2	\N	2026-03-11 12:14:25.158352	2026-03-12 01:11:55.605641	f
3370	2026-03-11	12:22:00	22:05, 	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	25.70	21.80	🔺 So So	3.90	1	❌ - 🔺	15	加汪喵 櫻桃鴨 5.2g	\N	2	\N	2026-03-11 12:22:15.097157	2026-03-12 01:10:43.744357	f
3371	2026-03-11	12:24:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	10.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	53	2026-03-11 12:24:26.43718	2026-03-12 01:07:53.576844	t
3369	2026-03-11	12:19:00	-	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	25.10	❌ No!!!	0.00	0	❌ - ❌	8	加汪喵 櫻桃鴨 5.1g	\N	2	56	2026-03-11 12:20:08.516359	2026-03-12 01:11:13.351789	t
3388	2026-03-12	01:16:00	14:09, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	22.30	🔺 So So	2.80	1	❌ - 🔺	15	加汪喵 櫻桃鴨 5.1g	\N	2	56	2026-03-12 01:16:39.722517	2026-03-12 13:04:36.229359	t
3386	2026-03-12	01:06:00	10:07, 16:58, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	30.70	🔺 So So	49.30	2	💖 - 🔺	27		\N	2	\N	2026-03-12 01:06:44.516614	2026-03-12 13:07:16.278825	f
3395	2024-11-01	00:30:00	-	Wet	易特廚	易特廚 鮮嫩雞肉煲湯	💖 Yes, eat right away	80.00	51.90	❌ No!!!	28.10	0	💖 - ❌	18	一直叫, 又不吃	\N	2	\N	2026-03-12 15:17:00.909046	2026-03-12 15:17:00.909046	f
3396	2024-11-01	00:30:00	-	Wet	貓日和	貓日和 鮮饗餐包 雞肉雞肝	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	聞了, 連吃都沒吃就撥沙/倒掉	\N	2	\N	2026-03-12 15:17:00.916241	2026-03-12 15:17:00.916241	f
3397	2024-11-01	00:30:00	-	Wet	ciao	旨定罐 a-82 白身鮪魚+干貝	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:00.918686	2026-03-12 15:17:00.918686	f
3398	2024-11-01	02:30:00	-	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	💖 Yes, eat right away	60.00	45.90	❌ No!!!	14.10	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:00.920529	2026-03-12 15:17:00.920529	f
3399	2024-11-01	00:30:00	9:37, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.40	14.60	🔺 So So	5.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:00.922862	2026-03-12 15:17:00.922862	f
3400	2024-11-01	09:30:00	22:08, 00:32, 04:46	Wet	ciao	鰹魚燒晚餐包 ic-244 x2	💖 Yes, eat right away	100.00	62.00	🔺 So So	38.00	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:00.92464	2026-03-12 15:17:00.92464	f
3401	2024-11-01	09:30:00	17:30, 21:05, 22:08, 00:31, 03:44, 04:44, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	40.60	16.20	💕 Love it So Much	24.40	6	❌ - 💕	35	\N	\N	2	\N	2026-03-12 15:17:00.926411	2026-03-12 15:17:00.926411	f
3402	2024-11-02	00:30:00	9:55, 	Wet	vif	c2 咪芙好鮮餐包 - 雞肉濃湯	💖 Yes, eat right away	75.00	35.90	🔺 So So	39.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:00.928485	2026-03-12 15:17:00.928485	f
3403	2024-11-02	00:30:00	8:34, 9:54, 10:28, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	9.60	🔺 So So	10.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:00.930453	2026-03-12 15:17:00.930453	f
3404	2024-11-02	00:30:00	20:39, 4:08, 5:49, 	Wet	金湯	愛貓湯罐 白身鮪魚&小麥草	❌ No, not interested	80.00	31.00	🔺 So So	49.00	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:00.932486	2026-03-12 15:17:00.932486	f
3405	2024-11-02	00:30:00	19:24, 20:38, 23:13, 23:56, 4:07, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	34.70	12.30	🔺 So So	22.40	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:00.934994	2026-03-12 15:17:00.934994	f
3394	2026-03-12	13:04:00	7:30,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	21.60	🔺 So So	3.70	1	❌ - 🔺	15		\N	2	56	2026-03-12 13:05:27.738396	2026-03-13 02:25:45.505608	t
3391	2026-03-12	13:00:00	21:44, 00:03,  3:16, 7:31, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	29.50	💕 Love it So Much	55.50	4	💖 - 💕	41		\N	2	\N	2026-03-12 13:00:21.768546	2026-03-13 02:26:02.710195	f
3392	2026-03-12	13:02:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-12 13:02:29.118196	2026-03-13 01:32:25.87069	f
3387	2026-03-12	01:13:00	10:06, 11:26, 12:15, 18:18, 19:41, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	9.50	🔺 So So	10.90	5	❌ - 🔺	23		6.80	2	\N	2026-03-12 01:13:27.501363	2026-03-12 13:03:14.928793	f
3393	2026-03-12	13:04:00	00:04, 3:14,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	14.20	🔺 So So	5.80	2	❌ - 🔺	17		\N	2	\N	2026-03-12 13:04:11.057473	2026-03-13 01:32:54.751966	f
3406	2024-11-03	00:18:00	13:36, 15:34, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	27.20	💕 Love it So Much	52.80	2	💖 - 💕	37	\N	\N	2	\N	2026-03-12 15:17:00.936899	2026-03-12 15:17:00.936899	f
3407	2024-11-03	00:18:00	13:35, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.20	17.60	🔺 So So	3.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:00.939403	2026-03-12 15:17:00.939403	f
3408	2024-11-03	10:00:00	18:20, 1:31, 4:25, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	10.90	💕 Love it So Much	39.10	3	❌ - 💕	36	\N	\N	2	\N	2026-03-12 15:17:00.941179	2026-03-12 15:17:00.941179	f
3409	2024-11-03	10:00:00	21:05, 22:33, 1:29, 4:23, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	42.80	16.20	🔺 So So	26.60	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:00.943062	2026-03-12 15:17:00.943062	f
3410	2024-11-04	00:00:00	9:10, 15:15, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	30.30	🔺 So So	29.70	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:00.946232	2026-03-12 15:17:00.946232	f
3411	2024-11-04	00:00:00	9:09, 15:14, 17:28, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	16.70	🔺 So So	3.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:00.949035	2026-03-12 15:17:00.949035	f
3412	2024-11-04	09:30:00	22:20, 00:38, 4;57,	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	9.30	💕 Love it So Much	50.70	3	💖 - 💕	46	\N	\N	2	\N	2026-03-12 15:17:00.951397	2026-03-12 15:17:00.951397	f
3413	2024-11-04	09:30:00	19:26, 22:19, 00:36, 3:01, 5:45,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	41.70	17.40	🔺 So So	24.30	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:00.953247	2026-03-12 15:17:00.953247	f
3414	2024-11-05	00:30:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	46.70	❌ No!!!	33.30	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:00.955361	2026-03-12 15:17:00.955361	f
3415	2024-11-05	00:30:00	16:10, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.80	15.40	🔺 So So	5.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:00.957234	2026-03-12 15:17:00.957234	f
3416	2024-11-05	09:40:00	23:14, 23:37, 3:57,  6:19, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	🔺 No, not really. Ate A Little	80.00	32.10	🔺 So So	47.90	4	🔺 - 🔺	26	23:37 => 吃完後撥砂	\N	2	\N	2026-03-12 15:17:00.962154	2026-03-12 15:17:00.962154	f
3417	2024-11-05	09:40:00	21:04, 23:13, 23:35, 3:54, 6:17, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	40.40	19.60	🔺 So So	20.80	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:00.964596	2026-03-12 15:17:00.964596	f
3418	2024-11-06	00:40:00	-	Wet	歐姆貓	機能補水罐 雞肉鮪魚	🔺 No, not really. Ate A Little	80.00	68.20	❌ No!!!	11.80	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-12 15:17:00.966386	2026-03-12 15:17:00.966386	f
3420	2024-11-06	00:40:00	13:49, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.20	19.20	🔺 So So	1.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:00.970738	2026-03-12 15:17:00.970738	f
3421	2024-11-06	10:30:00	21:57, 00:03, 4:17, 	Wet	ciao	ic-238 鰹魚燒晚餐包 化毛配方 鰹魚+柴魚片+干貝	💖 Yes, eat right away	50.00	13.00	🔺 So So	37.00	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:00.972482	2026-03-12 15:17:00.972482	f
3422	2024-11-06	10:30:00	21:55, 00:02, 4:15, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	39.20	28.50	🔺 So So	10.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:00.974157	2026-03-12 15:17:00.974157	f
3423	2024-11-06	10:30:00	-	Kibble	紐崔斯	七種魚	❌ No, not interested	10.30	10.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:00.975791	2026-03-12 15:17:00.975791	f
3424	2024-11-07	00:15:00	-	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	45.10	❌ No!!!	14.90	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:00.977574	2026-03-12 15:17:00.977574	f
3425	2024-11-07	00:15:00	-	Wet	喵食堂	喵食堂 燉煮鮪魚海老鍋	💖 Yes, eat right away	80.00	65.40	❌ No!!!	14.60	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:00.981446	2026-03-12 15:17:00.981446	f
3426	2024-11-07	00:15:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	19.80	19.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:00.983185	2026-03-12 15:17:00.983185	f
3427	2024-11-07	07:35:00	-	Kibble	原點	雞肉 無穀全貓配方	💖 Yes, eat right away	9.40	4.20	❌ No!!!	5.20	0	💖 - ❌	18	一直喵喵叫, 感覺沒吃飽？！倒了新飼料, 馬上跑過來吃	\N	2	\N	2026-03-12 15:17:00.998681	2026-03-12 15:17:00.998681	f
3428	2024-11-07	09:35:00	20:10, 22:42, 23:25, 4:32, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	31.80	💕 Love it So Much	53.20	4	💖 - 💕	41	\N	\N	2	\N	2026-03-12 15:17:01.000901	2026-03-12 15:17:01.000901	f
3429	2024-11-07	09:35:00	23:24, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	39.80	38.30	🔺 So So	1.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.003933	2026-03-12 15:17:01.003933	f
3430	2024-11-07	09:35:00	17:35, 22:40, 4:30, 	Kibble	原點	雞肉 無穀全貓配方	💖 Yes, eat right away	24.20	11.60	🔺 So So	12.60	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.007078	2026-03-12 15:17:01.007078	f
3431	2024-11-08	00:35:00	9:20, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	54.70	🔺 So So	25.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.008811	2026-03-12 15:17:01.008811	f
3432	2024-11-08	00:35:00	-	Kibble	素力高	宅宅貓吃魚	❌ No, not interested	17.10	17.10	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.011136	2026-03-12 15:17:01.011136	f
3433	2024-11-08	00:35:00	9:19, 14:06, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.00	15.10	🔺 So So	4.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.013031	2026-03-12 15:17:01.013031	f
3434	2024-11-08	09:40:00	5:49, 6:33, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	❌ No, not interested	50.00	36.00	🔺 So So	14.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.014706	2026-03-12 15:17:01.014706	f
3435	2024-11-08	09:40:00	21:48, 00:47, 5:48, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	36.90	🔺 So So	48.10	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.016577	2026-03-12 15:17:01.016577	f
3436	2024-11-08	09:40:00	-	Wet	皇家	感官饗宴 濃郁香氣 主食濕糧 ssw	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	20:20 倒掉, 完全不吃	\N	2	\N	2026-03-12 15:17:01.018606	2026-03-12 15:17:01.018606	f
3437	2024-11-08	09:40:00	21:46, 00:45, 2:30, 6:32, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	37.10	19.00	🔺 So So	18.10	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.021176	2026-03-12 15:17:01.021176	f
3438	2024-11-09	00:20:00	9:18, 14:48,	Wet	ciao	啾嚕雪花膏 鮪魚 cs-191	💖 Yes, eat right away	80.00	44.20	🔺 So So	35.80	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.022899	2026-03-12 15:17:01.022899	f
3439	2024-11-09	00:20:00	-	Wet	bellotta	成貓 貓鮮包 腸道配方+益菌生f.o.s 鮪魚+雞肉	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 完全不吃	\N	2	\N	2026-03-12 15:17:01.024589	2026-03-12 15:17:01.024589	f
3440	2024-11-09	00:20:00	-	Wet	vi chi 維齊	益力膳貓餐罐 - 雞肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.031397	2026-03-12 15:17:01.031397	f
3441	2024-11-09	00:20:00	9:17, 14:45, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.70	15.20	🔺 So So	5.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.034718	2026-03-12 15:17:01.034718	f
3442	2024-11-09	10:40:00	19:29, 23:21, 5:10, 	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	💖 Yes, eat right away	65.00	17.00	💕 Love it So Much	48.00	3	💖 - 💕	39	\N	\N	2	\N	2026-03-12 15:17:01.036583	2026-03-12 15:17:01.036583	f
3443	2024-11-09	10:40:00	-	Wet	ciao	旨定罐 a-83 白身鮪魚+雞肉+干貝	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞舔鼻子, 所以倒掉	\N	2	\N	2026-03-12 15:17:01.038225	2026-03-12 15:17:01.038225	f
3444	2024-11-09	10:40:00	23:18, 3:51, 5:09, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	36.80	13.50	🔺 So So	23.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.040125	2026-03-12 15:17:01.040125	f
3445	2024-11-10	00:20:00	10:04, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	33.70	🔺 So So	46.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.04208	2026-03-12 15:17:01.04208	f
3446	2024-11-10	00:20:00	10:03, 14:45, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.20	16.40	🔺 So So	3.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.043919	2026-03-12 15:17:01.043919	f
3447	2024-11-10	09:30:00	00:09, 4:07, 5:33, 6:43,	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	19.70	💕 Love it So Much	50.30	4	💖 - 💕	41	\N	\N	2	\N	2026-03-12 15:17:01.045754	2026-03-12 15:17:01.045754	f
3448	2024-11-10	09:30:00	00:07, 4:05, 5:32, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	37.00	26.80	🔺 So So	10.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.047898	2026-03-12 15:17:01.047898	f
3449	2024-11-11	00:30:00	-	Wet	吶一口	鮮肉貓罐 鮪魚+雞肉	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉/飼料有加凍乾碎屑/15:50 吐	\N	2	\N	2026-03-12 15:17:01.050033	2026-03-12 15:17:01.050033	f
3450	2024-11-11	00:30:00	-	Wet	ciao	cc-83 貓用頂級奢華鮪魚 凍罐 鮪魚+鰹魚	🔺 No, not really. Ate A Little	60.00	56.80	❌ No!!!	3.20	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-12 15:17:01.052237	2026-03-12 15:17:01.052237	f
3451	2024-11-11	00:30:00	12:51, 15:47, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.30	12.50	🔺 So So	7.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.054135	2026-03-12 15:17:01.054135	f
3452	2024-11-11	08:30:00	22:09, 4:46,	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	34.70	🔺 So So	45.30	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.056046	2026-03-12 15:17:01.056046	f
3453	2024-11-11	08:30:00	21:42, 22:08, 00:32, 1:45, 4:44, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	33.40	12.80	🔺 So So	20.60	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.058249	2026-03-12 15:17:01.058249	f
3454	2024-11-12	00:35:00	-	Wet	ciao	布丁杯 鰹魚 imc-152	💖 Yes, eat right away	65.00	54.00	❌ No!!!	11.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.060242	2026-03-12 15:17:01.060242	f
3455	2024-11-12	00:35:00	8:39, 13:56, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.50	17.10	🔺 So So	4.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.062304	2026-03-12 15:17:01.062304	f
3456	2024-11-12	09:50:00	23:43, 	Wet	ciao	鰹魚燒晚餐 ic-281 (雞肉+鰹魚+蟹肉+干貝)	🔺 No, not really. Ate A Little	50.00	43.50	🔺 So So	6.50	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.064428	2026-03-12 15:17:01.064428	f
3457	2024-11-12	09:50:00	5:40, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	❌ No, not interested	60.00	33.40	🔺 So So	26.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.066492	2026-03-12 15:17:01.066492	f
3458	2024-11-12	09:50:00	23:41, 3:48, 5:38, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	39.50	19.40	🔺 So So	20.10	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.068337	2026-03-12 15:17:01.068337	f
3459	2024-11-13	00:30:00	15:19, 	Wet	ciao	ic-308 化毛配方 鮪魚+雞肉+干貝	💖 Yes, eat right away	40.00	16.10	🔺 So So	23.90	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.07024	2026-03-12 15:17:01.07024	f
3460	2024-11-13	00:30:00	15:17, 18:20, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.30	16.60	🔺 So So	3.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.072138	2026-03-12 15:17:01.072138	f
3461	2024-11-13	10:22:00	4:47, 6:27, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	41.80	🔺 So So	43.20	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.073944	2026-03-12 15:17:01.073944	f
3462	2024-11-13	10:22:00	20:24, 23:22, 00:38, 3:31, 4:45, 6:25, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	36.90	11.60	💕 Love it So Much	25.30	6	❌ - 💕	35	\N	\N	2	\N	2026-03-12 15:17:01.07567	2026-03-12 15:17:01.07567	f
3463	2024-11-14	00:40:00	15:25, 	Wet	ciao	cc-84 奢華鮪魚罐 鮪魚+吻仔魚	🔺 No, not really. Ate A Little	60.00	44.20	🔺 So So	15.80	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.077368	2026-03-12 15:17:01.077368	f
3464	2024-11-14	00:40:00	15:25, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.00	18.70	🔺 So So	2.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.078996	2026-03-12 15:17:01.078996	f
3466	2024-11-14	10:30:00	00:46, 	Wet	ciao	啾嚕雪花膏 雞肉干貝 cs-195	🔺 No, not really. Ate A Little	80.00	39.00	🔺 So So	41.00	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.082386	2026-03-12 15:17:01.082386	f
3467	2024-11-14	10:30:00	-	Wet	喵食堂	燉煮鮪魚雞肝鍋	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.084238	2026-03-12 15:17:01.084238	f
3468	2024-11-14	10:30:00	21:13, 22:40, 00:02, 00:44, 3:57, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	39.40	22.50	🔺 So So	16.90	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.086042	2026-03-12 15:17:01.086042	f
3469	2024-11-15	01:00:00	-	Wet	迷幻喵	6號 多汁雞肉+野生鮭魚	💖 Yes, eat right away	125.00	96.40	❌ No!!!	28.60	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.087768	2026-03-12 15:17:01.087768	f
3470	2024-11-15	01:00:00	13:46, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.30	18.50	🔺 So So	1.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.089939	2026-03-12 15:17:01.089939	f
3471	2024-11-15	09:30:00	21:28, 21:47, 4:57	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	15.60	🔺 So So	34.40	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.091726	2026-03-12 15:17:01.091726	f
3472	2024-11-15	09:30:00	21:28, 00:13, 3:25, 4:56, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	39.00	22.20	🔺 So So	16.80	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.093446	2026-03-12 15:17:01.093446	f
3473	2024-11-16	23:40:00	11:07, 14:08, 	Wet	辛迪斯	貓罐 雞肉扇貝 cr-064	🔺 No, not really. Ate A Little	80.00	54.40	🔺 So So	25.60	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-12 15:17:01.095183	2026-03-12 15:17:01.095183	f
3474	2024-11-16	23:40:00	14:09, 	Wet	ciao	ic-313 奢華鮭魚 (鮪魚+雞肉)	💖 Yes, eat right away	35.00	10.30	💕 Love it So Much	24.70	1	💖 - 💕	35	\N	\N	2	\N	2026-03-12 15:17:01.097865	2026-03-12 15:17:01.097865	f
3475	2024-11-16	23:40:00	11:06, 14:07, 14:22, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	15.70	🔺 So So	4.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.099511	2026-03-12 15:17:01.099511	f
3476	2024-11-16	08:30:00	18:44, 20:46, 23:16, 4:19, 4:53, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	17.80	💕 Love it So Much	62.20	5	💖 - 💕	50	\N	\N	2	\N	2026-03-12 15:17:01.101862	2026-03-12 15:17:01.101862	f
3477	2024-11-16	08:30:00	18:42, 20:45, 23:08, 23:15, 2:48, 4:52, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	36.40	12.80	💕 Love it So Much	23.60	6	❌ - 💕	35	\N	\N	2	\N	2026-03-12 15:17:01.103659	2026-03-12 15:17:01.103659	f
3478	2024-11-17	00:15:00	14:41, 15:50, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	💖 Yes, eat right away	80.00	30.70	💕 Love it So Much	49.30	2	💖 - 💕	37	\N	\N	2	\N	2026-03-12 15:17:01.105394	2026-03-12 15:17:01.105394	f
3479	2024-11-17	00:15:00	14:40, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	16.60	🔺 So So	3.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.107032	2026-03-12 15:17:01.107032	f
3480	2024-11-17	10:00:00	22:44, 2:32, 4:30, 8:31, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	14.10	💕 Love it So Much	65.90	4	💖 - 💕	48	\N	\N	2	\N	2026-03-12 15:17:01.110168	2026-03-12 15:17:01.110168	f
3481	2024-11-17	10:00:00	20:29, 22:43, 2:29, 4:28, 8:29, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	38.30	13.50	🔺 So So	24.80	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.112406	2026-03-12 15:17:01.112406	f
3482	2024-11-18	01:30:00	-	Wet	vi chi 維齊	貓罐 鮪魚+雞肉+鮭魚	💖 Yes, eat right away	80.00	69.00	❌ No!!!	11.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.114026	2026-03-12 15:17:01.114026	f
3483	2024-11-18	01:30:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.70	21.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.115744	2026-03-12 15:17:01.115744	f
3484	2024-11-18	01:30:00	21:39, 23:42, 4:15, 	Wet	ciao	ic-245 鰹魚燒晚餐包(鰹魚+干貝)	💖 Yes, eat right away	50.00	12.60	💕 Love it So Much	37.40	3	💖 - 💕	39	\N	\N	2	\N	2026-03-12 15:17:01.117446	2026-03-12 15:17:01.117446	f
3485	2024-11-18	10:00:00	-	Wet	vif	s2 咪芙好鮮餐包 - 雞肉濃湯	🔺 No, not really. Ate A Little	75.00	55.80	❌ No!!!	19.20	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-12 15:17:01.11906	2026-03-12 15:17:01.11906	f
3486	2024-11-18	10:00:00	23:39, 4:12, 8:20, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	46.00	29.60	🔺 So So	16.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.120736	2026-03-12 15:17:01.120736	f
3487	2024-11-19	00:30:00	13:43, 	Wet	ciao	cc-82 貓用頂級奢華鮪魚 鮪魚+干貝 凍罐	💖 Yes, eat right away	60.00	32.70	🔺 So So	27.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.122476	2026-03-12 15:17:01.122476	f
3488	2024-11-19	00:30:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.80	20.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.12417	2026-03-12 15:17:01.12417	f
3489	2024-11-19	02:30:00	11:08, 13:42, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	16.30	8.90	🔺 So So	7.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.132643	2026-03-12 15:17:01.132643	f
3490	2024-11-19	02:30:00	4:03, 5:38, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	34.00	🔺 So So	46.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.136202	2026-03-12 15:17:01.136202	f
3491	2024-11-19	11:44:00	5:37, 	Kibble	杜莎	鮮雞佐鴨	❌ No, not interested	15.00	13.80	🔺 So So	1.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.13784	2026-03-12 15:17:01.13784	f
3492	2024-11-19	11:44:00	4:01, 5:36, 9:05, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	34.20	13.30	🔺 So So	20.90	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.13951	2026-03-12 15:17:01.13951	f
3493	2024-11-20	01:13:00	15:30, 	Wet	mon petit 貓倍麗	mon petit 嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	60.90	🔺 So So	24.10	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.141169	2026-03-12 15:17:01.141169	f
3494	2024-11-20	01:13:00	14:45, 15:30, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.00	13.00	🔺 So So	7.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.144325	2026-03-12 15:17:01.144325	f
3495	2024-11-20	10:00:00	4:00, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	🔺 No, not really. Ate A Little	80.00	58.60	🔺 So So	21.40	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.149964	2026-03-12 15:17:01.149964	f
3496	2024-11-20	11:00:00	22:39, 23:48, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	❌ No, not interested	50.00	34.30	🔺 So So	15.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.156631	2026-03-12 15:17:01.156631	f
3497	2024-11-20	11:00:00	23:45, 3:57, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	34.00	19.50	🔺 So So	14.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.15874	2026-03-12 15:17:01.15874	f
3498	2024-11-21	00:20:00	-	Wet	vosto	鮮雞肉罐 (雞肉+鮪魚)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.16039	2026-03-12 15:17:01.16039	f
3499	2024-11-21	00:20:00	-	Wet	迷幻喵	6號 多汁雞肉+野生鮭魚	🔺 No, not really. Ate A Little	125.00	105.00	❌ No!!!	20.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-12 15:17:01.162012	2026-03-12 15:17:01.162012	f
3500	2024-11-21	00:20:00	14:34, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	61.80	🔺 So So	18.20	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.163837	2026-03-12 15:17:01.163837	f
3501	2024-11-21	00:20:00	14:33, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.50	16.70	🔺 So So	3.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.165462	2026-03-12 15:17:01.165462	f
3502	2024-11-21	00:20:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭	❌ No, not interested	15.30	15.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.167068	2026-03-12 15:17:01.167068	f
3503	2024-11-21	00:20:00	22:39, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	15.60	6.10	🔺 So So	9.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.168714	2026-03-12 15:17:01.168714	f
3504	2024-11-21	11:00:00	-	Wet	易特廚	易特廚 干貝豪華大餐 (鮪魚+雞肉+干貝)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.170325	2026-03-12 15:17:01.170325	f
3505	2024-11-21	11:00:00	4:57, 	Wet	ciao	ic-306 泌尿保健 鮪魚+雞肉+干貝	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	1	❌ - ❌	10	\N	\N	2	\N	2026-03-12 15:17:01.171932	2026-03-12 15:17:01.171932	f
3506	2024-11-21	11:00:00	22:38, 2:32, 4:59, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	36.70	21.10	🔺 So So	15.60	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.173565	2026-03-12 15:17:01.173565	f
3507	2024-11-22	00:40:00	-	Wet	爵士貓吧	雞肉肉泥	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-12 15:17:01.175731	2026-03-12 15:17:01.175731	f
3508	2024-11-22	00:40:00	14:04, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	🔺 No, not really. Ate A Little	60.00	43.80	🔺 So So	16.20	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.182272	2026-03-12 15:17:01.182272	f
3509	2024-11-22	00:40:00	8:44, 14:03, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	22.00	18.00	🔺 So So	4.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.184772	2026-03-12 15:17:01.184772	f
3510	2024-11-22	09:37:00	5:04, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	30.90	🔺 So So	49.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.203567	2026-03-12 15:17:01.203567	f
3511	2024-11-22	09:37:00	19:38, 19:49, 23:29, 2:10, 4;14, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	38.00	11.60	💕 Love it So Much	26.40	5	❌ - 💕	33	\N	\N	2	\N	2026-03-12 15:17:01.205448	2026-03-12 15:17:01.205448	f
3512	2024-11-23	00:30:00	-	Wet	vi chi 維齊	貓罐 - 鮪魚+雞肉+牛肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-12 15:17:01.207109	2026-03-12 15:17:01.207109	f
3513	2024-11-23	00:30:00	-	Wet	ciao	燒晚餐(雞肉+干貝) ic-282	🔺 No, not really. Ate A Little	50.00	48.00	❌ No!!!	2.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-12 15:17:01.20884	2026-03-12 15:17:01.20884	f
3514	2024-11-23	00:30:00	-	Wet	希爾斯	成貓主食罐 香煎鮪魚燴胡蘿蔔	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-12 15:17:01.214112	2026-03-12 15:17:01.214112	f
3515	2024-11-23	00:30:00	9:19, 14:19,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.40	16.90	🔺 So So	4.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.216921	2026-03-12 15:17:01.216921	f
3516	2024-11-23	08:38:00	18:19, 19:14, 20:23, 21:14, 23:12, 00:44, 4:17, 5:53, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	39.10	0.00	💕 Love it So Much	39.10	8	❌ - 💕	46	\N	\N	2	\N	2026-03-12 15:17:01.218621	2026-03-12 15:17:01.218621	f
3517	2024-11-23	13:38:00	23:13, 5:55,	Wet	ciao	ciao cc-85 奢華鮪魚罐 鮪魚+蟹肉	💖 Yes, eat right away	60.00	36.00	🔺 So So	24.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.22023	2026-03-12 15:17:01.22023	f
3518	2024-11-24	00:30:00	9:36, 14:26, 	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	💖 Yes, eat right away	50.00	21.60	🔺 So So	28.40	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.221801	2026-03-12 15:17:01.221801	f
3519	2024-11-24	00:30:00	9:36, 14:25, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	22.10	20.40	🔺 So So	1.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.22361	2026-03-12 15:17:01.22361	f
3520	2024-11-24	08:09:00	18:34, 19:48, 20:26, 22:03, 23:59, 00:12, 4:59, 8:04, 8:37	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	49.30	0.00	💕 Love it So Much	49.30	9	❌ - 💕	48	\N	\N	2	\N	2026-03-12 15:17:01.226414	2026-03-12 15:17:01.226414	f
3521	2024-11-24	14:25:00	00:12, 5:01, 8:38	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	24.90	💕 Love it So Much	55.10	3	💖 - 💕	39	\N	\N	2	\N	2026-03-12 15:17:01.228214	2026-03-12 15:17:01.228214	f
3522	2024-11-25	01:45:00	-	Wet	辛迪斯	辛迪斯貓餐包 雞肉鳳尾魚 cr-cp002	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.230051	2026-03-12 15:17:01.230051	f
3523	2024-11-25	01:45:00	9:48, 13:37, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	💖 Yes, eat right away	20.20	12.30	🔺 So So	7.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.231698	2026-03-12 15:17:01.231698	f
3524	2024-11-25	09:11:00	17:28, 19:29, 23:12, 01:33, 4:15, 7:33	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	💖 Yes, eat right away	32.30	0.00	💕 Love it So Much	32.30	6	💖 - 💕	52	\N	\N	2	\N	2026-03-12 15:17:01.233345	2026-03-12 15:17:01.233345	f
3525	2024-11-25	12:33:00	23:14, 01:35, 4:12, 5:09, 7:35,	Wet	mon petit 貓倍麗	mon petit 嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	14.70	💕 Love it So Much	70.30	5	💖 - 💕	50	\N	\N	2	\N	2026-03-12 15:17:01.234984	2026-03-12 15:17:01.234984	f
3526	2024-11-26	01:09:00	14:22, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	37.60	🔺 So So	12.40	1	💖 - 🔺	25	5:20 吐	\N	2	\N	2026-03-12 15:17:01.236587	2026-03-12 15:17:01.236587	f
3527	2024-11-26	01:09:00	9:10, 14:21, 	Kibble	快樂貓	鮪魚雞肉貓飼料	💖 Yes, eat right away	20.30	15.80	🔺 So So	4.50	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.238232	2026-03-12 15:17:01.238232	f
3528	2024-11-26	09:00:00	17:32, 21:02, 22:54, 00:50, 1:21, 5:12, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	36.50	0.00	💕 Love it So Much	36.50	6	❌ - 💕	42	\N	\N	2	\N	2026-03-12 15:17:01.239965	2026-03-12 15:17:01.239965	f
3529	2024-11-26	09:00:00	00:51, 1:23, 5:14, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	43.40	🔺 So So	36.60	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.241784	2026-03-12 15:17:01.241784	f
3530	2024-11-27	00:50:00	-	Wet	吶一口	吶一口鮮肉貓罐 雞肉+雞丁	💖 Yes, eat right away	70.00	45.60	❌ No!!!	24.40	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.243756	2026-03-12 15:17:01.243756	f
3531	2024-11-27	00:50:00	14:24, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.90	19.60	🔺 So So	1.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.245631	2026-03-12 15:17:01.245631	f
3532	2024-11-27	09:15:00	18:28, 23:46, 4:06, 5:42, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	44.60	0.00	🔺 So So	44.60	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-12 15:17:01.247625	2026-03-12 15:17:01.247625	f
3533	2024-11-27	12:45:00	23:47, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味) x2	💖 Yes, eat right away	120.00	65.70	🔺 So So	54.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.249673	2026-03-12 15:17:01.249673	f
3534	2024-11-28	01:10:00	-	Wet	vif	c5 咪芙好鮮餐包 鮪魚吻仔魚濃湯	❌ No, not interested	75.00	75.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.251594	2026-03-12 15:17:01.251594	f
3535	2024-11-28	01:10:00	9:52, 	Wet	迷幻喵	15號 100%開胃火雞肉	🔺 No, not really. Ate A Little	125.00	114.60	🔺 So So	10.40	1	🔺 - 🔺	20	有加剩餘的凍乾粉	\N	2	\N	2026-03-12 15:17:01.25379	2026-03-12 15:17:01.25379	f
3536	2024-11-28	01:10:00	9:13, 12:45,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	22.50	13.40	🔺 So So	9.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.255582	2026-03-12 15:17:01.255582	f
3537	2024-11-28	10:30:00	22:10, 00:00, 4:49, 8:46,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	15.70	💕 Love it So Much	44.30	4	💖 - 💕	41	有用溫水隔水加熱(65C. 約一分鐘)	\N	2	\N	2026-03-12 15:17:01.257354	2026-03-12 15:17:01.257354	f
3538	2024-11-28	10:30:00	22:09, 23:59, 4:47, 8:45,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	38.50	19.70	🔺 So So	18.80	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.259194	2026-03-12 15:17:01.259194	f
3539	2024-11-29	01:10:00	13:35,	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	31.90	🔺 So So	48.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.260955	2026-03-12 15:17:01.260955	f
3540	2024-11-29	01:10:00	13:34, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.60	16.60	🔺 So So	4.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.262589	2026-03-12 15:17:01.262589	f
3541	2024-11-29	10:50:00	19:04, 23:07, 00:09, 1:40, 5:09, 	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	❌ No, not interested	50.00	3.40	💕 Love it So Much	46.60	5	❌ - 💕	40	\N	\N	2	\N	2026-03-12 15:17:01.264181	2026-03-12 15:17:01.264181	f
3542	2024-11-29	10:50:00	19:04, 20:03, 23:06, 00:08, 1:19, 1:38, 5:07, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	38.10	23.70	🔺 So So	14.40	7	❌ - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.26573	2026-03-12 15:17:01.26573	f
3543	2024-11-30	00:40:00	9:16, 	Wet	愛情貴族	白身鮪魚 & 雞肉	🔺 No, not really. Ate A Little	80.00	69.70	🔺 So So	10.30	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.267324	2026-03-12 15:17:01.267324	f
3544	2024-11-30	00:40:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.60	21.60	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.26897	2026-03-12 15:17:01.26897	f
3545	2024-11-30	12:30:00	1:24, 1:45, 5:27	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	30.50	🔺 So So	49.50	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.270608	2026-03-12 15:17:01.270608	f
3615	2024-12-16	13:20:00	22:13, 4:27, 9:43	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	38.40	23.00	🔺 So So	15.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.442511	2026-03-12 15:17:01.442511	f
3546	2024-11-30	09:30:00	17:30, 19:46, 22:42, 1:22, 1:44, 5:25, 8:40	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	💖 Yes, eat right away	43.00	11.10	💕 Love it So Much	31.90	7	💖 - 💕	47	加剩餘的凍乾粉	\N	2	\N	2026-03-12 15:17:01.272206	2026-03-12 15:17:01.272206	f
3547	2024-12-01	00:45:00	16:18, 	Wet	喵食堂	燉煮鮪魚鮭魚鍋	💖 Yes, eat right away	80.00	38.20	🔺 So So	41.80	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.274091	2026-03-12 15:17:01.274091	f
3548	2024-12-01	00:45:00	16:17, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	17.00	🔺 So So	3.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.282363	2026-03-12 15:17:01.282363	f
3549	2024-12-01	12:30:00	23:48, 00:59, 5:08	Wet	ciao	鰹魚燒晚餐包 ic-244	🔺 No, not really. Ate A Little	50.00	28.60	🔺 So So	21.40	3	🔺 - 🔺	24	\N	\N	2	\N	2026-03-12 15:17:01.284169	2026-03-12 15:17:01.284169	f
3550	2024-12-01	12:30:00	23:47, 00:38, 00:58, 5:05, 8:57, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	38.30	11.90	🔺 So So	26.40	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.285908	2026-03-12 15:17:01.285908	f
3551	2024-12-02	02:00:00	-	Wet	易特廚	美味鮮蝦大餐 鮪魚+雞肉+鮮蝦	💖 Yes, eat right away	80.00	73.80	❌ No!!!	6.20	0	💖 - ❌	18	\N	5.70	2	\N	2026-03-12 15:17:01.287593	2026-03-12 15:17:01.287593	f
3552	2024-12-02	02:00:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.289131	2026-03-12 15:17:01.289131	f
3553	2024-12-02	09:38:00	17:59, 19:25, 20:12, 00:34, 4:26, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	41.50	0.00	💕 Love it So Much	41.50	5	❌ - 💕	40	\N	\N	2	\N	2026-03-12 15:17:01.290733	2026-03-12 15:17:01.290733	f
3554	2024-12-02	12:50:00	00:36, 4:27, 4:49	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	22.50	🔺 So So	27.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.292451	2026-03-12 15:17:01.292451	f
3555	2024-12-03	01:00:00	10:00, 15:10	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	29.60	🔺 So So	30.40	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.29408	2026-03-12 15:17:01.29408	f
3556	2024-12-03	01:00:00	9:59, 15:08, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.00	13.90	🔺 So So	6.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.295652	2026-03-12 15:17:01.295652	f
3557	2024-12-03	09:35:00	18:01, 18:58, 19:10, 22:51, 23:37, 3:45, 5:28	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	35.10	9.10	💕 Love it So Much	26.00	7	❌ - 💕	37	\N	\N	2	\N	2026-03-12 15:17:01.297222	2026-03-12 15:17:01.297222	f
3558	2024-12-03	13:00:00	3:46, 5:29	Wet	mon petit 貓倍麗	mon petit 嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	48.20	🔺 So So	36.80	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.298843	2026-03-12 15:17:01.298843	f
3559	2024-12-04	01:00:00	15:06,	Wet	t.n.a 悠遊	厚肉肉有料湯肉貓罐 鮮鯛魚	🔺 No, not really. Ate A Little	80.00	58.10	🔺 So So	21.90	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.300408	2026-03-12 15:17:01.300408	f
3560	2024-12-04	01:00:00	15:06,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.50	16.40	🔺 So So	5.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.30217	2026-03-12 15:17:01.30217	f
3561	2024-12-04	09:19:00	20:56, 22:18, 00:42, 4:09, 5:35,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	43.60	22.20	🔺 So So	21.40	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.303931	2026-03-12 15:17:01.303931	f
3562	2024-12-04	10:40:00	20:57, 22:18, 5:36,	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	❌ No, not interested	85.00	42.50	🔺 So So	42.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.305596	2026-03-12 15:17:01.305596	f
3563	2024-12-05	01:25:00	15:37, 	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	🔺 No, not really. Ate A Little	65.00	51.80	🔺 So So	13.20	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.307361	2026-03-12 15:17:01.307361	f
3564	2024-12-05	01:25:00	9:49, 11:34, 13:08, 15:36, 18:04, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	22.20	8.40	🔺 So So	13.80	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.309027	2026-03-12 15:17:01.309027	f
3565	2024-12-05	10:10:00	19:01, 19:36, 22:02, 23:55, 4:04, 8:53, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	34.00	1.60	💕 Love it So Much	32.40	6	❌ - 💕	42	\N	\N	2	\N	2026-03-12 15:17:01.310726	2026-03-12 15:17:01.310726	f
3566	2024-12-05	13:40:00	23:57, 00:11, 8:55	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	15.30	💕 Love it So Much	59.70	3	💖 - 💕	46	\N	\N	2	\N	2026-03-12 15:17:01.312417	2026-03-12 15:17:01.312417	f
3567	2024-12-06	01:40:00	-	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	💖 Yes, eat right away	57.00	35.30	❌ No!!!	21.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.314076	2026-03-12 15:17:01.314076	f
3568	2024-12-06	01:40:00	10:30, 14:26,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.40	16.30	🔺 So So	5.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.315715	2026-03-12 15:17:01.315715	f
3569	2024-12-06	09:50:00	18:00, 23:30, 1:08, 3:32, 5:11, 10:51	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	41.50	19.20	🔺 So So	22.30	6	❌ - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.317397	2026-03-12 15:17:01.317397	f
3570	2024-12-06	13:40:00	23:32, 1:07, 5:12, 10:53	Wet	ciao	近海鰹魚罐93號 (干貝味) 	💖 Yes, eat right away	80.00	24.30	💕 Love it So Much	55.70	4	💖 - 💕	41	\N	\N	2	\N	2026-03-12 15:17:01.319178	2026-03-12 15:17:01.319178	f
3571	2024-12-07	03:00:00	-	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	42.80	❌ No!!!	17.20	0	💖 - ❌	18	\N	5.70	2	\N	2026-03-12 15:17:01.320953	2026-03-12 15:17:01.320953	f
3572	2024-12-07	03:00:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.40	16.80	❌ No!!!	3.60	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.322514	2026-03-12 15:17:01.322514	f
3573	2024-12-07	08:30:00	9:11, 	Kibble	lucy 魔力寵糧	鮭魚雞肉佐南瓜	❌ No, not interested	18.40	14.00	🔺 So So	4.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.324118	2026-03-12 15:17:01.324118	f
3574	2024-12-07	08:30:00	23:38, 00:44, 4:40	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	37.20	17.30	🔺 So So	19.90	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.325722	2026-03-12 15:17:01.325722	f
3575	2024-12-07	08:30:00	4:43, 9:12, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	21.00	💕 Love it So Much	54.00	2	💖 - 💕	37	\N	\N	2	\N	2026-03-12 15:17:01.327364	2026-03-12 15:17:01.327364	f
3576	2024-12-08	02:10:00	-	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	52.60	❌ No!!!	17.40	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.32895	2026-03-12 15:17:01.32895	f
3577	2024-12-08	02:10:00	10:50, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.50	10.80	🔺 So So	9.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.330526	2026-03-12 15:17:01.330526	f
3578	2024-12-08	09:50:00	18:28, 20:45, 23:53, 00:33, 3:52, 5:39	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	36.10	10.50	💕 Love it So Much	25.60	6	❌ - 💕	35	\N	\N	2	\N	2026-03-12 15:17:01.332126	2026-03-12 15:17:01.332126	f
3579	2024-12-08	13:40:00	23:56, 3:54, 5:39, 	Wet	金湯	愛貓湯罐 白身鮪魚&雞肉	💖 Yes, eat right away	80.00	22.60	💕 Love it So Much	57.40	3	💖 - 💕	39	\N	\N	2	\N	2026-03-12 15:17:01.333742	2026-03-12 15:17:01.333742	f
3580	2024-12-09	01:40:00	10:13, 14:07, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	💖 Yes, eat right away	50.00	16.90	💕 Love it So Much	33.10	2	💖 - 💕	37	\N	\N	2	\N	2026-03-12 15:17:01.335446	2026-03-12 15:17:01.335446	f
3581	2024-12-09	01:40:00	13:41, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	22.20	18.80	🔺 So So	3.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.337181	2026-03-12 15:17:01.337181	f
3582	2024-12-09	09:30:00	00:29, 00:40, 5:09, 8:25, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	43.90	25.90	🔺 So So	18.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.33878	2026-03-12 15:17:01.33878	f
3583	2024-12-09	13:00:00	00:41, 5:11, 8:27,  	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	39.60	🔺 So So	40.40	4	💖 - 🔺	31	\N	\N	2	\N	2026-03-12 15:17:01.34044	2026-03-12 15:17:01.34044	f
3584	2024-12-10	01:10:00	17:04, 19:02, 	Wet	ciao	imc-165 布丁杯 雞肉+鮪魚	💖 Yes, eat right away	65.00	40.30	🔺 So So	24.70	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.342221	2026-03-12 15:17:01.342221	f
3585	2024-12-10	01:10:00	9:20, 17:01, 19:01, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.20	6.30	🔺 So So	13.90	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.344242	2026-03-12 15:17:01.344242	f
3586	2024-12-10	10:00:00	23:59, 4:15, 8:29, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	31.80	6.60	🔺 So So	25.20	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-12 15:17:01.34626	2026-03-12 15:17:01.34626	f
3587	2024-12-10	14:00:00	00:01, 4:18,	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	💖 Yes, eat right away	60.00	32.80	🔺 So So	27.20	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.348788	2026-03-12 15:17:01.348788	f
3588	2024-12-11	01:45:00	-	Wet	凱茲	嫩燉菲力 菲力雞肉+鮪魚主食餐盒	💖 Yes, eat right away	85.00	70.40	❌ No!!!	14.60	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.35061	2026-03-12 15:17:01.35061	f
3589	2024-12-11	01:45:00	13:54, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.80	17.60	🔺 So So	4.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.383861	2026-03-12 15:17:01.383861	f
3590	2024-12-11	09:20:00	17:45, 23:42, 2:32, 4:54, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	42.60	21.00	🔺 So So	21.60	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.386399	2026-03-12 15:17:01.386399	f
3591	2024-12-11	12:30:00	23:45, 4:55, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	❌ No, not interested	75.00	39.00	🔺 So So	36.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.388596	2026-03-12 15:17:01.388596	f
3592	2024-12-12	01:40:00	10:40, 14:31, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	31.60	🔺 So So	28.40	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.390647	2026-03-12 15:17:01.390647	f
3593	2024-12-12	01:40:00	10:39, 14:30, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	21.70	14.70	🔺 So So	7.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.392618	2026-03-12 15:17:01.392618	f
3594	2024-12-12	09:15:00	17:34, 18:15, 00:38, 4:51, 5:35	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	39.80	21.00	🔺 So So	18.80	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.394587	2026-03-12 15:17:01.394587	f
3595	2024-12-12	13:05:00	00:41, 4:52,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	30.00	🔺 So So	30.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.396501	2026-03-12 15:17:01.396501	f
3596	2024-12-13	01:44:00	10:49, 	Wet	吶一口	無穀主食餐包 2號 鮮嫩雞肉+鮪魚	🔺 No, not really. Ate A Little	85.00	72.40	🔺 So So	12.60	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-12 15:17:01.398417	2026-03-12 15:17:01.398417	f
3597	2024-12-13	01:44:00	10:48, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.50	16.40	🔺 So So	4.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.400383	2026-03-12 15:17:01.400383	f
3598	2024-12-13	09:30:00	17:48, 19:57, 23:21, 4:21, 6:49	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	45.30	22.10	🔺 So So	23.20	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.402548	2026-03-12 15:17:01.402548	f
3599	2024-12-13	09:30:00	23:21, 4:23, 6:50	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	❌ No, not interested	50.00	18.80	🔺 So So	31.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.404641	2026-03-12 15:17:01.404641	f
3600	2024-12-14	02:00:00	15:43, 19:06, 	Wet	mon petit 貓倍麗	珍饌雞里肌肉餐盒 lc4	💖 Yes, eat right away	57.00	27.20	🔺 So So	29.80	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.406507	2026-03-12 15:17:01.406507	f
3601	2024-12-14	02:00:00	10:10, 14:47, 15;41	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	21.70	15.70	🔺 So So	6.00	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.408333	2026-03-12 15:17:01.408333	f
3602	2024-12-14	11:11:00	21:54, 23:44, 4:26, 7:35	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	42.30	13.80	🔺 So So	28.50	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.411134	2026-03-12 15:17:01.411134	f
3603	2024-12-14	13:00:00	4:29, 7:37	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	33.10	🔺 So So	46.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.413121	2026-03-12 15:17:01.413121	f
3604	2024-12-15	01:50:00	10:39, 11:08, 17:32	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	21.80	💕 Love it So Much	43.20	3	💖 - 💕	39	\N	\N	2	\N	2026-03-12 15:17:01.415691	2026-03-12 15:17:01.415691	f
3605	2024-12-15	01:50:00	10:37, 11:06, 13:29, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.30	7.60	🔺 So So	13.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.420861	2026-03-12 15:17:01.420861	f
3606	2024-12-15	09:10:00	17:30, 20:20, 23:30, 2:47, 4:21,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	32.70	11.90	🔺 So So	20.80	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.42292	2026-03-12 15:17:01.42292	f
3607	2024-12-15	13:08:00	23:33, 4:23, 8:35, 	Wet	ciao	ciao 鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	18.10	🔺 So So	31.90	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.424888	2026-03-12 15:17:01.424888	f
3608	2024-12-16	01:10:00	11:04, 16:57, 18:27, 	Wet	法麗	微湯汁系列 天然嫩雞肉	💖 Yes, eat right away	80.00	29.60	💕 Love it So Much	50.40	3	💖 - 💕	39	\N	\N	2	\N	2026-03-12 15:17:01.428977	2026-03-12 15:17:01.428977	f
3609	2024-12-16	01:10:00	9:44, 11:03, 15:15, 16:55, 18:02, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.40	9.40	💕 Love it So Much	12.00	5	❌ - 💕	33	\N	\N	2	\N	2026-03-12 15:17:01.431273	2026-03-12 15:17:01.431273	f
3610	2024-12-16	10:30:00	18:42, 21:18, 00:17, 1:44, 8:25	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	36.10	21.00	🔺 So So	15.10	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.433422	2026-03-12 15:17:01.433422	f
3611	2024-12-16	13:00:00	21:19, 00:13, 00:18, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	❌ No, not interested	75.00	33.60	🔺 So So	41.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.435239	2026-03-12 15:17:01.435239	f
3612	2024-12-16	00:30:00	17:02, 18:35	Wet	ciao	鮪魚布丁杯 鮪魚+干貝 imc-154	💖 Yes, eat right away	65.00	34.40	🔺 So So	30.60	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.437152	2026-03-12 15:17:01.437152	f
3613	2024-12-16	00:30:00	17:01, 18:34	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	20.60	13.40	🔺 So So	7.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.438934	2026-03-12 15:17:01.438934	f
3614	2024-12-16	13:45:00	22:14, 9:45, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	18.90	💕 Love it So Much	41.10	2	💖 - 💕	37	\N	\N	2	\N	2026-03-12 15:17:01.440741	2026-03-12 15:17:01.440741	f
3616	2024-12-18	02:08:00	15:05,	Wet	金湯	愛貓湯罐 鮮嫩雞肉	💖 Yes, eat right away	80.00	44.60	🔺 So So	35.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.444217	2026-03-12 15:17:01.444217	f
3617	2024-12-18	02:08:00	14:20, 15:03,	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	22.30	17.30	🔺 So So	5.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.446106	2026-03-12 15:17:01.446106	f
3618	2024-12-18	10:40:00	19:39, 23:20, 00:50, 4:22	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	43.70	23.60	🔺 So So	20.10	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.448062	2026-03-12 15:17:01.448062	f
3619	2024-12-18	11:00:00	-	Wet	迷幻喵	6號 多汁雞肉+野生鮭魚	❌ No, not interested	125.00	125.00	❌ No!!!	0.00	0	❌ - ❌	8	21:00倒掉	\N	2	\N	2026-03-12 15:17:01.449809	2026-03-12 15:17:01.449809	f
3620	2024-12-18	13:40:00	23:21, 4:24, 6:57, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	44.70	🔺 So So	40.30	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.452841	2026-03-12 15:17:01.452841	f
3622	2024-12-19	01:00:00	13:39, 17:15, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	23.00	18.20	🔺 So So	4.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.456486	2026-03-12 15:17:01.456486	f
3623	2024-12-19	10:00:00	19:35, 20:18, 22:49, 1:17, 6:09	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	44.30	18.80	🔺 So So	25.50	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.458243	2026-03-12 15:17:01.458243	f
3624	2024-12-19	14:20:00	1:20, 6:12	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	44.50	🔺 So So	40.50	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.485263	2026-03-12 15:17:01.485263	f
3625	2024-12-20	01:35:00	-	Wet	吶一口	無穀主食餐包10號 鮭魚+火雞肉+貓薄荷	💖 Yes, eat right away	85.00	77.70	❌ No!!!	7.30	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.488659	2026-03-12 15:17:01.488659	f
3626	2024-12-20	01:35:00	10:17, 17:21,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	12.60	🔺 So So	7.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.490841	2026-03-12 15:17:01.490841	f
3627	2024-12-20	10:30:00	19:07, 23:04, 00:14, 00:33, 4:34, 7:04, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	38.50	12.00	💕 Love it So Much	26.50	6	❌ - 💕	35	\N	\N	2	\N	2026-03-12 15:17:01.492906	2026-03-12 15:17:01.492906	f
3628	2024-12-20	10:30:00	00:35, 4:37, 7:05, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	❌ No, not interested	70.00	46.00	🔺 So So	24.00	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.494876	2026-03-12 15:17:01.494876	f
3629	2024-12-21	00:45:00	14:25, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	39.50	🔺 So So	35.50	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.496807	2026-03-12 15:17:01.496807	f
3630	2024-12-21	00:45:00	14:23, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.00	15.60	🔺 So So	5.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.498735	2026-03-12 15:17:01.498735	f
3631	2024-12-21	09:55:00	20:48, 21:21, 00:35, 5:58, 6:35, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	40.60	19.00	🔺 So So	21.60	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-12 15:17:01.500647	2026-03-12 15:17:01.500647	f
3632	2024-12-21	13:55:00	00:36,  6:37	Wet	ciao	近海鰹魚罐93號 (干貝味) 	💖 Yes, eat right away	80.00	40.40	🔺 So So	39.60	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.502547	2026-03-12 15:17:01.502547	f
3633	2024-12-22	01:40:00	17:47	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	25.90	🔺 So So	34.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.504378	2026-03-12 15:17:01.504378	f
3634	2024-12-22	01:40:00	11:28, 17:46	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	21.40	10.20	🔺 So So	11.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.507023	2026-03-12 15:17:01.507023	f
3635	2024-12-22	09:55:00	23:33, 2:57, 5:51, 9:32, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	37.00	24.20	🔺 So So	12.80	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.50877	2026-03-12 15:17:01.50877	f
3636	2024-12-22	13:20:00	23:34, 00:56, 2:58, 5:51,	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	9.60	💕 Love it So Much	40.40	4	💖 - 💕	48	\N	\N	2	\N	2026-03-12 15:17:01.510486	2026-03-12 15:17:01.510486	f
3637	2024-12-23	01:35:00	14:45, 	Wet	ciao	豪華魚三味 ic-418 高齡貓餐包 鮪魚	💖 Yes, eat right away	60.00	34.90	🔺 So So	25.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.512142	2026-03-12 15:17:01.512142	f
3638	2024-12-23	01:35:00	-	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	22.40	22.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.513907	2026-03-12 15:17:01.513907	f
3639	2024-12-23	10:13:00	22:17, 2:17, 5:58, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	42.90	26.30	🔺 So So	16.60	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.515608	2026-03-12 15:17:01.515608	f
3640	2024-12-23	10:13:00	-	Kibble	lucy 魔力寵糧	鮭魚雞肉佐南瓜	❌ No, not interested	25.40	25.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-12 15:17:01.517461	2026-03-12 15:17:01.517461	f
3641	2024-12-23	10:40:00	-	Wet	ciao	imc-165 布丁杯 雞肉+鮪魚	💖 Yes, eat right away	65.00	57.50	❌ No!!!	7.50	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.519275	2026-03-12 15:17:01.519275	f
3642	2024-12-24	02:30:00	17:08, 17:39, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	32.70	🔺 So So	27.30	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.521381	2026-03-12 15:17:01.521381	f
3643	2024-12-24	02:30:00	17:07, 17:33, 17:38, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	22.90	13.10	🔺 So So	9.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.523127	2026-03-12 15:17:01.523127	f
3644	2024-12-24	10:30:00	00:47, 1:05, 4:39, 7:01	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	38.60	21.60	🔺 So So	17.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.524834	2026-03-12 15:17:01.524834	f
3645	2024-12-24	13:40:00	00:49, 4:41, 7:03, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	❌ No, not interested	80.00	43.00	🔺 So So	37.00	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.526496	2026-03-12 15:17:01.526496	f
3646	2024-12-25	01:00:00	-	Wet	吶一口	無穀主食餐包3號 雞肉+火雞肉+鴨肉	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉/10:20 有吐	\N	2	\N	2026-03-12 15:17:01.528119	2026-03-12 15:17:01.528119	f
3647	2024-12-25	01:00:00	17:18, 	Wet	vif	c2 咪芙好鮮餐包 - 雞肉濃湯	💖 Yes, eat right away	75.00	33.60	🔺 So So	41.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.529747	2026-03-12 15:17:01.529747	f
3648	2024-12-25	01:00:00	9:36, 17:16	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.50	13.90	🔺 So So	6.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.53376	2026-03-12 15:17:01.53376	f
3649	2024-12-25	09:20:00	20:54, 22:13, 00:19, 2;37, 5:08, 7:12	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	39.80	14.60	💕 Love it So Much	25.20	6	❌ - 💕	35	\N	\N	2	\N	2026-03-12 15:17:01.53563	2026-03-12 15:17:01.53563	f
3650	2024-12-25	13:25:00	00:23, 5:09, 7:13, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	38.90	🔺 So So	41.10	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.537403	2026-03-12 15:17:01.537403	f
3651	2024-12-26	01:55:00	-	Wet	vif	c3 咪芙好鮮餐包 - 鮪魚鮭魚濃湯	💖 Yes, eat right away	75.00	53.80	❌ No!!!	21.20	0	💖 - ❌	18	\N	\N	2	\N	2026-03-12 15:17:01.539187	2026-03-12 15:17:01.539187	f
3652	2024-12-26	01:55:00	9:57, 14:19, 14:25, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	💖 Yes, eat right away	22.10	5.70	🔺 So So	16.40	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-12 15:17:01.54092	2026-03-12 15:17:01.54092	f
3653	2024-12-26	10:15:00	19:17, 00:15, 4:52, 7:48	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	43.10	20.50	🔺 So So	22.60	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.542599	2026-03-12 15:17:01.542599	f
3654	2024-12-26	13:40:00	00:16, 4:54, 7:50	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	❌ No, not interested	50.00	13.00	💕 Love it So Much	37.00	3	❌ - 💕	29	\N	\N	2	\N	2026-03-12 15:17:01.544219	2026-03-12 15:17:01.544219	f
3655	2024-12-27	02:00:00	14:19, 	Wet	金湯	愛貓湯罐 鮮嫩雞肉	💖 Yes, eat right away	80.00	54.00	🔺 So So	26.00	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.545885	2026-03-12 15:17:01.545885	f
3656	2024-12-27	02:00:00	10:52, 14:18, 21:19, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	14.20	11.90	🔺 So So	2.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.582925	2026-03-12 15:17:01.582925	f
3657	2024-12-27	02:00:00	-	Kibble	莫比	無穀鹿肉低敏燻鮭	❌ No, not interested	18.70	18.70	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-12 15:17:01.584952	2026-03-12 15:17:01.584952	f
3658	2024-12-27	02:00:00	10:52, 14:18, 	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	20.30	17.90	🔺 So So	2.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.586717	2026-03-12 15:17:01.586717	f
3659	2024-12-27	09:50:00	22:24, 22:36, 00:37, 4:37, 6:44	Kibble	快樂貓	鮪魚雞肉貓飼料	❌ No, not interested	47.70	31.30	🔺 So So	16.40	5	❌ - 🔺	23	加好味小姐凍乾 4.8g	\N	2	\N	2026-03-12 15:17:01.588517	2026-03-12 15:17:01.588517	f
3660	2024-12-27	09:50:00	00:38, 4:39, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	32.40	13.50	🔺 So So	18.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-12 15:17:01.590395	2026-03-12 15:17:01.590395	f
3661	2024-12-27	09:50:00	4:40, 6:46, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	23.40	💕 Love it So Much	51.60	2	💖 - 💕	37	\N	\N	2	\N	2026-03-12 15:17:01.602062	2026-03-12 15:17:01.602062	f
3662	2024-12-28	02:00:00	13:41, 17:47,	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	12.90	💕 Love it So Much	47.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-12 15:17:01.604338	2026-03-12 15:17:01.604338	f
3663	2024-12-28	02:00:00	13:40, 17:45, 20:52,	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	24.90	14.20	🔺 So So	10.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.60626	2026-03-12 15:17:01.60626	f
3664	2024-12-28	12:55:00	5:52, 9:29	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	37.00	🔺 So So	23.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-12 15:17:01.608242	2026-03-12 15:17:01.608242	f
3665	2024-12-28	12:55:00	23:03, 5:49, 9:26	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	41.50	15.50	🔺 So So	26.00	3	❌ - 🔺	19	有加凍乾	\N	2	\N	2026-03-12 15:17:01.610151	2026-03-12 15:17:01.610151	f
3666	2024-12-29	02:15:00	11:15, 15:34, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	14.00	💕 Love it So Much	51.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-12 15:17:01.614378	2026-03-12 15:17:01.614378	f
3667	2024-12-29	02:15:00	15:32, 	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	20.00	14.90	🔺 So So	5.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-12 15:17:01.61612	2026-03-12 15:17:01.61612	f
3668	2024-12-29	10:00:00	19:27, 23:16, 00:05, 5:40, 9:20	Kibble	lucy 魔力寵糧	放牧雞肉燉南瓜	❌ No, not interested	45.50	22.40	🔺 So So	23.10	5	❌ - 🔺	23	加好味小姐凍乾 4.2g	\N	2	\N	2026-03-12 15:17:01.617911	2026-03-12 15:17:01.617911	f
3669	2024-12-29	12:05:00	00:06, 5:42, 9:23	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	❌ No, not interested	80.00	58.70	🔺 So So	21.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-12 15:17:01.620327	2026-03-12 15:17:01.620327	f
3670	2024-12-30	02:00:00	15:29, 	Wet	ciao	鰹魚燒餐杯 imc-102 鮪魚+蟹肉+鰹魚片	🔺 No, not really. Ate A Little	80.00	58.60	🔺 So So	21.40	1	🔺 - 🔺	20	20:00 後外出	\N	2	\N	2026-03-12 15:17:01.622109	2026-03-12 15:17:01.622109	f
3671	2024-12-30	02:00:00	10:15, 10:55, 15:28, 17:55, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	22.40	12.70	🔺 So So	9.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-12 15:17:01.624794	2026-03-12 15:17:01.624794	f
3672	2024-12-30	02:00:00	18:31, 20:55, 22:45, 01:57, 3:48, 6:11, 7:55, 10:52, 14:05, 16:52, 	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	59.90	23.30	💕 Love it So Much	36.60	10	❌ - 💕	43	加好味小姐凍乾 6.4g	\N	2	\N	2026-03-12 15:17:01.626556	2026-03-12 15:17:01.626556	f
3673	2024-12-30	09:56:00	10:53, 	Wet	mon petit 貓倍麗	珍饌雞里肌肉餐盒 lc4	💖 Yes, eat right away	57.00	33.00	🔺 So So	24.00	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.62834	2026-03-12 15:17:01.62834	f
3674	2024-12-30	12:05:00	22:46, 23:35, 3:49, 6:12, 7:55, 14:08, 16:54, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	❌ No, not interested	50.00	3.00	💕 Love it So Much	47.00	7	❌ - 💕	44	\N	\N	2	\N	2026-03-12 15:17:01.63009	2026-03-12 15:17:01.63009	f
3675	2024-12-31	11:00:00	21:34,	Kibble	原點	雞肉 無穀全貓配方	❌ No, not interested	30.00	17.70	🔺 So So	12.30	1	❌ - 🔺	15	19:00 回來	\N	2	\N	2026-03-12 15:17:01.631863	2026-03-12 15:17:01.631863	f
3676	2024-12-31	11:00:00	21:36	Wet	mon petit 貓倍麗	mon petit 嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	40.60	🔺 So So	44.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-12 15:17:01.634336	2026-03-12 15:17:01.634336	f
3419	2024-11-06	00:40:00	-	Wet	ciao	啾嚕雪花膏 雞肉干貝 cs-195	💖 Yes, eat right away	80.00	57.10	❌ No!!!	22.90	0	💖 - ❌	18		\N	2	\N	2026-03-12 15:17:00.968073	2026-03-13 13:52:06.284351	f
3677	2026-03-13	01:25:00	10:44, 12:52, 15:35, 18:54, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	29.20	💕 Love it So Much	75.80	4	💖 - 💕	41		\N	2	\N	2026-03-13 01:31:54.64919	2026-03-13 12:40:41.569963	f
3682	2026-03-13	12:34:00	22:11, 4:20,	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	💖 Yes, eat right away	80.00	32.60	🔺 So So	47.40	2	💖 - 🔺	27		\N	2	\N	2026-03-13 12:35:00.162043	2026-03-14 00:57:11.23109	f
3678	2026-03-13	01:36:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-13 01:36:34.862173	2026-03-13 12:32:50.236865	f
4960	2026-03-16	13:05:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.30	20.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-16 13:06:07.906003	2026-03-17 01:13:17.158222	f
4573	2026-03-14	01:06:00	13:19, 16:38, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	14.40	🔺 So So	5.60	2	❌ - 🔺	17		\N	2	\N	2026-03-14 01:07:06.871004	2026-03-14 12:29:34.595577	f
5599	2026-03-27	10:01:00	-	Wet	ciao	布丁杯 鰹魚 imc-152	🔺 No, not really. Ate A Little	65.00	47.40	❌ No!!!	17.60	0	🔺 - ❌	13		\N	2	\N	2026-03-27 10:01:20.551504	2026-03-27 12:54:54.695664	f
5521	2026-03-18	12:56:00	21:44, 00:07, 2:19, 	Wet	ciao	nc-91 極鮮合味貓罐 鮪魚	💖 Yes, eat right away	85.00	18.40	💕 Love it So Much	66.60	3	💖 - 💕	46		\N	2	\N	2026-03-18 12:58:02.391665	2026-03-19 01:01:12.075383	f
3681	2026-03-13	02:51:00	-	Freeze-Dried	曙光	無穀鴨肉凍乾生食	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-13 02:51:14.537352	2026-03-13 12:33:06.84354	f
4233	2024-09-01	00:30:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	3.80	❌ No!!!	31.20	0	💖 - ❌	25	\N	\N	2	\N	2026-03-13 14:01:58.206372	2026-03-13 14:01:58.206372	f
4234	2024-09-01	00:30:00	-	Wet	axia	樂妙喵 銀魚&雞柳 mt-6	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞開始撥砂/10:10 倒掉	\N	2	\N	2026-03-13 14:01:58.209523	2026-03-13 14:01:58.209523	f
4235	2024-09-01	02:15:00	15:04, 16:55, 	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	💖 Yes, eat right away	50.00	17.10	💕 Love it So Much	32.90	2	💖 - 💕	37	\N	\N	2	\N	2026-03-13 14:01:58.211144	2026-03-13 14:01:58.211144	f
4236	2024-09-01	02:15:00	-	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	15.30	15.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.212685	2026-03-13 14:01:58.212685	f
4237	2024-09-01	00:30:00	9:46, 15:03, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.50	13.20	🔺 So So	7.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.21417	2026-03-13 14:01:58.21417	f
4238	2024-09-01	09:25:00	-	Wet	ciao	鰹魚燒晚餐 ic-281 (雞肉+鰹魚+蟹肉+干貝)	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞開始撥砂	\N	2	\N	2026-03-13 14:01:58.215699	2026-03-13 14:01:58.215699	f
4239	2024-09-01	09:25:00	18:07, 4:00, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	❌ No, not interested	60.00	37.10	🔺 So So	22.90	2	❌ - 🔺	17	聞一聞開始撥砂	\N	2	\N	2026-03-13 14:01:58.217218	2026-03-13 14:01:58.217218	f
4240	2024-09-01	09:25:00	23:01, 3:55, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	30.60	17.50	🔺 So So	13.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.218717	2026-03-13 14:01:58.218717	f
4241	2024-09-01	09:25:00	18:05, 3:58, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	33.50	22.40	🔺 So So	11.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.22017	2026-03-13 14:01:58.22017	f
4242	2024-09-02	00:30:00	8:54, 9:46, 14:07, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	16.20	💕 Love it So Much	43.80	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:58.221727	2026-03-13 14:01:58.221727	f
4243	2024-09-02	00:30:00	8:53, 14:04, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.00	8.10	🔺 So So	11.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.223276	2026-03-13 14:01:58.223276	f
4244	2024-09-02	10:10:00	9:53, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	❌ No, not interested	80.00	49.30	🔺 So So	30.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.22479	2026-03-13 14:01:58.22479	f
4245	2024-09-02	10:10:00	-	Wet	o'kat 美喵人生	肉泥主食罐 鮪魚+貓薄荷	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.226352	2026-03-13 14:01:58.226352	f
4246	2024-09-02	10:10:00	9:52, 00:11, 3:45, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	33.20	7.50	🔺 So So	25.70	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-13 14:01:58.227861	2026-03-13 14:01:58.227861	f
4247	2024-09-03	00:15:00	14:23, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	30.40	🔺 So So	49.60	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:58.230122	2026-03-13 14:01:58.230122	f
4250	2024-09-03	08:50:00	18:13, 18:39, 00:06, 4:15, 8:15	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	7.20	💕 Love it So Much	52.80	5	💖 - 💕	50	\N	\N	2	\N	2026-03-13 14:01:58.234877	2026-03-13 14:01:58.234877	f
4251	2024-09-03	08:50:00	17:26, 18:10, 18:38, 21:45, 00:01, 3:39, 4:13, 8:15,	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	43.10	8.80	💕 Love it So Much	34.30	8	❌ - 💕	46	\N	\N	2	\N	2026-03-13 14:01:58.236548	2026-03-13 14:01:58.236548	f
4252	2024-09-04	00:25:00	-	Wet	o'kat 美喵人生	綿綿慕斯主食罐 鮪魚+鮭魚+干貝	💖 Yes, eat right away	80.00	50.60	❌ No!!!	29.40	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.238127	2026-03-13 14:01:58.238127	f
4253	2024-09-04	00:25:00	8:50,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	18.70	🔺 So So	1.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.23964	2026-03-13 14:01:58.23964	f
4255	2024-09-04	08:10:00	17:25, 21:37, 5:01, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	❌ No, not interested	60.00	39.20	🔺 So So	20.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.242994	2026-03-13 14:01:58.242994	f
4256	2024-09-04	09:00:00	-	Wet	pramy 普拉	經典貓餐包 放山雞+黃金鮮鮪	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.244614	2026-03-13 14:01:58.244614	f
4257	2024-09-04	08:10:00	16:51, 17:24, 21:36, 2:19, 4:01, 5:01, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	43.70	12.60	💕 Love it So Much	31.10	6	❌ - 💕	35	\N	\N	2	\N	2026-03-13 14:01:58.246148	2026-03-13 14:01:58.246148	f
4258	2024-09-05	00:10:00	14:27, 16:01, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	10.60	💕 Love it So Much	64.40	2	💖 - 💕	44	\N	\N	2	\N	2026-03-13 14:01:58.247651	2026-03-13 14:01:58.247651	f
4259	2024-09-05	00:10:00	14:26, 15:20, 16:00, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.30	13.50	🔺 So So	6.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.249116	2026-03-13 14:01:58.249116	f
4260	2024-09-05	09:00:00	18:38, 21:17, 3:36, 5:13, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	24.40	💕 Love it So Much	55.60	4	💖 - 💕	41	\N	\N	2	\N	2026-03-13 14:01:58.250696	2026-03-13 14:01:58.250696	f
4261	2024-09-05	09:00:00	3:37, 	Wet	法麗	微湯汁系列 天然嫩雞佐鮮蔬	❌ No, not interested	80.00	70.20	🔺 So So	9.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.252187	2026-03-13 14:01:58.252187	f
4262	2024-09-05	09:00:00	18:37, 21:16, 23:27, 3:35, 5:11, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	39.20	13.60	💕 Love it So Much	25.60	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:58.253705	2026-03-13 14:01:58.253705	f
4263	2024-09-06	00:13:00	9:32, 14:26, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	2.50	💕 Love it So Much	47.50	2	💖 - 💕	44	\N	\N	2	\N	2026-03-13 14:01:58.255255	2026-03-13 14:01:58.255255	f
4264	2024-09-06	00:13:00	14:26, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.60	19.00	🔺 So So	1.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.256829	2026-03-13 14:01:58.256829	f
4265	2024-09-06	09:20:00	17:55, 18:32, 22:39, 00:29, 00:49, 4:20, 5:49,	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	19.60	💕 Love it So Much	65.40	7	💖 - 💕	54	\N	\N	2	\N	2026-03-13 14:01:58.258317	2026-03-13 14:01:58.258317	f
4266	2024-09-06	09:20:00	17:54, 18:30, 22:38, 00:09, 00:48, 4:18, 5:48, 8:10	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	44.70	18.00	💕 Love it So Much	26.70	8	❌ - 💕	39	\N	\N	2	\N	2026-03-13 14:01:58.259833	2026-03-13 14:01:58.259833	f
4267	2024-09-07	00:10:00	-	Wet	o'kat 美喵人生	綿綿慕斯主食罐 雞+蔓越莓	💖 Yes, eat right away	80.00	54.20	❌ No!!!	25.80	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.261339	2026-03-13 14:01:58.261339	f
4268	2024-09-07	00:10:00	13:29, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	13.80	🔺 So So	6.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.262835	2026-03-13 14:01:58.262835	f
4269	2024-09-07	08:30:00	18:40, 22:34, 5:22, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	21.30	🔺 So So	38.70	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:58.264299	2026-03-13 14:01:58.264299	f
4270	2024-09-07	08:30:00	3:18, 5:21, 	Wet	pramy 普拉	雞肉鮪魚慕斯主食餐包	💖 Yes, eat right away	80.00	28.00	💕 Love it So Much	52.00	2	💖 - 💕	37	\N	\N	2	\N	2026-03-13 14:01:58.26581	2026-03-13 14:01:58.26581	f
4271	2024-09-07	08:30:00	22:17, 22:32, 3:15, 5:19, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	39.40	17.60	🔺 So So	21.80	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.26726	2026-03-13 14:01:58.26726	f
4272	2024-09-08	00:20:00	9:58, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	11.60	💕 Love it So Much	63.40	1	💖 - 💕	42	\N	\N	2	\N	2026-03-13 14:01:58.268758	2026-03-13 14:01:58.268758	f
4273	2024-09-08	00:20:00	9:57, 14:03,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.50	15.90	🔺 So So	4.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.270219	2026-03-13 14:01:58.270219	f
4274	2024-09-08	09:10:00	3:43, 5:57	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	25.00	🔺 So So	35.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:58.271787	2026-03-13 14:01:58.271787	f
4275	2024-09-08	09:10:00	-	Wet	法麗	全照護主食罐 鮪魚佐鯛魚慕斯	💖 Yes, eat right away	80.00	68.00	❌ No!!!	12.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.273347	2026-03-13 14:01:58.273347	f
4276	2024-09-08	09:10:00	20:12, 23:55, 3:41, 8:15,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	40.00	15.50	🔺 So So	24.50	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.274835	2026-03-13 14:01:58.274835	f
4277	2024-09-09	00:20:00	9:18, 14:24, 15:39, 	Wet	法麗	微湯汁系列 天然嫩雞肉	💖 Yes, eat right away	80.00	23.50	💕 Love it So Much	56.50	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:58.276332	2026-03-13 14:01:58.276332	f
4278	2024-09-09	00:20:00	9:15, 14:21, 15:39, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.90	5.00	🔺 So So	15.90	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-13 14:01:58.291485	2026-03-13 14:01:58.291485	f
4279	2024-09-09	09:10:00	19:29, 21:57, 2:47, 5:17, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	20.30	🔺 So So	29.70	4	💖 - 🔺	31	\N	\N	2	\N	2026-03-13 14:01:58.293152	2026-03-13 14:01:58.293152	f
4280	2024-09-09	09:10:00	-	Wet	奧圖 aatu	無穀97%鮮肉餐包 鮭魚+雞肉+蝦	💖 Yes, eat right away	85.00	68.90	❌ No!!!	16.10	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.294742	2026-03-13 14:01:58.294742	f
4281	2024-09-09	09:10:00	19:28, 20:23, 21:57, 2:44, 5:15, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	32.90	13.40	🔺 So So	19.50	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-13 14:01:58.296315	2026-03-13 14:01:58.296315	f
4282	2024-09-10	00:25:00	9:51, 14:12, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	30.40	🔺 So So	49.60	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:58.297916	2026-03-13 14:01:58.297916	f
4283	2024-09-10	00:25:00	9:49, 14:10, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	21.40	10.00	🔺 So So	11.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.299456	2026-03-13 14:01:58.299456	f
4284	2024-09-10	09:30:00	-	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	❌ No, not interested	75.00	75.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.30095	2026-03-13 14:01:58.30095	f
4285	2024-09-10	12:32:00	4:41, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	🔺 No, not really. Ate A Little	60.00	46.80	🔺 So So	13.20	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:58.302539	2026-03-13 14:01:58.302539	f
4286	2024-09-10	12:32:00	22:50, 00:28, 4:37, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	35.10	14.40	🔺 So So	20.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.304067	2026-03-13 14:01:58.304067	f
4288	2024-09-11	00:00:00	13:52, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.40	16.10	🔺 So So	4.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.3072	2026-03-13 14:01:58.3072	f
4289	2024-09-11	09:05:00	22:28, 00:40, 6:04, 	Wet	ciao	ic-218 貓用巧餐包化毛球配方-鮪魚+扇貝 x2	💖 Yes, eat right away	80.00	27.80	💕 Love it So Much	52.20	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:58.308746	2026-03-13 14:01:58.308746	f
4290	2024-09-11	09:05:00	4:37, 6:05, 	Wet	ciao	ic-220 巧餐包 鮪魚+扇貝+雞肉(乳酸菌)	💖 Yes, eat right away	40.00	8.60	💕 Love it So Much	31.40	2	💖 - 💕	44	\N	\N	2	\N	2026-03-13 14:01:58.310295	2026-03-13 14:01:58.310295	f
4291	2024-09-11	09:05:00	17:56, 21:11, 00:38, 4:34, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	41.20	11.20	🔺 So So	30.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.311905	2026-03-13 14:01:58.311905	f
4292	2024-09-12	00:30:00	14:27, 	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	19.50	💕 Love it So Much	50.50	1	💖 - 💕	35	\N	\N	2	\N	2026-03-13 14:01:58.314091	2026-03-13 14:01:58.314091	f
4293	2024-09-12	00:30:00	13:16,	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.90	12.90	🔺 So So	8.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.315653	2026-03-13 14:01:58.315653	f
4294	2024-09-12	09:15:00	18:53, 19:38, 21:29, 22:37, 00:18, 3:43, 7:45,	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	24.70	💕 Love it So Much	60.30	7	💖 - 💕	47	\N	\N	2	\N	2026-03-13 14:01:58.317238	2026-03-13 14:01:58.317238	f
4295	2024-09-12	09:15:00	-	Wet	ciao	ic-219 下部尿路配方 鮪魚+扇貝+雞肉	💖 Yes, eat right away	40.00	24.10	❌ No!!!	15.90	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.318784	2026-03-13 14:01:58.318784	f
4296	2024-09-12	09:15:00	17:16, 19:37, 21:27, 00:16, 3;39, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	38.00	9.50	💕 Love it So Much	28.50	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:58.320429	2026-03-13 14:01:58.320429	f
4297	2024-09-13	00:15:00	9:19, 14:41, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	21.30	🔺 So So	38.70	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:58.322024	2026-03-13 14:01:58.322024	f
4298	2024-09-13	00:15:00	9:17, 14:39, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.50	13.50	🔺 So So	7.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.32387	2026-03-13 14:01:58.32387	f
4299	2024-09-13	00:15:00	8:20, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	❌ No, not interested	60.00	45.30	🔺 So So	14.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.325446	2026-03-13 14:01:58.325446	f
4300	2024-09-13	10:00:00	20:56, 23:58, 4:31, 	Wet	ciao	ciao ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	❌ No, not interested	60.00	24.60	🔺 So So	35.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.326956	2026-03-13 14:01:58.326956	f
4301	2024-09-13	10:00:00	18:09, 20:55, 23:56, 4:28, 5:59, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	39.20	16.80	🔺 So So	22.40	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-13 14:01:58.328619	2026-03-13 14:01:58.328619	f
4302	2024-09-14	00:20:00	16:06, 	Wet	法麗	室內貓排毛 鮪魚佐鯛魚	🔺 No, not really. Ate A Little	80.00	52.70	🔺 So So	27.30	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:58.330263	2026-03-13 14:01:58.330263	f
4303	2024-09-14	00:20:00	9:16, 12:10, 15:54, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.80	11.30	🔺 So So	9.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.331802	2026-03-13 14:01:58.331802	f
4304	2024-09-14	08:10:00	20:56, 23:19, 00:59, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	21.10	🔺 So So	28.90	3	🔺 - 🔺	24	\N	\N	2	\N	2026-03-13 14:01:58.333354	2026-03-13 14:01:58.333354	f
4305	2024-09-14	13:22:00	-	Wet	dr.wish	愛貓營養食(泥狀) 鮪魚+雞肉+維他命b群	💖 Yes, eat right away	85.00	74.10	❌ No!!!	10.90	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.335008	2026-03-13 14:01:58.335008	f
4306	2024-09-14	08:10:00	19:16, 20:55, 23:17, 00:57, 3:59, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	37.30	14.50	💕 Love it So Much	22.80	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:58.336644	2026-03-13 14:01:58.336644	f
4307	2024-09-15	00:15:00	16:05, 	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	💖 Yes, eat right away	70.00	19.40	💕 Love it So Much	50.60	1	💖 - 💕	35	\N	\N	2	\N	2026-03-13 14:01:58.338192	2026-03-13 14:01:58.338192	f
4308	2024-09-15	00:15:00	14:27, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.60	15.00	🔺 So So	5.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.339771	2026-03-13 14:01:58.339771	f
4309	2024-09-15	00:56:00	14:26, 	Kibble	新萃	全穀物成幼貓 雞肉	💖 Yes, eat right away	10.90	1.10	🔺 So So	9.80	1	💖 - 🔺	32	\N	\N	2	\N	2026-03-13 14:01:58.341306	2026-03-13 14:01:58.341306	f
4310	2024-09-15	10:30:00	4:03,	Wet	mon petit 貓倍麗	嚴選金罐 極品鮪魚真鯛(特選鯛魚塊)	❌ No, not interested	85.00	74.80	🔺 So So	10.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.342857	2026-03-13 14:01:58.342857	f
4311	2024-09-15	13:25:00	23:54, 5:06, 	Wet	ciao	ic-506 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	23.50	🔺 So So	36.50	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:58.34445	2026-03-13 14:01:58.34445	f
4312	2024-09-15	00:56:00	16:07, 19:47, 23:50, 4:00, 5:07, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	23.70	1.40	💕 Love it So Much	22.30	5	❌ - 💕	40	\N	\N	2	\N	2026-03-13 14:01:58.345958	2026-03-13 14:01:58.345958	f
4313	2024-09-15	10:30:00	19:49, 23:52, 4:02, 5:08, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	30.00	20.60	🔺 So So	9.40	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.347501	2026-03-13 14:01:58.347501	f
4314	2024-09-16	00:25:00	-	Wet	pramy 普拉	雞肉鮪魚慕斯主食餐包	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.348989	2026-03-13 14:01:58.348989	f
4315	2024-09-16	00:25:00	-	Wet	姆吉	2號無穀鮮肉餐包 鮪魚雞肉 mc-rm2	💖 Yes, eat right away	70.00	55.00	❌ No!!!	15.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.350512	2026-03-13 14:01:58.350512	f
4316	2024-09-16	00:25:00	10:59, 17:36, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	21.10	13.20	🔺 So So	7.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.352121	2026-03-13 14:01:58.352121	f
4317	2024-09-16	09:40:00	18:32, 8:10	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	37.50	🔺 So So	42.50	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:58.353707	2026-03-13 14:01:58.353707	f
4318	2024-09-16	09:40:00	18:30, 21:29, 3:43, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	38.50	15.80	🔺 So So	22.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.355209	2026-03-13 14:01:58.355209	f
4319	2024-09-17	00:15:00	8:46, 10:11, 12:53, 14:53, 	Wet	ciao	ic-245 鰹魚燒晚餐包(鰹魚+干貝)	💖 Yes, eat right away	50.00	7.50	💕 Love it So Much	42.50	4	💖 - 💕	48	\N	\N	2	\N	2026-03-13 14:01:58.35676	2026-03-13 14:01:58.35676	f
4320	2024-09-17	00:15:00	8:45, 10:10, 14:52, 17:50, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.30	13.60	🔺 So So	6.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.35827	2026-03-13 14:01:58.35827	f
4321	2024-09-17	10:00:00	00:13, 4:59, 7:57,	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	20.60	💕 Love it So Much	49.40	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:58.359808	2026-03-13 14:01:58.359808	f
4322	2024-09-17	10:00:00	20:17, 22:01, 00:11, 4:56, 8:00	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	39.10	5.70	💕 Love it So Much	33.40	5	❌ - 💕	40	\N	\N	2	\N	2026-03-13 14:01:58.361339	2026-03-13 14:01:58.361339	f
4323	2024-09-18	00:30:00	-	Wet	pramy 普拉	雞肉鮪魚煲湯主食餐包	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞直接撥砂	\N	2	\N	2026-03-13 14:01:58.362961	2026-03-13 14:01:58.362961	f
4324	2024-09-18	01:28:00	14:14, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	19.80	💕 Love it So Much	40.20	1	💖 - 💕	35	\N	\N	2	\N	2026-03-13 14:01:58.392313	2026-03-13 14:01:58.392313	f
4325	2024-09-18	00:30:00	9:23, 14:12, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	20.00	9.40	🔺 So So	10.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.394373	2026-03-13 14:01:58.394373	f
4326	2024-09-18	09:45:00	4:40, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	44.20	🔺 So So	35.80	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:58.396264	2026-03-13 14:01:58.396264	f
4327	2024-09-18	09:45:00	19:29, 21:38, 4:36, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	34.80	17.50	🔺 So So	17.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.398084	2026-03-13 14:01:58.398084	f
4328	2024-09-19	00:00:00	8:59, 	Wet	ciao	imc-196 乳酸菌果凍杯 (鮪魚+雞肉)	💖 Yes, eat right away	65.00	27.30	🔺 So So	37.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:58.401727	2026-03-13 14:01:58.401727	f
4329	2024-09-19	00:00:00	8:58, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	20.20	10.70	🔺 So So	9.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.403663	2026-03-13 14:01:58.403663	f
4330	2024-09-19	09:20:00	2:00,	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝 x2	💖 Yes, eat right away	60.00	23.30	🔺 So So	36.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:58.40538	2026-03-13 14:01:58.40538	f
4331	2024-09-19	09:20:00	21:18, 4:51, 	Wet	lluang 伊魯	保健布丁杯 30g 雞肉	🔺 No, not really. Ate A Little	30.00	1.20	💕 Love it So Much	28.80	2	🔺 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:58.407098	2026-03-13 14:01:58.407098	f
4332	2024-09-19	12:50:00	21:17, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	73.50	🔺 So So	11.50	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:58.408832	2026-03-13 14:01:58.408832	f
4333	2024-09-19	12:50:00	21:16, 22:41, 01:58, 4:48, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	35.50	17.40	🔺 So So	18.10	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.410538	2026-03-13 14:01:58.410538	f
4334	2024-09-20	23:45:00	13:20, 	Wet	axia	金罐特選4號 鮪+雞+扇貝	🔺 No, not really. Ate A Little	70.00	41.30	🔺 So So	28.70	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:58.412287	2026-03-13 14:01:58.412287	f
4335	2024-09-20	23:45:00	12:01, 13:18, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.20	8.90	🔺 So So	11.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.414033	2026-03-13 14:01:58.414033	f
4336	2024-09-20	09:10:00	00:49, 2:04, 5:09, 	Wet	ciao	ic-245 鰹魚燒晚餐包(鰹魚+干貝)	🔺 No, not really. Ate A Little	50.00	8.60	💕 Love it So Much	41.40	3	🔺 - 💕	41	\N	\N	2	\N	2026-03-13 14:01:58.415823	2026-03-13 14:01:58.415823	f
4337	2024-09-20	09:10:00	23:08, 	Wet	ciao	tcr-142 2000億乳酸菌4連包 鮪魚+干貝	❌ No, not interested	35.00	9.30	💕 Love it So Much	25.70	1	❌ - 💕	25	\N	\N	2	\N	2026-03-13 14:01:58.417729	2026-03-13 14:01:58.417729	f
4338	2024-09-20	09:10:00	20:06, 23:06, 2:02, 5:07, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	34.40	6.80	💕 Love it So Much	27.60	4	❌ - 💕	38	\N	\N	2	\N	2026-03-13 14:01:58.419491	2026-03-13 14:01:58.419491	f
4339	2024-09-21	00:00:00	14:46,	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	23.50	💕 Love it So Much	51.50	1	💖 - 💕	35	\N	\N	2	\N	2026-03-13 14:01:58.421537	2026-03-13 14:01:58.421537	f
4340	2024-09-21	00:00:00	-	Wet	lluang 伊魯	保健布丁杯 30g 鮪魚	❌ No, not interested	30.00	30.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 開始撥沙	\N	2	\N	2026-03-13 14:01:58.423514	2026-03-13 14:01:58.423514	f
4341	2024-09-21	00:00:00	-	Wet	axia	妙喵濃厚主食軟包2號 - 干貝	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 開始撥沙	\N	2	\N	2026-03-13 14:01:58.425577	2026-03-13 14:01:58.425577	f
4342	2024-09-21	00:00:00	9:38, 14:45, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.30	12.50	🔺 So So	7.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.427365	2026-03-13 14:01:58.427365	f
4343	2024-09-21	08:40:00	19:36, 1:11, 4:57, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	29.10	🔺 So So	20.90	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:58.429121	2026-03-13 14:01:58.429121	f
4344	2024-09-21	08:40:00	-	Wet	法麗	微湯汁系列 天然嫩雞佐牛肉	💖 Yes, eat right away	80.00	55.90	❌ No!!!	24.10	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.430874	2026-03-13 14:01:58.430874	f
4345	2024-09-21	08:40:00	19:35, 22:00, 1:09, 4:55, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	40.10	16.10	🔺 So So	24.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.432588	2026-03-13 14:01:58.432588	f
4346	2024-09-22	00:15:00	-	Wet	鮮時	鮮時高蛋白無穀主食罐- 雞肉+牛肉(肉醬)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.43426	2026-03-13 14:01:58.43426	f
4347	2024-09-22	00:15:00	-	Wet	ciao	ic-527 奢華濃湯餐包 雞肉+干貝+鮪魚 x2	🔺 No, not really. Ate A Little	60.00	49.60	❌ No!!!	10.40	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-13 14:01:58.436003	2026-03-13 14:01:58.436003	f
4348	2024-09-22	00:15:00	-	Kibble	pure luxe 純華	天然無穀亮毛配方 雞肉&鮭魚	❌ No, not interested	12.80	12.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.437693	2026-03-13 14:01:58.437693	f
4349	2024-09-22	00:15:00	12:50, 16:20	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.00	13.50	🔺 So So	6.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.439469	2026-03-13 14:01:58.439469	f
4350	2024-09-22	08:20:00	23:22, 3:20, 5:21, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	37.60	🔺 So So	42.40	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:58.441179	2026-03-13 14:01:58.441179	f
4351	2024-09-22	12:30:00	-	Wet	姆吉	6號 無穀鮮肉貓餐包 鮪魚扇貝	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.443007	2026-03-13 14:01:58.443007	f
4352	2024-09-22	08:20:00	18:48, 23:21, 3:17, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	38.80	14.90	🔺 So So	23.90	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.445838	2026-03-13 14:01:58.445838	f
4353	2024-09-23	00:15:00	15:36, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	27.50	🔺 So So	32.50	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:58.447843	2026-03-13 14:01:58.447843	f
4354	2024-09-23	00:15:00	15:35, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	21.00	17.60	🔺 So So	3.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.449765	2026-03-13 14:01:58.449765	f
4355	2024-09-23	09:30:00	4:43, 7:55, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	🔺 No, not really. Ate A Little	85.00	55.10	🔺 So So	29.90	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-13 14:01:58.492224	2026-03-13 14:01:58.492224	f
4356	2024-09-23	09:30:00	19:55, 2:57, 4:42, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	42.80	24.70	🔺 So So	18.10	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.494617	2026-03-13 14:01:58.494617	f
4357	2024-09-23	09:30:00	4:40, 	Kibble	野性魅力	成貓配方	❌ No, not interested	16.60	12.60	🔺 So So	4.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.496767	2026-03-13 14:01:58.496767	f
4358	2024-09-24	00:00:00	8:56, 15:13, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	💖 Yes, eat right away	80.00	22.70	💕 Love it So Much	57.30	2	💖 - 💕	37	\N	5.60	2	\N	2026-03-13 14:01:58.498858	2026-03-13 14:01:58.498858	f
4359	2024-09-24	00:00:00	14:00, 17:49, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.20	16.70	🔺 So So	3.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.592209	2026-03-13 14:01:58.592209	f
4360	2024-09-24	00:00:00	8:55, 14:01, 15:13, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	16.00	8.90	🔺 So So	7.10	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.594322	2026-03-13 14:01:58.594322	f
4361	2024-09-24	09:50:00	23:04, 3:24, 4:47, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	15.40	💕 Love it So Much	34.60	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:58.596161	2026-03-13 14:01:58.596161	f
4362	2024-09-24	09:50:00	4:48, 	Wet	ciao	imc-196 乳酸菌果凍杯 (鮪魚+雞肉)	❌ No, not interested	65.00	52.90	🔺 So So	12.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.597927	2026-03-13 14:01:58.597927	f
4363	2024-09-24	09:50:00	18:44, 23:03, 3:21, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	36.90	21.70	🔺 So So	15.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.599643	2026-03-13 14:01:58.599643	f
4364	2024-09-24	09:50:00	3:23, 4:45, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	25.10	15.00	🔺 So So	10.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:58.691979	2026-03-13 14:01:58.691979	f
4365	2024-09-25	00:30:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	31.50	❌ No!!!	28.50	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.694016	2026-03-13 14:01:58.694016	f
4366	2024-09-25	00:30:00	12:05, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	22.60	14.60	🔺 So So	8.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:58.696028	2026-03-13 14:01:58.696028	f
4367	2024-09-25	09:15:00	2:41,	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	9.40	💕 Love it So Much	65.60	1	💖 - 💕	42	\N	\N	2	\N	2026-03-13 14:01:58.697858	2026-03-13 14:01:58.697858	f
4368	2024-09-25	09:15:00	-	Wet	極饌	愛貓鮪魚主食包 6897	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:58.800206	2026-03-13 14:01:58.800206	f
4369	2024-09-25	09:15:00	18:37, 21:10, 2:37, 3:59, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	40.30	7.30	🔺 So So	33.00	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-13 14:01:58.802354	2026-03-13 14:01:58.802354	f
4370	2024-09-26	23:55:00	9:16, 14:26, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	💖 Yes, eat right away	50.00	10.60	💕 Love it So Much	39.40	2	💖 - 💕	44	\N	\N	2	\N	2026-03-13 14:01:58.804108	2026-03-13 14:01:58.804108	f
4371	2024-09-26	23:55:00	8:26, 9:15, 14:25, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	21.70	15.10	🔺 So So	6.60	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.992193	2026-03-13 14:01:58.992193	f
4372	2024-09-26	09:30:00	22:26, 3:59, 6:16, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	❌ No, not interested	80.00	31.00	🔺 So So	49.00	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:58.994604	2026-03-13 14:01:58.994604	f
4373	2024-09-26	09:30:00	22:24, 00:00, 3:56, 6:15, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	41.10	19.60	🔺 So So	21.50	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:58.998007	2026-03-13 14:01:58.998007	f
4374	2024-09-27	00:00:00	-	Wet	ciao	tcr-142 2000億乳酸菌4連包 鮪魚+干貝 x2 	💖 Yes, eat right away	70.00	32.00	❌ No!!!	38.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:58.999944	2026-03-13 14:01:58.999944	f
4375	2024-09-27	00:00:00	9:23, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	21.40	14.80	🔺 So So	6.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.001732	2026-03-13 14:01:59.001732	f
4376	2024-09-27	09:20:00	17:59, 18:26, 23:41, 3:45, 7:29, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	❌ No, not interested	60.00	20.40	🔺 So So	39.60	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-13 14:01:59.00366	2026-03-13 14:01:59.00366	f
4377	2024-09-27	09:20:00	17:57, 18:24, 20:33, 3:43, 7:28, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	40.70	12.60	💕 Love it So Much	28.10	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.006523	2026-03-13 14:01:59.006523	f
4378	2024-09-28	00:26:00	15:42, 	Wet	法麗	室內貓排毛 鮪魚佐柴魚	❌ No, not interested	80.00	64.50	🔺 So So	15.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.008922	2026-03-13 14:01:59.008922	f
4379	2024-09-28	00:26:00	15:42, 	Wet	吶一口	鮮肉貓罐 雞肉+牛肉	💖 Yes, eat right away	70.00	39.70	🔺 So So	30.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:59.011139	2026-03-13 14:01:59.011139	f
4380	2024-09-28	00:26:00	12:34, 15:40, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.20	13.90	🔺 So So	6.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.015458	2026-03-13 14:01:59.015458	f
4381	2024-09-28	09:12:00	19:09, 23:01, 3:42, 	Wet	ciao	ic-245 鰹魚燒晚餐包(鰹魚+干貝)	💖 Yes, eat right away	50.00	13.00	💕 Love it So Much	37.00	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:59.017141	2026-03-13 14:01:59.017141	f
4382	2024-09-28	09:12:00	19:11, 21:47, 23:00, 3:39, 8:15, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	40.30	17.30	🔺 So So	23.00	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-13 14:01:59.020208	2026-03-13 14:01:59.020208	f
4383	2024-09-29	00:32:00	-	Wet	ciao	ic-213 高湯餐包 雞肉+干貝 (日本製)	💖 Yes, eat right away	40.00	8.30	❌ No!!!	31.70	0	💖 - ❌	25	\N	\N	2	\N	2026-03-13 14:01:59.021995	2026-03-13 14:01:59.021995	f
4384	2024-09-29	00:32:00	-	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.60	20.60	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.023858	2026-03-13 14:01:59.023858	f
4385	2024-09-29	10:40:00	19:24, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	❌ No, not interested	85.00	82.00	🔺 So So	3.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.025659	2026-03-13 14:01:59.025659	f
4386	2024-09-29	13:36:00	22:24, 23:48, 4:53, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	35.80	🔺 So So	24.20	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:59.027992	2026-03-13 14:01:59.027992	f
4387	2024-09-29	10:40:00	19:22, 23:45, 3:36, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	46.20	23.20	🔺 So So	23.00	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.029829	2026-03-13 14:01:59.029829	f
4388	2024-09-30	23:55:00	8:32, 9:57, 15:03	Wet	ciao	ic-238 鰹魚燒晚餐包 化毛配方 鰹魚+柴魚片+干貝	💖 Yes, eat right away	50.00	18.10	🔺 So So	31.90	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:59.031685	2026-03-13 14:01:59.031685	f
4389	2024-09-30	23:55:00	9:55, 11:57, 15:01, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	20.50	8.30	🔺 So So	12.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.033496	2026-03-13 14:01:59.033496	f
4390	2024-09-30	09:50:00	7:41, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	38.30	🔺 So So	36.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:59.035283	2026-03-13 14:01:59.035283	f
4391	2024-09-30	12:30:00	3:10, 7:40, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	❌ No, not interested	60.00	32.70	🔺 So So	27.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.038543	2026-03-13 14:01:59.038543	f
4392	2024-09-30	09:50:00	17:52, 19:08, 3:08, 7:38, 	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	34.80	19.40	🔺 So So	15.40	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.092475	2026-03-13 14:01:59.092475	f
4393	2024-10-01	00:25:00	9:54, 	Wet	ciao	cc-82 貓用頂級奢華鮪魚 鮪魚+干貝 凍罐	❌ No, not interested	60.00	34.70	🔺 So So	25.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.09469	2026-03-13 14:01:59.09469	f
4394	2024-10-01	00:25:00	9:52, 16:55	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	20.00	12.30	🔺 So So	7.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.096776	2026-03-13 14:01:59.096776	f
4395	2024-10-01	09:00:00	-	Wet	法麗	微湯汁系列 天然嫩雞佐糙米	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	21:00 => 倒掉, 完全不吃	\N	2	\N	2026-03-13 14:01:59.098662	2026-03-13 14:01:59.098662	f
4396	2024-10-01	09:00:00	18:29, 00:54, 3:51, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	23.20	🔺 So So	26.80	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:59.100575	2026-03-13 14:01:59.100575	f
4397	2024-10-01	09:00:00	18:28, 23:46, 00:53, 3:50, 8:00	Kibble	芮格爾	成貓-雞肉&魚肉 rc-2	❌ No, not interested	37.90	23.80	🔺 So So	14.10	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-13 14:01:59.103026	2026-03-13 14:01:59.103026	f
4398	2024-10-02	00:10:00	-	Wet	pramy 普拉	雞肉慕斯主食餐包	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	8:10 => 倒掉/聞一聞, 撥沙	\N	2	\N	2026-03-13 14:01:59.104919	2026-03-13 14:01:59.104919	f
4399	2024-10-02	00:10:00	-	Wet	ciao	imc-231 果凍杯 鮪魚+鰹魚	💖 Yes, eat right away	65.00	39.50	❌ No!!!	25.50	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.106639	2026-03-13 14:01:59.106639	f
4400	2024-10-02	02:02:00	14:49, 17:00, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	💖 Yes, eat right away	10.00	0.00	🔺 So So	10.00	2	💖 - 🔺	34	\N	\N	2	\N	2026-03-13 14:01:59.108273	2026-03-13 14:01:59.108273	f
4401	2024-10-02	00:10:00	8:33, 9:11, 	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	20.90	12.70	🔺 So So	8.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.109914	2026-03-13 14:01:59.109914	f
4402	2024-10-02	07:00:00	2:38, 4:02, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	❌ No, not interested	60.00	46.90	🔺 So So	13.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.112295	2026-03-13 14:01:59.112295	f
4403	2024-10-02	13:00:00	-	Wet	凱茲	n405 嫩燉菲力 菲力火雞肉+鮭魚主食餐盒	💖 Yes, eat right away	85.00	72.20	❌ No!!!	12.80	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.114156	2026-03-13 14:01:59.114156	f
4404	2024-10-02	13:00:00	2:37, 4:00, 7:20, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	30.20	9.70	🔺 So So	20.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.115834	2026-03-13 14:01:59.115834	f
4405	2024-10-03	23:50:00	-	Wet	姆吉	3號 美膚貓慕斯 鮪魚鮭魚	💖 Yes, eat right away	70.00	44.80	❌ No!!!	25.20	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.117527	2026-03-13 14:01:59.117527	f
4406	2024-10-03	01:24:00	14:00	Wet	ciao	ic-216 鰹魚高湯餐包 鮪魚+干貝+雞肉	💖 Yes, eat right away	40.00	13.50	🔺 So So	26.50	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:59.119224	2026-03-13 14:01:59.119224	f
4407	2024-10-03	23:50:00	7:58, 9:21, 14:00	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	20.30	13.50	🔺 So So	6.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.121574	2026-03-13 14:01:59.121574	f
4408	2024-10-03	08:00:00	20:05, 23:15, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	14.60	💕 Love it So Much	45.40	2	💖 - 💕	44	\N	\N	2	\N	2026-03-13 14:01:59.123215	2026-03-13 14:01:59.123215	f
4409	2024-10-03	12:10:00	3:20, 7:07, 	Wet	ciao	ic-245 鰹魚燒晚餐包(鰹魚+干貝)	❌ No, not interested	50.00	34.00	🔺 So So	16.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.124859	2026-03-13 14:01:59.124859	f
4410	2024-10-03	08:00:00	17:39, 19:38, 21:53, 3:17, 7:06, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	38.90	12.60	💕 Love it So Much	26.30	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.126566	2026-03-13 14:01:59.126566	f
4411	2024-10-04	00:40:00	13:16, 15:38, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	💖 Yes, eat right away	80.00	46.10	🔺 So So	33.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:59.128236	2026-03-13 14:01:59.128236	f
4412	2024-10-04	00:40:00	13:15, 15:37, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	22.00	18.20	🔺 So So	3.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.12993	2026-03-13 14:01:59.12993	f
4413	2024-10-04	10:30:00	22:42, 00:02, 3:54, 	Wet	mon petit 貓倍麗	嚴選金罐鮮燴鰹魚大餐 (嚴選鰹魚塊)	❌ No, not interested	85.00	56.20	🔺 So So	28.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.132302	2026-03-13 14:01:59.132302	f
4414	2024-10-04	13:14:00	22:41, 3:54, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	44.70	🔺 So So	30.30	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:59.133974	2026-03-13 14:01:59.133974	f
4415	2024-10-04	10:30:00	19:27, 22:40, 00:01, 3:51, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	42.80	28.20	🔺 So So	14.60	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.135527	2026-03-13 14:01:59.135527	f
4416	2024-10-05	23:45:00	8:20, 15:10, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	17.90	💕 Love it So Much	42.10	2	💖 - 💕	37	\N	\N	2	\N	2026-03-13 14:01:59.137069	2026-03-13 14:01:59.137069	f
4417	2024-10-05	23:45:00	8:49, 15:08, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.30	10.00	🔺 So So	10.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.138587	2026-03-13 14:01:59.138587	f
4418	2024-10-05	09:00:00	19:05, 23:36, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	❌ No, not interested	60.00	18.00	💕 Love it So Much	42.00	2	❌ - 💕	27	\N	\N	2	\N	2026-03-13 14:01:59.14072	2026-03-13 14:01:59.14072	f
4419	2024-10-05	09:00:00	19:04, 23:33, 3:30, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	36.20	7.10	🔺 So So	29.10	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-13 14:01:59.142561	2026-03-13 14:01:59.142561	f
4420	2024-10-06	00:10:00	14:05, 16:49, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	31.30	🔺 So So	28.70	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:59.144058	2026-03-13 14:01:59.144058	f
4421	2024-10-06	00:10:00	14:04, 16:47, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	21.10	13.80	🔺 So So	7.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.145584	2026-03-13 14:01:59.145584	f
4422	2024-10-06	10:50:00	23:51, 7:11	Wet	ciao	ic-218 貓用巧餐包化毛球配方-鮪魚+扇貝 x2	💖 Yes, eat right away	80.00	37.50	🔺 So So	42.50	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:59.147109	2026-03-13 14:01:59.147109	f
4423	2024-10-06	10:50:00	23:48, 3:57, 7:09, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	39.50	20.00	🔺 So So	19.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.149	2026-03-13 14:01:59.149	f
4424	2024-10-07	00:55:00	-	Wet	ciao	tcr-23 自私的貓餐包 鮪魚+雞柳	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙	\N	2	\N	2026-03-13 14:01:59.150643	2026-03-13 14:01:59.150643	f
4425	2024-10-07	00:55:00	-	Wet	ciao	ic-233 鰹魚燒晚餐包 鰹魚+吻仔魚+干貝	💖 Yes, eat right away	50.00	39.60	❌ No!!!	10.40	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.152178	2026-03-13 14:01:59.152178	f
4426	2024-10-07	00:55:00	14:17, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	20.20	18.10	🔺 So So	2.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.153713	2026-03-13 14:01:59.153713	f
4427	2024-10-07	09:55:00	23:30, 4:23, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	44.10	🔺 So So	40.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:59.155246	2026-03-13 14:01:59.155246	f
4428	2024-10-07	09:55:00	21:52, 23:30,4:21, 7:55, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	43.10	28.40	🔺 So So	14.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.15677	2026-03-13 14:01:59.15677	f
4429	2024-10-08	00:00:00	16:34, 	Wet	ciao	ic-216 鰹魚高湯餐包 鮪魚+干貝+雞肉	💖 Yes, eat right away	40.00	11.90	🔺 So So	28.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:59.158874	2026-03-13 14:01:59.158874	f
4430	2024-10-08	00:00:00	12:45, 16:32, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	22.40	10.80	🔺 So So	11.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.160472	2026-03-13 14:01:59.160472	f
4431	2024-10-08	00:00:00	16:34, 	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	16.40	13.80	🔺 So So	2.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.161954	2026-03-13 14:01:59.161954	f
4432	2024-10-08	10:30:00	19:16, 23:07, 4:07, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	13.50	💕 Love it So Much	46.50	3	💖 - 💕	46	\N	\N	2	\N	2026-03-13 14:01:59.163551	2026-03-13 14:01:59.163551	f
4433	2024-10-08	10:30:00	23:05,4:06, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	37.80	28.90	🔺 So So	8.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.165087	2026-03-13 14:01:59.165087	f
4434	2024-10-08	10:30:00	-	Kibble	野性魅力	乾 野性魅力 海陸龍蝦盛宴	❌ No, not interested	12.10	12.10	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.167288	2026-03-13 14:01:59.167288	f
4435	2024-10-09	23:55:00	10:07, 	Wet	ciao	ic-433 乳酸菌餐包 雞肉+干貝	💖 Yes, eat right away	40.00	3.00	💕 Love it So Much	37.00	1	💖 - 💕	42	\N	\N	2	\N	2026-03-13 14:01:59.168936	2026-03-13 14:01:59.168936	f
4436	2024-10-09	23:55:00	10:06, 13:36, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	20.40	18.00	🔺 So So	2.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.170538	2026-03-13 14:01:59.170538	f
4437	2024-10-09	23:55:00	-	Kibble	極光	全齡貓 無穀鮭魚, 鯡魚, 雪蟹	❌ No, not interested	14.90	14.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.191491	2026-03-13 14:01:59.191491	f
4438	2024-10-09	10:40:00	19:48, 20:59, 2:39, 	Wet	ciao	ic-238 鰹魚燒晚餐包 化毛配方 鰹魚+柴魚片+干貝	💖 Yes, eat right away	50.00	25.30	🔺 So So	24.70	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:59.193272	2026-03-13 14:01:59.193272	f
4439	2024-10-09	10:40:00	20:57, 23:04, 2:38, 3:27, 6:57, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	43.00	23.10	💕 Love it So Much	19.90	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.194976	2026-03-13 14:01:59.194976	f
4440	2024-10-10	23:30:00	-	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	31.20	❌ No!!!	28.80	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.196898	2026-03-13 14:01:59.196898	f
4441	2024-10-10	23:30:00	9:47, 14:11, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	20.20	15.00	🔺 So So	5.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.198522	2026-03-13 14:01:59.198522	f
4442	2024-10-10	09:20:00	18:35, 20:21, 22:24, 3:33	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝) x2	💖 Yes, eat right away	100.00	43.10	🔺 So So	56.90	4	💖 - 🔺	31	22:50=> 有再補放一包 50g, 原本放一包50g	\N	2	\N	2026-03-13 14:01:59.200121	2026-03-13 14:01:59.200121	f
4443	2024-10-10	09:20:00	20:20, 3:31, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	40.80	29.50	🔺 So So	11.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.201706	2026-03-13 14:01:59.201706	f
4444	2024-10-11	00:10:00	9:02, 10:29, 15:45, 	Wet	ciao	cc-81 貓用頂級奢華鮪魚 凍罐	💖 Yes, eat right away	60.00	21.40	🔺 So So	38.60	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:59.203359	2026-03-13 14:01:59.203359	f
4445	2024-10-11	00:10:00	9:00, 10:28, 15:44, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.00	10.80	🔺 So So	9.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.205443	2026-03-13 14:01:59.205443	f
4446	2024-10-11	09:35:00	23:39, 8:11, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	25.10	🔺 So So	34.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:59.206983	2026-03-13 14:01:59.206983	f
4447	2024-10-11	09:35:00	18:18, 23:36, 4:06, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	36.00	11.60	🔺 So So	24.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.20871	2026-03-13 14:01:59.20871	f
4448	2024-10-12	00:20:00	-	Wet	辛迪斯	貓餐包 雞肉白魚 cr-cp003	💖 Yes, eat right away	50.00	10.00	❌ No!!!	40.00	0	💖 - ❌	25	\N	\N	2	\N	2026-03-13 14:01:59.210371	2026-03-13 14:01:59.210371	f
4449	2024-10-12	00:20:00	16:30, 	Kibble	天然密碼	低敏雞肉	❌ No, not interested	16.90	11.90	🔺 So So	5.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.211877	2026-03-13 14:01:59.211877	f
4450	2024-10-12	00:20:00	10:26, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	20.20	18.60	🔺 So So	1.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.213457	2026-03-13 14:01:59.213457	f
4451	2024-10-12	09:30:00	21:36, 23:32, 3:15, 4:10, 7:55, 	Kibble	天然密碼	低敏雞肉	💖 Yes, eat right away	37.30	24.20	🔺 So So	13.10	5	💖 - 🔺	33	\N	\N	2	\N	2026-03-13 14:01:59.215335	2026-03-13 14:01:59.215335	f
4452	2024-10-12	09:30:00	23:33, 3:17, 4:41,	Wet	ciao	旨定罐 a-83 白身鮪魚+雞肉+干貝	💖 Yes, eat right away	85.00	34.00	💕 Love it So Much	51.00	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:59.217009	2026-03-13 14:01:59.217009	f
4453	2024-10-13	00:20:00	9:36,	Wet	ciao	ic-433 乳酸菌餐包 雞肉+干貝	💖 Yes, eat right away	40.00	3.90	💕 Love it So Much	36.10	1	💖 - 💕	42	\N	\N	2	\N	2026-03-13 14:01:59.218565	2026-03-13 14:01:59.218565	f
4454	2024-10-13	00:20:00	9:34, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.60	7.80	🔺 So So	12.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.220099	2026-03-13 14:01:59.220099	f
4455	2024-10-13	08:25:00	19:16, 20:32, 4:23	Wet	金湯	愛貓湯罐 白身鮪魚&雞肉	💖 Yes, eat right away	80.00	38.40	🔺 So So	41.60	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:59.221673	2026-03-13 14:01:59.221673	f
4456	2024-10-13	08:25:00	18:45, 19:15, 20:31, 4:22, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	33.30	15.40	🔺 So So	17.90	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.223202	2026-03-13 14:01:59.223202	f
4457	2024-10-14	00:55:00	9:53, 	Wet	ciao	ic-441 乳酸菌餐包 鮪魚+干貝+雞肉	💖 Yes, eat right away	40.00	5.10	💕 Love it So Much	34.90	1	💖 - 💕	42	\N	\N	2	\N	2026-03-13 14:01:59.22492	2026-03-13 14:01:59.22492	f
4458	2024-10-14	00:55:00	-	Kibble	天然密碼	低敏雞肉	❌ No, not interested	21.40	21.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.226956	2026-03-13 14:01:59.226956	f
4459	2024-10-14	00:55:00	11:06, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.90	18.60	🔺 So So	2.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.228535	2026-03-13 14:01:59.228535	f
4460	2024-10-14	10:00:00	22:05, 3:28, 5:13, 7:10, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)        	💖 Yes, eat right away	85.00	23.70	💕 Love it So Much	61.30	4	💖 - 💕	41	\N	\N	2	\N	2026-03-13 14:01:59.230113	2026-03-13 14:01:59.230113	f
4461	2024-10-14	10:00:00	21:10, 00:04, 3:25, 7:07,	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	43.40	15.80	🔺 So So	27.60	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.231718	2026-03-13 14:01:59.231718	f
4462	2024-10-15	23:55:00	-	Wet	ciao	ic-216 鰹魚高湯餐包 鮪魚+干貝+雞肉	🔺 No, not really. Ate A Little	40.00	18.60	❌ No!!!	21.40	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-13 14:01:59.233505	2026-03-13 14:01:59.233505	f
4463	2024-10-15	23:55:00	-	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	20.90	15.90	❌ No!!!	5.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.235109	2026-03-13 14:01:59.235109	f
4464	2024-10-15	09:00:00	-	Wet	ciao	ic-233 鰹魚燒晚餐包 鰹魚+吻仔魚+干貝	🔺 No, not really. Ate A Little	50.00	50.00	❌ No!!!	0.00	0	🔺 - ❌	13	一直喵喵叫, 覺得可能沒吃飽(不愛）倒掉	\N	2	\N	2026-03-13 14:01:59.236825	2026-03-13 14:01:59.236825	f
4465	2024-10-15	09:00:00	-	Wet	辛迪斯	貓餐包 雞肉泥 cr-cp001	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8	一直喵喵叫, 覺得可能沒吃飽(不愛）倒掉	\N	2	\N	2026-03-13 14:01:59.238449	2026-03-13 14:01:59.238449	f
4466	2024-10-15	09:00:00	5:38	Wet	ciao	ic-432 乳酸菌餐包 鰹魚+雞肉+柴魚片	🔺 No, not really. Ate A Little	40.00	18.60	🔺 So So	21.40	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:59.240066	2026-03-13 14:01:59.240066	f
4467	2024-10-15	09:00:00	3:26, 5:39, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	🔺 No, not really. Ate A Little	60.00	35.90	🔺 So So	24.10	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-13 14:01:59.241683	2026-03-13 14:01:59.241683	f
4468	2024-10-15	09:00:00	22:01, 23:32, 3:24, 5:36,	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	30.30	10.60	🔺 So So	19.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.243324	2026-03-13 14:01:59.243324	f
4469	2024-10-16	00:00:00	-	Wet	ciao	ic-220 巧餐包 鮪魚+扇貝+雞肉(乳酸菌)	💖 Yes, eat right away	40.00	13.70	❌ No!!!	26.30	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.244896	2026-03-13 14:01:59.244896	f
4470	2024-10-16	00:00:00	-	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.00	18.30	❌ No!!!	1.70	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.246476	2026-03-13 14:01:59.246476	f
4472	2024-10-16	08:30:00	-	Wet	nature 養生湯罐	白身鮪魚+雞肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	21:30 => 倒掉(避免放太多，自己錯亂, 加上阿吉聞聞也不吃)/20:45 => 補15.8g	\N	2	\N	2026-03-13 14:01:59.250348	2026-03-13 14:01:59.250348	f
4473	2024-10-16	08:30:00	21:27, 2:57, 4:15	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	43.60	30.90	🔺 So So	12.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.252315	2026-03-13 14:01:59.252315	f
4474	2024-10-16	12:30:00	21:28, 4:16, 	Wet	ciao	旨定罐 c-21 (雞肉+ 干貝)	❌ No, not interested	85.00	77.00	🔺 So So	8.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.254308	2026-03-13 14:01:59.254308	f
4475	2024-10-17	00:00:00	-	Wet	竣寶	化毛貓罐 鮪魚	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	9:00 => 已倒掉	\N	2	\N	2026-03-13 14:01:59.256326	2026-03-13 14:01:59.256326	f
4476	2024-10-17	00:00:00	9:05, 13:01, 14:38, 	Wet	金湯	愛貓湯罐 白身鮪魚&小麥草	💖 Yes, eat right away	80.00	21.10	💕 Love it So Much	58.90	3	💖 - 💕	39	\N	\N	2	\N	2026-03-13 14:01:59.258308	2026-03-13 14:01:59.258308	f
4478	2024-10-17	00:00:00	14:36, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.40	18.20	🔺 So So	2.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.294549	2026-03-13 14:01:59.294549	f
4479	2024-10-17	09:18:00	00:43, 4:07, 	Wet	ciao	極鮮合味系列 貓餐杯 nc-93 雞肉	💖 Yes, eat right away	85.00	24.20	💕 Love it So Much	60.80	2	💖 - 💕	37	\N	\N	2	\N	2026-03-13 14:01:59.296526	2026-03-13 14:01:59.296526	f
4480	2024-10-17	09:18:00	4:05, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	44.30	34.50	🔺 So So	9.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.298298	2026-03-13 14:01:59.298298	f
4481	2024-10-17	09:18:00	-	Kibble	halo	成貓 無穀野生鮭魚燉白魚	❌ No, not interested	15.70	15.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.300151	2026-03-13 14:01:59.300151	f
4482	2024-10-18	00:20:00	-	Wet	ciao	ic-245 鰹魚燒晚餐包(鰹魚+干貝)	💖 Yes, eat right away	50.00	34.30	❌ No!!!	15.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.302076	2026-03-13 14:01:59.302076	f
4483	2024-10-18	00:20:00	-	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.304228	2026-03-13 14:01:59.304228	f
4484	2024-10-18	00:20:00	-	Kibble	柏萊富	棒吉 海陸直送6種肉 (3種放養鮮肉+3種嚴選鮮魚)	❌ No, not interested	16.30	16.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.305897	2026-03-13 14:01:59.305897	f
4485	2024-10-18	07:30:00	-	Kibble	安柏希雅	火雞肉 & 鯡魚	💖 Yes, eat right away	15.10	10.30	❌ No!!!	4.80	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.307498	2026-03-13 14:01:59.307498	f
4486	2024-10-18	10:00:00	-	Wet	ciao	ic-433 乳酸菌餐包 雞肉+干貝 x2	💖 Yes, eat right away	80.00	69.30	❌ No!!!	10.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.309158	2026-03-13 14:01:59.309158	f
4487	2024-10-18	10:00:00	-	Wet	petline	sm-1 三時貓用慕斯餐包25g 雞肉+鰹魚	❌ No, not interested	25.00	25.00	❌ No!!!	0.00	0	❌ - ❌	8	18:30 => 倒掉	\N	2	\N	2026-03-13 14:01:59.310824	2026-03-13 14:01:59.310824	f
4488	2024-10-18	10:00:00	-	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	35.00	35.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.312469	2026-03-13 14:01:59.312469	f
4489	2024-10-18	10:00:00	18:00, 3:58, 5:30, 	Kibble	安柏希雅	火雞肉 & 鯡魚	❌ No, not interested	30.30	15.20	🔺 So So	15.10	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.315893	2026-03-13 14:01:59.315893	f
4490	2024-10-18	10:00:00	-	Freeze-Dried	超越巔峰	貓用鮮食肉片 雞肉+鱈魚+綠貽貝	❌ No, not interested	25.00	25.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.318088	2026-03-13 14:01:59.318088	f
4491	2024-10-19	23:00:00	12:04, 14:00, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	21.50	11.90	🔺 So So	9.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.322034	2026-03-13 14:01:59.322034	f
4492	2024-10-19	23:00:00	12:51, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	20.20	17.00	🔺 So So	3.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.323751	2026-03-13 14:01:59.323751	f
4493	2024-10-19	23:00:00	-	Wet	ciao	旨定罐 a-83 白身鮪魚+雞肉+干貝	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	聞聞都沒吃, 推測不愛, 所以放半小時沒吃, 直接倒掉/避免後續自己混亂	\N	2	\N	2026-03-13 14:01:59.325467	2026-03-13 14:01:59.325467	f
4494	2024-10-19	23:00:00	-	Wet	爵士貓吧	鮪魚肉泥 	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞聞都沒吃, 推測不愛, 所以放半小時沒吃, 直接倒掉/避免後續自己混亂	\N	2	\N	2026-03-13 14:01:59.327095	2026-03-13 14:01:59.327095	f
4495	2024-10-19	23:00:00	12:06,	Wet	ciao	cc-83 貓用頂級奢華鮪魚 鮪魚+鰹魚 凍罐	🔺 No, not really. Ate A Little	60.00	35.40	🔺 So So	24.60	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:59.328742	2026-03-13 14:01:59.328742	f
4496	2024-10-19	10:40:00	4:30, 5:47,	Wet	金湯	愛貓湯罐 鮮嫩雞肉	💖 Yes, eat right away	80.00	31.60	🔺 So So	48.40	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-13 14:01:59.330303	2026-03-13 14:01:59.330303	f
4497	2024-10-19	10:40:00	2:07, 4:28, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	37.20	26.00	🔺 So So	11.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.332541	2026-03-13 14:01:59.332541	f
4498	2024-10-19	10:40:00	21:08, 23:40, 4:30, 5:45, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	42.20	33.10	🔺 So So	9.10	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.334756	2026-03-13 14:01:59.334756	f
4499	2024-10-19	10:40:00	21:07, 	Kibble	加拿大 楓沛	火雞鮭魚	❌ No, not interested	20.30	20.00	🔺 So So	0.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.336437	2026-03-13 14:01:59.336437	f
4500	2024-10-20	00:17:00	-	Wet	ciao	極鮮合味系列 貓餐杯 nc-92 鰹魚	💖 Yes, eat right away	85.00	38.20	❌ No!!!	46.80	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.338235	2026-03-13 14:01:59.338235	f
4501	2024-10-20	00:17:00	-	Kibble	自然平衡	lid無穀雞肉腸胃保健成貓配方	❌ No, not interested	20.10	20.10	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.339984	2026-03-13 14:01:59.339984	f
4502	2024-10-20	00:17:00	-	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	21.80	21.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.341625	2026-03-13 14:01:59.341625	f
4471	2024-10-16	07:30:00	19:53, 21:26, 2:55, 	Kibble	貓倍麗	海洋魚高纖化毛	💖 Yes, eat right away	15.20	4.20	🔺 So So	11.00	3	💖 - 🔺	29		\N	2	\N	2026-03-13 14:01:59.248477	2026-03-15 12:05:51.055159	f
4503	2024-10-20	02:10:00	-	Wet	迷幻喵	1號 多汁雞肉+胡蘿蔔+貓草	💖 Yes, eat right away	125.00	104.90	❌ No!!!	20.10	0	💖 - ❌	18		\N	2	\N	2026-03-13 14:01:59.343206	2026-03-16 14:25:15.065006	f
4504	2024-10-20	10:30:00	-	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	❌ No, not interested	60.00	45.00	❌ No!!!	15.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.345231	2026-03-13 14:01:59.345231	f
4505	2024-10-20	10:30:00	-	Wet	法麗	全方位無膠主食罐 雞肉慕斯佐鮪魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.34824	2026-03-13 14:01:59.34824	f
4506	2024-10-20	10:30:00	21:17, 3:26, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	21.80	14.20	🔺 So So	7.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.349922	2026-03-13 14:01:59.349922	f
4507	2024-10-21	00:05:00	-	Wet	nature 養生湯罐	白身鮪魚+鮭魚	💖 Yes, eat right away	80.00	51.60	❌ No!!!	28.40	0	💖 - ❌	18	是否太常給凍乾, 造成乾乾&罐頭不願意吃？ 改一天給一次就好	\N	2	\N	2026-03-13 14:01:59.351551	2026-03-13 14:01:59.351551	f
4508	2024-10-21	00:05:00	-	Wet	吶一口	主食泥罐 鮮嫩鮪魚+卵磷脂	🔺 No, not really. Ate A Little	60.00	43.20	❌ No!!!	16.80	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-13 14:01:59.393377	2026-03-13 14:01:59.393377	f
4509	2024-10-21	00:05:00	-	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	20.50	20.50	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.395933	2026-03-13 14:01:59.395933	f
4510	2024-10-21	00:05:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 牛+羊	❌ No, not interested	22.50	22.50	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.397981	2026-03-13 14:01:59.397981	f
4511	2024-10-21	10:10:00	-	Wet	愛情貴族	白身鮪魚&牛肉 	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	19:40 => 倒掉, 都不吃, 一直喵喵叫	\N	2	\N	2026-03-13 14:01:59.399763	2026-03-13 14:01:59.399763	f
4512	2024-10-21	10:10:00	-	Wet	grau 灰樂	低敏無穀主食貓餐包-2號狂野火雞	❌ No, not interested	125.00	125.00	❌ No!!!	0.00	0	❌ - ❌	8	21:00 => 倒掉, 都沒吃, 但還是一直喵喵叫	\N	2	\N	2026-03-13 14:01:59.401402	2026-03-13 14:01:59.401402	f
4513	2024-10-21	11:45:00	21:36, 22:28, 2:09, 4:26, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	💖 Yes, eat right away	50.00	7.80	💕 Love it So Much	42.20	4	💖 - 💕	48	\N	\N	2	\N	2026-03-13 14:01:59.402987	2026-03-13 14:01:59.402987	f
4514	2024-10-21	11:45:00	4:28, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	🔺 No, not really. Ate A Little	85.00	67.10	🔺 So So	17.90	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:59.405725	2026-03-13 14:01:59.405725	f
4515	2024-10-21	11:45:00	4:26, 	Kibble	納茲 rawz	鮭魚+脫水雞肉+白魚	❌ No, not interested	35.90	32.10	🔺 So So	3.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.407421	2026-03-13 14:01:59.407421	f
4516	2024-10-21	11:45:00	22:27, 2:08, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	15.10	9.60	🔺 So So	5.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.40912	2026-03-13 14:01:59.40912	f
4517	2024-10-21	11:45:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 牛+羊	❌ No, not interested	38.00	38.00	❌ No!!!	0.00	0	❌ - ❌	8	21:00 => 倒掉, 改放原本的素力高 	\N	2	\N	2026-03-13 14:01:59.412089	2026-03-13 14:01:59.412089	f
4518	2024-10-22	23:55:00	-	Wet	ciao	ic-441 乳酸菌餐包 鮪魚+干貝+雞肉 x2	💖 Yes, eat right away	80.00	42.00	❌ No!!!	38.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.413791	2026-03-13 14:01:59.413791	f
4519	2024-10-22	23:55:00	-	Kibble	origen	鮮雞愛貓	❌ No, not interested	16.40	16.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.415456	2026-03-13 14:01:59.415456	f
4520	2024-10-22	02:00:00	-	Wet	grau 灰樂	4號 火雞佐純羊	❌ No, not interested	125.00	125.00	❌ No!!!	0.00	0	❌ - ❌	8	一直喵喵叫, 感覺沒吃飽	\N	2	\N	2026-03-13 14:01:59.417067	2026-03-13 14:01:59.417067	f
4521	2024-10-22	05:30:00	14:39, 17:05	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	15.20	15.20	❌ No!!!	0.00	2	❌ - ❌	12	17:07 => 幾乎快吃完, 馬上加31.5g	\N	2	\N	2026-03-13 14:01:59.419743	2026-03-13 14:01:59.419743	f
4522	2024-10-22	09:10:00	18:01, 21:03, 00:02, 4:04, 6:06,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	46.70	8.90	💕 Love it So Much	37.80	5	❌ - 💕	40	\N	\N	2	\N	2026-03-13 14:01:59.429879	2026-03-13 14:01:59.429879	f
4523	2024-10-22	09:10:00	18:03, 21:05, 00:04, 4:07, 6:07, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	14.50	💕 Love it So Much	35.50	5	💖 - 💕	43	\N	\N	2	\N	2026-03-13 14:01:59.431763	2026-03-13 14:01:59.431763	f
4524	2024-10-22	09:10:00	-	Wet	辛迪斯	貓餐包 鮪魚雞肉 cr-cp006	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.434192	2026-03-13 14:01:59.434192	f
4525	2024-10-23	00:20:00	-	Wet	原燒	干貝濃湯餐包 鮮嫩鮪魚+鮭魚	🔺 No, not really. Ate A Little	50.00	50.00	❌ No!!!	0.00	0	🔺 - ❌	13	13:30 => 倒掉	\N	2	\N	2026-03-13 14:01:59.436055	2026-03-13 14:01:59.436055	f
4526	2024-10-23	00:20:00	11:53,	Wet	ciao	ic-433 乳酸菌餐包 雞肉+干貝	💖 Yes, eat right away	40.00	10.00	💕 Love it So Much	30.00	1	💖 - 💕	35	\N	\N	2	\N	2026-03-13 14:01:59.437815	2026-03-13 14:01:59.437815	f
4527	2024-10-23	00:20:00	11:51, 14:09, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	22.40	16.40	🔺 So So	6.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.440302	2026-03-13 14:01:59.440302	f
4528	2024-10-23	09:00:00	21:35, 3:41, 5:55, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	25.20	🔺 So So	34.80	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-13 14:01:59.442181	2026-03-13 14:01:59.442181	f
4529	2024-10-23	09:00:00	18:16, 21:33, 00:05, 3:39, 5:53, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	42.60	13.90	💕 Love it So Much	28.70	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.44409	2026-03-13 14:01:59.44409	f
4530	2024-10-24	23:55:00	15:32, 	Wet	易特廚	奢華嫩鮭魚大餐(鮪魚+雞肉+鮭魚)	🔺 No, not really. Ate A Little	80.00	57.20	🔺 So So	22.80	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:59.44589	2026-03-13 14:01:59.44589	f
4531	2024-10-24	23:55:00	15:31, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	17.80	🔺 So So	2.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.447904	2026-03-13 14:01:59.447904	f
4532	2024-10-24	09:10:00	21:59, 4:06, 5:25, 	Wet	axia	新金罐濃厚7號- 鮪, 牛	🔺 No, not really. Ate A Little	70.00	43.60	🔺 So So	26.40	3	🔺 - 🔺	24	\N	\N	2	\N	2026-03-13 14:01:59.449699	2026-03-13 14:01:59.449699	f
4533	2024-10-24	09:10:00	18:52, 21:59, 23:04, 4:06, 5:24, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	🔺 No, not really. Ate A Little	50.00	9.20	💕 Love it So Much	40.80	5	🔺 - 💕	45	\N	\N	2	\N	2026-03-13 14:01:59.451343	2026-03-13 14:01:59.451343	f
4534	2024-10-24	09:10:00	-	Wet	axia	金罐特選濃厚8號 鮪+雞+柴	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-13 14:01:59.453064	2026-03-13 14:01:59.453064	f
4535	2024-10-24	09:10:00	18:50, 21:58, 23:03, 4:04	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	44.20	24.70	🔺 So So	19.50	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.454778	2026-03-13 14:01:59.454778	f
4536	2024-10-25	00:15:00	8:41, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	🔺 No, not really. Ate A Little	60.00	42.20	🔺 So So	17.80	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-13 14:01:59.456504	2026-03-13 14:01:59.456504	f
4537	2024-10-25	00:15:00	8:42, 	Wet	易特廚	鮪魚燉雞煲湯	❌ No, not interested	80.00	59.80	🔺 So So	20.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-13 14:01:59.458143	2026-03-13 14:01:59.458143	f
4538	2024-10-25	00:15:00	-	Wet	ciao	旨定罐 a-84 鰹魚+干貝	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	倒掉	\N	2	\N	2026-03-13 14:01:59.459972	2026-03-13 14:01:59.459972	f
4539	2024-10-25	00:15:00	8:39, 14:47,	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	22.20	17.40	🔺 So So	4.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.46162	2026-03-13 14:01:59.46162	f
4540	2024-10-25	09:50:00	18:52, 20:26, 23:40, 03:47, 05:53, 	Wet	ciao	鰹魚燒晚餐包 ic-244	❌ No, not interested	50.00	19.40	💕 Love it So Much	30.60	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.463475	2026-03-13 14:01:59.463475	f
4541	2024-10-25	09:50:00	-	Wet	ciao	啾嚕雪花膏 雞肉干貝 cs-195	💖 Yes, eat right away	80.00	52.10	❌ No!!!	27.90	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.465496	2026-03-13 14:01:59.465496	f
4542	2024-10-25	09:50:00	18:50, 20:25, 23:38, 03:44, 05:52, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	45.40	24.40	💕 Love it So Much	21.00	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.467192	2026-03-13 14:01:59.467192	f
4543	2024-10-26	00:07:00	16:35, 	Wet	axia	金罐特選4號 鮪+雞+扇貝 gmc-4	💖 Yes, eat right away	70.00	33.50	🔺 So So	36.50	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:59.468816	2026-03-13 14:01:59.468816	f
4544	2024-10-26	00:07:00	8:44, 14:09, 16:34, 18:00, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	22.80	12.90	🔺 So So	9.90	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.470455	2026-03-13 14:01:59.470455	f
4545	2024-10-26	10:00:00	19:08, 21:23, 3:37,.	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	🔺 No, not really. Ate A Little	50.00	25.90	🔺 So So	24.10	3	🔺 - 🔺	24	\N	\N	2	\N	2026-03-13 14:01:59.491848	2026-03-13 14:01:59.491848	f
4546	2024-10-26	10:00:00	21:22, 23:19, 3:34, 5:50, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	38.50	15.90	🔺 So So	22.60	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.49461	2026-03-13 14:01:59.49461	f
4547	2024-10-27	00:15:00	9:09, 15:13, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	18.30	💕 Love it So Much	41.70	2	💖 - 💕	37	\N	\N	2	\N	2026-03-13 14:01:59.496299	2026-03-13 14:01:59.496299	f
4548	2024-10-27	00:15:00	9:08, 15:11, 16:58, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	12.10	🔺 So So	7.90	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.497961	2026-03-13 14:01:59.497961	f
4549	2024-10-27	00:15:00	7:28, 	Wet	ciao	ic-432 乳酸菌餐包 鰹魚+雞肉+柴魚片	💖 Yes, eat right away	40.00	11.30	🔺 So So	28.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:59.499633	2026-03-13 14:01:59.499633	f
4550	2024-10-27	10:00:00	-	Wet	ciao	ic-441 乳酸菌餐包 鮪魚+干貝+雞肉	🔺 No, not really. Ate A Little	40.00	28.50	❌ No!!!	11.50	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-13 14:01:59.501613	2026-03-13 14:01:59.501613	f
4551	2024-10-27	10:00:00	20:48, 23:28, 2:52, 4:40, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	39.90	19.70	🔺 So So	20.20	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.503232	2026-03-13 14:01:59.503232	f
4552	2024-10-28	00:35:00	-	Wet	蘿拉喵 lola & co	鮪鮪魚雞肉果凍 rm8	💖 Yes, eat right away	80.00	46.50	❌ No!!!	33.50	0	💖 - ❌	18	\N	\N	2	\N	2026-03-13 14:01:59.505453	2026-03-13 14:01:59.505453	f
4553	2024-10-28	00:35:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.50774	2026-03-13 14:01:59.50774	f
4554	2024-10-28	10:00:00	18:23, 23:32, 3:57, 8:03, 	Wet	ciao	ic-231 鰹魚燒晚餐包 (鰹魚+柴魚片+干貝)	❌ No, not interested	50.00	17.10	🔺 So So	32.90	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.509331	2026-03-13 14:01:59.509331	f
4555	2024-10-28	10:00:00	18:21, 21:40, 23:30, 3:55, 8:01	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	45.70	18.70	💕 Love it So Much	27.00	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.519473	2026-03-13 14:01:59.519473	f
4556	2024-10-29	00:25:00	-	Wet	易特廚	奢華嫩鮭魚大餐(鮪魚+雞肉+鮭魚)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	17:40, 18:15 吐	\N	2	\N	2026-03-13 14:01:59.521111	2026-03-13 14:01:59.521111	f
4557	2024-10-29	02:00:00	-	Wet	dr.wish	愛貓營養食(泥狀) 鮪魚+雞肉+牛磺酸	🔺 No, not really. Ate A Little	85.00	74.20	❌ No!!!	10.80	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-13 14:01:59.5227	2026-03-13 14:01:59.5227	f
4558	2024-10-29	02:00:00	-	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	21.70	21.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-13 14:01:59.524349	2026-03-13 14:01:59.524349	f
4559	2024-10-29	09:20:00	23:20, 3:51, 5:23, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	❌ No, not interested	60.00	22.80	🔺 So So	37.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.526237	2026-03-13 14:01:59.526237	f
4560	2024-10-29	09:20:00	18:05, 20:01, 3:50, 5:25, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	❌ No, not interested	50.00	33.10	🔺 So So	16.90	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-13 14:01:59.528237	2026-03-13 14:01:59.528237	f
4561	2024-10-29	09:20:00	18:00, 20:00, 23:17, 3:48, 5:21, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	48.20	21.80	💕 Love it So Much	26.40	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.530109	2026-03-13 14:01:59.530109	f
4562	2024-10-30	00:40:00	10:02, 	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	26.60	💕 Love it So Much	43.40	1	💖 - 💕	35	\N	\N	2	\N	2026-03-13 14:01:59.531763	2026-03-13 14:01:59.531763	f
4563	2024-10-30	00:40:00	10:00, 17:52, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	22.00	18.30	🔺 So So	3.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-13 14:01:59.53331	2026-03-13 14:01:59.53331	f
4564	2024-10-30	09:55:00	20:10, 22:32, 00:03, 00:44, 4:49, 6:44	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)        	💖 Yes, eat right away	85.00	4.80	💕 Love it So Much	80.20	6	💖 - 💕	52	\N	\N	2	\N	2026-03-13 14:01:59.534893	2026-03-13 14:01:59.534893	f
4565	2024-10-30	09:55:00	20:09, 22:31, 00:01, 4:46, 6:42, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	43.30	20.50	💕 Love it So Much	22.80	5	❌ - 💕	33	\N	\N	2	\N	2026-03-13 14:01:59.536869	2026-03-13 14:01:59.536869	f
4566	2024-10-31	00:23:00	9:36, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	28.10	🔺 So So	31.90	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-13 14:01:59.538561	2026-03-13 14:01:59.538561	f
4567	2024-10-31	00:23:00	9:35, 13:58, 17:28, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	20.00	15.10	🔺 So So	4.90	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-13 14:01:59.540131	2026-03-13 14:01:59.540131	f
4568	2024-10-31	09:30:00	19:11, 20:57, 00:36, 4:04, 6:43, 	Wet	ciao	近海鰹魚罐93號 (干貝味) 	💖 Yes, eat right away	80.00	9.20	💕 Love it So Much	70.80	5	💖 - 💕	50	\N	\N	2	\N	2026-03-13 14:01:59.54171	2026-03-13 14:01:59.54171	f
4569	2024-10-31	09:30:00	19:09, 20:55, 23:21, 00:33, 4:02, 6:41, 	Kibble	柏萊富	特調無穀 全齡貓配方 鴨肉+鮭魚+豌豆	❌ No, not interested	40.70	11.80	💕 Love it So Much	28.90	6	❌ - 💕	35	\N	\N	2	\N	2026-03-13 14:01:59.54325	2026-03-13 14:01:59.54325	f
3686	2026-03-13	12:39:00	00:51, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	19.70	🔺 So So	5.60	1	❌ - 🔺	15		\N	2	56	2026-03-13 12:39:58.107325	2026-03-14 00:54:54.043418	t
3683	2026-03-13	12:35:00	00:29, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	19.80	🔺 So So	0.20	1	❌ - 🔺	15		\N	2	\N	2026-03-13 12:35:11.74885	2026-03-14 00:56:09.391159	f
4571	2026-03-14	00:52:00	11:43, 	Wet	禮加樂 regalos	鮪魚雞肉罐頭	💖 Yes, eat right away	80.00	46.70	🔺 So So	33.30	1	💖 - 🔺	25	跟上跟下	\N	2	\N	2026-03-14 00:53:07.80694	2026-03-14 07:20:42.363006	f
4576	2026-03-14	12:26:00	22:03, 1:47, 5:28	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x3	💖 Yes, eat right away	105.00	25.80	💕 Love it So Much	79.20	3	💖 - 💕	46		\N	2	\N	2026-03-14 12:26:53.711112	2026-03-15 01:34:20.205749	f
4581	2026-03-15	01:29:00	-	Wet	ciao	旅日系列餐包 ic-165 德島阿波尾雞高湯+秋田比內地雞高湯 - 德島阿波尾雞高湯ic-16c x2	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-15 01:29:33.44664	2026-03-17 01:26:43.048958	f
3685	2026-03-13	12:37:00	22:09,  4:18, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.30	12.50	🔺 So So	7.80	2	❌ - 🔺	17		\N	2	\N	2026-03-13 12:37:15.07605	2026-03-14 00:56:33.853603	f
1425	2025-04-22	11:00:00	21:44,  8:15, 	Wet	sheba	金罐 鮪魚及鮭魚 (湯汁)	🔺 No, not really. Ate A Little	85.00	50.30	🔺 So So	34.70	2	🔺 - 🔺	22		\N	2	\N	2026-03-02 12:05:33.301318	2026-03-15 09:10:02.339589	f
1646	2025-05-24	00:40:00	-	Wet	nature 養生湯罐	白身鮪魚+鮭魚	🔺 No, not really. Ate A Little	80.00	64.60	❌ No!!!	15.40	0	🔺 - ❌	13	1:36 吃完雞心凍乾後沒多久吐/10:45 一直叫, 卻不回頭吃, 倒掉	\N	2	\N	2026-03-04 11:51:05.422776	2026-03-15 09:23:14.116499	f
3060	2025-12-07	01:50:00	-	Kibble	曙光	無穀滋養白鮭魚食譜	❌ No, not interested	20.30	20.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.397474	2026-03-15 09:55:07.292168	f
3054	2025-12-06	02:20:00	19:39, 1:02, 3:59, 8:37, 	Kibble	曙光	無穀滋養白鮭魚食譜	❌ No, not interested	20.30	12.00	🔺 So So	8.30	4	❌ - 🔺	21	19:39=> 要拿到面前才願意吃, 再觀察看看	\N	2	\N	2026-03-08 13:51:59.347035	2026-03-15 09:55:26.027844	f
3390	2026-03-12	07:18:00	16:59, 19:43, 	Wet	ciao	旅日系列餐包 ic-165 德島阿波尾雞高湯+秋田比內地雞高湯 - 秋田比內地雞高湯ic-16d x2	❌ No, not interested	40.00	22.80	🔺 So So	17.20	2	❌ - 🔺	17		\N	2	\N	2026-03-12 07:22:12.615397	2026-03-17 01:26:23.910891	f
4582	2026-03-15	01:36:00	11:01, 17:52, 20:00, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.50	19.20	🔺 So So	6.30	3	❌ - 🔺	19	加誠實貓 雞塊 5.2g	\N	2	56	2026-03-15 01:36:42.730573	2026-03-15 12:36:54.47719	t
4287	2024-09-11	00:00:00	-	Wet	惡魔喵	天然無穀餐包 小惡魔1號 鮮嫩雞肉	💖 Yes, eat right away	85.00	51.00	❌ No!!!	34.00	0	💖 - ❌	18		\N	2	\N	2026-03-13 14:01:58.305648	2026-03-15 11:50:51.741103	f
4585	2024-07-01	00:15:00	8:37, 12:01, 	Wet	ginny 吉妮貓	鮮餐煲 鮪雞雙拼拌醬	❌ No, not interested	70.00	23.90	💕 Love it So Much	46.10	2	❌ - 💕	27	\N	\N	2	\N	2026-03-15 12:03:08.680265	2026-03-15 12:03:08.680265	f
4586	2024-07-01	00:15:00	15:12, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	12.40	🔺 So So	7.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.691896	2026-03-15 12:03:08.691896	f
4587	2024-07-01	09:00:00	20:42, 21:32, 3:55, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	20.00	💕 Love it So Much	60.00	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:08.695236	2026-03-15 12:03:08.695236	f
4588	2024-07-01	09:00:00	21:31, 3:53, 	Wet	ciao	原湯杯52號(鮪+蟹+小魚)	💖 Yes, eat right away	60.00	10.90	💕 Love it So Much	49.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:08.699499	2026-03-15 12:03:08.699499	f
4589	2024-07-01	09:00:00	6:42, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	32.40	26.70	🔺 So So	5.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.707217	2026-03-15 12:03:08.707217	f
4590	2024-07-02	00:20:00	14:12, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	32.70	🔺 So So	37.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:08.710295	2026-03-15 12:03:08.710295	f
4591	2024-07-02	00:20:00	-	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:08.712336	2026-03-15 12:03:08.712336	f
4592	2024-07-02	01:38:00	15:25,	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	12.10	💕 Love it So Much	47.90	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:08.789136	2026-03-15 12:03:08.789136	f
4593	2024-07-02	09:00:00	17:44, 22:28, 4:52, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	11.40	💕 Love it So Much	63.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:08.792575	2026-03-15 12:03:08.792575	f
4594	2024-07-02	09:00:00	17:45, 19:12, 22:29, 3:04, 4:50, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	2.50	💕 Love it So Much	47.50	5	💖 - 💕	50	\N	\N	2	\N	2026-03-15 12:03:08.79642	2026-03-15 12:03:08.79642	f
4595	2024-07-02	09:00:00	17:44, 3:02, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	40.40	22.50	🔺 So So	17.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:08.79854	2026-03-15 12:03:08.79854	f
4596	2024-07-03	00:20:00	15:00, 	Wet	nature 養生湯罐	白身鮪魚+吻仔魚	💖 Yes, eat right away	80.00	41.60	🔺 So So	38.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:08.801011	2026-03-15 12:03:08.801011	f
4597	2024-07-03	00:20:00	14:58, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	19.80	12.60	🔺 So So	7.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.803043	2026-03-15 12:03:08.803043	f
4598	2024-07-03	09:05:00	4:36, 	Wet	sheba	金罐 鮪魚及鮭魚 (湯汁)	💖 Yes, eat right away	85.00	36.80	🔺 So So	48.20	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:08.805375	2026-03-15 12:03:08.805375	f
4599	2024-07-03	09:05:00	18:30, 22:08, 3:32, 4:35, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	3.10	💕 Love it So Much	46.90	4	💖 - 💕	48	\N	\N	2	\N	2026-03-15 12:03:08.809685	2026-03-15 12:03:08.809685	f
4600	2024-07-03	09:05:00	18:28, 3:29, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	💖 Yes, eat right away	20.30	1.90	🔺 So So	18.40	2	💖 - 🔺	34	\N	\N	2	\N	2026-03-15 12:03:08.811823	2026-03-15 12:03:08.811823	f
4601	2024-07-03	09:05:00	3:28, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	12.60	5.50	🔺 So So	7.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.813913	2026-03-15 12:03:08.813913	f
4602	2024-07-04	00:00:00	8:28, 15:55, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	22.40	💕 Love it So Much	57.60	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:08.816416	2026-03-15 12:03:08.816416	f
4603	2024-07-04	00:00:00	13:55, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	22.60	12.40	🔺 So So	10.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.819043	2026-03-15 12:03:08.819043	f
4604	2024-07-04	09:30:00	17:50, 21:15, 3:39, 7:53,	Wet	mon petit 貓倍麗	嚴選金罐 極品鮪魚真鯛(特選鯛魚塊)	❌ No, not interested	85.00	30.40	💕 Love it So Much	54.60	4	❌ - 💕	31	\N	\N	2	\N	2026-03-15 12:03:08.823023	2026-03-15 12:03:08.823023	f
4605	2024-07-04	09:30:00	17:50, 21:14, 4:25, 7:52, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	❌ No, not interested	60.00	24.40	🔺 So So	35.60	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:08.825626	2026-03-15 12:03:08.825626	f
4606	2024-07-04	09:30:00	21:13, 3:36, 7:49, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	32.40	8.90	🔺 So So	23.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:08.828575	2026-03-15 12:03:08.828575	f
4607	2024-07-05	00:19:00	9:27, 14:54, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	9.70	💕 Love it So Much	50.30	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:08.832183	2026-03-15 12:03:08.832183	f
4608	2024-07-05	00:19:00	9:26, 14:52, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.30	10.60	🔺 So So	9.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:08.834779	2026-03-15 12:03:08.834779	f
4609	2024-07-05	08:55:00	17:39, 20:48, 1:31, 4:31, 7:58, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	🔺 No, not really. Ate A Little	80.00	17.50	💕 Love it So Much	62.50	5	🔺 - 💕	45	\N	\N	2	\N	2026-03-15 12:03:08.838131	2026-03-15 12:03:08.838131	f
4610	2024-07-05	08:55:00	-	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	🔺 No, not really. Ate A Little	57.00	39.40	❌ No!!!	17.60	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-15 12:03:08.84327	2026-03-15 12:03:08.84327	f
4611	2024-07-05	08:55:00	20:49, 22:30, 1:29, 4:28, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	31.10	1.50	🔺 So So	29.60	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-15 12:03:08.8457	2026-03-15 12:03:08.8457	f
4612	2024-07-06	00:20:00	14:17,	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	9.40	💕 Love it So Much	65.60	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:08.849168	2026-03-15 12:03:08.849168	f
4613	2024-07-06	00:20:00	14:16, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.50	11.50	🔺 So So	9.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.888991	2026-03-15 12:03:08.888991	f
4614	2024-07-06	09:45:00	22:18, 5:15, 7:49, 	Wet	axia	津燒濃厚10號- 鮪, 雞, 扇貝 yz-10	❌ No, not interested	70.00	14.00	💕 Love it So Much	56.00	3	❌ - 💕	36	\N	\N	2	\N	2026-03-15 12:03:08.893198	2026-03-15 12:03:08.893198	f
4615	2024-07-06	09:45:00	18:41, 20:28, 3:53,	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	3.90	💕 Love it So Much	46.10	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:08.896008	2026-03-15 12:03:08.896008	f
4616	2024-07-06	09:45:00	20:26, 22:17, 3:50, 5:13, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	31.50	7.10	🔺 So So	24.40	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-15 12:03:08.898279	2026-03-15 12:03:08.898279	f
4617	2024-07-07	00:30:00	10:02, 15:07, 15:27, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	7.70	💕 Love it So Much	52.30	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:08.90018	2026-03-15 12:03:08.90018	f
4902	2024-08-24	00:35:00	15:29, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.30	14.60	🔺 So So	6.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.68181	2026-03-15 12:03:09.68181	f
4618	2024-07-07	00:30:00	10:00, 15:25, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.20	11.00	🔺 So So	9.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:08.902361	2026-03-15 12:03:08.902361	f
4619	2024-07-07	10:00:00	20:26, 7:17, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	19.20	💕 Love it So Much	55.80	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:08.907642	2026-03-15 12:03:08.907642	f
4620	2024-07-07	10:00:00	20:24, 22:51, 3:46, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	14.50	💕 Love it So Much	35.50	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:08.909919	2026-03-15 12:03:08.909919	f
4621	2024-07-07	10:00:00	20:22, 22:49, 3:42, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	31.40	1.00	🔺 So So	30.40	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:08.91177	2026-03-15 12:03:08.91177	f
4622	2024-07-08	00:20:00	9:19, 	Wet	axia	津燒濃厚9號- 鮪, 雞, 柴 yz-9	💖 Yes, eat right away	70.00	14.20	💕 Love it So Much	55.80	1	💖 - 💕	42	\N	5.28	2	\N	2026-03-15 12:03:08.913746	2026-03-15 12:03:08.913746	f
4623	2024-07-08	00:20:00	9:17, 15:09, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	22.20	8.60	🔺 So So	13.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:08.916047	2026-03-15 12:03:08.916047	f
4624	2024-07-08	09:05:00	20:05, 4:52, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	31.50	🔺 So So	38.50	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:08.917998	2026-03-15 12:03:08.917998	f
4625	2024-07-08	09:05:00	22:36, 3:29, 	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	28.90	💕 Love it So Much	51.10	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:08.920662	2026-03-15 12:03:08.920662	f
4626	2024-07-08	09:05:00	20:02, 22:34, 3:28, 4:50, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	28.80	11.10	🔺 So So	17.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:08.922916	2026-03-15 12:03:08.922916	f
4627	2024-07-09	00:20:00	-	Wet	ginny 吉妮貓	鮮餐煲 鮪雞雙拼拌醬	💖 Yes, eat right away	70.00	41.10	❌ No!!!	28.90	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:08.924941	2026-03-15 12:03:08.924941	f
4628	2024-07-09	00:20:00	15:24, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.00	9.80	🔺 So So	10.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.92685	2026-03-15 12:03:08.92685	f
4629	2024-07-09	09:20:00	23:26, 	Wet	竣寶	經典貓罐 - 雞肉+鮮蝦	❌ No, not interested	70.00	42.80	🔺 So So	27.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.931014	2026-03-15 12:03:08.931014	f
4630	2024-07-09	09:20:00	21:38, 7:23, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	3.70	💕 Love it So Much	56.30	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:08.935669	2026-03-15 12:03:08.935669	f
4631	2024-07-09	09:20:00	23:24, 3:42, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	32.20	11.00	🔺 So So	21.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:08.93813	2026-03-15 12:03:08.93813	f
4632	2024-07-10	00:15:00	8:53, 15:26, 	Wet	ciao	魚三味貓餐包 ic-415 鮪魚+雞肉+吻仔魚	💖 Yes, eat right away	60.00	3.20	💕 Love it So Much	56.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:08.940263	2026-03-15 12:03:08.940263	f
4633	2024-07-10	00:15:00	8:51, 15:24, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.00	8.40	🔺 So So	11.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:08.943521	2026-03-15 12:03:08.943521	f
4634	2024-07-10	09:15:00	19:16, 00:12, 3:48, 7:10,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	❌ No, not interested	85.00	21.10	💕 Love it So Much	63.90	4	❌ - 💕	38	\N	\N	2	\N	2026-03-15 12:03:08.945562	2026-03-15 12:03:08.945562	f
4635	2024-07-10	09:15:00	19:13, 00:11, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	4.20	💕 Love it So Much	55.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:08.948951	2026-03-15 12:03:08.948951	f
4636	2024-07-10	09:15:00	00:07, 3:46, 7:08, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	28.70	4.00	🔺 So So	24.70	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:08.965946	2026-03-15 12:03:08.965946	f
4637	2024-07-11	23:50:00	14:06, 	Wet	ciao	豪華罐 a-144 鮪魚+雞肉+鰹魚乾	💖 Yes, eat right away	80.00	40.80	🔺 So So	39.20	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:08.970315	2026-03-15 12:03:08.970315	f
4638	2024-07-11	23:50:00	14:04, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.30	12.70	🔺 So So	7.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:08.972809	2026-03-15 12:03:08.972809	f
4639	2024-07-11	09:10:00	19:06, 22:33, 4:47, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	28.70	💕 Love it So Much	51.30	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:08.97489	2026-03-15 12:03:08.97489	f
4640	2024-07-11	09:10:00	21:23, 4:45, 	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	💖 Yes, eat right away	60.00	16.00	💕 Love it So Much	44.00	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:08.97709	2026-03-15 12:03:08.97709	f
4641	2024-07-11	09:10:00	19:04, 21:22, 00:29, 4:41, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	33.00	2.30	🔺 So So	30.70	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-15 12:03:08.979205	2026-03-15 12:03:08.979205	f
4642	2024-07-12	00:15:00	8:28, 9:29, 9:35, 14:34, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	7.00	💕 Love it So Much	43.00	4	💖 - 💕	48	\N	\N	2	\N	2026-03-15 12:03:08.981533	2026-03-15 12:03:08.981533	f
4643	2024-07-12	00:15:00	9:34, 10:52, 14:33, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.20	10.40	🔺 So So	9.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:08.984157	2026-03-15 12:03:08.984157	f
4644	2024-07-12	09:40:00	18:48, 23:10, 	Wet	ciao	魚三味貓餐包 ic-415 鮪魚+雞肉+吻仔魚	❌ No, not interested	60.00	17.60	💕 Love it So Much	42.40	2	❌ - 💕	27	\N	\N	2	\N	2026-03-15 12:03:08.986205	2026-03-15 12:03:08.986205	f
4645	2024-07-12	09:40:00	19:27, 	Wet	ciao	原湯杯52號(鮪+蟹+小魚)	🔺 No, not really. Ate A Little	60.00	9.70	💕 Love it So Much	50.30	1	🔺 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:08.98841	2026-03-15 12:03:08.98841	f
4646	2024-07-12	09:40:00	18:47, 00:05, 4:12, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	30.70	7.40	🔺 So So	23.30	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:08.990287	2026-03-15 12:03:08.990287	f
4647	2024-07-13	00:20:00	9:23, 15:47, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	5.50	💕 Love it So Much	69.50	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:08.992152	2026-03-15 12:03:08.992152	f
4648	2024-07-13	00:20:00	9:22, 14:33, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.00	13.00	🔺 So So	7.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:08.996011	2026-03-15 12:03:08.996011	f
4649	2024-07-13	09:00:00	19:10, 20:22, 7:00	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	6.90	💕 Love it So Much	53.10	3	💖 - 💕	46	睡前放冰磚	\N	2	\N	2026-03-15 12:03:08.99811	2026-03-15 12:03:08.99811	f
4650	2024-07-13	09:00:00	22:10, 3:55, 7:02, 8:31, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	37.30	🔺 So So	32.70	4	💖 - 🔺	31	\N	\N	2	\N	2026-03-15 12:03:09.002391	2026-03-15 12:03:09.002391	f
4651	2024-07-13	09:00:00	20:21, 22:11, ,3:11, 3:53	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	33.30	14.50	🔺 So So	18.80	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.004527	2026-03-15 12:03:09.004527	f
4652	2024-07-14	00:20:00	8:32, 10:02, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	34.70	💕 Love it So Much	45.30	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.006447	2026-03-15 12:03:09.006447	f
4653	2024-07-14	00:20:00	8:28, 10:01, 14:31, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.20	10.50	🔺 So So	9.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.009372	2026-03-15 12:03:09.009372	f
4654	2024-07-14	09:00:00	21:40, 23:53, 4:06, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	5.60	💕 Love it So Much	54.40	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.014837	2026-03-15 12:03:09.014837	f
4655	2024-07-14	09:00:00	21:38, 22:02, 7:35, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	41.90	🔺 So So	43.10	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-15 12:03:09.017119	2026-03-15 12:03:09.017119	f
4656	2024-07-14	09:00:00	23:48, 4:04, 7:34,:	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	30.50	8.30	🔺 So So	22.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.019341	2026-03-15 12:03:09.019341	f
4657	2024-07-15	00:35:00	-	Wet	ciao	燒晚餐(雞肉+干貝) ic-282	💖 Yes, eat right away	50.00	20.60	❌ No!!!	29.40	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.02137	2026-03-15 12:03:09.02137	f
4658	2024-07-15	01:30:00	14:35,	Wet	ciao	ic-507 貓用極致肉塊餐包-鮪魚片	❌ No, not interested	30.00	13.70	🔺 So So	16.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.023304	2026-03-15 12:03:09.023304	f
4659	2024-07-15	00:35:00	8:40, 14:33, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.20	13.30	🔺 So So	6.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.025147	2026-03-15 12:03:09.025147	f
4660	2024-07-15	08:50:00	6:57, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	38.30	🔺 So So	41.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.026948	2026-03-15 12:03:09.026948	f
4661	2024-07-15	08:50:00	18:18, 3:15, 6:55, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	❌ No, not interested	50.00	15.90	💕 Love it So Much	34.10	3	❌ - 💕	29	\N	\N	2	\N	2026-03-15 12:03:09.028883	2026-03-15 12:03:09.028883	f
4662	2024-07-15	08:50:00	18:17, 21:58, 3:13, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	35.00	21.30	🔺 So So	13.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.030737	2026-03-15 12:03:09.030737	f
4663	2024-07-16	00:20:00	8:56, 15:48, 	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	13.70	💕 Love it So Much	66.30	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.033976	2026-03-15 12:03:09.033976	f
4664	2024-07-16	00:20:00	9:27, 15:46, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.80	12.80	🔺 So So	8.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.036876	2026-03-15 12:03:09.036876	f
4665	2024-07-16	01:00:00	9:30, 15:47, 	Kibble	wealtz 維爾滋	天然無穀寵物糧 全齡貓 鮭魚	🔺 No, not really. Ate A Little	45.00	38.90	🔺 So So	6.10	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-15 12:03:09.038912	2026-03-15 12:03:09.038912	f
4666	2024-07-16	09:00:00	18:30, 21:10, 3:20, 7:16, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	27.20	💕 Love it So Much	52.80	4	💖 - 💕	41	\N	\N	2	\N	2026-03-15 12:03:09.040757	2026-03-15 12:03:09.040757	f
4667	2024-07-16	09:00:00	18:30, 21:11	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	💖 Yes, eat right away	60.00	23.30	🔺 So So	36.70	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.043212	2026-03-15 12:03:09.043212	f
4668	2024-07-16	09:00:00	18:29, 21:09, 22:44, 3:16, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	28.20	11.00	🔺 So So	17.20	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.045399	2026-03-15 12:03:09.045399	f
4669	2024-07-16	09:00:00	22:25, 7:18, 	Kibble	wealtz 維爾滋	天然無穀寵物糧 全齡貓 鮭魚	❌ No, not interested	45.00	34.20	🔺 So So	10.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.04721	2026-03-15 12:03:09.04721	f
4670	2024-07-17	00:20:00	9:11, 	Wet	axia	津燒濃厚9號- 鮪, 雞, 柴 yz-9	💖 Yes, eat right away	70.00	8.90	💕 Love it So Much	61.10	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:09.049215	2026-03-15 12:03:09.049215	f
4671	2024-07-17	00:20:00	9:09, 14:10, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.60	10.50	🔺 So So	10.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.050996	2026-03-15 12:03:09.050996	f
4672	2024-07-17	08:50:00	18:18, 22:01, 22:38, 00:34, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	22.80	💕 Love it So Much	62.20	4	💖 - 💕	41	\N	\N	2	\N	2026-03-15 12:03:09.052852	2026-03-15 12:03:09.052852	f
4673	2024-07-17	08:50:00	18:17, 	Wet	combo 吻饌	蒸煮餐包 鮪魚+鰹魚+干貝 (pnr-5)	❌ No, not interested	40.00	22.90	🔺 So So	17.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.054731	2026-03-15 12:03:09.054731	f
4674	2024-07-17	08:50:00	18:16, 22:00, 00:32, 4:08, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	31.50	9.20	🔺 So So	22.30	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.056556	2026-03-15 12:03:09.056556	f
4675	2024-07-18	00:10:00	-	Wet	ginny 吉妮貓	鮮餐煲 5號 飽滿鮪魚拌醬	💖 Yes, eat right away	70.00	35.80	❌ No!!!	34.20	0	💖 - ❌	18	16:37 => 吐, 沒看到毛球, 只有食物跟湯汁	\N	2	\N	2026-03-15 12:03:09.059671	2026-03-15 12:03:09.059671	f
4676	2024-07-18	00:10:00	8:15, 15:50, 16:22, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.60	12.60	🔺 So So	8.00	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.061479	2026-03-15 12:03:09.061479	f
4677	2024-07-18	08:30:00	21:20, 4:30, 6:33, 	Wet	ciao	豪華罐 a-144 鮪魚+雞肉+鰹魚乾	💖 Yes, eat right away	80.00	19.70	💕 Love it So Much	60.30	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.063722	2026-03-15 12:03:09.063722	f
4678	2024-07-18	08:30:00	17:43, 21:22, 7:44, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	7.20	💕 Love it So Much	52.80	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.08889	2026-03-15 12:03:09.08889	f
4679	2024-07-18	08:30:00	17:42, 00:35, 4:26, 7:45, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	32.80	3.10	🔺 So So	29.70	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-15 12:03:09.092027	2026-03-15 12:03:09.092027	f
4680	2024-07-19	00:20:00	15:15, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	27.20	💕 Love it So Much	52.80	1	💖 - 💕	35	\N	\N	2	\N	2026-03-15 12:03:09.094745	2026-03-15 12:03:09.094745	f
4681	2024-07-19	00:20:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.096839	2026-03-15 12:03:09.096839	f
4682	2024-07-19	09:15:00	20:55, 1:36, 4:36, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	6.50	💕 Love it So Much	68.50	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.098741	2026-03-15 12:03:09.098741	f
4683	2024-07-19	09:15:00	7:12, 	Wet	axia	津燒濃厚10號- 鮪, 雞, 扇貝 yz-10	🔺 No, not really. Ate A Little	70.00	24.80	💕 Love it So Much	45.20	1	🔺 - 💕	30	\N	\N	2	\N	2026-03-15 12:03:09.100868	2026-03-15 12:03:09.100868	f
4684	2024-07-19	09:15:00	20:52, 1:33, 4:31, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	40.30	12.00	🔺 So So	28.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.103005	2026-03-15 12:03:09.103005	f
4685	2024-07-20	00:25:00	-	Wet	竣寶	經典貓罐 - 雞肉+鮮蝦	💖 Yes, eat right away	70.00	26.40	❌ No!!!	43.60	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.106856	2026-03-15 12:03:09.106856	f
4686	2024-07-20	02:10:00	16:01, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	25.70	🔺 So So	24.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.10888	2026-03-15 12:03:09.10888	f
4687	2024-07-20	02:10:00	15:59, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.00	6.80	🔺 So So	13.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.110732	2026-03-15 12:03:09.110732	f
4688	2024-07-20	10:15:00	21:59, 00:39,	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	36.00	🔺 So So	44.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.113156	2026-03-15 12:03:09.113156	f
4689	2024-07-20	10:15:00	20:06, 22:00, 4:51, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	16.10	💕 Love it So Much	43.90	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:09.124598	2026-03-15 12:03:09.124598	f
4690	2024-07-20	10:15:00	00:41, 4:48, 8:26, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	27.00	15.20	🔺 So So	11.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.135625	2026-03-15 12:03:09.135625	f
4691	2024-07-21	00:30:00	8:56, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	17.20	💕 Love it So Much	42.80	1	💖 - 💕	35	\N	\N	2	\N	2026-03-15 12:03:09.139412	2026-03-15 12:03:09.139412	f
4692	2024-07-21	00:30:00	17:09	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.80	13.10	🔺 So So	7.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.143747	2026-03-15 12:03:09.143747	f
4693	2024-07-21	09:10:00	5:12, 7:04, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	85.00	10.90	💕 Love it So Much	74.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.145901	2026-03-15 12:03:09.145901	f
4694	2024-07-21	09:10:00	4:05, 7:04, 8:40, 	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	💖 Yes, eat right away	60.00	14.10	💕 Love it So Much	45.90	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.14795	2026-03-15 12:03:09.14795	f
4695	2024-07-21	09:10:00	18:11, 00:08, 4:02, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	33.10	6.60	🔺 So So	26.50	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:09.149905	2026-03-15 12:03:09.149905	f
4696	2024-07-22	00:35:00	14:44, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	24.20	💕 Love it So Much	45.80	1	💖 - 💕	35	\N	\N	2	\N	2026-03-15 12:03:09.152213	2026-03-15 12:03:09.152213	f
4697	2024-07-22	00:35:00	14:15, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.80	18.30	🔺 So So	2.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.154174	2026-03-15 12:03:09.154174	f
4698	2024-07-22	00:35:00	-	Wet	go	全方位天然糧 高肉量四種肉無穀全貓糧	❌ No, not interested	15.00	15.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.157543	2026-03-15 12:03:09.157543	f
4699	2024-07-22	09:35:00	-	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	64.60	❌ No!!!	20.40	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.159483	2026-03-15 12:03:09.159483	f
4700	2024-07-22	09:35:00	00:12, 4:12, 4:54, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	14.50	💕 Love it So Much	60.50	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.161427	2026-03-15 12:03:09.161427	f
4701	2024-07-22	09:35:00	00:10, 4:10, 5:21, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	44.90	28.70	🔺 So So	16.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.163398	2026-03-15 12:03:09.163398	f
4702	2024-07-22	10:40:00	00:13, 5:22, 	Kibble	曙光	乾 spring 曙光 無穀滋養白鮭魚食譜	💖 Yes, eat right away	15.10	8.20	🔺 So So	6.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.183193	2026-03-15 12:03:09.183193	f
4703	2024-07-23	00:20:00	14:18, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	💖 Yes, eat right away	80.00	48.60	🔺 So So	31.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.196582	2026-03-15 12:03:09.196582	f
4704	2024-07-23	00:20:00	-	Kibble	凡諦斯	海陸全餐 火雞肉&鯡魚	❌ No, not interested	17.50	14.40	❌ No!!!	3.10	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.20359	2026-03-15 12:03:09.20359	f
4705	2024-07-23	00:20:00	14:16, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.20	18.90	🔺 So So	1.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.20896	2026-03-15 12:03:09.20896	f
4706	2024-07-23	01:40:00	14:17, 	Wet	ciao	ic-218 貓用巧餐包化毛球配方-鮪魚+扇貝	💖 Yes, eat right away	40.00	2.90	💕 Love it So Much	37.10	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:09.211143	2026-03-15 12:03:09.211143	f
4707	2024-07-23	09:15:00	23:07, 00:49, 4:40, 	Wet	axia	妙喵16號片狀- 鮪, 干貝	❌ No, not interested	70.00	28.20	🔺 So So	41.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.213682	2026-03-15 12:03:09.213682	f
4708	2024-07-23	09:15:00	-	Wet	mon petit 貓倍麗	嚴選鮮味鰹魚餐盒 lc2	❌ No, not interested	57.00	57.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.215848	2026-03-15 12:03:09.215848	f
4709	2024-07-23	09:15:00	17:34, 23:05, 00:46, 4:38, 8:40	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	40.10	21.90	🔺 So So	18.20	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-15 12:03:09.217891	2026-03-15 12:03:09.217891	f
4710	2024-07-23	09:15:00	-	Kibble	愛肯拿	農場盛宴貓 無穀 放養雞肉+蔓越莓	❌ No, not interested	16.40	16.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.220953	2026-03-15 12:03:09.220953	f
4711	2024-07-24	00:50:00	9:53, 14;41, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	10.00	💕 Love it So Much	50.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.222972	2026-03-15 12:03:09.222972	f
4712	2024-07-24	00:50:00	14:39, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	21.60	18.80	🔺 So So	2.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.225127	2026-03-15 12:03:09.225127	f
4713	2024-07-24	00:50:00	-	Kibble	愛肯拿	乾 加拿大 愛肯拿 農場盛宴貓 無穀 放養雞肉+蔓越莓	❌ No, not interested	15.90	15.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.229274	2026-03-15 12:03:09.229274	f
4714	2024-07-24	09:30:00	18:20, 1:33,	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	27.00	💕 Love it So Much	53.00	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.231635	2026-03-15 12:03:09.231635	f
4715	2024-07-24	09:30:00	4:00, 	Wet	ciao	柴魚鮮味餐包(鮪魚+扇貝) ic-353	❌ No, not interested	40.00	12.80	💕 Love it So Much	27.20	1	❌ - 💕	25	\N	\N	2	\N	2026-03-15 12:03:09.233945	2026-03-15 12:03:09.233945	f
4716	2024-07-24	09:30:00	00:31, 4:02, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	39.20	22.40	🔺 So So	16.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.235769	2026-03-15 12:03:09.235769	f
4717	2024-07-24	09:30:00	-	Kibble	愛肯拿	農場盛宴貓 無穀 放養雞肉+蔓越莓	❌ No, not interested	15.90	15.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.238895	2026-03-15 12:03:09.238895	f
4718	2024-07-24	10:18:00	4:42, 	Kibble	曙光	無穀滋養白鮭魚食譜	💖 Yes, eat right away	15.20	7.20	🔺 So So	8.00	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.241088	2026-03-15 12:03:09.241088	f
4719	2024-07-25	00:20:00	9:50, 15:45	Wet	nature 養生湯罐	白身鮪魚+吻仔魚	💖 Yes, eat right away	80.00	29.00	💕 Love it So Much	51.00	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.243255	2026-03-15 12:03:09.243255	f
4720	2024-07-25	00:20:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.90	20.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.245308	2026-03-15 12:03:09.245308	f
4721	2024-07-25	00:20:00	9:49, 	Kibble	曙光	無穀滋養白鮭魚食譜	❌ No, not interested	15.30	8.80	🔺 So So	6.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.247615	2026-03-15 12:03:09.247615	f
4722	2024-07-25	08:25:00	19:02, 23:54, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	15.90	💕 Love it So Much	59.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.24942	2026-03-15 12:03:09.24942	f
4723	2024-07-25	08:25:00	19:00, 21:51, 	Wet	ciao	魚三味貓餐包 ic-415 鮪魚+雞肉+吻仔魚	💖 Yes, eat right away	60.00	31.80	🔺 So So	28.20	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.251093	2026-03-15 12:03:09.251093	f
4724	2024-07-25	08:25:00	23:50, 4:11, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	42.10	19.00	🔺 So So	23.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.252821	2026-03-15 12:03:09.252821	f
4725	2024-07-25	08:25:00	21:50, 7:20, 	Kibble	曙光	無穀滋養白鮭魚食譜	❌ No, not interested	28.80	20.00	🔺 So So	8.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.255315	2026-03-15 12:03:09.255315	f
4726	2024-07-26	00:30:00	9:38, 14:13, 	Wet	axia	妙喵11號片狀 - 鮪魚 mmf-11	💖 Yes, eat right away	70.00	27.10	💕 Love it So Much	42.90	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.25733	2026-03-15 12:03:09.25733	f
4727	2024-07-26	00:30:00	14:12, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.00	17.10	🔺 So So	2.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.260006	2026-03-15 12:03:09.260006	f
4728	2024-07-26	00:30:00	9:37, 	Kibble	曙光	無穀滋養白鮭魚食譜	💖 Yes, eat right away	20.50	18.10	🔺 So So	2.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.261625	2026-03-15 12:03:09.261625	f
4729	2024-07-26	09:40:00	3:55, 7:16, 	Wet	axia	津燒濃厚10號- 鮪, 雞, 扇貝 yz-10	❌ No, not interested	70.00	30.20	🔺 So So	39.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.26332	2026-03-15 12:03:09.26332	f
4730	2024-07-26	09:40:00	18:35, 7:17, 	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	💖 Yes, eat right away	60.00	21.60	🔺 So So	38.40	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.266372	2026-03-15 12:03:09.266372	f
4731	2024-07-26	09:40:00	22:29, 7:15, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	38.00	17.00	🔺 So So	21.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.270342	2026-03-15 12:03:09.270342	f
4732	2024-07-26	09:40:00	18:34, 00:21, 3:51, 7:14, 	Kibble	曙光	無穀滋養白鮭魚食譜	❌ No, not interested	33.10	29.60	🔺 So So	3.50	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.274492	2026-03-15 12:03:09.274492	f
4733	2024-07-27	00:25:00	8:36, 10:38,	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	19.30	💕 Love it So Much	55.70	2	💖 - 💕	37	更換柏萊富飼料	\N	2	\N	2026-03-15 12:03:09.276374	2026-03-15 12:03:09.276374	f
4734	2024-07-27	00:25:00	10:36, 15:37, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	16.00	3.30	🔺 So So	12.70	2	❌ - 🔺	24	\N	\N	2	\N	2026-03-15 12:03:09.278141	2026-03-15 12:03:09.278141	f
4735	2024-07-27	00:25:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.80	20.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.279841	2026-03-15 12:03:09.279841	f
4736	2024-07-27	09:00:00	4:26, 	Wet	sheba	金罐 鮪魚及蟹肉(湯汁)	🔺 No, not really. Ate A Little	85.00	58.80	🔺 So So	26.20	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.281628	2026-03-15 12:03:09.281628	f
4737	2024-07-27	09:00:00	00:25, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	17.20	💕 Love it So Much	32.80	1	💖 - 💕	35	\N	\N	2	\N	2026-03-15 12:03:09.290281	2026-03-15 12:03:09.290281	f
4738	2024-07-27	09:00:00	18:17, 00:23, 4:25, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	23.50	8.20	🔺 So So	15.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.292038	2026-03-15 12:03:09.292038	f
4739	2024-07-27	09:00:00	18:15, 00:21, 4:21, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	36.00	20.50	🔺 So So	15.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.29624	2026-03-15 12:03:09.29624	f
4740	2024-07-28	00:20:00	9:26, 14:50, 	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	11.40	💕 Love it So Much	68.60	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.298185	2026-03-15 12:03:09.298185	f
4741	2024-07-28	00:20:00	9:04, 9:25, 14:49, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.60	13.00	🔺 So So	8.60	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.299971	2026-03-15 12:03:09.299971	f
4742	2024-07-28	00:20:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	15.10	15.10	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.301617	2026-03-15 12:03:09.301617	f
4743	2024-07-28	09:15:00	00:34, 6:58, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	💖 Yes, eat right away	80.00	45.10	🔺 So So	34.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.303302	2026-03-15 12:03:09.303302	f
4744	2024-07-28	09:15:00	19:16, 00:35, 4:15, 6:57, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	9.20	💕 Love it So Much	50.80	4	💖 - 💕	48	\N	\N	2	\N	2026-03-15 12:03:09.305018	2026-03-15 12:03:09.305018	f
4745	2024-07-28	09:15:00	19:14, 4:15, 6:55, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	33.00	24.40	🔺 So So	8.60	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.306773	2026-03-15 12:03:09.306773	f
4746	2024-07-28	09:15:00	00:31, 4:12	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	30.40	13.50	🔺 So So	16.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.308814	2026-03-15 12:03:09.308814	f
4747	2024-07-29	00:27:00	9:30, 15:35, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	22.00	💕 Love it So Much	63.00	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.31053	2026-03-15 12:03:09.31053	f
4748	2024-07-29	00:27:00	14:19, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.60	18.00	🔺 So So	3.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.312287	2026-03-15 12:03:09.312287	f
4749	2024-07-29	00:27:00	-	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	14.90	14.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.313999	2026-03-15 12:03:09.313999	f
4750	2024-07-29	09:15:00	19:00, 	Wet	sheba	金罐 鮪魚及鮭魚 (湯汁)	❌ No, not interested	85.00	57.80	🔺 So So	27.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.319328	2026-03-15 12:03:09.319328	f
4751	2024-07-29	09:15:00	17:47, 19:00, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝	❌ No, not interested	40.00	1.70	💕 Love it So Much	38.30	2	❌ - 💕	34	\N	\N	2	\N	2026-03-15 12:03:09.321164	2026-03-15 12:03:09.321164	f
4752	2024-07-29	09:15:00	18:58, 4:27, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	38.60	21.00	🔺 So So	17.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.322884	2026-03-15 12:03:09.322884	f
4753	2024-07-29	09:15:00	4:32, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	14.90	12.20	🔺 So So	2.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.324703	2026-03-15 12:03:09.324703	f
4754	2024-07-30	00:20:00	15:27, 	Wet	petline	極品湯罐 (z17)	🔺 No, not really. Ate A Little	80.00	44.90	🔺 So So	35.10	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.326441	2026-03-15 12:03:09.326441	f
4755	2024-07-30	00:20:00	9:10, 9:30, 	Wet	ciao	鰹魚燒晚餐 ic-281 (雞肉+鰹魚+蟹肉+干貝)	💖 Yes, eat right away	50.00	10.00	💕 Love it So Much	40.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.329228	2026-03-15 12:03:09.329228	f
4756	2024-07-30	00:20:00	9:08, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	17.10	🔺 So So	2.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.331058	2026-03-15 12:03:09.331058	f
4757	2024-07-30	08:40:00	18:26, 19:22, 4:22, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	12.00	💕 Love it So Much	48.00	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.334222	2026-03-15 12:03:09.334222	f
4758	2024-07-30	08:40:00	18:24, 	Wet	ciao	柴魚鮮味餐包(鮪魚+扇貝) ic-353	💖 Yes, eat right away	40.00	6.00	💕 Love it So Much	34.00	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:09.336059	2026-03-15 12:03:09.336059	f
4759	2024-07-30	08:40:00	18:25, 19:20, 00:23, 4:18, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	37.50	12.00	🔺 So So	25.50	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.339247	2026-03-15 12:03:09.339247	f
4760	2024-07-31	00:10:00	8:54, 15:15, 	Wet	mama mia	貓餐罐(雞肉+白身鮪魚+蝦肉)	🔺 No, not really. Ate A Little	85.00	53.30	🔺 So So	31.70	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-15 12:03:09.341006	2026-03-15 12:03:09.341006	f
4761	2024-07-31	00:10:00	8:51, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.50	15.90	🔺 So So	4.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.342701	2026-03-15 12:03:09.342701	f
4762	2024-07-31	08:30:00	18:59, 00:15, 7:28, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	15.40	💕 Love it So Much	64.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.34503	2026-03-15 12:03:09.34503	f
4763	2024-07-31	08:30:00	18:58, 	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	❌ No, not interested	57.00	40.70	🔺 So So	16.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.348469	2026-03-15 12:03:09.348469	f
4764	2024-07-31	08:30:00	18:57, 7:28, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	31.20	8.60	🔺 So So	22.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.350279	2026-03-15 12:03:09.350279	f
4765	2024-07-31	08:30:00	-	Kibble	wellness	core 無穀新鮮火雞肉	❌ No, not interested	10.40	10.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.351989	2026-03-15 12:03:09.351989	f
4766	2024-08-01	00:20:00	15:14, 	Wet	axia	津燒濃厚9號- 鮪, 雞, 柴 yz-9	💖 Yes, eat right away	70.00	23.70	💕 Love it So Much	46.30	1	💖 - 💕	35	\N	\N	2	\N	2026-03-15 12:03:09.353769	2026-03-15 12:03:09.353769	f
4767	2024-08-01	00:20:00	15:12, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	13.40	🔺 So So	6.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.355501	2026-03-15 12:03:09.355501	f
4768	2024-08-01	10:00:00	8:16,	Wet	axia	妙喵16號片狀- 鮪, 干貝	❌ No, not interested	70.00	60.70	🔺 So So	9.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.357213	2026-03-15 12:03:09.357213	f
4769	2024-08-01	10:00:00	3:16, 5:44, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	💖 Yes, eat right away	60.00	23.70	🔺 So So	36.30	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.359096	2026-03-15 12:03:09.359096	f
4770	2024-08-01	10:00:00	22:01, 3:13, 8:13, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	33.90	7.40	🔺 So So	26.50	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:09.360971	2026-03-15 12:03:09.360971	f
4771	2024-08-02	00:10:00	-	Wet	petline	極品貓罐(z13)	🔺 No, not really. Ate A Little	80.00	60.60	❌ No!!!	19.40	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-15 12:03:09.364061	2026-03-15 12:03:09.364061	f
4772	2024-08-02	00:10:00	8:43, 14:13, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	10.00	🔺 So So	10.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.365873	2026-03-15 12:03:09.365873	f
4773	2024-08-02	00:10:00	17:30, 21:53, 3:52, 7:18, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	17.70	5.80	🔺 So So	11.90	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.36765	2026-03-15 12:03:09.36765	f
4774	2024-08-02	08:58:00	3:54, 7:20, 	Wet	combo 吻饌	蒸煮餐包 鮪魚+鰹魚 pnr-1	❌ No, not interested	40.00	26.70	🔺 So So	13.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.369319	2026-03-15 12:03:09.369319	f
4775	2024-08-02	08:58:00	18:47, 22:15, 7:21, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	31.30	💕 Love it So Much	53.70	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:09.37104	2026-03-15 12:03:09.37104	f
4776	2024-08-02	08:58:00	17:30, 18:45, 21:54, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	30.60	4.20	🔺 So So	26.40	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:09.37271	2026-03-15 12:03:09.37271	f
4777	2024-08-03	00:20:00	-	Wet	nature 養生湯罐	白身鮪魚+吻仔魚	💖 Yes, eat right away	80.00	54.90	❌ No!!!	25.10	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.374505	2026-03-15 12:03:09.374505	f
4778	2024-08-03	00:20:00	15:18, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	14.60	🔺 So So	5.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.3764	2026-03-15 12:03:09.3764	f
4779	2024-08-03	01:40:00	-	Wet	ciao	ic-212 貓用巧餐包- 鰹魚+扇貝	💖 Yes, eat right away	40.00	11.30	❌ No!!!	28.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.378066	2026-03-15 12:03:09.378066	f
4780	2024-08-03	08:45:00	19:35, 6:14, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	31.00	🔺 So So	49.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.37985	2026-03-15 12:03:09.37985	f
4781	2024-08-03	08:45:00	19:35, 21:02, 21:27, 00:08, 6:16, 	Wet	ciao	鰹魚燒晚餐包 ic-244	🔺 No, not really. Ate A Little	50.00	18.70	🔺 So So	31.30	5	🔺 - 🔺	28	\N	\N	2	\N	2026-03-15 12:03:09.381495	2026-03-15 12:03:09.381495	f
4782	2024-08-03	08:45:00	21:01, 21:26, 00:04, 6:12, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	39.50	18.20	🔺 So So	21.30	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.38348	2026-03-15 12:03:09.38348	f
4783	2024-08-04	00:20:00	14:22, 	Wet	mama mia	貓餐罐(雞肉+白身鮪魚)	❌ No, not interested	85.00	69.00	🔺 So So	16.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.3879	2026-03-15 12:03:09.3879	f
4784	2024-08-04	00:20:00	-	Wet	ciao	柴魚鮮味餐包(鮪魚+扇貝) ic-353	💖 Yes, eat right away	80.00	29.20	❌ No!!!	50.80	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.389543	2026-03-15 12:03:09.389543	f
4785	2024-08-04	00:20:00	14:21, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	16.40	🔺 So So	3.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.391455	2026-03-15 12:03:09.391455	f
4786	2024-08-04	09:40:00	19:03, 23:40, 7:33, 	Wet	nature 養生湯罐	雞肉+鮭魚	❌ No, not interested	80.00	35.70	🔺 So So	44.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.39316	2026-03-15 12:03:09.39316	f
4787	2024-08-04	09:40:00	21:45, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	21.30	🔺 So So	28.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.394812	2026-03-15 12:03:09.394812	f
4788	2024-08-04	09:40:00	21:43, 23:38, 7:31, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	41.80	18.00	🔺 So So	23.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.396451	2026-03-15 12:03:09.396451	f
4789	2024-08-05	00:25:00	15:54, 	Wet	法麗	法麗 室內貓排毛 鮪魚佐鯛魚	💖 Yes, eat right away	80.00	33.20	🔺 So So	46.80	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.398136	2026-03-15 12:03:09.398136	f
4790	2024-08-05	00:25:00	9:21, 14:15, 15:53, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.30	5.00	🔺 So So	16.30	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:09.400044	2026-03-15 12:03:09.400044	f
4791	2024-08-05	10:00:00	-	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	32.50	❌ No!!!	27.50	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.401739	2026-03-15 12:03:09.401739	f
4792	2024-08-05	10:00:00	3:53, 8:15,	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	51.20	🔺 So So	28.80	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-15 12:03:09.403418	2026-03-15 12:03:09.403418	f
4793	2024-08-05	10:00:00	22:10, 00:09, 3:52, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	30.10	16.30	🔺 So So	13.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.405348	2026-03-15 12:03:09.405348	f
4794	2024-08-06	00:20:00	15:39, 	Wet	sheba	金罐 鮪魚及蟹肉(湯汁)	💖 Yes, eat right away	85.00	39.40	🔺 So So	45.60	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.40715	2026-03-15 12:03:09.40715	f
4795	2024-08-06	00:20:00	12:09, 14:21, 15:39, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.10	12.00	🔺 So So	9.10	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.409087	2026-03-15 12:03:09.409087	f
4796	2024-08-06	09:15:00	-	Wet	ciao	cc-82 貓用頂級奢華鮪魚 鮪魚+干貝 凍罐	💖 Yes, eat right away	80.00	69.60	❌ No!!!	10.40	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.412867	2026-03-15 12:03:09.412867	f
4797	2024-08-06	09:15:00	18:45, 4:29, 6:58, 	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	3.50	💕 Love it So Much	46.50	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.414582	2026-03-15 12:03:09.414582	f
4798	2024-08-06	09:15:00	18:44, 23:46, 6:56	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	37.10	13.30	🔺 So So	23.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.416315	2026-03-15 12:03:09.416315	f
4799	2024-08-07	00:20:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	💖 Yes, eat right away	80.00	31.10	❌ No!!!	48.90	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.418066	2026-03-15 12:03:09.418066	f
4800	2024-08-07	01:40:00	15:52,	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	16.90	💕 Love it So Much	43.10	1	💖 - 💕	35	\N	\N	2	\N	2026-03-15 12:03:09.419772	2026-03-15 12:03:09.419772	f
4801	2024-08-07	00:20:00	9:20, 15:51, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.30	15.80	🔺 So So	4.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.421495	2026-03-15 12:03:09.421495	f
4802	2024-08-07	08:50:00	18:43, 3:54, 6:51, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	18.90	💕 Love it So Much	41.10	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:09.424275	2026-03-15 12:03:09.424275	f
4803	2024-08-07	08:50:00	6:53, 	Wet	銀湯匙	貓餐包 鮪魚, 鰹魚, 雞胸肉 p-mc 202	🔺 No, not really. Ate A Little	60.00	37.10	🔺 So So	22.90	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.426403	2026-03-15 12:03:09.426403	f
4804	2024-08-07	08:50:00	18:40, 23:28, 3:51, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	41.00	7.90	🔺 So So	33.10	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:09.429717	2026-03-15 12:03:09.429717	f
4805	2024-08-08	00:20:00	15:27,	Wet	mon petit 貓倍麗	嚴選金罐 極品鮪魚真鯛(特選鯛魚塊)	💖 Yes, eat right away	85.00	40.70	🔺 So So	44.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.431573	2026-03-15 12:03:09.431573	f
4806	2024-08-08	00:20:00	15:16, 15:26, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.40	17.40	🔺 So So	4.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.435045	2026-03-15 12:03:09.435045	f
4807	2024-08-08	09:15:00	18:43,	Wet	ciao	ciao 旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	39.00	🔺 So So	36.00	1	💖 - 🔺	25	吃到一半, 被門外的聲音嚇到, 就沒繼續吃了	\N	2	\N	2026-03-15 12:03:09.438433	2026-03-15 12:03:09.438433	f
4808	2024-08-08	09:15:00	18:42, 19:45, 4:04, 	Wet	ciao	ic-211 貓用巧餐包-鮪魚+扇貝	❌ No, not interested	40.00	8.80	💕 Love it So Much	31.20	3	❌ - 💕	36	\N	\N	2	\N	2026-03-15 12:03:09.442315	2026-03-15 12:03:09.442315	f
4809	2024-08-08	09:15:00	18:57, 19:43, 23:08, 4:02, 7:29, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	43.50	10.20	🔺 So So	33.30	5	❌ - 🔺	30	\N	\N	2	\N	2026-03-15 12:03:09.444322	2026-03-15 12:03:09.444322	f
4810	2024-08-09	00:20:00	-	Wet	axia	妙喵11號片狀 - 鮪魚 mmf-11	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.447263	2026-03-15 12:03:09.447263	f
4811	2024-08-09	01:00:00	-	Wet	ciao	原湯杯54號 (雞肉+蟹肉+吻仔魚)	💖 Yes, eat right away	60.00	20.40	❌ No!!!	39.60	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.451299	2026-03-15 12:03:09.451299	f
4812	2024-08-09	01:00:00	14:14, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.50	15.20	🔺 So So	6.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.45317	2026-03-15 12:03:09.45317	f
4813	2024-08-09	09:20:00	23:49, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	33.60	🔺 So So	46.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.456258	2026-03-15 12:03:09.456258	f
4814	2024-08-09	09:20:00	19:13, 23:48, 7:21, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	19.10	💕 Love it So Much	30.90	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:09.461227	2026-03-15 12:03:09.461227	f
4815	2024-08-09	09:20:00	19:11, 23:46, 7:18, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	40.40	23.90	🔺 So So	16.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.464665	2026-03-15 12:03:09.464665	f
4816	2024-08-10	00:20:00	-	Wet	法麗	室內貓排毛 鮪魚佐蟹肉	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	法麗可能吃膩了, 等三個月後再來確認看看	\N	2	\N	2026-03-15 12:03:09.467305	2026-03-15 12:03:09.467305	f
4817	2024-08-10	01:30:00	10:46, 16:17	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	11.20	💕 Love it So Much	48.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.469854	2026-03-15 12:03:09.469854	f
4818	2024-08-10	00:20:00	9:24, 10:45, 16:16, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.50	7.20	🔺 So So	13.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.471569	2026-03-15 12:03:09.471569	f
4819	2024-08-10	01:30:00	23:38, 4:34, 8:00, 	Wet	nature 養生湯罐	雞肉+鮭魚	❌ No, not interested	80.00	39.80	🔺 So So	40.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.473268	2026-03-15 12:03:09.473268	f
4820	2024-08-10	01:30:00	18:32, 4:36, 	Wet	sheba	鮮饌包 鮪魚+雞肉 (sri103)	❌ No, not interested	35.00	14.90	🔺 So So	20.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.488389	2026-03-15 12:03:09.488389	f
4821	2024-08-10	01:30:00	18:30, 23:36, 00:50, 4:31, 7:58, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	32.20	3.00	🔺 So So	29.20	5	❌ - 🔺	30	\N	\N	2	\N	2026-03-15 12:03:09.490549	2026-03-15 12:03:09.490549	f
4822	2024-08-11	00:40:00	10:09, 14:40, 	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	💖 Yes, eat right away	60.00	6.20	💕 Love it So Much	53.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.492579	2026-03-15 12:03:09.492579	f
4823	2024-08-11	00:40:00	10:08, 14:38, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.90	14.30	🔺 So So	6.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.494427	2026-03-15 12:03:09.494427	f
4824	2024-08-11	09:50:00	22:50, 4:24, 8:19, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	17.80	💕 Love it So Much	57.20	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.496374	2026-03-15 12:03:09.496374	f
4825	2024-08-11	09:50:00	19:06, 19:23, 8:19	Wet	ciao	柴魚鮮味餐包(鮪魚+扇貝) ic-353	💖 Yes, eat right away	40.00	9.00	💕 Love it So Much	31.00	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.499385	2026-03-15 12:03:09.499385	f
4826	2024-08-11	09:50:00	19:04, 22:47, 00:15, 4:21, 8:19, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	39.70	1.70	🔺 So So	38.00	5	❌ - 🔺	30	\N	\N	2	\N	2026-03-15 12:03:09.501129	2026-03-15 12:03:09.501129	f
4827	2024-08-12	00:25:00	14:03, 15:14,	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	14.50	💕 Love it So Much	45.50	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.504313	2026-03-15 12:03:09.504313	f
4828	2024-08-12	00:25:00	14:01, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.20	12.50	🔺 So So	7.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.506188	2026-03-15 12:03:09.506188	f
4829	2024-08-12	09:15:00	18:20, 4:46, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	❌ No, not interested	80.00	42.40	🔺 So So	37.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.507901	2026-03-15 12:03:09.507901	f
4830	2024-08-12	09:15:00	17:50, 19:57, 23:51, 	Wet	ciao	ic-503 貓用極致濃湯肉塊餐包- 雞肉+干貝	❌ No, not interested	30.00	5.40	💕 Love it So Much	24.60	3	❌ - 💕	36	\N	\N	2	\N	2026-03-15 12:03:09.509595	2026-03-15 12:03:09.509595	f
4831	2024-08-12	09:15:00	18:19, 19:55, 23:49, 1:07, 4:43, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	37.60	4.90	🔺 So So	32.70	5	❌ - 🔺	30	\N	\N	2	\N	2026-03-15 12:03:09.51173	2026-03-15 12:03:09.51173	f
4832	2024-08-13	00:25:00	9:23, 	Wet	法麗	全照護主食罐 鮪魚佐鮭魚慕斯	💖 Yes, eat right away	80.00	38.10	🔺 So So	41.90	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.513478	2026-03-15 12:03:09.513478	f
4833	2024-08-13	00:25:00	9:22, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	16.70	🔺 So So	3.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.515139	2026-03-15 12:03:09.515139	f
4834	2024-08-13	10:00:00	7:07, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	❌ No, not interested	75.00	52.70	🔺 So So	22.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.517107	2026-03-15 12:03:09.517107	f
4835	2024-08-13	07:15:00	15:47, 18:36, 22:12, 23:27, 4:14, 7:06, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	5.10	💕 Love it So Much	44.90	6	💖 - 💕	52	\N	\N	2	\N	2026-03-15 12:03:09.521285	2026-03-15 12:03:09.521285	f
4836	2024-08-13	10:00:00	18:33, 22:10, 23:26, 4:11, 7:04, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	42.00	12.10	🔺 So So	29.90	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-15 12:03:09.526293	2026-03-15 12:03:09.526293	f
4837	2024-08-14	00:25:00	9:05, 16:12, 	Wet	ciao	ic-216 貓用巧餐包 鮪魚+鰹魚乾+雞肉	❌ No, not interested	40.00	3.70	💕 Love it So Much	36.30	2	❌ - 💕	34	\N	\N	2	\N	2026-03-15 12:03:09.528961	2026-03-15 12:03:09.528961	f
4838	2024-08-14	00:25:00	-	Wet	sheba	鮮饌包 鮪魚+蔬菜 (sam100)	💖 Yes, eat right away	40.00	20.00	❌ No!!!	20.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.530898	2026-03-15 12:03:09.530898	f
4839	2024-08-14	00:25:00	8:30, 9:04, 14:20, 16:10, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.70	6.70	🔺 So So	14.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.533737	2026-03-15 12:03:09.533737	f
4840	2024-08-14	09:45:00	5:09, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	40.60	🔺 So So	39.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.535459	2026-03-15 12:03:09.535459	f
4841	2024-08-14	09:45:00	19:06, 00:20, 5:08, 	Wet	ciao	ic-506 貓用極致濃湯肉塊餐包- 雞肉+干貝	💖 Yes, eat right away	30.00	4.70	💕 Love it So Much	25.30	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.538389	2026-03-15 12:03:09.538389	f
4842	2024-08-14	09:45:00	19:03, 00:17, 5:06, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	32.30	4.50	🔺 So So	27.80	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:09.542248	2026-03-15 12:03:09.542248	f
4843	2024-08-15	00:20:00	8:34, 12:01, 13:28, 14:34, 16:35, 	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	❌ No, not interested	50.00	4.10	💕 Love it So Much	45.90	5	❌ - 💕	40	16:11 有吐食物出來(肉泥& 乾飼料)/16:50 吐	\N	2	\N	2026-03-15 12:03:09.543998	2026-03-15 12:03:09.543998	f
4844	2024-08-15	00:20:00	8:33, 14:33, 16:30	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.30	7.80	🔺 So So	13.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.545723	2026-03-15 12:03:09.545723	f
4845	2024-08-15	09:15:00	20:00, 22:43, 00:46, 5:17, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	10.90	💕 Love it So Much	49.10	4	💖 - 💕	48	\N	\N	2	\N	2026-03-15 12:03:09.551248	2026-03-15 12:03:09.551248	f
4846	2024-08-15	09:15:00	18:45, 	Wet	ciao	ic-351 貓用柴魚鮮味餐包- 鮪魚	💖 Yes, eat right away	40.00	6.30	💕 Love it So Much	33.70	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:09.55298	2026-03-15 12:03:09.55298	f
4847	2024-08-15	09:15:00	18:46, 19:59, 22:41, 00:44, 5:15, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	33.10	7.40	🔺 So So	25.70	5	❌ - 🔺	30	\N	\N	2	\N	2026-03-15 12:03:09.554693	2026-03-15 12:03:09.554693	f
4848	2024-08-16	00:40:00	14:08, 	Wet	sheba	鮪魚及鯛魚口味 餐包	🔺 No, not really. Ate A Little	70.00	35.00	🔺 So So	35.00	1	🔺 - 🔺	20	不確定是否被早上的地震嚇到, 有點不安	\N	2	\N	2026-03-15 12:03:09.556415	2026-03-15 12:03:09.556415	f
4849	2024-08-16	00:40:00	10:34, 	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	🔺 No, not really. Ate A Little	60.00	44.50	🔺 So So	15.50	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.558124	2026-03-15 12:03:09.558124	f
4850	2024-08-16	00:40:00	-	Wet	銀湯匙	無添加餐包 鮪魚鰹魚雞胸肉 d-mc 609	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.559836	2026-03-15 12:03:09.559836	f
4851	2024-08-16	00:40:00	10:33, 14:07, 15:30, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.90	16.50	🔺 So So	4.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.561985	2026-03-15 12:03:09.561985	f
4852	2024-08-16	09:25:00	22:07, 1:01, 4:46, 7:16, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	❌ No, not interested	60.00	21.00	🔺 So So	39.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.56368	2026-03-15 12:03:09.56368	f
4853	2024-08-16	09:25:00	18:15, 1:02, 	Wet	ciao	ic-505 貓用極致濃湯肉塊餐包- 鰹魚+干貝+雞肉	❌ No, not interested	30.00	14.40	🔺 So So	15.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.565623	2026-03-15 12:03:09.565623	f
4854	2024-08-16	09:25:00	18:14, 22:06, 00:59,  4:43, 7:16, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	42.00	14.50	🔺 So So	27.50	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-15 12:03:09.567472	2026-03-15 12:03:09.567472	f
4855	2024-08-17	00:35:00	9:25, 16:35, 	Wet	sheba	金罐 鮪魚及蟹肉(湯汁)	💖 Yes, eat right away	85.00	26.20	💕 Love it So Much	58.80	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.56935	2026-03-15 12:03:09.56935	f
4856	2024-08-17	00:35:00	16:34, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.60	8.50	🔺 So So	12.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.571897	2026-03-15 12:03:09.571897	f
4857	2024-08-17	08:55:00	18:43, 4:35, 7:30, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	12.40	💕 Love it So Much	47.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.573693	2026-03-15 12:03:09.573693	f
4858	2024-08-17	08:55:00	21:48, 00:17, 7:31, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	11.90	💕 Love it So Much	63.10	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.575583	2026-03-15 12:03:09.575583	f
4859	2024-08-17	08:55:00	21:45, 00:14, 4:33, 7:28, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	34.10	5.00	🔺 So So	29.10	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-15 12:03:09.577356	2026-03-15 12:03:09.577356	f
4860	2024-08-18	00:30:00	10:30, 15:38, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	9.20	💕 Love it So Much	40.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.581259	2026-03-15 12:03:09.581259	f
4861	2024-08-18	00:30:00	10:29, 18:04	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.40	19.10	🔺 So So	1.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.583142	2026-03-15 12:03:09.583142	f
4862	2024-08-18	10:05:00	19:30, 4:14, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	30.20	🔺 So So	49.80	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.58494	2026-03-15 12:03:09.58494	f
4863	2024-08-18	10:05:00	19:31, 	Wet	ciao	柴魚鮮味餐包(鮪魚+扇貝) ic-353	❌ No, not interested	40.00	17.20	🔺 So So	22.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.586744	2026-03-15 12:03:09.586744	f
4864	2024-08-18	10:05:00	19:28, 22:16, 4:10, 8:35	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	44.30	14.10	🔺 So So	30.20	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.591015	2026-03-15 12:03:09.591015	f
3465	2024-11-14	00:40:00	-	Kibble	喜耀	成貓 海洋魚總匯	❌ No, not interested	16.50	16.50	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-12 15:17:01.080621	2026-03-15 12:05:23.625972	f
4865	2024-08-19	00:40:00	9:21, 	Wet	克勞德博士	菲力貓罐 7號雞肉鮭魚	🔺 No, not really. Ate A Little	70.00	40.60	🔺 So So	29.40	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.594262	2026-03-15 12:03:09.594262	f
4866	2024-08-19	00:40:00	9:21, 11:21, 15:31, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	21.00	11.50	🔺 So So	9.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.596109	2026-03-15 12:03:09.596109	f
4867	2024-08-19	09:30:00	18:03, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	🔺 No, not really. Ate A Little	50.00	32.30	🔺 So So	17.70	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.598512	2026-03-15 12:03:09.598512	f
4868	2024-08-19	09:30:00	18:02, 18:51, 3:55, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	11.60	💕 Love it So Much	48.40	3	💖 - 💕	46	\N	\N	2	\N	2026-03-15 12:03:09.602499	2026-03-15 12:03:09.602499	f
4869	2024-08-19	12:00:00	21:50, 3:53, 	Kibble	wellness	core 無穀新鮮火雞肉	❌ No, not interested	10.00	2.00	🔺 So So	8.00	2	❌ - 🔺	24	\N	\N	2	\N	2026-03-15 12:03:09.604242	2026-03-15 12:03:09.604242	f
4870	2024-08-19	09:30:00	18:50, 3:51, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	36.80	15.40	🔺 So So	21.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.608267	2026-03-15 12:03:09.608267	f
4871	2024-08-20	00:30:00	9:24, 	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	5.40	💕 Love it So Much	54.60	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:09.610107	2026-03-15 12:03:09.610107	f
4872	2024-08-20	00:30:00	9:23, 14:04, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	10.00	5.20	🔺 So So	4.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.611899	2026-03-15 12:03:09.611899	f
4873	2024-08-20	00:30:00	-	Kibble	wellness	core 無穀新鮮火雞肉	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.616278	2026-03-15 12:03:09.616278	f
4874	2024-08-20	09:30:00	00:33, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	❌ No, not interested	75.00	56.60	🔺 So So	18.40	1	❌ - 🔺	15	緩緩, 可能吃膩了	\N	2	\N	2026-03-15 12:03:09.618102	2026-03-15 12:03:09.618102	f
4875	2024-08-20	09:30:00	19:19, 4:28, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	35.10	🔺 So So	24.90	2	💖 - 🔺	27	可能吃膩了	\N	2	\N	2026-03-15 12:03:09.619863	2026-03-15 12:03:09.619863	f
4876	2024-08-20	09:30:00	19:16, 00:29, 4:27, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	25.90	5.10	🔺 So So	20.80	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-15 12:03:09.624278	2026-03-15 12:03:09.624278	f
4877	2024-08-20	09:30:00	00:32, 4:25, 	Kibble	wellness	core 無穀新鮮火雞肉	❌ No, not interested	20.90	8.50	🔺 So So	12.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.626121	2026-03-15 12:03:09.626121	f
4878	2024-08-21	00:20:00	-	Wet	ciao	a-252 1000億乳酸菌 鮪魚+雞肉+干貝	🔺 No, not really. Ate A Little	85.00	57.00	❌ No!!!	28.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-15 12:03:09.628286	2026-03-15 12:03:09.628286	f
4879	2024-08-21	00:20:00	-	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.632339	2026-03-15 12:03:09.632339	f
4880	2024-08-21	00:20:00	14:00, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	10.00	5.20	🔺 So So	4.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.634201	2026-03-15 12:03:09.634201	f
4881	2024-08-21	00:20:00	-	Kibble	wellness	core 無穀新鮮火雞肉	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.636536	2026-03-15 12:03:09.636536	f
4882	2024-08-21	07:35:00	3:57, 	Wet	ciao	鰹魚燒晚餐 ic-281 (雞肉+鰹魚+蟹肉+干貝)	🔺 No, not really. Ate A Little	50.00	37.40	🔺 So So	12.60	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.638621	2026-03-15 12:03:09.638621	f
4883	2024-08-21	07:35:00	-	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	🔺 No, not really. Ate A Little	80.00	64.00	❌ No!!!	16.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-15 12:03:09.640504	2026-03-15 12:03:09.640504	f
4884	2024-08-21	11:10:00	-	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝	💖 Yes, eat right away	35.00	15.50	❌ No!!!	19.50	0	💖 - ❌	18	22:24 收起來	\N	2	\N	2026-03-15 12:03:09.643277	2026-03-15 12:03:09.643277	f
4885	2024-08-21	07:35:00	-	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	26.30	26.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.645021	2026-03-15 12:03:09.645021	f
4886	2024-08-21	11:10:00	-	Kibble	wellness	core 無穀新鮮火雞肉	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.647173	2026-03-15 12:03:09.647173	f
4887	2024-08-22	00:30:00	14:27	Wet	惡魔喵	天然無穀餐包 小惡魔6號 - 美味火雞+鮪魚	💖 Yes, eat right away	36.00	19.02	🔺 So So	16.98	1	💖 - 🔺	25	混合 ciao a-143 (ciao a-143: 小惡魔6號 = 0.31:0.69)	\N	2	\N	2026-03-15 12:03:09.649766	2026-03-15 12:03:09.649766	f
4888	2024-08-22	03:00:00	14:27	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	42.28	🔺 So So	37.72	1	💖 - 🔺	25	11:10 => ciao a-143豪華罐+德國惡魔喵餐包	\N	2	\N	2026-03-15 12:03:09.651552	2026-03-15 12:03:09.651552	f
4889	2024-08-22	03:00:00	14:25, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.70	13.70	🔺 So So	7.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.654381	2026-03-15 12:03:09.654381	f
4890	2024-08-22	09:25:00	-	Wet	惡魔喵	天然無穀餐包 小惡魔6號 - 美味火雞+鮪魚	❌ No, not interested	49.20	49.20	❌ No!!!	0.00	0	❌ - ❌	8	21:30 => 倒掉	\N	2	\N	2026-03-15 12:03:09.656107	2026-03-15 12:03:09.656107	f
4891	2024-08-22	09:25:00	-	Wet	ciao	豪華魚三味餐包 ic-416 (北海道干貝湯底)	❌ No, not interested	62.50	62.50	❌ No!!!	0.00	0	❌ - ❌	8	21:30 => 倒掉	\N	2	\N	2026-03-15 12:03:09.659634	2026-03-15 12:03:09.659634	f
4892	2024-08-22	09:25:00	17:56, 18:34, 23:26, 4:04, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	40.90	5.90	💕 Love it So Much	35.00	4	❌ - 💕	38	\N	\N	2	\N	2026-03-15 12:03:09.661439	2026-03-15 12:03:09.661439	f
4893	2024-08-22	11:40:00	-	Wet	ciao	ic-239 鰹魚燒晚餐包 鰹魚+鮭魚+干貝	❌ No, not interested	50.00	50.00	❌ No!!!	0.00	0	❌ - ❌	8	21:30 => 倒掉	\N	2	\N	2026-03-15 12:03:09.663408	2026-03-15 12:03:09.663408	f
4894	2024-08-22	13:20:00	4:07, 	Wet	axia	新金罐濃厚3號 鮪魚+吻仔魚	💖 Yes, eat right away	70.00	31.00	🔺 So So	39.00	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.665167	2026-03-15 12:03:09.665167	f
4895	2024-08-23	00:40:00	-	Wet	nature 養生湯罐	雞肉+蛋+吻仔魚	💖 Yes, eat right away	80.00	51.30	❌ No!!!	28.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.669296	2026-03-15 12:03:09.669296	f
4896	2024-08-23	00:40:00	9:48, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.20	17.50	🔺 So So	2.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.671108	2026-03-15 12:03:09.671108	f
4897	2024-08-23	08:40:00	4:27, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	43.60	🔺 So So	31.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.672896	2026-03-15 12:03:09.672896	f
4898	2024-08-23	08:40:00	22:13,	Wet	克勞德博士	5號 鮮雞鮪魚炒菠菜	💖 Yes, eat right away	85.00	67.80	🔺 So So	17.20	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.674618	2026-03-15 12:03:09.674618	f
4899	2024-08-23	08:40:00	16:44, 17:33, 18:49, 22:12, 00:07, 4:24, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	42.70	10.20	💕 Love it So Much	32.50	6	❌ - 💕	42	\N	\N	2	\N	2026-03-15 12:03:09.676373	2026-03-15 12:03:09.676373	f
4900	2024-08-24	00:35:00	-	Wet	sheba	鮮饌包 鮪魚及鮭魚	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.678328	2026-03-15 12:03:09.678328	f
4901	2024-08-24	00:35:00	-	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	💖 Yes, eat right away	60.00	20.90	❌ No!!!	39.10	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.679968	2026-03-15 12:03:09.679968	f
4903	2024-08-24	09:20:00	19:02, 	Wet	ciao	旨定罐-奢華系列 a-145(柴魚片+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	64.50	🔺 So So	15.50	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.68454	2026-03-15 12:03:09.68454	f
4904	2024-08-24	09:20:00	20:41, 4:05, 	Wet	法麗	全照護主食罐 雞肉佐鮪魚慕斯	💖 Yes, eat right away	80.00	22.40	💕 Love it So Much	57.60	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.686519	2026-03-15 12:03:09.686519	f
4905	2024-08-24	09:20:00	19:01, 20:39, 00:14, 4:00, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	39.70	15.30	🔺 So So	24.40	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.688304	2026-03-15 12:03:09.688304	f
4906	2024-08-25	00:20:00	15:12,	Wet	ciao	ic-501 貓用極致濃湯肉塊餐包 - 鮪魚+雞肉+干貝 x2	💖 Yes, eat right away	60.00	11.20	💕 Love it So Much	48.80	1	💖 - 💕	42	\N	\N	2	\N	2026-03-15 12:03:09.691297	2026-03-15 12:03:09.691297	f
4907	2024-08-25	00:20:00	15:11, 17:21, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.40	16.90	🔺 So So	3.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.694136	2026-03-15 12:03:09.694136	f
4908	2024-08-25	09:25:00	-	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	❌ No, not interested	75.00	75.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.697261	2026-03-15 12:03:09.697261	f
4909	2024-08-25	09:25:00	18:17, 	Wet	oasy	舒芙蕾 那不勒斯鮮雞	🔺 No, not really. Ate A Little	85.00	57.30	🔺 So So	27.70	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-15 12:03:09.699521	2026-03-15 12:03:09.699521	f
4910	2024-08-25	09:25:00	18:16, 22:14, 23:48, 3:27, 6:57, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	42.10	14.10	🔺 So So	28.00	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-15 12:03:09.702331	2026-03-15 12:03:09.702331	f
4911	2024-08-26	00:20:00	9:07, 14:16	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	10.30	💕 Love it So Much	69.70	2	💖 - 💕	44	\N	\N	2	\N	2026-03-15 12:03:09.704103	2026-03-15 12:03:09.704103	f
4912	2024-08-26	00:20:00	14:14, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.60	16.20	🔺 So So	4.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.705877	2026-03-15 12:03:09.705877	f
4913	2024-08-26	09:15:00	-	Wet	ciao	豪華雞三味餐包 ic-534 (蟹肉口味)	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8	18:30 => 倒掉	\N	2	\N	2026-03-15 12:03:09.707761	2026-03-15 12:03:09.707761	f
4914	2024-08-26	09:15:00	4:06, 	Wet	ciao	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	46.20	🔺 So So	33.80	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.709903	2026-03-15 12:03:09.709903	f
4915	2024-08-26	10:50:00	8:17	Wet	法麗	全照護主食罐 雞肉佐鮪魚慕斯	💖 Yes, eat right away	80.00	33.30	🔺 So So	46.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.711853	2026-03-15 12:03:09.711853	f
4916	2024-08-26	10:50:00	23:25, , 4:04, 8:16, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	41.50	13.70	🔺 So So	27.80	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.713909	2026-03-15 12:03:09.713909	f
4917	2024-08-27	00:30:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	70.00	33.30	❌ No!!!	36.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-15 12:03:09.716515	2026-03-15 12:03:09.716515	f
4918	2024-08-27	00:30:00	18:20	Kibble	wellness	core 無穀新鮮火雞肉	❌ No, not interested	20.40	19.40	🔺 So So	1.00	1	❌ - 🔺	15	18:20 => 需要拿到面前才會吃幾口, 目前觀察起來不會主動去吃	\N	2	\N	2026-03-15 12:03:09.718297	2026-03-15 12:03:09.718297	f
4919	2024-08-27	00:30:00	18:38, 21:38, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	23.20	🔺 So So	26.80	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-15 12:03:09.720155	2026-03-15 12:03:09.720155	f
4920	2024-08-27	10:00:00	-	Wet	mon petit 貓倍麗	銀罐 鰹魚吞拿魚拌木魚乾	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.721999	2026-03-15 12:03:09.721999	f
4921	2024-08-27	10:00:00	21:37, 23:09, 3:36, 8:10	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	37.40	18.60	🔺 So So	18.80	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.724313	2026-03-15 12:03:09.724313	f
4922	2024-08-28	00:15:00	9:07, 	Wet	nature 養生湯罐	雞肉+鮮蝦	💖 Yes, eat right away	80.00	37.00	🔺 So So	43.00	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.726116	2026-03-15 12:03:09.726116	f
4923	2024-08-28	00:15:00	9:05, 15:20, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.30	15.20	🔺 So So	5.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-15 12:03:09.727919	2026-03-15 12:03:09.727919	f
4925	2024-08-28	09:10:00	23:46, 5:35, 	Wet	ciao	ciao 旨定濃湯罐系列 a-233 (雞肉+干貝)	💖 Yes, eat right away	75.00	21.60	💕 Love it So Much	53.40	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.731346	2026-03-15 12:03:09.731346	f
4926	2024-08-28	09:10:00	-	Wet	法麗	全方位無膠主食罐 鮪魚慕斯佐鯛魚 (紅罐)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.733067	2026-03-15 12:03:09.733067	f
4928	2024-08-28	09:10:00	18:15, 22:12, 3:25, 8:00, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	35.20	14.70	🔺 So So	20.50	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.737257	2026-03-15 12:03:09.737257	f
4929	2024-08-29	00:20:00	8:51, 14:28, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	28.90	💕 Love it So Much	56.10	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.739263	2026-03-15 12:03:09.739263	f
4930	2024-08-29	00:20:00	14:26, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	15.80	🔺 So So	4.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.741091	2026-03-15 12:03:09.741091	f
4932	2024-08-29	09:30:00	8:07, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	❌ No, not interested	80.00	71.00	🔺 So So	9.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.756514	2026-03-15 12:03:09.756514	f
4933	2024-08-29	09:30:00	3:21, 8:07, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	💖 Yes, eat right away	60.00	16.80	💕 Love it So Much	43.20	2	💖 - 💕	37	\N	\N	2	\N	2026-03-15 12:03:09.758407	2026-03-15 12:03:09.758407	f
4934	2024-08-29	09:30:00	22:16, 3:18, 8:05, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	41.20	23.00	🔺 So So	18.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.76028	2026-03-15 12:03:09.76028	f
4936	2024-08-30	00:15:00	14:03, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	32.70	🔺 So So	27.30	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.764382	2026-03-15 12:03:09.764382	f
4937	2024-08-30	00:15:00	14:03,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.00	17.60	🔺 So So	2.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.766278	2026-03-15 12:03:09.766278	f
4938	2024-08-30	00:15:00	-	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	11.00	11.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.767938	2026-03-15 12:03:09.767938	f
4477	2024-10-17	00:00:00	-	Kibble	貓倍麗	海洋魚高纖化毛	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-13 14:01:59.292287	2026-03-15 12:05:38.141166	f
4931	2024-08-29	00:20:00	8:51, 	Kibble	法麗	真肉配方全營養貓糧 雞肉主食 泌尿道照護	❌ No, not interested	15.10	14.00	🔺 So So	1.10	1	❌ - 🔺	15		\N	2	\N	2026-03-15 12:03:09.754671	2026-03-15 12:06:16.973214	f
4924	2024-08-28	00:15:00	14:23, 	Kibble	法麗	真肉配方全營養貓糧 雞肉主食 泌尿道照護	❌ No, not interested	11.40	7.00	🔺 So So	4.40	1	❌ - 🔺	15		\N	2	\N	2026-03-15 12:03:09.729599	2026-03-15 12:06:52.141906	f
4955	2026-03-16	01:45:00	14:01, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.70	18.50	🔺 So So	2.20	1	❌ - 🔺	15		\N	2	\N	2026-03-16 01:45:35.703778	2026-03-16 13:04:51.323544	f
4939	2024-08-30	09:30:00	00:46, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	❌ No, not interested	85.00	73.00	🔺 So So	12.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.769648	2026-03-15 12:03:09.769648	f
4940	2024-08-30	09:30:00	-	Wet	oasy	oasy 舒芙蕾 威尼斯鮮鮭魚	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.772179	2026-03-15 12:03:09.772179	f
4941	2024-08-30	09:30:00	18:11, 00:45, 3:39, 5:01, 8:14, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	42.90	27.40	🔺 So So	15.50	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-15 12:03:09.773815	2026-03-15 12:03:09.773815	f
4942	2024-08-30	09:30:00	21:33, 00:43, 8:15,	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	26.30	11.00	🔺 So So	15.30	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-15 12:03:09.775538	2026-03-15 12:03:09.775538	f
4943	2024-08-31	00:15:00	9:58, 	Wet	nature 養生湯罐	白身鮪魚+雞肉	💖 Yes, eat right away	80.00	35.90	🔺 So So	44.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.777288	2026-03-15 12:03:09.777288	f
4944	2024-08-31	00:15:00	9:58, 	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	20.20	18.50	🔺 So So	1.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-15 12:03:09.778966	2026-03-15 12:03:09.778966	f
4945	2024-08-31	00:15:00	-	Kibble	新萃	全穀物成幼貓 雞肉	❌ No, not interested	16.00	10.80	❌ No!!!	5.20	0	❌ - ❌	8	\N	\N	2	\N	2026-03-15 12:03:09.781455	2026-03-15 12:03:09.781455	f
4946	2024-08-31	10:10:00	19:17, 	Wet	法麗	關節保護主食罐 雞肉佐小麥草	💖 Yes, eat right away	80.00	63.90	🔺 So So	16.10	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-15 12:03:09.78324	2026-03-15 12:03:09.78324	f
4947	2024-08-31	10:10:00	22:12, 4:40, 5:47, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	28.20	💕 Love it So Much	46.80	3	💖 - 💕	39	\N	\N	2	\N	2026-03-15 12:03:09.785098	2026-03-15 12:03:09.785098	f
4948	2024-08-31	10:10:00	18:15, 22:11, 00:27, 4:38, 	Kibble	素力高	宅宅貓吃雞	❌ No, not interested	17.10	2.90	🔺 So So	14.20	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-15 12:03:09.787079	2026-03-15 12:03:09.787079	f
4949	2024-08-31	10:10:00	18:14, 22:09, 00:26, 4:35,	Kibble	柏萊富	雞肉+豌豆	❌ No, not interested	39.40	21.10	🔺 So So	18.30	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-15 12:03:09.789592	2026-03-15 12:03:09.789592	f
2990	2025-11-26	01:00:00	-	Kibble	法麗	真肉配方 鴨肉主食 腸胃呵護	❌ No, not interested	21.30	21.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-08 13:51:59.198123	2026-03-15 12:03:36.160108	f
4935	2024-08-29	09:30:00	23:14, 	Kibble	法麗	真肉配方全營養貓糧 雞肉主食 泌尿道照護	❌ No, not interested	31.00	26.10	🔺 So So	4.90	1	❌ - 🔺	15		\N	2	\N	2026-03-15 12:03:09.762532	2026-03-15 12:06:03.79157	f
4927	2024-08-28	09:10:00	17:32, 23:45, 3:28, 7:59, 	Kibble	法麗	真肉配方全營養貓糧 雞肉主食 泌尿道照護	❌ No, not interested	15.00	4.70	🔺 So So	10.30	4	❌ - 🔺	21		\N	2	\N	2026-03-15 12:03:09.734804	2026-03-15 12:06:28.957247	f
2230	2025-08-19	10:10:00	-	Wet	mon petit 貓倍麗	嚴選金罐鮪魚蟹肉拼盤(吞拿魚及蟹柳)	❌ No, not interested	85.00	85.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:08.083782	2026-03-16 09:01:19.05671	f
1941	2025-07-02	11:20:00	2:56, 6:04, 	Wet	mon petit 貓倍麗	嚴選金罐鮪魚蟹肉拼盤(吞拿魚及蟹柳)	❌ No, not interested	85.00	60.40	🔺 So So	24.60	2	❌ - 🔺	17		\N	2	\N	2026-03-04 11:51:06.382956	2026-03-16 09:01:31.680522	f
1721	2025-06-03	00:30:00	-	Wet	nuevo 新歡	精選菲力主食貓罐系列 3號 雞鮪雙拼	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-04 11:51:05.61781	2026-03-16 09:22:43.300649	f
4583	2026-03-15	01:39:00	17:50, 18:44, 19:59, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	12.20	🔺 So So	8.20	3	❌ - 🔺	19		\N	2	\N	2026-03-15 01:39:35.219061	2026-03-15 12:35:32.993473	f
4962	2026-03-16	13:10:00	-	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 撥沙, 半小時後倒掉	\N	2	\N	2026-03-16 13:10:52.880869	2026-03-16 14:27:57.829233	f
4964	2024-05-01	00:40:00	9:30, 	Wet	neko 貓湯罐	鮪魚+鮭魚 貓湯罐	🔺 No, not really. Ate A Little	80.00	39.30	🔺 So So	40.70	1	🔺 - 🔺	20	21:35 => 吐出食物, 不確定是吃完太激動？還是早上的食物？	\N	2	\N	2026-03-16 14:39:14.316437	2026-03-16 14:39:14.316437	f
4965	2024-05-01	00:40:00	9:30,	Kibble	歐那特	多種魚	❌ No, not interested	20.30	13.30	🔺 So So	7.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.321306	2026-03-16 14:39:14.321306	f
4966	2024-05-01	10:05:00	18:35, 20:42, 21:30, 22:02, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	1.50	💕 Love it So Much	83.50	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.323244	2026-03-16 14:39:14.323244	f
4951	2026-03-15	12:38:00	21:32, 00:08, 1:13,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	16.80	🔺 So So	8.40	3	❌ - 🔺	19	加誠實貓 雞塊 5.2g	\N	2	56	2026-03-15 12:38:26.572608	2026-03-16 01:43:09.178552	t
4950	2026-03-15	12:36:00	1:11, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	15.70	🔺 So So	4.30	1	❌ - 🔺	15		\N	2	\N	2026-03-15 12:36:14.612711	2026-03-16 01:42:41.923382	f
4952	2026-03-15	13:35:00	00:08, 1:14, 5:18, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	66.80	🔺 So So	63.20	3	💖 - 🔺	29		\N	2	\N	2026-03-15 13:38:00.017778	2026-03-16 01:44:25.61189	f
4967	2024-05-01	10:05:00	20:43, 21:02, 4:48	Wet	mon petit 貓倍麗	極上餐包- 鮮鮪紅鯛	🔺 No, not really. Ate A Little	35.00	12.20	🔺 So So	22.80	3	🔺 - 🔺	24	\N	\N	2	\N	2026-03-16 14:39:14.325266	2026-03-16 14:39:14.325266	f
4968	2024-05-01	10:05:00	18:32, 20:42, 21:01, 21:59, 3:21, 4:43,	Kibble	歐那特	多種魚	❌ No, not interested	43.70	18.20	💕 Love it So Much	25.50	6	❌ - 💕	35	\N	\N	2	\N	2026-03-16 14:39:14.327418	2026-03-16 14:39:14.327418	f
4969	2024-05-02	00:30:00	10:25, 14:38, 15:50, 	Wet	ciao	旨定貓罐 白身鮪魚1000億乳酸菌 a-135	💖 Yes, eat right away	85.00	25.80	💕 Love it So Much	59.20	3	💖 - 💕	39	\N	\N	2	\N	2026-03-16 14:39:14.329454	2026-03-16 14:39:14.329454	f
4970	2024-05-02	00:30:00	10:25, 14:36	Kibble	歐那特	多種魚	❌ No, not interested	20.00	12.20	🔺 So So	7.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.331122	2026-03-16 14:39:14.331122	f
4971	2024-05-02	10:20:00	20:55, 22:13, 23:12, 3:58,	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	3.30	💕 Love it So Much	76.70	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.332772	2026-03-16 14:39:14.332772	f
4963	2026-03-16	14:00:00	23:21, 2:23, 5:00, 	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x3	❌ No, not interested	105.00	53.70	🔺 So So	51.30	3	❌ - 🔺	19		\N	2	\N	2026-03-16 14:28:49.737341	2026-03-17 01:15:25.095087	f
4972	2024-05-02	10:20:00	-	Wet	ciao	柴魚鮮味餐包(鮪魚+扇貝) ic-353	💖 Yes, eat right away	40.00	2.30	❌ No!!!	37.70	0	💖 - ❌	25	\N	\N	2	\N	2026-03-16 14:39:14.335098	2026-03-16 14:39:14.335098	f
4973	2024-05-02	10:20:00	20:52, 22:12, 3:55, 8:14, 	Kibble	歐那特	多種魚	❌ No, not interested	43.80	17.70	🔺 So So	26.10	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-16 14:39:14.336806	2026-03-16 14:39:14.336806	f
4974	2024-05-03	00:20:00	19:42, 4:13, 	Wet	原燒	白身鮪魚+鮮蝦	💖 Yes, eat right away	80.00	24.70	💕 Love it So Much	55.30	2	💖 - 💕	37	\N	\N	2	\N	2026-03-16 14:39:14.338425	2026-03-16 14:39:14.338425	f
4975	2024-05-03	00:20:00	14:44, 	Kibble	歐那特	多種魚	❌ No, not interested	22.00	17.80	🔺 So So	4.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.340633	2026-03-16 14:39:14.340633	f
4976	2024-05-03	03:30:00	-	Wet	mon petit 貓倍麗	鮪魚蟹肉鮮蝦極品高湯	💖 Yes, eat right away	40.00	10.40	❌ No!!!	29.60	0	💖 - ❌	18	湯汁喝光剩肉,	\N	2	\N	2026-03-16 14:39:14.342228	2026-03-16 14:39:14.342228	f
4977	2024-05-03	11:00:00	19:42, 4:13, 	Wet	sheba	鮮饌包 鮪魚及鮭魚	💖 Yes, eat right away	70.00	15.30	💕 Love it So Much	54.70	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.344176	2026-03-16 14:39:14.344176	f
4978	2024-05-03	11:00:00	19:43, 23:42, 	Wet	sheba	鮮饌包 鮪魚及蟹肉口味	❌ No, not interested	70.00	15.10	💕 Love it So Much	54.90	2	❌ - 💕	34	\N	\N	2	\N	2026-03-16 14:39:14.345865	2026-03-16 14:39:14.345865	f
4979	2024-05-03	11:00:00	4:10, 	Kibble	歐那特	多種魚	❌ No, not interested	49.20	37.50	🔺 So So	11.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.347591	2026-03-16 14:39:14.347591	f
4981	2024-05-04	00:40:00	9:55, 	Kibble	歐那特	多種魚	❌ No, not interested	20.40	17.40	🔺 So So	3.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.351879	2026-03-16 14:39:14.351879	f
4983	2024-05-04	10:20:00	19:38, 20:38, 22:11, 4:16, 	Kibble	歐那特	多種魚	❌ No, not interested	48.90	18.20	🔺 So So	30.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-16 14:39:14.35525	2026-03-16 14:39:14.35525	f
4984	2024-05-04	14:37:00	-	Freeze-Dried	法麗	原肉凍乾 鮪魚	💖 Yes, eat right away	1.60	0.00	💕 Love it So Much	1.60	0	💖 - 💕	40	\N	\N	2	\N	2026-03-16 14:39:14.357399	2026-03-16 14:39:14.357399	f
4985	2024-05-05	00:25:00	10:44, 14:49	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	1.50	💕 Love it So Much	68.50	2	💖 - 💕	44	14:49 => 吃光	\N	2	\N	2026-03-16 14:39:14.380993	2026-03-16 14:39:14.380993	f
4986	2024-05-05	00:25:00	16:10,	Kibble	歐那特	多種魚	❌ No, not interested	20.00	14.60	🔺 So So	5.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.383119	2026-03-16 14:39:14.383119	f
4987	2024-05-05	10:20:00	23:43, 4:07, 	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	💖 Yes, eat right away	120.00	39.70	💕 Love it So Much	80.30	2	💖 - 💕	37	\N	\N	2	\N	2026-03-16 14:39:14.384842	2026-03-16 14:39:14.384842	f
4988	2024-05-05	10:20:00	23:39, 4:04, 8;14,	Kibble	歐那特	多種魚	❌ No, not interested	44.60	21.20	🔺 So So	23.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.38658	2026-03-16 14:39:14.38658	f
4989	2024-05-05	13:44:00	-	Freeze-Dried	法麗	原肉凍乾 鮪魚	💖 Yes, eat right away	1.60	0.00	💕 Love it So Much	1.60	0	💖 - 💕	40	\N	\N	2	\N	2026-03-16 14:39:14.388294	2026-03-16 14:39:14.388294	f
4990	2024-05-06	00:20:00	9:48, 14:11, 14:50, 17:08, 	Wet	mon petit 貓倍麗	嚴選金罐鮮燴鰹魚大餐 (嚴選鰹魚塊)	💖 Yes, eat right away	85.00	23.30	💕 Love it So Much	61.70	4	💖 - 💕	41	\N	\N	2	\N	2026-03-16 14:39:14.38989	2026-03-16 14:39:14.38989	f
4991	2024-05-06	00:20:00	14:10, 17:07, 	Kibble	歐那特	多種魚	❌ No, not interested	21.20	17.90	🔺 So So	3.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.391502	2026-03-16 14:39:14.391502	f
4992	2024-05-06	10:20:00	19:32, 22:39, 4:08, 5:25, 	Wet	mon petit 貓倍麗	鮪魚蟹肉銀魚極品鮮湯 sp1 x2	❌ No, not interested	80.00	17.40	💕 Love it So Much	62.60	4	❌ - 💕	38	\N	\N	2	\N	2026-03-16 14:39:14.393509	2026-03-16 14:39:14.393509	f
4993	2024-05-06	10:20:00	19:33, 22:40, 5:23,	Wet	mon petit 貓倍麗	鮪魚蟹肉鰹魚 極品上湯	❌ No, not interested	40.00	15.90	💕 Love it So Much	24.10	3	❌ - 💕	29	\N	\N	2	\N	2026-03-16 14:39:14.395278	2026-03-16 14:39:14.395278	f
4994	2024-05-06	10:20:00	19:29, 20:34, 22:04, 22:38, 4:05, 	Kibble	歐那特	多種魚	❌ No, not interested	47.90	14.10	🔺 So So	33.80	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-16 14:39:14.396915	2026-03-16 14:39:14.396915	f
4995	2024-05-06	14:19:00	-	Freeze-Dried	法麗	原肉凍乾 鮪魚	💖 Yes, eat right away	1.50	0.00	❌ No!!!	1.50	0	💖 - ❌	25	\N	\N	2	\N	2026-03-16 14:39:14.398593	2026-03-16 14:39:14.398593	f
4996	2024-05-07	00:30:00	14:32, 17:48, 	Wet	sheba	金罐 鮪魚及蟹肉(湯汁)	💖 Yes, eat right away	85.00	17.30	💕 Love it So Much	67.70	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.400171	2026-03-16 14:39:14.400171	f
4997	2024-05-07	00:30:00	17:46, 18:04, 	Kibble	歐那特	多種魚	❌ No, not interested	21.40	14.70	🔺 So So	6.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.402143	2026-03-16 14:39:14.402143	f
4998	2024-05-07	10:10:00	18:55, 21:16, 23:01, 	Wet	奇境	野生鮪魚燉雞湯	💖 Yes, eat right away	55.00	1.40	💕 Love it So Much	53.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.404076	2026-03-16 14:39:14.404076	f
4999	2024-05-07	10:10:00	18:55, 21:17, 4:04, 	Other	petline	極品貓罐 (z14)	💖 Yes, eat right away	80.00	39.70	🔺 So So	40.30	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-16 14:39:14.405709	2026-03-16 14:39:14.405709	f
5000	2024-05-07	10:10:00	4:00, 	Kibble	歐那特	多種魚	❌ No, not interested	44.70	24.60	🔺 So So	20.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.407356	2026-03-16 14:39:14.407356	f
5002	2024-05-08	00:28:00	16:03, 	Kibble	歐那特	多種魚	❌ No, not interested	20.80	11.30	🔺 So So	9.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.410961	2026-03-16 14:39:14.410961	f
5004	2024-05-08	10:20:00	22:36, 4:16, 	Kibble	歐那特	多種魚	❌ No, not interested	22.20	17.50	🔺 So So	4.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.414377	2026-03-16 14:39:14.414377	f
5006	2024-05-08	14:55:00	-	Freeze-Dried	法麗	原肉凍乾 鮪魚	💖 Yes, eat right away	1.40	0.00	❌ No!!!	1.40	0	💖 - ❌	25	\N	\N	2	\N	2026-03-16 14:39:14.417533	2026-03-16 14:39:14.417533	f
5007	2024-05-09	23:53:00	8:21, 13:30, 15:54,	Wet	axia	金罐4號-鮪, 柴(gn-4)	💖 Yes, eat right away	70.00	23.20	💕 Love it So Much	46.80	3	💖 - 💕	39	\N	\N	2	\N	2026-03-16 14:39:14.419138	2026-03-16 14:39:14.419138	f
5001	2024-05-08	00:28:00	9:18, 9:45, 16:05, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	💖 Yes, eat right away	80.00	7.10	💕 Love it So Much	72.90	3	💖 - 💕	46	比平時更peace的感覺	\N	2	\N	2026-03-16 14:39:14.40892	2026-03-16 14:44:22.76926	f
4980	2024-05-04	00:40:00	9:58, 	Wet	法麗	泌尿道保健主食罐 鮪魚佐紅蘿蔔	💖 Yes, eat right away	80.00	18.70	💕 Love it So Much	61.30	1	💖 - 💕	42		\N	2	\N	2026-03-16 14:39:14.349236	2026-03-16 14:45:13.849448	f
5005	2024-05-08	10:20:00	21:06, 22:37, 4:15, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	19.80	0.00	🔺 So So	19.80	3	❌ - 🔺	26		\N	2	\N	2026-03-16 14:39:14.415966	2026-03-16 14:48:08.744582	f
4982	2024-05-04	10:20:00	19:41, 20:39, 22:13, 22:51, 4:18, 5:03, 	Wet	法麗	室內貓排毛 鮪魚佐鮮蝦	❌ No, not interested	162.70	73.20	💕 Love it So Much	89.50	6	❌ - 💕	35		\N	2	\N	2026-03-16 14:39:14.353547	2026-03-17 08:21:12.224735	f
5009	2024-05-09	10:05:00	21:29, 4:28,	Wet	axia	金罐芳醇餐包5號-鮪, 扇貝(ghp-5)	❌ No, not interested	60.00	31.70	🔺 So So	28.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.423241	2026-03-16 14:39:14.423241	f
5010	2024-05-09	10:05:00	-	Wet	axia	金罐芳醇餐包1號-鮪(ghp-1)	❌ No, not interested	60.00	60.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.424897	2026-03-16 14:39:14.424897	f
5012	2024-05-09	11:30:00	21:30, 23:35, 4:26, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	5.00	💕 Love it So Much	80.00	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.428082	2026-03-16 14:39:14.428082	f
5013	2024-05-10	00:31:00	9:14, 9:57, 16:10, 	Wet	ciao	旨定罐10號(鰹魚+柴魚片)	💖 Yes, eat right away	85.00	42.90	🔺 So So	42.10	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-16 14:39:14.429588	2026-03-16 14:39:14.429588	f
5015	2024-05-10	10:10:00	20:21, 22:54, 01:13, 4:49, 7:58, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	11.50	💕 Love it So Much	68.50	5	💖 - 💕	50	\N	\N	2	\N	2026-03-16 14:39:14.432652	2026-03-16 14:39:14.432652	f
5016	2024-05-10	10:10:00	20:22, 	Wet	ciao	柴魚鮮味餐包(鰹魚) ic-352	💖 Yes, eat right away	40.00	5.50	💕 Love it So Much	34.50	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.434654	2026-03-16 14:39:14.434654	f
5018	2024-05-11	00:27:00	15:21, 	Wet	mon petit 貓倍麗	嚴選金罐鮪魚蟹肉拼盤(吞拿魚及蟹柳)	🔺 No, not really. Ate A Little	85.00	54.50	🔺 So So	30.50	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-16 14:39:14.43792	2026-03-16 14:39:14.43792	f
5020	2024-05-11	00:27:00	15:20, 	Freeze-Dried	法麗	原肉凍乾 鮪魚	💖 Yes, eat right away	1.40	0.00	💕 Love it So Much	1.40	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.441191	2026-03-16 14:39:14.441191	f
5021	2024-05-11	10:39:00	20:36, 22:20, 00:23, 3:55, 6:16	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	💖 Yes, eat right away	114.00	18.00	💕 Love it So Much	96.00	5	💖 - 💕	50	\N	\N	2	\N	2026-03-16 14:39:14.44272	2026-03-16 14:39:14.44272	f
5028	2024-05-12	11:23:00	20:48, 23:59, 	Kibble	ucat	雞肉+蔓越莓(試吃包）	❌ No, not interested	30.50	8.20	🔺 So So	22.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.492046	2026-03-16 14:39:14.492046	f
5029	2024-05-12	13:36:00	4:36,	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	12.00	💕 Love it So Much	68.00	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.493674	2026-03-16 14:39:14.493674	f
5030	2024-05-13	00:55:00	9:42, 13:39, 18:04, 	Wet	axia	金罐8號 高湯 鰹魚	💖 Yes, eat right away	70.00	15.10	💕 Love it So Much	54.90	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.495681	2026-03-16 14:39:14.495681	f
5032	2024-05-13	10:50:00	20:45, 22:12, 00:23, 4:49\n	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	4.20	💕 Love it So Much	65.80	4	💖 - 💕	48	00:23 => 吃光/4:49 => 盤裡的削削吃	\N	2	\N	2026-03-16 14:39:14.499572	2026-03-16 14:39:14.499572	f
5033	2024-05-13	10:50:00	20:46, 00:25, 4:12, 4:49	Wet	axia	新金罐濃厚5號- 鮪, 柴 gnt-5	💖 Yes, eat right away	70.00	7.50	💕 Love it So Much	62.50	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.501178	2026-03-16 14:39:14.501178	f
5035	2024-05-14	00:15:00	9:55, 15:21, 15:43, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	1.40	💕 Love it So Much	73.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.504531	2026-03-16 14:39:14.504531	f
5037	2024-05-14	10:00:00	22:12, 00:19, 5:28, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	30.00	💕 Love it So Much	50.00	3	💖 - 💕	39	\N	\N	2	\N	2026-03-16 14:39:14.508551	2026-03-16 14:39:14.508551	f
5038	2024-05-14	10:00:00	-	Wet	ciao	柴魚鮮味餐包(鰹魚) ic-352	💖 Yes, eat right away	40.00	10.00	❌ No!!!	30.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-16 14:39:14.510424	2026-03-16 14:39:14.510424	f
5040	2024-05-14	13:47:00	22:13, 00:16, 5:29, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	26.60	💕 Love it So Much	58.40	3	💖 - 💕	39	\N	\N	2	\N	2026-03-16 14:39:14.514055	2026-03-16 14:39:14.514055	f
5041	2024-05-15	00:30:00	-	Wet	自然小貓	無膠肉湯罐 鮪魚魚湯	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	想辦法調整菜單的隨機性	\N	2	\N	2026-03-16 14:39:14.515853	2026-03-16 14:39:14.515853	f
5026	2024-05-12	10:10:00	-	Wet	法麗	室內貓排毛 鮪魚佐柴魚	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-16 14:39:14.488665	2026-03-16 14:44:43.57175	f
5023	2024-05-12	00:35:00	9:17, 15:34, 	Wet	法麗	微湯汁系列 天然嫩雞肉	💖 Yes, eat right away	80.00	8.40	💕 Love it So Much	71.60	2	💖 - 💕	44		\N	2	\N	2026-03-16 14:39:14.483577	2026-03-16 14:45:03.638891	f
5022	2024-05-11	10:39:00	20:32, 22:16, 3:53	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	44.00	8.80	🔺 So So	35.20	3	❌ - 🔺	26		\N	2	\N	2026-03-16 14:39:14.481198	2026-03-16 14:45:48.491654	f
5011	2024-05-09	10:05:00	21:27, 23:32, 4:25, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	34.20	7.70	🔺 So So	26.50	3	❌ - 🔺	26		\N	2	\N	2026-03-16 14:39:14.426548	2026-03-16 14:46:27.068382	f
5039	2024-05-14	10:00:00	22:10, 4:19, 5:25,	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	39.90	28.70	🔺 So So	11.20	3	❌ - 🔺	19		\N	2	\N	2026-03-16 14:39:14.512276	2026-03-16 14:46:36.410916	f
5019	2024-05-11	00:27:00	15:18, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.40	13.60	🔺 So So	6.80	1	❌ - 🔺	15		\N	2	\N	2026-03-16 14:39:14.439541	2026-03-16 14:46:45.912256	f
5034	2024-05-13	10:50:00	22:10, 00:20, 4:47, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	39.00	25.60	🔺 So So	13.40	3	❌ - 🔺	19		\N	2	\N	2026-03-16 14:39:14.50276	2026-03-16 14:46:56.571899	f
5014	2024-05-10	00:31:00	9:11, 9:55, 16:08, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.00	1.90	🔺 So So	18.10	3	❌ - 🔺	26		\N	2	\N	2026-03-16 14:39:14.43115	2026-03-16 14:47:05.929587	f
5024	2024-05-12	00:35:00	9:15, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.30	15.00	🔺 So So	5.30	1	❌ - 🔺	15	可能不喜歡目前的飼料？	\N	2	\N	2026-03-16 14:39:14.48522	2026-03-16 14:47:17.284768	f
5036	2024-05-14	00:15:00	9:53, 15:20, 15:45, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.00	9.60	🔺 So So	10.40	3	❌ - 🔺	19		\N	2	\N	2026-03-16 14:39:14.50645	2026-03-16 14:47:27.420405	f
5027	2024-05-12	10:10:00	19:11	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	75.20	71.70	🔺 So So	3.50	1	❌ - 🔺	15	19:15 吃到一半吐/19:18追加30.2 g	\N	2	\N	2026-03-16 14:39:14.490368	2026-03-16 14:47:37.24337	f
5031	2024-05-13	00:55:00	9:39, 13:37, 18:02, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.30	9.00	🔺 So So	11.30	3	❌ - 🔺	19		\N	2	\N	2026-03-16 14:39:14.497368	2026-03-16 14:47:47.574217	f
5008	2024-05-09	23:53:00	7:55, 8:19, 13:29, 15:53, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	💖 Yes, eat right away	20.30	3.80	🔺 So So	16.50	4	💖 - 🔺	38		\N	2	\N	2026-03-16 14:39:14.420642	2026-03-16 14:47:58.069208	f
5017	2024-05-10	10:10:00	18:50, 20:17, 22:52, 00:43, 4:47, 7:55, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	32.30	2.00	💕 Love it So Much	30.30	6	❌ - 💕	42	換成大包裝1.8kg (coupang訂購）	\N	2	\N	2026-03-16 14:39:14.436329	2026-03-16 14:48:21.29513	f
5044	2024-05-15	00:30:00	-	Freeze-Dried	法麗	天然原肉凍乾 鮪魚	💖 Yes, eat right away	2.00	0.00	💕 Love it So Much	2.00	0	💖 - 💕	40	\N	\N	2	\N	2026-03-16 14:39:14.520928	2026-03-16 14:39:14.520928	f
5046	2024-05-15	10:30:00	21:04, 4:01, 	Wet	奇境	野生鯖魚燉雞湯	❌ No, not interested	55.00	17.50	💕 Love it So Much	37.50	2	❌ - 💕	27	\N	\N	2	\N	2026-03-16 14:39:14.523935	2026-03-16 14:39:14.523935	f
5048	2024-05-15	11:02:00	-	Wet	惜時	in 機能湯 白身鮪魚&花枝&燒汁	🔺 No, not really. Ate A Little	80.00	60.00	❌ No!!!	20.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-16 14:39:14.527183	2026-03-16 14:39:14.527183	f
5049	2024-05-15	14:34:00	2:53, 	Wet	mon petit 貓倍麗	香烤鮮鮭 特尚品味主食餐包	💖 Yes, eat right away	50.00	26.00	🔺 So So	24.00	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-16 14:39:14.528814	2026-03-16 14:39:14.528814	f
5050	2024-05-16	00:40:00	-	Wet	axia	金罐2號 鰹魚 	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞後撥砂	\N	2	\N	2026-03-16 14:39:14.530516	2026-03-16 14:39:14.530516	f
5051	2024-05-16	00:40:00	10:10	Wet	ciao	旨定罐85號 (鮪魚+柴魚片)	🔺 No, not really. Ate A Little	85.00	40.00	🔺 So So	45.00	1	🔺 - 🔺	20	原本放地上, 吃沒幾口就跑來喵喵叫,後來改放在中島上, 吃得蠻久的	\N	2	\N	2026-03-16 14:39:14.532053	2026-03-16 14:39:14.532053	f
5053	2024-05-16	00:40:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	4.80	0.00	❌ No!!!	4.80	0	💖 - ❌	25	\N	\N	2	\N	2026-03-16 14:39:14.535135	2026-03-16 14:39:14.535135	f
5054	2024-05-16	09:00:00	17:05, 19:37, 20:44, 21:12, 4:02, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	31.70	9.10	💕 Love it So Much	22.60	5	❌ - 💕	33	\N	\N	2	\N	2026-03-16 14:39:14.536656	2026-03-16 14:39:14.536656	f
5055	2024-05-16	10:40:00	20:44, 22:48, 3:16, 4:40, 	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	🔺 No, not really. Ate A Little	114.00	72.30	🔺 So So	41.70	4	🔺 - 🔺	26	\N	\N	2	\N	2026-03-16 14:39:14.538207	2026-03-16 14:39:14.538207	f
5057	2024-05-16	10:40:00	19:38, 21:12, 	Wet	nuevo 新歡	魅惑主食餐包系列 - 7號美鮭拌鮮雞(nc01-071)	❌ No, not interested	85.00	52.00	🔺 So So	33.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.583274	2026-03-16 14:39:14.583274	f
5058	2024-05-17	00:35:00	9:25, 9:54,	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	9.10	6.50	🔺 So So	2.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.584971	2026-03-16 14:39:14.584971	f
5059	2024-05-17	00:35:00	9:26, 9:55, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	3.20	💕 Love it So Much	71.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.586612	2026-03-16 14:39:14.586612	f
5060	2024-05-17	07:50:00	23:40, 1:28, 3:54, 7:14, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	30.20	16.20	🔺 So So	14.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-16 14:39:14.588166	2026-03-16 14:39:14.588166	f
5061	2024-05-17	10:20:00	3:57, 7:15, 	Wet	axia	水分補給3號 - 鮪魚片狀	❌ No, not interested	40.00	21.70	🔺 So So	18.30	2	❌ - 🔺	17	更換為新萃 鮭魚	\N	2	\N	2026-03-16 14:39:14.589714	2026-03-16 14:39:14.589714	f
5062	2024-05-17	10:20:00	22:16, 23:42, 1:29, 	Wet	mama mia	貓餐罐(雞肉+白身鮪魚+蝦肉)	💖 Yes, eat right away	85.00	7.40	💕 Love it So Much	77.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.591313	2026-03-16 14:39:14.591313	f
5063	2024-05-18	23:40:00	8:12, 10:30, 	Wet	和罐	白身鮪魚 & 鮭魚	💖 Yes, eat right away	85.00	42.10	🔺 So So	42.90	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:14.592874	2026-03-16 14:39:14.592874	f
5064	2024-05-18	23:40:00	10:30, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.20	15.80	🔺 So So	4.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.594551	2026-03-16 14:39:14.594551	f
5065	2024-05-18	10:20:00	20:30, 23:01,	Wet	axia	津燒濃厚9號- 鮪, 雞, 柴 yz-9	💖 Yes, eat right away	70.00	0.90	💕 Love it So Much	69.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.59616	2026-03-16 14:39:14.59616	f
5066	2024-05-18	10:20:00	23:03, 4:06, 	Wet	axia	津燒濃厚10號- 鮪, 雞, 扇貝 yz-10	❌ No, not interested	70.00	14.60	💕 Love it So Much	55.40	2	❌ - 💕	34	\N	\N	2	\N	2026-03-16 14:39:14.597667	2026-03-16 14:39:14.597667	f
5067	2024-05-18	10:20:00	21:40, 4:03, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	46.10	27.90	🔺 So So	18.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.599167	2026-03-16 14:39:14.599167	f
5068	2024-05-19	00:30:00	9:03, 15:18, 17:17, 	Wet	carny	阿曼達 鮪魚+牛肉	🔺 No, not really. Ate A Little	80.00	24.50	💕 Love it So Much	55.50	3	🔺 - 💕	34	晚上準備進房的時候, 沒有咬我或想抓住我不讓我進去, 就默默地邊跟著我邊看我進房	\N	2	\N	2026-03-16 14:39:14.600717	2026-03-16 14:39:14.600717	f
5069	2024-05-19	00:30:00	17:17, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.60	16.50	🔺 So So	4.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.602306	2026-03-16 14:39:14.602306	f
5071	2024-05-19	11:20:00	3:24, 5:04, 	Wet	combo 吻饌	蒸煮餐包 鮪魚+鰹魚+干貝 (pnr-5)	💖 Yes, eat right away	40.00	23.40	🔺 So So	16.60	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:14.605973	2026-03-16 14:39:14.605973	f
5072	2024-05-19	11:20:00	5:00, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	47.30	29.30	🔺 So So	18.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.607663	2026-03-16 14:39:14.607663	f
5073	2024-05-20	00:20:00	14:43, 17:42, 	Wet	mon petit 貓倍麗	嚴選金罐 極品鮪魚真鯛(特選鯛魚塊)	💖 Yes, eat right away	85.00	5.40	💕 Love it So Much	79.60	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.609341	2026-03-16 14:39:14.609341	f
5074	2024-05-20	00:20:00	17:41, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.00	18.50	🔺 So So	1.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.611035	2026-03-16 14:39:14.611035	f
5075	2024-05-20	10:10:00	22:46, 4:35, 7:30, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	11.30	💕 Love it So Much	68.70	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.61287	2026-03-16 14:39:14.61287	f
5070	2024-05-19	11:20:00	21:28, 22:12, 3:22	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	1.60	💕 Love it So Much	78.40	3	💖 - 💕	46		\N	2	\N	2026-03-16 14:39:14.603958	2026-03-16 14:44:13.002161	f
5045	2024-05-15	10:30:00	4:27, 	Wet	petline	極品貓罐(z11)	❌ No, not interested	80.00	59.20	🔺 So So	20.80	1	❌ - 🔺	15		\N	2	\N	2026-03-16 14:39:14.522439	2026-03-16 14:44:33.395386	f
5056	2024-05-16	10:40:00	-	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	17.90	3.60	❌ No!!!	14.30	0	❌ - ❌	15	延續早上的量, 沒額外增加	\N	2	\N	2026-03-16 14:39:14.581286	2026-03-16 14:45:37.349062	f
5052	2024-05-16	00:40:00	15:38, 22:47, 3:12, 4:38	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.20	17.90	🔺 So So	2.30	4	❌ - 🔺	21		\N	2	\N	2026-03-16 14:39:14.53358	2026-03-16 14:45:58.651099	f
5047	2024-05-15	10:30:00	2:50, 3:58, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	💖 Yes, eat right away	42.80	27.70	🔺 So So	15.10	2	💖 - 🔺	27		\N	2	\N	2026-03-16 14:39:14.525454	2026-03-16 14:46:07.955969	f
5043	2024-05-15	00:30:00	9:32, 10:07, 16:03, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.50	12.80	🔺 So So	7.70	3	❌ - 🔺	19		\N	2	\N	2026-03-16 14:39:14.519331	2026-03-16 14:46:17.376293	f
5546	2026-03-21	06:35:00	-	Kibble	野性魅力	鮮鴨貓	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-21 06:42:54.041258	2026-03-22 01:13:45.146476	f
5076	2024-05-20	10:10:00	21:04, 22:47, 23:52, 7:33	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	6.60	💕 Love it So Much	73.40	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.614711	2026-03-16 14:39:14.614711	f
5077	2024-05-20	10:10:00	22:46, 4:32, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	48.70	43.30	🔺 So So	5.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.616514	2026-03-16 14:39:14.616514	f
5078	2024-05-21	00:15:00	17:06,	Wet	mama mia	貓餐罐(雞肉+白身鮪魚+南瓜)	🔺 No, not really. Ate A Little	85.00	48.10	🔺 So So	36.90	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-16 14:39:14.618387	2026-03-16 14:39:14.618387	f
5079	2024-05-21	00:15:00	17:04, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.00	14.60	🔺 So So	5.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.620368	2026-03-16 14:39:14.620368	f
5080	2024-05-21	10:15:00	22:35, 3:34, 	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	12.00	💕 Love it So Much	58.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.622213	2026-03-16 14:39:14.622213	f
5081	2024-05-21	10:15:00	22:36, 3:36, 4:13, 4:40, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	1.10	💕 Love it So Much	48.90	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.623886	2026-03-16 14:39:14.623886	f
5082	2024-05-21	10:15:00	4:12, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	36.30	34.70	🔺 So So	1.60	1	❌ - 🔺	15	陪玩約10分鐘	\N	2	\N	2026-03-16 14:39:14.625442	2026-03-16 14:39:14.625442	f
5083	2024-05-22	00:45:00	9:53, 12:09, 	Wet	惜時	in 機能湯 白身鮪魚&吻仔魚&燒汁	💖 Yes, eat right away	80.00	40.70	🔺 So So	39.30	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:14.626949	2026-03-16 14:39:14.626949	f
5084	2024-05-22	00:45:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.628505	2026-03-16 14:39:14.628505	f
5085	2024-05-22	09:35:00	20:58, 3:46, 7:35,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	2.40	💕 Love it So Much	82.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.631008	2026-03-16 14:39:14.631008	f
5086	2024-05-22	09:35:00	-	Wet	mon petit 貓倍麗	珍饌鮮鮪特尚品味主食餐包	💖 Yes, eat right away	50.00	25.90	❌ No!!!	24.10	0	💖 - ❌	18	\N	\N	2	\N	2026-03-16 14:39:14.632559	2026-03-16 14:39:14.632559	f
5087	2024-05-22	09:35:00	3:46, 7:36, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	40.40	38.80	🔺 So So	1.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.634137	2026-03-16 14:39:14.634137	f
5088	2024-05-23	23:55:00	11:11, 14:20\n	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	0.60	💕 Love it So Much	79.40	2	💖 - 💕	44	14:20 => 吃光	\N	2	\N	2026-03-16 14:39:14.635741	2026-03-16 14:39:14.635741	f
5089	2024-05-23	23:55:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	21.20	21.20	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.637262	2026-03-16 14:39:14.637262	f
5090	2024-05-23	09:10:00	19:17, 23:37, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	3.10	💕 Love it So Much	56.90	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.638835	2026-03-16 14:39:14.638835	f
5091	2024-05-23	09:10:00	23:34, 4:01,	Wet	axia	津燒濃厚8號- 鮪, 雞, 吻	❌ No, not interested	70.00	10.30	💕 Love it So Much	59.70	2	❌ - 💕	34	\N	\N	2	\N	2026-03-16 14:39:14.640348	2026-03-16 14:39:14.640348	f
5092	2024-05-23	09:10:00	23:32, 4:00, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	41.80	28.80	🔺 So So	13.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.642118	2026-03-16 14:39:14.642118	f
5093	2024-05-24	00:20:00	16:14, 	Wet	三洋食品	小玉傳說 無添加系列 鮪魚純罐	🔺 No, not really. Ate A Little	70.00	53.30	🔺 So So	16.70	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-16 14:39:14.643661	2026-03-16 14:39:14.643661	f
5094	2024-05-24	00:20:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.681333	2026-03-16 14:39:14.681333	f
5096	2024-05-24	09:00:00	17:58, 18:52, 22:13, 00:14,	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	0.80	💕 Love it So Much	49.20	4	💖 - 💕	48	00:14 => 吃光	\N	2	\N	2026-03-16 14:39:14.684845	2026-03-16 14:39:14.684845	f
5097	2024-05-24	09:00:00	17:55, 18:51, 4:20, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	40.00	7.90	🔺 So So	32.10	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-16 14:39:14.686669	2026-03-16 14:39:14.686669	f
5098	2024-05-25	00:15:00	9:44, 	Wet	和罐	白身鮪魚 & 鮭魚	🔺 No, not really. Ate A Little	85.00	35.40	🔺 So So	49.60	1	🔺 - 🔺	20	\N	5.20	2	\N	2026-03-16 14:39:14.688474	2026-03-16 14:39:14.688474	f
5099	2024-05-25	00:15:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.00	8.10	❌ No!!!	11.90	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.690265	2026-03-16 14:39:14.690265	f
5100	2024-05-25	10:13:00	20:08, 21:49, 3:18, 4:23, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	2.60	💕 Love it So Much	67.40	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.691839	2026-03-16 14:39:14.691839	f
5101	2024-05-25	10:13:00	20:08, 	Wet	mon petit 貓倍麗	珍饌鮮鮪特尚品味主食餐包	❌ No, not interested	50.00	21.30	🔺 So So	28.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.693567	2026-03-16 14:39:14.693567	f
5102	2024-05-25	10:13:00	21:49, 4:20, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	28.40	25.00	🔺 So So	3.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.695147	2026-03-16 14:39:14.695147	f
5103	2024-05-26	00:30:00	9:05, 9:34, 14:48, 	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	1.00	💕 Love it So Much	79.00	3	💖 - 💕	46	14:48 => 吃光/5/27 早上7:30有被咬, 推測可能前一晚的濕食不愛& 有點玩不起來(可能玩不夠)	\N	2	\N	2026-03-16 14:39:14.696876	2026-03-16 14:39:14.696876	f
5104	2024-05-26	00:30:00	16:56, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.00	17.10	🔺 So So	2.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.698696	2026-03-16 14:39:14.698696	f
5105	2024-05-26	09:05:00	20:07, 3:19, 7:41	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	22.70	💕 Love it So Much	57.30	3	💖 - 💕	39	\N	\N	2	\N	2026-03-16 14:39:14.700508	2026-03-16 14:39:14.700508	f
5106	2024-05-26	09:05:00	20:05, 3:21, 7:42	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	2.50	💕 Love it So Much	47.50	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.702637	2026-03-16 14:39:14.702637	f
5107	2024-05-26	09:05:00	7:40, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	37.10	36.10	🔺 So So	1.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.704483	2026-03-16 14:39:14.704483	f
5108	2024-05-27	00:35:00	9:57, 12:27, 16:35	Wet	carny	阿曼達 鮪魚+鯛魚	🔺 No, not really. Ate A Little	80.00	36.90	🔺 So So	43.10	3	🔺 - 🔺	24	\N	\N	2	\N	2026-03-16 14:39:14.706208	2026-03-16 14:39:14.706208	f
5109	2024-05-27	00:35:00	16:33, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	21.10	19.30	🔺 So So	1.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.708035	2026-03-16 14:39:14.708035	f
5110	2024-05-27	09:40:00	3:38, 7:39, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	💖 Yes, eat right away	75.00	3.40	💕 Love it So Much	71.60	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.709747	2026-03-16 14:39:14.709747	f
5111	2024-05-27	09:40:00	22:04, 3:39, 7:41, 	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	🔺 No, not really. Ate A Little	57.00	15.90	💕 Love it So Much	41.10	3	🔺 - 💕	34	\N	\N	2	\N	2026-03-16 14:39:14.711462	2026-03-16 14:39:14.711462	f
5112	2024-05-27	09:40:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	40.90	40.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.713238	2026-03-16 14:39:14.713238	f
5113	2024-05-28	00:33:00	15:00, 	Wet	sunrise	naturaha 無穀鮪魚主食餐包- 喵樂事 snh-020	❌ No, not interested	60.00	22.10	🔺 So So	37.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.715115	2026-03-16 14:39:14.715115	f
5114	2024-05-28	00:33:00	14:58, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.50	14.60	🔺 So So	5.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.716745	2026-03-16 14:39:14.716745	f
5115	2024-05-28	09:37:00	21:42, 4:46,	Wet	惜時	in 機能湯 白身鮪魚&蟹肉&燒汁 (幼貓)	🔺 No, not really. Ate A Little	80.00	56.00	🔺 So So	24.00	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-16 14:39:14.718425	2026-03-16 14:39:14.718425	f
5116	2024-05-28	09:37:00	21:41, 23:50, 4:45, 	Wet	奇境	野生鮪魚燉雞湯	💖 Yes, eat right away	55.00	2.00	💕 Love it So Much	53.00	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.720083	2026-03-16 14:39:14.720083	f
5117	2024-05-28	09:37:00	23:47, 4:44, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	35.80	26.50	🔺 So So	9.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.721725	2026-03-16 14:39:14.721725	f
5118	2024-05-29	00:30:00	14:34,	Wet	axia	妙喵16號片狀- 鮪, 干貝	💖 Yes, eat right away	70.00	30.00	🔺 So So	40.00	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-16 14:39:14.723444	2026-03-16 14:39:14.723444	f
5119	2024-05-29	00:30:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.20	20.20	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.725108	2026-03-16 14:39:14.725108	f
5120	2024-05-29	10:20:00	20:38, 3:44	Wet	axia	新金罐濃厚1號-鮪魚	💖 Yes, eat right away	70.00	36.30	🔺 So So	33.70	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:14.727124	2026-03-16 14:39:14.727124	f
5121	2024-05-29	10:20:00	20:36, 22:41, 3:44	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	2.60	💕 Love it So Much	57.40	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.728807	2026-03-16 14:39:14.728807	f
5122	2024-05-29	10:20:00	20:35, 22:40, 3:45, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	40.40	22.00	🔺 So So	18.40	3	❌ - 🔺	19	飼料有加柴魚片	\N	2	\N	2026-03-16 14:39:14.730496	2026-03-16 14:39:14.730496	f
5123	2024-05-30	00:30:00	-	Wet	三洋食品	小玉傳說 美食家貓罐 (鮪魚, 雞胸肉)	🔺 No, not really. Ate A Little	70.00	61.50	❌ No!!!	8.50	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-16 14:39:14.732179	2026-03-16 14:39:14.732179	f
5124	2024-05-30	01:06:00	15:26,	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	9.70	💕 Love it So Much	50.30	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.733867	2026-03-16 14:39:14.733867	f
5125	2024-05-30	01:06:00	15:23, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.60	14.90	🔺 So So	5.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.735474	2026-03-16 14:39:14.735474	f
5126	2024-05-30	09:30:00	18:14, 21:57, 23:48, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	1.30	💕 Love it So Much	83.70	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.737271	2026-03-16 14:39:14.737271	f
5127	2024-05-30	09:30:00	-	Wet	ciao	魚盛 大餐包 tcr-17(鮪魚+鰹魚)	💖 Yes, eat right away	60.00	53.50	❌ No!!!	6.50	0	💖 - ❌	18	\N	\N	2	\N	2026-03-16 14:39:14.738938	2026-03-16 14:39:14.738938	f
5128	2024-05-30	09:30:00	21:55, 00:25, 7:12, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	34.90	16.50	🔺 So So	18.40	3	❌ - 🔺	19	飼料有加柴魚片	\N	2	\N	2026-03-16 14:39:14.781218	2026-03-16 14:39:14.781218	f
5129	2024-05-31	00:19:00	-	Wet	ciao	旨定罐 c-55(鮭魚+雞肉+鮪魚+起司)	🔺 No, not really. Ate A Little	85.00	71.80	❌ No!!!	13.20	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-16 14:39:14.783099	2026-03-16 14:39:14.783099	f
5130	2024-05-31	01:41:00	14:43, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)        	💖 Yes, eat right away	75.00	13.30	💕 Love it So Much	61.70	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.784773	2026-03-16 14:39:14.784773	f
5131	2024-05-31	01:41:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.50	11.90	❌ No!!!	8.60	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.786459	2026-03-16 14:39:14.786459	f
5132	2024-05-31	09:45:00	23:48, 4:08, 7:55	Wet	axia	津燒3號- 鮪, 雞, 柴	💖 Yes, eat right away	70.00	13.90	💕 Love it So Much	56.10	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.787997	2026-03-16 14:39:14.787997	f
5133	2024-05-31	09:45:00	20:08, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	8.40	💕 Love it So Much	41.60	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.789696	2026-03-16 14:39:14.789696	f
5134	2024-05-31	09:45:00	17:42, 20:09, 4:07, 7:51, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	32.60	11.10	🔺 So So	21.50	4	❌ - 🔺	21	飼料有加柴魚片	\N	2	\N	2026-03-16 14:39:14.791387	2026-03-16 14:39:14.791387	f
5135	2024-06-01	00:30:00	16:08, 	Wet	惜時	in 機能湯 白身鮪魚&雞肉&燒汁(7歲中老貓)	❌ No, not interested	80.00	62.60	🔺 So So	17.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.792963	2026-03-16 14:39:14.792963	f
5136	2024-06-01	00:30:00	9:03, 12:04, 16:05, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.40	1.70	🔺 So So	18.70	3	❌ - 🔺	26	飼料有加柴魚片	\N	2	\N	2026-03-16 14:39:14.794541	2026-03-16 14:39:14.794541	f
5138	2024-06-01	10:00:00	18:46, 20:55, 	Wet	mon petit 貓倍麗	香烤鮮鮭特尚品味主食餐包	💖 Yes, eat right away	50.00	22.40	🔺 So So	27.60	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:14.797819	2026-03-16 14:39:14.797819	f
5139	2024-06-01	10:00:00	18:45, 1:18, 4:52, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	21.90	7.40	🔺 So So	14.50	3	❌ - 🔺	19	飼料有加柴魚片	\N	2	\N	2026-03-16 14:39:14.79956	2026-03-16 14:39:14.79956	f
5140	2024-06-02	00:15:00	10:54, 14:59, 15:51, 	Wet	sheba	鮪魚及鯛魚口味 餐包	💖 Yes, eat right away	70.00	3.60	💕 Love it So Much	66.40	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.80137	2026-03-16 14:39:14.80137	f
5141	2024-06-02	00:15:00	10:52, 14:58, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.20	12.30	🔺 So So	7.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.803325	2026-03-16 14:39:14.803325	f
5142	2024-06-02	10:20:00	22:15, 1:06, 4:14, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	5.80	💕 Love it So Much	74.20	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.804933	2026-03-16 14:39:14.804933	f
5143	2024-06-02	10:20:00	4:16, 7:17, 	Wet	奇境	無穀幼貓罐 鮪魚燉雞湯	💖 Yes, eat right away	55.00	22.40	🔺 So So	32.60	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:14.806491	2026-03-16 14:39:14.806491	f
5144	2024-06-02	10:20:00	22:13, 1:03, 4:12, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	33.10	19.30	🔺 So So	13.80	3	❌ - 🔺	19	飼料有加柴魚片	\N	2	\N	2026-03-16 14:39:14.808019	2026-03-16 14:39:14.808019	f
5145	2024-06-03	00:20:00	9:11, 14:41, 	Wet	nature 養生湯罐	白身鮪魚+蟹肉	💖 Yes, eat right away	80.00	32.80	🔺 So So	47.20	2	💖 - 🔺	27	吃完後約半個小時吐	\N	2	\N	2026-03-16 14:39:14.809473	2026-03-16 14:39:14.809473	f
5146	2024-06-03	00:20:00	11:36, 14:38, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	20.60	15.60	🔺 So So	5.00	2	❌ - 🔺	17	飼料有加柴魚片	\N	2	\N	2026-03-16 14:39:14.810937	2026-03-16 14:39:14.810937	f
5147	2024-06-03	09:35:00	19:52,  20:22, 23:43, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	2.10	💕 Love it So Much	67.90	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.81261	2026-03-16 14:39:14.81261	f
5148	2024-06-03	09:35:00	19:52, 23:47, 4:01, 	Wet	axia	新金罐濃厚5號- 鮪, 柴 gnt-5	💖 Yes, eat right away	70.00	21.80	💕 Love it So Much	48.20	3	💖 - 💕	39	\N	\N	2	\N	2026-03-16 14:39:14.814084	2026-03-16 14:39:14.814084	f
5149	2024-06-03	09:35:00	19:51, 3:59, 	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	38.20	26.30	🔺 So So	11.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.815501	2026-03-16 14:39:14.815501	f
5150	2024-06-03	12:35:00	21:33, 3:57, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	💖 Yes, eat right away	13.80	0.00	🔺 So So	13.80	2	💖 - 🔺	34	\N	\N	2	\N	2026-03-16 14:39:14.816997	2026-03-16 14:39:14.816997	f
5151	2024-06-04	00:25:00	8:50, 9:30, 14:36, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	15.70	5.30	🔺 So So	10.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.818504	2026-03-16 14:39:14.818504	f
5152	2024-06-04	00:25:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	21.30	21.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.820011	2026-03-16 14:39:14.820011	f
5153	2024-06-04	00:25:00	8:50, 9:30, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	1.20	💕 Love it So Much	73.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.821494	2026-03-16 14:39:14.821494	f
5154	2024-06-04	09:45:00	-	Kibble	新萃	pv 單一肉種 無穀 鮭魚+超級食物	❌ No, not interested	37.80	37.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.823149	2026-03-16 14:39:14.823149	f
5155	2024-06-04	09:45:00	21:57, 00:39, 8:02,	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	30.40	7.40	🔺 So So	23.00	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-16 14:39:14.824652	2026-03-16 14:39:14.824652	f
5156	2024-06-04	09:45:00	18:32, 21:59, 22:23, 00:41, 4:45, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	3.40	💕 Love it So Much	81.60	5	💖 - 💕	50	\N	\N	2	\N	2026-03-16 14:39:14.826388	2026-03-16 14:39:14.826388	f
5157	2024-06-04	09:45:00	4:44, 8:06, 	Wet	mon petit 貓倍麗	極上餐包 鮮鮪比目魚 lp13	❌ No, not interested	35.00	3.70	💕 Love it So Much	31.30	2	❌ - 💕	34	\N	\N	2	\N	2026-03-16 14:39:14.827962	2026-03-16 14:39:14.827962	f
5158	2024-06-05	00:27:00	-	Wet	卓越	無穀主食餐包- 成貓(鮭魚)	💖 Yes, eat right away	100.00	62.70	❌ No!!!	37.30	0	💖 - ❌	18	\N	\N	2	\N	2026-03-16 14:39:14.829433	2026-03-16 14:39:14.829433	f
5159	2024-06-05	00:27:00	14:26, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	10.00	🔺 So So	10.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.830925	2026-03-16 14:39:14.830925	f
5160	2024-06-05	09:30:00	18:20, 21:06, 4:25, 8:23	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	💖 Yes, eat right away	75.00	10.00	💕 Love it So Much	65.00	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.832477	2026-03-16 14:39:14.832477	f
5161	2024-06-05	09:30:00	21:05, 00:39, 4:26,	Wet	axia	津燒濃厚7號 - 鮪, 雞, 蟹棒	❌ No, not interested	70.00	22.80	💕 Love it So Much	47.20	3	❌ - 💕	29	\N	\N	2	\N	2026-03-16 14:39:14.834168	2026-03-16 14:39:14.834168	f
5162	2024-06-05	09:30:00	21:05, 00:38, 4:21, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	30.00	8.90	🔺 So So	21.10	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.835639	2026-03-16 14:39:14.835639	f
5163	2024-06-05	09:30:00	-	Other	petline	懷石系列 餅乾	💖 Yes, eat right away	4.70	0.00	❌ No!!!	4.70	0	💖 - ❌	25	\N	\N	2	\N	2026-03-16 14:39:14.837254	2026-03-16 14:39:14.837254	f
5165	2024-06-06	00:20:00	13:32, 15:16, 17:00, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.20	12.70	🔺 So So	7.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.840295	2026-03-16 14:39:14.840295	f
5167	2024-06-06	10:55:00	20:31, 4:16, 	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	💖 Yes, eat right away	57.00	11.40	💕 Love it So Much	45.60	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.843413	2026-03-16 14:39:14.843413	f
5168	2024-06-06	10:55:00	20:29, 00:45, 5:19,  	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	32.70	9.80	🔺 So So	22.90	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-16 14:39:14.845064	2026-03-16 14:39:14.845064	f
5169	2024-06-07	00:25:00	-	Wet	ginny 吉妮貓	鮮餐煲 鮪魚燴雞湯	💖 Yes, eat right away	70.00	32.30	❌ No!!!	37.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-16 14:39:14.846489	2026-03-16 14:39:14.846489	f
5170	2024-06-07	00:25:00	14:35, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.40	15.90	🔺 So So	4.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.847942	2026-03-16 14:39:14.847942	f
5171	2024-06-07	09:20:00	19:20, 20:57, 01:04, 4:19	Wet	ciao	豪華罐 a-144 鮪魚+雞肉+鰹魚乾	💖 Yes, eat right away	80.00	11.10	💕 Love it So Much	68.90	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.849432	2026-03-16 14:39:14.849432	f
5172	2024-06-07	09:20:00	18:03, 20:59, 22:48, 00:59	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	2.90	💕 Love it So Much	57.10	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.851106	2026-03-16 14:39:14.851106	f
5173	2024-06-07	09:20:00	22:49, 4:16, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	36.20	18.30	🔺 So So	17.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.881148	2026-03-16 14:39:14.881148	f
5174	2024-06-08	00:20:00	15:41, 16:12, 	Wet	惜時	in 機能湯 白身鮪魚&蝦肉&燒汁	💖 Yes, eat right away	80.00	31.80	🔺 So So	48.20	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:14.883095	2026-03-16 14:39:14.883095	f
5175	2024-06-08	00:20:00	8:55, 9:17, 15:40, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.60	2.30	🔺 So So	18.30	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-16 14:39:14.884685	2026-03-16 14:39:14.884685	f
5176	2024-06-08	09:30:00	4:26, 	Wet	axia	新金罐濃厚1號-鮪魚	💖 Yes, eat right away	70.00	11.80	💕 Love it So Much	58.20	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.886236	2026-03-16 14:39:14.886236	f
5177	2024-06-08	09:30:00	-	Wet	ciao	金湯杯 imc-136 鮪魚&柴魚片	💖 Yes, eat right away	70.00	46.00	❌ No!!!	24.00	0	💖 - ❌	18	\N	\N	2	\N	2026-03-16 14:39:14.887694	2026-03-16 14:39:14.887694	f
5178	2024-06-08	09:30:00	20:42, 1:12, 4:19, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	22.30	3.80	🔺 So So	18.50	3	❌ - 🔺	26	\N	\N	2	\N	2026-03-16 14:39:14.88921	2026-03-16 14:39:14.88921	f
5166	2024-06-06	10:55:00	00:46, 4:19, 5:24, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	💖 Yes, eat right away	80.00	27.60	💕 Love it So Much	52.40	3	💖 - 💕	39		\N	2	\N	2026-03-16 14:39:14.841911	2026-03-16 14:41:19.48309	f
5180	2024-06-09	22:30:00	15:46, 20:19,	Wet	sheba	金罐 鮪魚及鮭魚 (湯汁)	💖 Yes, eat right away	85.00	10.70	💕 Love it So Much	74.30	2	💖 - 💕	44		\N	2	\N	2026-03-16 14:39:14.89459	2026-03-19 03:20:51.674069	f
5184	2024-06-10	01:06:00	-	Wet	sunrise	naturaha 無穀鮪魚+鮭魚主食餐包 貓樂事snh-025	💖 Yes, eat right away	60.00	39.30	❌ No!!!	20.70	0	💖 - ❌	18	\N	\N	2	\N	2026-03-16 14:39:14.901159	2026-03-16 14:39:14.901159	f
5185	2024-06-10	01:06:00	9:35, 13:19, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	21.20	5.90	🔺 So So	15.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.90269	2026-03-16 14:39:14.90269	f
5187	2024-06-10	09:55:00	20:52, 4:30, 	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	💖 Yes, eat right away	60.00	7.90	💕 Love it So Much	52.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.905682	2026-03-16 14:39:14.905682	f
5188	2024-06-10	09:55:00	20:51, 4:27, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	26.30	7.10	🔺 So So	19.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.907304	2026-03-16 14:39:14.907304	f
5189	2024-06-11	00:30:00	-	Wet	combo 吻饌	蒸煮餐包 鮪魚+鰹魚+干貝 (pnr-5)	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.908843	2026-03-16 14:39:14.908843	f
5190	2024-06-11	00:30:00	-	Wet	combo 吻饌	蒸煮餐包 鮪魚+鰹魚+野菜 (pnr-4)	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.910366	2026-03-16 14:39:14.910366	f
5191	2024-06-11	01:40:00	16:09, 	Wet	ciao	原湯杯53號 (雞肉+蟹肉棒+柴魚片)	💖 Yes, eat right away	60.00	11.90	💕 Love it So Much	48.10	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.911906	2026-03-16 14:39:14.911906	f
5192	2024-06-11	01:40:00	8:41, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	18.90	🔺 So So	1.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.913447	2026-03-16 14:39:14.913447	f
5193	2024-06-11	09:25:00	20:25, 22:22, 3:52, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	25.20	💕 Love it So Much	54.80	3	💖 - 💕	39	\N	\N	2	\N	2026-03-16 14:39:14.915051	2026-03-16 14:39:14.915051	f
5194	2024-06-11	09:25:00	20:26, 22:23, 3:53, 8:33,	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	8.40	💕 Love it So Much	41.60	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:14.916519	2026-03-16 14:39:14.916519	f
5195	2024-06-11	09:25:00	20:24, 3:52, 7:29, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	39.10	26.30	🔺 So So	12.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.918252	2026-03-16 14:39:14.918252	f
5197	2024-06-12	00:30:00	14:27, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	21.20	12.10	🔺 So So	9.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.921303	2026-03-16 14:39:14.921303	f
5198	2024-06-12	09:25:00	19:40, 20:23, 23:33, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	4.70	💕 Love it So Much	75.30	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.922828	2026-03-16 14:39:14.922828	f
5199	2024-06-12	09:25:00	23:35, 	Wet	姆吉	8號 熱浪椰島貓湯包 - 鮪魚鰹魚	🔺 No, not really. Ate A Little	40.00	16.80	🔺 So So	23.20	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-16 14:39:14.924369	2026-03-16 14:39:14.924369	f
5200	2024-06-12	09:25:00	20:22, 21:32, 4:35, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	32.10	12.50	🔺 So So	19.60	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.925889	2026-03-16 14:39:14.925889	f
5201	2024-06-13	00:20:00	14:54, 	Wet	ginny 吉妮貓	鮮餐煲 鮪雞雙拼拌醬	💖 Yes, eat right away	70.00	10.00	💕 Love it So Much	60.00	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:14.927448	2026-03-16 14:39:14.927448	f
5202	2024-06-13	00:20:00	12:45, 14:53, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.20	8.90	🔺 So So	11.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.929264	2026-03-16 14:39:14.929264	f
5203	2024-06-13	09:40:00	23:53, 4:45, 	Wet	axia	新金罐濃厚6號- 鮪. 蟹棒	💖 Yes, eat right away	70.00	19.20	💕 Love it So Much	50.80	2	💖 - 💕	37	\N	\N	2	\N	2026-03-16 14:39:14.930835	2026-03-16 14:39:14.930835	f
5204	2024-06-13	09:40:00	18:45, 22:06, 4:43, 	Wet	axia	純罐21號- 鮪, 片狀	❌ No, not interested	65.00	38.30	🔺 So So	26.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.93235	2026-03-16 14:39:14.93235	f
5205	2024-06-13	09:40:00	4:08, 4:42, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	29.30	17.00	🔺 So So	12.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.934008	2026-03-16 14:39:14.934008	f
5206	2024-06-14	00:20:00	10:00, 	Wet	mon petit 貓倍麗	銀罐 鰹魚鮪魚(吞拿魚)及小鯷魚拼盤	💖 Yes, eat right away	80.00	47.60	🔺 So So	32.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-16 14:39:14.935625	2026-03-16 14:39:14.935625	f
5207	2024-06-14	00:20:00	9:59, 14:30, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.20	12.50	🔺 So So	7.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.9372	2026-03-16 14:39:14.9372	f
5208	2024-06-14	10:00:00	19:58, 20:50, 21:33, 00:14, 4:17, 	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	11.80	💕 Love it So Much	73.20	5	💖 - 💕	50	\N	\N	2	\N	2026-03-16 14:39:14.938987	2026-03-16 14:39:14.938987	f
5209	2024-06-14	10:00:00	19:56, 20:49, 21:35, 	Wet	ciao	燒湯杯71號(柴魚片+扇貝+雞肉) nc-71	💖 Yes, eat right away	60.00	5.60	💕 Love it So Much	54.40	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:14.94063	2026-03-16 14:39:14.94063	f
5210	2024-06-14	10:00:00	20:48, 00:13, 4:15, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	32.80	19.60	🔺 So So	13.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:14.942279	2026-03-16 14:39:14.942279	f
5211	2024-06-15	00:15:00	12:30, 	Wet	sheba	鮪魚, 雞肉及鰹魚片口味 餐包	💖 Yes, eat right away	70.00	21.90	💕 Love it So Much	48.10	1	💖 - 💕	35	\N	\N	2	\N	2026-03-16 14:39:14.98105	2026-03-16 14:39:14.98105	f
5212	2024-06-15	00:15:00	-	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.30	17.60	❌ No!!!	2.70	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:14.982732	2026-03-16 14:39:14.982732	f
5213	2024-06-15	09:15:00	18:00, 19:20, 23:22, 01:03, 4:25, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	9.00	💕 Love it So Much	71.00	5	💖 - 💕	50	\N	\N	2	\N	2026-03-16 14:39:14.984228	2026-03-16 14:39:14.984228	f
5214	2024-06-15	09:15:00	17:58, 19:18, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	2.40	💕 Love it So Much	47.60	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.985746	2026-03-16 14:39:14.985746	f
5215	2024-06-15	09:15:00	22:19, 23:22, 01:01, 4:24, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	37.90	22.70	🔺 So So	15.20	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-16 14:39:14.98742	2026-03-16 14:39:14.98742	f
5186	2024-06-10	09:55:00	3:01, 4:29, 	Wet	法麗	全營養主食罐 關節保健 鮪魚佐番茄	💖 Yes, eat right away	80.00	20.20	💕 Love it So Much	59.80	2	💖 - 💕	37		\N	2	\N	2026-03-16 14:39:14.904206	2026-03-16 14:40:58.370215	f
5183	2024-06-09	16:42:00	6:24, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	26.10	20.50	🔺 So So	5.60	1	❌ - 🔺	15		\N	2	\N	2026-03-16 14:39:14.899641	2026-03-19 03:21:07.453823	f
5181	2024-06-09	22:30:00	15:43, 17:41,	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	35.00	15.80	🔺 So So	19.20	2	❌ - 🔺	17		\N	2	\N	2026-03-16 14:39:14.89642	2026-03-19 03:21:17.761037	f
5182	2024-06-09	16:42:00	01:05, 6:25, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	15.50	💕 Love it So Much	64.50	2	💖 - 💕	44		\N	2	\N	2026-03-16 14:39:14.898142	2026-03-19 03:22:15.197815	f
5216	2024-06-16	00:20:00	13:47, 16:50	Wet	竣寶	經典貓罐 - 雞肉+鮮蝦	💖 Yes, eat right away	70.00	5.90	💕 Love it So Much	64.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.988946	2026-03-16 14:39:14.988946	f
5217	2024-06-16	00:20:00	13:46, 16:50\n	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	19.80	11.10	🔺 So So	8.70	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:14.990521	2026-03-16 14:39:14.990521	f
5219	2024-06-16	10:00:00	22:02, 1:05, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	1.00	💕 Love it So Much	59.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:14.993731	2026-03-16 14:39:14.993731	f
5220	2024-06-16	10:00:00	4:17, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	32.70	21.40	🔺 So So	11.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.995324	2026-03-16 14:39:14.995324	f
5221	2024-06-17	00:20:00	10:02, 	Wet	克勞德博士	菲力貓罐 3號 鮪魚雞肉	💖 Yes, eat right away	70.00	30.60	🔺 So So	39.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-16 14:39:14.996945	2026-03-16 14:39:14.996945	f
5222	2024-06-17	00:20:00	14:59, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.50	18.80	🔺 So So	1.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:14.998565	2026-03-16 14:39:14.998565	f
5223	2024-06-17	09:34:00	22:01, 	Wet	mon petit 貓倍麗	嚴選金罐鮮燴鰹魚大餐 (嚴選鰹魚塊)	💖 Yes, eat right away	85.00	36.30	🔺 So So	48.70	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-16 14:39:15.000122	2026-03-16 14:39:15.000122	f
5224	2024-06-17	09:34:00	00:42, 4:27, 	Wet	mon petit 貓倍麗	珍饌雞里肌肉餐盒 lc4	❌ No, not interested	57.00	34.00	🔺 So So	23.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:15.001663	2026-03-16 14:39:15.001663	f
5225	2024-06-17	09:34:00	4:25, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	39.00	31.50	🔺 So So	7.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.003182	2026-03-16 14:39:15.003182	f
5226	2024-06-17	11:18:00	-	Kibble	囍碗	lbc3 全齡貓 鯡魚鮭魚大西洋龍蝦(3號)	💖 Yes, eat right away	28.00	25.30	❌ No!!!	2.70	0	💖 - ❌	18	19:30 在茶几上一直叫(感覺像是沒吃飽), 因為早上飼料只吃了1.7公斤, 推測可能吃膩pure luxe, 所以放了囍碗順便測試口味喜好	\N	2	\N	2026-03-16 14:39:15.00463	2026-03-16 14:39:15.00463	f
5227	2024-06-18	00:15:00	9:16, 14:41, 	Wet	axia	妙喵11號片狀 - 鮪魚 mmf-11	💖 Yes, eat right away	70.00	10.60	💕 Love it So Much	59.40	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.006164	2026-03-16 14:39:15.006164	f
5228	2024-06-18	00:15:00	14:40, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.40	11.40	🔺 So So	9.00	1	❌ - 🔺	15	15:30 改換長褲, 拿掉腳套/早上11:00有拿掉腳套走動(阿吉在睡覺）	\N	2	\N	2026-03-16 14:39:15.007631	2026-03-16 14:39:15.007631	f
5229	2024-06-18	09:30:00	18:48, 22:24, 00:42, 7;22, 	Wet	axia	新金罐濃厚7號- 鮪, 牛	💖 Yes, eat right away	70.00	23.70	💕 Love it So Much	46.30	4	💖 - 💕	41	\N	\N	2	\N	2026-03-16 14:39:15.009257	2026-03-16 14:39:15.009257	f
5230	2024-06-18	09:30:00	18:49, 22:24, 00:40, 7:21,	Wet	sheba	鮪魚及鯛魚口味 餐包	💖 Yes, eat right away	70.00	12.60	💕 Love it So Much	57.40	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:15.010832	2026-03-16 14:39:15.010832	f
5231	2024-06-18	09:30:00	22:23, 00:39, 7:20,	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	32.90	22.50	🔺 So So	10.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:15.012452	2026-03-16 14:39:15.012452	f
5232	2024-06-19	00:30:00	8:55, 9:40, 	Wet	ginny 吉妮貓	鮮餐煲 5號 飽滿鮪魚拌醬	💖 Yes, eat right away	70.00	8.90	💕 Love it So Much	61.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.01403	2026-03-16 14:39:15.01403	f
5233	2024-06-19	00:30:00	14:47, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.50	18.40	🔺 So So	2.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.015542	2026-03-16 14:39:15.015542	f
5234	2024-06-19	09:20:00	18:20, 22:08, 00:22, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	1.80	💕 Love it So Much	58.20	3	💖 - 💕	46	00:22 => 吃光	\N	2	\N	2026-03-16 14:39:15.017059	2026-03-16 14:39:15.017059	f
5235	2024-06-19	09:20:00	00:26, 1:02, 4:44, 7:25,	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	💖 Yes, eat right away	85.00	17.40	💕 Love it So Much	67.60	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:15.018561	2026-03-16 14:39:15.018561	f
5236	2024-06-19	09:20:00	22:08, 00:22, 4:41, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	38.40	23.20	🔺 So So	15.20	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:15.020923	2026-03-16 14:39:15.020923	f
5237	2024-06-19	13:50:00	-	Kibble	囍碗	囍碗 lbc2 全齡貓 雞肉雪蟹(2號)	❌ No, not interested	27.70	27.70	❌ No!!!	0.00	0	❌ - ❌	8	推測可能pure luxe吃膩？ 看我起身, 一直叫, 回頭頻率變低	\N	2	\N	2026-03-16 14:39:15.022489	2026-03-16 14:39:15.022489	f
5239	2024-06-20	01:00:00	14:40, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	11.50	🔺 So So	38.50	1	💖 - 🔺	32	\N	\N	2	\N	2026-03-16 14:39:15.025614	2026-03-16 14:39:15.025614	f
5240	2024-06-20	01:00:00	14:39, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	13.30	🔺 So So	6.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.027138	2026-03-16 14:39:15.027138	f
5241	2024-06-20	08:50:00	19:52, 22:17, 7:16, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	3.90	💕 Love it So Much	56.10	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:15.028585	2026-03-16 14:39:15.028585	f
5242	2024-06-20	08:50:00	19:52, 22:15, 00:54, 4:24, 7:18, 	Wet	ciao	豪華罐 a-144 鮪魚+雞肉+鰹魚乾	💖 Yes, eat right away	80.00	14.40	💕 Love it So Much	65.60	5	💖 - 💕	50	\N	\N	2	\N	2026-03-16 14:39:15.030111	2026-03-16 14:39:15.030111	f
5243	2024-06-20	08:50:00	4:24, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	33.30	23.20	🔺 So So	10.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.031847	2026-03-16 14:39:15.031847	f
5244	2024-06-21	00:10:00	8:48, 15:23, 16:19, 	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	6.60	💕 Love it So Much	73.40	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:15.03338	2026-03-16 14:39:15.03338	f
5245	2024-06-21	00:10:00	12:55,	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	18.00	🔺 So So	2.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.034845	2026-03-16 14:39:15.034845	f
5246	2024-06-21	09:30:00	22:50, 4:18, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	29.00	🔺 So So	41.00	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-16 14:39:15.03631	2026-03-16 14:39:15.03631	f
5247	2024-06-21	09:30:00	00:26, 4:18, 7:23, 	Wet	mon petit 貓倍麗	嚴選鮮味鰹魚餐盒 lc2	🔺 No, not really. Ate A Little	57.00	27.80	🔺 So So	29.20	3	🔺 - 🔺	24	\N	\N	2	\N	2026-03-16 14:39:15.037765	2026-03-16 14:39:15.037765	f
5248	2024-06-21	09:30:00	19:00, 00:28, 7:22, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	38.60	15.20	🔺 So So	23.40	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-16 14:39:15.039274	2026-03-16 14:39:15.039274	f
5284	2024-06-27	08:30:00	19:10, 21:11, 00:53, 	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	1.70	💕 Love it So Much	68.30	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:15.12512	2026-03-16 14:39:15.12512	f
5249	2024-06-22	00:10:00	8:26, 9:40, 	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	25.30	💕 Love it So Much	54.70	2	💖 - 💕	37	新增紐崔斯飼料, 懷疑可能pure luxe吃膩或原本不是很愛？	\N	2	\N	2026-03-16 14:39:15.04076	2026-03-16 14:39:15.04076	f
5250	2024-06-22	00:10:00	-	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.20	20.20	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:15.042594	2026-03-16 14:39:15.042594	f
5251	2024-06-22	00:10:00	8:23, 13:20, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	15.80	6.30	🔺 So So	9.50	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:15.044292	2026-03-16 14:39:15.044292	f
5253	2024-06-22	09:20:00	20:55, 21:52, 00:09, 3:58, 7:04, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	3.00	💕 Love it So Much	47.00	5	💖 - 💕	50	\N	\N	2	\N	2026-03-16 14:39:15.047446	2026-03-16 14:39:15.047446	f
5254	2024-06-22	09:20:00	00:04,	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	35.80	33.80	🔺 So So	2.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.048919	2026-03-16 14:39:15.048919	f
5255	2024-06-22	09:20:00	17:23, 00:05, 3:54, 6:38, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	26.30	3.50	🔺 So So	22.80	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-16 14:39:15.050394	2026-03-16 14:39:15.050394	f
5256	2024-06-23	00:04:00	8:50, 14:53, 	Wet	mon petit 貓倍麗	嚴選金罐 極品鮪魚真鯛(特選鯛魚塊)	💖 Yes, eat right away	85.00	25.30	💕 Love it So Much	59.70	2	💖 - 💕	37	\N	\N	2	\N	2026-03-16 14:39:15.052162	2026-03-16 14:39:15.052162	f
5257	2024-06-23	00:04:00	8:06, 9:48, 17:11, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	💖 Yes, eat right away	20.80	3.70	🔺 So So	17.10	3	💖 - 🔺	36	\N	\N	2	\N	2026-03-16 14:39:15.080973	2026-03-16 14:39:15.080973	f
5258	2024-06-23	00:04:00	-	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.70	19.80	❌ No!!!	0.90	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:15.082619	2026-03-16 14:39:15.082619	f
5259	2024-06-23	09:15:00	19:25, 22:48, 5:30, 	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	4.00	💕 Love it So Much	56.00	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:15.08416	2026-03-16 14:39:15.08416	f
5260	2024-06-23	09:15:00	19:26, 22:46, 	Wet	ciao	旨定濃湯罐系列 a-234 (鮪魚+雞肉+吻仔魚)	💖 Yes, eat right away	75.00	14.80	💕 Love it So Much	60.20	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.085661	2026-03-16 14:39:15.085661	f
5261	2024-06-23	09:15:00	2:11, 6:45, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	24.10	6.90	🔺 So So	17.20	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:15.087189	2026-03-16 14:39:15.087189	f
5262	2024-06-23	09:15:00	6:48, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	40.80	38.30	🔺 So So	2.50	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.08871	2026-03-16 14:39:15.08871	f
5263	2024-06-24	00:20:00	-	Wet	nature 養生湯罐	白身鮪魚+鮮蝦	🔺 No, not really. Ate A Little	80.00	63.00	❌ No!!!	17.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-16 14:39:15.090819	2026-03-16 14:39:15.090819	f
5264	2024-06-24	00:20:00	16:11, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	20.30	12.30	🔺 So So	8.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.092407	2026-03-16 14:39:15.092407	f
5265	2024-06-24	00:20:00	-	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.20	19.10	❌ No!!!	1.10	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:15.093938	2026-03-16 14:39:15.093938	f
5266	2024-06-24	00:50:00	16:13, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	16.40	💕 Love it So Much	43.60	1	💖 - 💕	35	\N	\N	2	\N	2026-03-16 14:39:15.095551	2026-03-16 14:39:15.095551	f
5267	2024-06-24	08:30:00	00:20, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	38.90	36.90	🔺 So So	2.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.097118	2026-03-16 14:39:15.097118	f
5268	2024-06-24	08:30:00	20:24, 21:43, 00:21, 3:38, 6:12, 	Kibble	紐崔斯	黑鑽頂級無穀貓+凍乾 火雞肉+雞肉+鮭魚	❌ No, not interested	35.90	15.30	🔺 So So	20.60	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-16 14:39:15.098594	2026-03-16 14:39:15.098594	f
5269	2024-06-24	08:30:00	-	Wet	sheba	金罐 鮪魚及鮭魚 (湯汁)	🔺 No, not really. Ate A Little	85.00	48.70	❌ No!!!	36.30	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-16 14:39:15.100075	2026-03-16 14:39:15.100075	f
5270	2024-06-24	09:50:00	-	Wet	迷幻喵	4號 好火雞+蒸南瓜+貓草	🔺 No, not really. Ate A Little	125.00	99.00	❌ No!!!	26.00	0	🔺 - ❌	13	\N	\N	2	\N	2026-03-16 14:39:15.101737	2026-03-16 14:39:15.101737	f
5271	2024-06-24	12:30:00	21:44, 23:53, 3:39, 6:14, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	10.20	💕 Love it So Much	39.80	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:15.103259	2026-03-16 14:39:15.103259	f
5272	2024-06-25	00:20:00	9:41, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	12.30	💕 Love it So Much	67.70	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:15.104747	2026-03-16 14:39:15.104747	f
5273	2024-06-25	00:20:00	14:51, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.30	16.40	🔺 So So	3.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.106286	2026-03-16 14:39:15.106286	f
5274	2024-06-25	09:00:00	20:01, 6:47, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	17.70	💕 Love it So Much	62.30	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.10773	2026-03-16 14:39:15.10773	f
5275	2024-06-25	09:00:00	20:00, 23:16, 	Wet	ciao	原湯杯52號(鮪+蟹+小魚)	💖 Yes, eat right away	60.00	12.40	💕 Love it So Much	47.60	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.109195	2026-03-16 14:39:15.109195	f
5276	2024-06-25	09:00:00	23:35, 3:42, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	37.00	24.00	🔺 So So	13.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:15.110624	2026-03-16 14:39:15.110624	f
5277	2024-06-26	00:20:00	14:16	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)        	💖 Yes, eat right away	75.00	5.60	💕 Love it So Much	69.40	1	💖 - 💕	42	\N	\N	2	\N	2026-03-16 14:39:15.112613	2026-03-16 14:39:15.112613	f
5278	2024-06-26	00:20:00	-	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.50	20.50	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:15.114365	2026-03-16 14:39:15.114365	f
5279	2024-06-26	09:30:00	7:11	Wet	ginny 吉妮貓	鮮餐煲 5號 飽滿鮪魚拌醬	🔺 No, not really. Ate A Little	70.00	39.00	🔺 So So	31.00	1	🔺 - 🔺	20	\N	\N	2	\N	2026-03-16 14:39:15.11613	2026-03-16 14:39:15.11613	f
5280	2024-06-26	09:30:00	18:42, 21:41, 00:42, 4:00	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	💖 Yes, eat right away	50.00	1.20	💕 Love it So Much	48.80	4	💖 - 💕	48	\N	\N	2	\N	2026-03-16 14:39:15.117854	2026-03-16 14:39:15.117854	f
5281	2024-06-26	09:30:00	21:40, 00:40, 3:59, 7:08, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	40.50	15.80	🔺 So So	24.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-16 14:39:15.119554	2026-03-16 14:39:15.119554	f
5282	2024-06-27	00:15:00	8:58, 14:56	Wet	ciao	豪華雞三味餐包 ic-532 (干貝口味)	💖 Yes, eat right away	60.00	3.40	💕 Love it So Much	56.60	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.121265	2026-03-16 14:39:15.121265	f
5283	2024-06-27	00:15:00	-	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-16 14:39:15.122949	2026-03-16 14:39:15.122949	f
5285	2024-06-27	08:30:00	4:42, 	Wet	mon petit 貓倍麗	鰹魚鮮雞雙拼餐盒 lc3	🔺 No, not really. Ate A Little	57.00	18.60	💕 Love it So Much	38.40	1	🔺 - 💕	30	\N	\N	2	\N	2026-03-16 14:39:15.127009	2026-03-16 14:39:15.127009	f
5286	2024-06-27	08:30:00	16:32, 19:09, 00:51, 4:41, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	40.00	11.00	🔺 So So	29.00	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-16 14:39:15.128719	2026-03-16 14:39:15.128719	f
5287	2024-06-28	00:15:00	15:31, 	Wet	mon petit 貓倍麗	嚴選金罐鮮燴鰹魚大餐 (嚴選鰹魚塊)	🔺 No, not really. Ate A Little	85.00	45.40	🔺 So So	39.60	1	🔺 - 🔺	20	9:30 咬人 => 是否沒吃飽？9:20坐下準備休息時, 一直喵喵叫/被咬的原因, 可能是靠太近快速移動被咬	\N	2	\N	2026-03-16 14:39:15.130261	2026-03-16 14:39:15.130261	f
5288	2024-06-28	00:15:00	15:31, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.50	11.40	🔺 So So	9.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.13187	2026-03-16 14:39:15.13187	f
5289	2024-06-28	09:40:00	23:44, 8:00, 	Wet	竣寶	經典貓罐 - 雞肉+鮮蝦	🔺 No, not really. Ate A Little	70.00	28.50	🔺 So So	41.50	2	🔺 - 🔺	22	\N	\N	2	\N	2026-03-16 14:39:15.133392	2026-03-16 14:39:15.133392	f
5290	2024-06-28	09:40:00	21:13, 7:59,	Wet	ciao	原湯杯51號(鮪+蟹+鰹)        	💖 Yes, eat right away	60.00	5.00	💕 Love it So Much	55.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.134981	2026-03-16 14:39:15.134981	f
5291	2024-06-28	09:40:00	00:06, 4:25, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	31.40	13.50	🔺 So So	17.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:15.136906	2026-03-16 14:39:15.136906	f
5292	2024-06-29	00:15:00	10:07, 10:49, 16:36,	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	4.10	💕 Love it So Much	75.90	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:15.13843	2026-03-16 14:39:15.13843	f
5293	2024-06-29	00:15:00	14:46, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	18.10	🔺 So So	1.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.139941	2026-03-16 14:39:15.139941	f
5295	2024-06-29	08:50:00	21:29, 22:43, 00:51, 	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	🔺 No, not really. Ate A Little	50.00	2.80	💕 Love it So Much	47.20	3	🔺 - 💕	41	\N	\N	2	\N	2026-03-16 14:39:15.142935	2026-03-16 14:39:15.142935	f
5296	2024-06-29	08:50:00	00:48, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	38.60	24.20	🔺 So So	14.40	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.144449	2026-03-16 14:39:15.144449	f
5297	2024-06-30	00:15:00	9:39, 15:04, 	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)        	💖 Yes, eat right away	75.00	7.60	💕 Love it So Much	67.40	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.147029	2026-03-16 14:39:15.147029	f
5298	2024-06-30	00:15:00	9:38, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	20.00	18.20	🔺 So So	1.80	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-16 14:39:15.148902	2026-03-16 14:39:15.148902	f
5299	2024-06-30	09:00:00	21:39, 23:14, 7:39, 	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	17.20	💕 Love it So Much	62.80	3	💖 - 💕	46	\N	\N	2	\N	2026-03-16 14:39:15.150531	2026-03-16 14:39:15.150531	f
5300	2024-06-30	09:00:00	21:41, 4:09, 	Wet	ciao	燒湯杯 nc-72(宗田鰹魚+雞肉+干貝)	💖 Yes, eat right away	60.00	14.80	💕 Love it So Much	45.20	2	💖 - 💕	44	\N	\N	2	\N	2026-03-16 14:39:15.152119	2026-03-16 14:39:15.152119	f
5301	2024-06-30	09:00:00	23:11, 4:06, 	Kibble	pure luxe 純華	室內全齡貓糧 鮭魚&豌豆	❌ No, not interested	38.40	14.00	🔺 So So	24.40	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-16 14:39:15.153721	2026-03-16 14:39:15.153721	f
5294	2024-06-29	08:50:00	6:52, 8:12, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	🔺 No, not really. Ate A Little	80.00	27.30	💕 Love it So Much	52.70	2	🔺 - 💕	32		\N	2	\N	2026-03-16 14:39:15.141429	2026-03-16 14:39:41.885565	f
5252	2024-06-22	09:20:00	3:59, 7:01	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	🔺 No, not really. Ate A Little	80.00	33.00	🔺 So So	47.00	2	🔺 - 🔺	22		\N	2	\N	2026-03-16 14:39:15.045926	2026-03-16 14:39:56.444869	f
5196	2024-06-12	00:30:00	-	Wet	petline	懷石貓罐(k21) 鮪魚, 雞肉,  牛肉	💖 Yes, eat right away	80.00	47.20	❌ No!!!	32.80	0	💖 - ❌	18		\N	2	\N	2026-03-16 14:39:14.919777	2026-03-16 14:40:23.289125	f
5025	2024-05-12	10:10:00	00:03, 4:34,	Wet	法麗	室內貓排毛 鮪魚佐鮭魚	🔺 No, not really. Ate A Little	80.00	50.40	🔺 So So	29.60	2	🔺 - 🔺	22		\N	2	\N	2026-03-16 14:39:14.486998	2026-03-16 14:43:51.593966	f
5238	2024-06-20	00:10:00	-	Wet	法麗	室內貓排毛 鮪魚佐蟹肉	🔺 No, not really. Ate A Little	80.00	58.30	❌ No!!!	21.70	0	🔺 - ❌	13		\N	2	\N	2026-03-16 14:39:15.024003	2026-03-16 14:40:11.175675	f
5218	2024-06-16	10:00:00	1:03, 4:14, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	💖 Yes, eat right away	80.00	24.70	💕 Love it So Much	55.30	2	💖 - 💕	37		\N	2	\N	2026-03-16 14:39:14.992205	2026-03-16 14:40:46.434329	f
5164	2024-06-06	00:20:00	13:33, 17:00, 	Wet	petline	懷石貓罐(k12)	🔺 No, not really. Ate A Little	80.00	51.20	🔺 So So	28.80	2	🔺 - 🔺	22		\N	2	\N	2026-03-16 14:39:14.838755	2026-03-16 14:41:09.447324	f
5137	2024-06-01	10:00:00	20:51, 23:09, 1:16, 4:54, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	💖 Yes, eat right away	80.00	2.10	💕 Love it So Much	77.90	4	💖 - 💕	48		\N	2	\N	2026-03-16 14:39:14.796141	2026-03-16 14:41:29.566347	f
5042	2024-05-15	00:30:00	9:33, 16:05, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	🔺 No, not really. Ate A Little	80.00	32.10	🔺 So So	47.90	2	🔺 - 🔺	22		\N	2	\N	2026-03-16 14:39:14.517518	2026-03-16 14:43:29.779855	f
5003	2024-05-08	10:20:00	21:09, 22:37, 22:57, 4:17, 7:29,	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	💖 Yes, eat right away	160.00	37.50	💕 Love it So Much	122.50	5	💖 - 💕	50	一樣比平時更peace, 六點多吃完就跑去洗澡睡覺了, 睡到八點半, 陪玩約30分鐘/21:06 吃完就又跑去睡覺了	\N	2	\N	2026-03-16 14:39:14.412807	2026-03-16 14:44:01.088893	f
5095	2024-05-24	09:00:00	4:23, 	Wet	法麗	室內貓排毛 鮪魚佐鮮蝦	❌ No, not interested	80.00	51.80	🔺 So So	28.20	1	❌ - 🔺	15		\N	2	\N	2026-03-16 14:39:14.683234	2026-03-17 08:21:33.997926	f
2091	2025-07-30	00:42:00	14:31, 	Wet	法麗	室內貓排毛 鮪魚佐鮮蝦	💖 Yes, eat right away	80.00	39.50	🔺 So So	40.50	1	💖 - 🔺	25		\N	2	\N	2026-03-04 11:51:07.298855	2026-03-17 08:21:22.891534	f
3621	2024-12-19	01:00:00	-	Wet	petline	蒸煮鮪魚雞肉 高湯 kp7	💖 Yes, eat right away	40.00	18.70	❌ No!!!	21.30	0	💖 - ❌	18		\N	2	\N	2026-03-12 15:17:01.454676	2026-03-17 09:21:08.861608	f
5307	2024-03-27	00:40:00	9:20, 9:40, 15:28, 18:18	Wet	金湯	愛貓湯罐 白身鮪魚&雞肉	🔺 No, not really. Ate A Little	80.00	5.20	💕 Love it So Much	74.80	4	🔺 - 💕	43	2/28 => 5.05kg/(目標) 220g濕食/3:30 有咬人,但只持續5-10分鐘左右/在走廊等, 但罐頭一放下去, 馬上跑過來/seed's 愛貓湯罐, 一開始有吃但沒吃很多, 來回吃了超過一半	\N	2	\N	2026-03-17 09:24:16.382093	2026-03-17 09:24:16.382093	f
5308	2024-03-27	00:40:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.388222	2026-03-17 09:24:16.388222	f
5309	2024-03-27	00:40:00	-	Kibble	本牧	非籠飼育雞	❌ No, not interested	5.70	5.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.39307	2026-03-17 09:24:16.39307	f
5310	2024-03-27	00:40:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	4.80	0.00	💕 Love it So Much	4.80	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.396187	2026-03-17 09:24:16.396187	f
5311	2024-03-27	10:30:00	19:02, 19:36, 20:58	Wet	喵樂	喵罐 嫩雞鮪魚燒	💖 Yes, eat right away	160.00	89.50	🔺 So So	70.50	3	💖 - 🔺	29	\N	\N	2	\N	2026-03-17 09:24:16.401205	2026-03-17 09:24:16.401205	f
5312	2024-03-27	10:30:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	45.70	14.60	💕 Love it So Much	31.10	0	❌ - 💕	23	\N	\N	2	\N	2026-03-17 09:24:16.404581	2026-03-17 09:24:16.404581	f
5313	2024-03-27	10:30:00	-	Kibble	本牧	非籠飼育雞	❌ No, not interested	10.90	10.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.407899	2026-03-17 09:24:16.407899	f
5314	2024-03-28	00:40:00	9:36, 10:17	Wet	nature 養生湯罐	雞肉+鮭魚	💖 Yes, eat right away	80.00	35.20	🔺 So So	44.80	2	💖 - 🔺	27	3:30有抓人一次, 起身包紮傷口後, 關房門/5:30 再跑來咬人, 一樣起身關房門/7:30 在旁邊喵喵叫, 有咬一下	\N	2	\N	2026-03-17 09:24:16.411762	2026-03-17 09:24:16.411762	f
5315	2024-03-28	00:40:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	15.70	11.30	🔺 So So	4.40	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.419597	2026-03-17 09:24:16.419597	f
5316	2024-03-28	00:40:00	-	Kibble	本牧	非籠飼育雞	❌ No, not interested	4.80	4.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.42498	2026-03-17 09:24:16.42498	f
5317	2024-03-28	10:30:00	19:06, 20:33	Wet	喵樂	喵罐 鮭魚鮪魚燒	💖 Yes, eat right away	160.00	79.80	🔺 So So	80.20	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-17 09:24:16.434064	2026-03-17 09:24:16.434064	f
5318	2024-03-28	10:30:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	36.70	19.30	🔺 So So	17.40	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.438597	2026-03-17 09:24:16.438597	f
5319	2024-03-28	10:30:00	-	Kibble	天然密碼	無穀鮭魚 鯡魚和曼哈頓魚	❌ No, not interested	5.00	5.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.441892	2026-03-17 09:24:16.441892	f
5320	2024-03-28	10:30:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	8.40	0.00	💕 Love it So Much	8.40	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.444892	2026-03-17 09:24:16.444892	f
5321	2024-03-29	00:40:00	9:20, 10:32, 16:30	Wet	nature 養生湯罐	白身鮪魚+吻仔魚	💖 Yes, eat right away	80.00	14.30	💕 Love it So Much	65.70	3	💖 - 💕	46	2:55 有咬一下(原本在我雙腳間舔毛, 我的腳稍微動一下就突然咬我), 關房門	\N	2	\N	2026-03-17 09:24:16.447681	2026-03-17 09:24:16.447681	f
5322	2024-03-29	00:40:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	15.40	11.50	🔺 So So	3.90	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.45013	2026-03-17 09:24:16.45013	f
5323	2024-03-29	00:40:00	-	Kibble	origen	鮮雞室內貓	❌ No, not interested	5.20	5.20	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.482431	2026-03-17 09:24:16.482431	f
5324	2024-03-29	10:30:00	19:22	Wet	ciao	鰹魚燒晚餐包 ic-244	❌ No, not interested	100.00	39.70	🔺 So So	60.30	1	❌ - 🔺	15	放飯時間在睡覺沒有興趣/18:58 自己跑過來吃	\N	2	\N	2026-03-17 09:24:16.486117	2026-03-17 09:24:16.486117	f
5325	2024-03-29	10:30:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	36.50	23.50	🔺 So So	13.00	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.489397	2026-03-17 09:24:16.489397	f
5326	2024-03-29	10:30:00	-	Kibble	紐樂芙	智利鮭魚	❌ No, not interested	5.70	5.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.492107	2026-03-17 09:24:16.492107	f
5327	2024-03-29	10:30:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	8.20	0.00	💕 Love it So Much	8.20	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.494385	2026-03-17 09:24:16.494385	f
5328	2024-03-30	01:20:00	10:09	Wet	nature 養生湯罐	白身鮪魚+鮮蝦	💖 Yes, eat right away	80.00	31.80	🔺 So So	48.20	1	💖 - 🔺	25	3:00 有咬人，有起身確認濕食跟乾乾都有剩，回房關門（過幾分鐘，發現不能進去在門口喵喵叫幾聲）/6:00 在門口叫的很大聲/跑過來想吃, 還在倒罐頭就開始吃了	\N	2	\N	2026-03-17 09:24:16.49736	2026-03-17 09:24:16.49736	f
5329	2024-03-30	01:51:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	15.40	6.60	🔺 So So	8.80	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.499673	2026-03-17 09:24:16.499673	f
5330	2024-03-30	01:51:00	-	Kibble	紐樂芙	智利鮭魚	❌ No, not interested	4.90	3.70	🔺 So So	1.20	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.502426	2026-03-17 09:24:16.502426	f
5331	2024-03-30	11:00:00	19:22, 19:37	Wet	喵樂	喵罐 吻仔魚+鮪魚燒	💖 Yes, eat right away	160.00	160.00	❌ No!!!	0.00	2	💖 - ❌	22	跑過來想吃, 還在準備手就想抓食物了/19:00 => 每次吃完後約10分鐘, 吐出剛剛吃的副食罐/懷疑罐頭有問題？19:50換掉	\N	2	\N	2026-03-17 09:24:16.504962	2026-03-17 09:24:16.504962	f
5332	2024-03-30	11:00:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	31.70	16.10	🔺 So So	15.60	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.507091	2026-03-17 09:24:16.507091	f
5333	2024-03-30	11:00:00	-	Kibble	紐樂芙	智利鮭魚	❌ No, not interested	5.00	5.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.50955	2026-03-17 09:24:16.50955	f
5334	2024-03-30	11:50:00	20:12	Wet	銀湯匙	貓餐包 鮪魚, 鰹魚, 雞胸肉 p-mc 202	💖 Yes, eat right away	70.00	31.60	🔺 So So	38.40	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-17 09:24:16.51174	2026-03-17 09:24:16.51174	f
5335	2024-03-30	14:23:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	6.80	0.00	💕 Love it So Much	6.80	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.514334	2026-03-17 09:24:16.514334	f
5481	2024-04-25	00:50:00	14:51, 	Freeze-Dried	法麗	原肉凍乾零食 鮭魚	💖 Yes, eat right away	2.20	0.00	💕 Love it So Much	2.20	1	💖 - 💕	42		\N	2	\N	2026-03-17 09:24:16.919193	2026-03-17 09:25:33.035681	f
5306	2026-03-17	01:23:00	-	Wet	ciao	旅日系列餐包 ic-167 長崎小魚乾高湯+北海道干貝高湯 - 北海道干貝高湯 ic-16a x2	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞沒馬上吃	\N	2	\N	2026-03-17 01:25:22.819922	2026-03-17 11:37:55.076922	f
5336	2024-03-31	00:40:00	8:51, 10:10, 17:49	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	💖 Yes, eat right away	80.00	6.00	💕 Love it So Much	74.00	3	💖 - 💕	46	3:00有咬人, 但持續約10分鐘左右, 就自己出門了, 再回房就沒有咬人了	\N	2	\N	2026-03-17 09:24:16.517356	2026-03-17 09:24:16.517356	f
5337	2024-03-31	00:40:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.00	2.60	🔺 So So	17.40	0	❌ - 🔺	20	\N	\N	2	\N	2026-03-17 09:24:16.521127	2026-03-17 09:24:16.521127	f
5338	2024-03-31	10:20:00	19:48, 2:36	Wet	毛力士	極地鮮味雙嫩魚	💖 Yes, eat right away	50.00	7.10	💕 Love it So Much	42.90	2	💖 - 💕	44	跑過來想吃, 還在準備中, 感覺有點不耐煩要咬我	\N	2	\N	2026-03-17 09:24:16.52346	2026-03-17 09:24:16.52346	f
5339	2024-03-31	10:20:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	32.60	14.40	🔺 So So	18.20	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.525988	2026-03-17 09:24:16.525988	f
5340	2024-03-31	10:20:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	9.60	0.00	💕 Love it So Much	9.60	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.529277	2026-03-17 09:24:16.529277	f
5341	2024-04-01	01:06:00	9:41, 15:50	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 嫩雞	💖 Yes, eat right away	80.00	1.10	💕 Love it So Much	78.90	2	💖 - 💕	44	2:17 有咬人，約持續5-10分鐘就回房了，看攝影機沒吃東西/2:30 又咬人，起身檢查飯碗，順便隔離	\N	2	\N	2026-03-17 09:24:16.532137	2026-03-17 09:24:16.532137	f
5342	2024-04-01	01:10:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.30	18.80	🔺 So So	1.50	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.534994	2026-03-17 09:24:16.534994	f
5343	2024-04-01	10:40:00	-	Wet	想比比	鮪魚雞肉餐 (主食罐)	❌ No, not interested	80.00	80.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.540952	2026-03-17 09:24:16.540952	f
5344	2024-04-01	10:50:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	49.40	25.00	🔺 So So	24.40	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.546443	2026-03-17 09:24:16.546443	f
5345	2024-04-01	11:34:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	10.00	0.00	💕 Love it So Much	10.00	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.549232	2026-03-17 09:24:16.549232	f
5346	2024-04-01	14:30:00	-	Wet	法麗	室內貓排毛 鮪魚佐蟹肉	💖 Yes, eat right away	80.00	3.20	💕 Love it So Much	76.80	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.552745	2026-03-17 09:24:16.552745	f
5347	2024-04-02	00:45:00	9:03, 13:30	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	💖 Yes, eat right away	80.00	7.70	💕 Love it So Much	72.30	2	💖 - 💕	44	2:00 有咬人, 持續了半個小時左右, 飯碗還有乾乾＆濕食	\N	2	\N	2026-03-17 09:24:16.554968	2026-03-17 09:24:16.554968	f
5348	2024-04-02	00:45:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.80	5.90	🔺 So So	14.90	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.557452	2026-03-17 09:24:16.557452	f
5349	2024-04-02	09:28:00	19:40, 22:30	Wet	nature 養生湯罐	白身鮪魚+蟹肉	💖 Yes, eat right away	80.00	1.50	💕 Love it So Much	78.50	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.581259	2026-03-17 09:24:16.581259	f
5350	2024-04-02	09:34:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	32.20	16.40	🔺 So So	15.80	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.584806	2026-03-17 09:24:16.584806	f
5351	2024-04-02	09:34:00	-	Kibble	origen	六種魚	❌ No, not interested	5.60	5.60	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.587427	2026-03-17 09:24:16.587427	f
5352	2024-04-03	01:10:00	15:05, 17:30	Wet	法麗	室內貓排毛 鮪魚佐鮭魚	❌ No, not interested	80.00	28.70	💕 Love it So Much	51.30	2	❌ - 💕	27	被地震嚇死了, 沒吃/11:00才吃	\N	2	\N	2026-03-17 09:24:16.590716	2026-03-17 09:24:16.590716	f
5353	2024-04-03	01:20:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	10.70	5.00	🔺 So So	5.70	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.594145	2026-03-17 09:24:16.594145	f
5354	2024-04-03	01:20:00	-	Kibble	origen	六種魚	❌ No, not interested	9.70	3.70	🔺 So So	6.00	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.596444	2026-03-17 09:24:16.596444	f
5355	2024-04-03	10:10:00	2:25, 3:10	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	💖 Yes, eat right away	80.00	6.00	💕 Love it So Much	74.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.598576	2026-03-17 09:24:16.598576	f
5356	2024-04-03	10:10:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	25.60	15.10	🔺 So So	10.50	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.602177	2026-03-17 09:24:16.602177	f
5357	2024-04-03	10:10:00	-	Kibble	origen	六種魚	❌ No, not interested	14.10	12.20	🔺 So So	1.90	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.604361	2026-03-17 09:24:16.604361	f
5358	2024-04-03	10:10:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	7.70	0.00	💕 Love it So Much	7.70	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.60805	2026-03-17 09:24:16.60805	f
5359	2024-04-04	00:50:00	9:50, 14:39	Wet	奇境	野生鮪魚燉雞湯	💖 Yes, eat right away	55.00	2.80	💕 Love it So Much	52.20	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.610518	2026-03-17 09:24:16.610518	f
5360	2024-04-04	00:50:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	10.00	1.80	🔺 So So	8.20	0	❌ - 🔺	20	\N	\N	2	\N	2026-03-17 09:24:16.61322	2026-03-17 09:24:16.61322	f
5361	2024-04-04	00:50:00	-	Kibble	origen	六種魚	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.618012	2026-03-17 09:24:16.618012	f
5362	2024-04-04	09:11:00	21:10, 3:10, 4:34	Wet	法麗	室內貓排毛 鮪魚佐柴魚	💖 Yes, eat right away	80.00	15.80	💕 Love it So Much	64.20	3	💖 - 💕	46	\N	\N	2	\N	2026-03-17 09:24:16.621048	2026-03-17 09:24:16.621048	f
5363	2024-04-04	09:11:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	21.80	11.40	🔺 So So	10.40	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.623381	2026-03-17 09:24:16.623381	f
5364	2024-04-04	09:11:00	-	Kibble	origen	六種魚	❌ No, not interested	19.80	19.80	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.625936	2026-03-17 09:24:16.625936	f
5365	2024-04-04	15:00:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	13.00	0.00	💕 Love it So Much	13.00	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.628286	2026-03-17 09:24:16.628286	f
5366	2024-04-04	15:45:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	8.40	0.00	💕 Love it So Much	8.40	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.630351	2026-03-17 09:24:16.630351	f
5367	2024-04-05	22:20:00	7:20	Wet	ciao	鰹魚燒晚餐包 ic-244	❌ No, not interested	50.00	0.00	💕 Love it So Much	50.00	1	❌ - 💕	32	出門/放下後5分鐘才吃	\N	2	\N	2026-03-17 09:24:16.632597	2026-03-17 09:24:16.632597	f
5368	2024-04-05	22:20:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	60.30	25.00	🔺 So So	35.30	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.635417	2026-03-17 09:24:16.635417	f
5369	2024-04-05	23:20:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	13.30	0.00	💕 Love it So Much	13.30	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.637516	2026-03-17 09:24:16.637516	f
5370	2024-04-05	15:40:00	2:35	Wet	法麗	室內貓排毛 鮪魚佐鮮蝦	💖 Yes, eat right away	80.00	5.40	💕 Love it So Much	74.60	1	💖 - 💕	42	\N	\N	2	\N	2026-03-17 09:24:16.639418	2026-03-17 09:24:16.639418	f
5371	2024-04-05	15:40:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	7.80	0.00	💕 Love it So Much	7.80	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.641329	2026-03-17 09:24:16.641329	f
5372	2024-04-06	02:10:00	18:10	Wet	nature 養生湯罐	優選雞肉	💖 Yes, eat right away	80.00	3.00	💕 Love it So Much	77.00	1	💖 - 💕	42	\N	\N	2	\N	2026-03-17 09:24:16.643144	2026-03-17 09:24:16.643144	f
5373	2024-04-06	02:10:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.50	15.60	🔺 So So	4.90	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.647253	2026-03-17 09:24:16.647253	f
5374	2024-04-06	10:30:00	19:43, 1:37, 4:20	Wet	法麗	室內貓排毛 鮪魚佐鯛魚	💖 Yes, eat right away	80.00	4.60	💕 Love it So Much	75.40	3	💖 - 💕	46	\N	\N	2	\N	2026-03-17 09:24:16.648983	2026-03-17 09:24:16.648983	f
5375	2024-04-06	10:43:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	45.80	19.50	🔺 So So	26.30	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.657081	2026-03-17 09:24:16.657081	f
5376	2024-04-07	02:10:00	10:40, 12:36	Wet	法麗	全營養主食罐 關節保健 鮪魚佐番茄	💖 Yes, eat right away	80.00	4.50	💕 Love it So Much	75.50	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.678581	2026-03-17 09:24:16.678581	f
5377	2024-04-07	02:10:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.40	14.30	🔺 So So	6.10	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.681678	2026-03-17 09:24:16.681678	f
5378	2024-04-07	10:30:00	19:00, 21:27	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	💖 Yes, eat right away	80.00	2.90	💕 Love it So Much	77.10	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.683904	2026-03-17 09:24:16.683904	f
5379	2024-04-07	10:30:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	44.30	25.50	🔺 So So	18.80	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.685734	2026-03-17 09:24:16.685734	f
5380	2024-04-08	00:47:00	9:20, 16:05	Wet	金湯	愛貓湯罐 白身鮪魚&雞肉	💖 Yes, eat right away	80.00	34.50	🔺 So So	45.50	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-17 09:24:16.687447	2026-03-17 09:24:16.687447	f
5381	2024-04-08	00:47:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	15.20	12.70	🔺 So So	2.50	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.689896	2026-03-17 09:24:16.689896	f
5382	2024-04-08	00:47:00	-	Kibble	安娜美廚	阿拉斯加鱈魚	❌ No, not interested	6.30	6.30	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.691849	2026-03-17 09:24:16.691849	f
5383	2024-04-08	09:50:00	19:25, 21:54	Wet	法麗	泌尿道保健主食罐 鮪魚佐紅蘿蔔	💖 Yes, eat right away	80.00	9.50	💕 Love it So Much	70.50	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.693508	2026-03-17 09:24:16.693508	f
5384	2024-04-08	09:50:00	1:46, 5:12	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	38.30	20.00	🔺 So So	18.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.695113	2026-03-17 09:24:16.695113	f
5385	2024-04-08	09:50:00	-	Kibble	安娜美廚	阿拉斯加鱈魚	❌ No, not interested	11.70	11.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.696725	2026-03-17 09:24:16.696725	f
5386	2024-04-08	09:50:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	💖 Yes, eat right away	11.70	0.00	💕 Love it So Much	11.70	0	💖 - 💕	40	\N	\N	2	\N	2026-03-17 09:24:16.699024	2026-03-17 09:24:16.699024	f
5387	2024-04-08	14:45:00	23:10, 1:50	Wet	銀湯匙	貓餐包 鮪魚, 鰹魚, 雞胸肉 p-mc 202	❌ No, not interested	35.00	15.00	🔺 So So	20.00	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.700635	2026-03-17 09:24:16.700635	f
5388	2024-04-09	00:40:00	15:30, 16:26	Wet	法麗	法麗 全照護主食罐 鮪魚慕斯	💖 Yes, eat right away	80.00	10.70	💕 Love it So Much	69.30	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.702237	2026-03-17 09:24:16.702237	f
5389	2024-04-09	00:40:00	15:30,	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	15.40	15.40	❌ No!!!	0.00	1	❌ - ❌	10	\N	\N	2	\N	2026-03-17 09:24:16.703837	2026-03-17 09:24:16.703837	f
5390	2024-04-09	00:40:00	15:30	Kibble	歐那特	多種魚	❌ No, not interested	6.00	0.00	💕 Love it So Much	6.00	1	❌ - 💕	32	(先吃吃到沒了, 吃安娜), 	\N	2	\N	2026-03-17 09:24:16.705542	2026-03-17 09:24:16.705542	f
5391	2024-04-09	10:20:00	19:30, 20:40, 21:55, 2:55	Wet	mon petit 貓倍麗	嚴選金罐鮮燴鰹魚大餐 (嚴選鰹魚塊)	💖 Yes, eat right away	85.00	7.00	💕 Love it So Much	78.00	4	💖 - 💕	48	19:00 陪玩25分鐘/21:15陪玩約30分鐘	\N	2	\N	2026-03-17 09:24:16.707921	2026-03-17 09:24:16.707921	f
5392	2024-04-09	10:20:00	5:00, 	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	20.80	14.60	🔺 So So	6.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.709483	2026-03-17 09:24:16.709483	f
5393	2024-04-09	10:20:00	20:00, 21:50, 2:52, 5:03	Kibble	歐那特	多種魚	❌ No, not interested	25.40	4.70	🔺 So So	20.70	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-17 09:24:16.711079	2026-03-17 09:24:16.711079	f
5394	2024-04-10	00:40:00	9:48, 10:36, 15:50	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	4.20	💕 Love it So Much	75.80	3	💖 - 💕	46	\N	\N	2	\N	2026-03-17 09:24:16.712678	2026-03-17 09:24:16.712678	f
5395	2024-04-10	00:40:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	5.00	5.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.714245	2026-03-17 09:24:16.714245	f
5396	2024-04-10	00:40:00	9:48,	Kibble	歐那特	多種魚	❌ No, not interested	16.10	14.20	🔺 So So	1.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.720647	2026-03-17 09:24:16.720647	f
5397	2024-04-10	10:20:00	22:57, 7:45	Wet	法麗	腸胃保健主食罐 鮪魚佐奇異果	🔺 No, not really. Ate A Little	80.00	19.80	💕 Love it So Much	60.20	2	🔺 - 💕	39	19:00 陪玩約25分鐘/22:30陪玩約20分鐘(但準備從客廳回房要睡的時候，阿吉跳上床一直叫，走回客廳拿出逗貓棒陪玩不到五分鐘就倒地，收起逗貓棒，回房，這時就沒追過來了	\N	2	\N	2026-03-17 09:24:16.722305	2026-03-17 09:24:16.722305	f
5398	2024-04-10	10:20:00	19:06, 3:08, 7:42	Kibble	歐那特	多種魚	❌ No, not interested	45.10	22.30	🔺 So So	22.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-17 09:24:16.723943	2026-03-17 09:24:16.723943	f
5399	2024-04-10	10:20:00	-	Freeze-Dried	zimple	呼嚕凍乾 雞肉	❌ No, not interested	9.60	5.10	🔺 So So	4.50	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.725589	2026-03-17 09:24:16.725589	f
5400	2024-04-10	12:36:00	23:01, 3:08	Wet	ciao	鮪魚鮮魚餐包(鮪魚+柴魚片) ci-ic354	❌ No, not interested	40.00	3.30	💕 Love it So Much	36.70	2	❌ - 💕	34	懷疑不愛吃法麗的 鮪魚佐奇異果, 因為沒有回來吃, 中間一直對我喵喵叫/看完烏鴉才跑來吃(20:54)\n吃了一半以上	\N	2	\N	2026-03-17 09:24:16.727206	2026-03-17 09:24:16.727206	f
5401	2024-04-11	00:40:00	-	Wet	mon petit 貓倍麗	嚴選金罐鮮嫩鮪魚銀魚(吞拿魚及白飯魚)	🔺 No, not really. Ate A Little	85.00	61.00	🔺 So So	24.00	0	🔺 - 🔺	18	吃完第一回合, 一直對我喵喵叫, 邊叫邊看飯碗, 後來放了ciao喵餐包後, 可能不愛這個口味的貓倍麗？\n早上10:00 左右施工工人有經過門口	\N	2	\N	2026-03-17 09:24:16.729629	2026-03-17 09:24:16.729629	f
5402	2024-04-11	00:40:00	16:10, 	Kibble	歐那特	多種魚	❌ No, not interested	20.00	16.30	🔺 So So	3.70	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.733109	2026-03-17 09:24:16.733109	f
5403	2024-04-11	02:36:00	16:48	Wet	ciao	鰹魚燒晚餐包 ic-244	💖 Yes, eat right away	50.00	15.40	🔺 So So	34.60	1	💖 - 🔺	25	\N	\N	2	\N	2026-03-17 09:24:16.735157	2026-03-17 09:24:16.735157	f
5404	2024-04-11	10:40:00	19:52, 21:08, 22:22, 00:09	Wet	nature 養生湯罐	白身鮪魚+鮭魚	💖 Yes, eat right away	80.00	0.50	💕 Love it So Much	79.50	4	💖 - 💕	48	21:45陪玩約30分鐘	\N	2	\N	2026-03-17 09:24:16.737127	2026-03-17 09:24:16.737127	f
5405	2024-04-11	10:40:00	19:51, 3:30, 8:12	Kibble	歐那特	多種魚	❌ No, not interested	46.30	23.80	🔺 So So	22.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-17 09:24:16.739132	2026-03-17 09:24:16.739132	f
5406	2024-04-12	00:40:00	14:50	Wet	奇境	野生鯖魚燉雞湯	💖 Yes, eat right away	110.00	65.20	🔺 So So	44.80	1	💖 - 🔺	25	早上9:00 左右施工工人有經過門口	\N	2	\N	2026-03-17 09:24:16.740834	2026-03-17 09:24:16.740834	f
5407	2024-04-12	00:40:00	14:50, 	Kibble	歐那特	多種魚	❌ No, not interested	20.00	17.40	🔺 So So	2.60	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.743248	2026-03-17 09:24:16.743248	f
5408	2024-04-12	10:40:00	00:00, 00:15, 4:10, 6:00	Wet	法麗	室內貓排毛 鮪魚佐鮭魚	💖 Yes, eat right away	120.00	11.60	💕 Love it So Much	108.40	4	💖 - 💕	48	19:00 吃完第一回合罐罐, 就自己回臉盆睡覺了, 這正常嗎？/20:10 陪玩約25分鐘/22:30 陪玩約15分鐘, 阿吉倒地在旁邊休息	\N	2	\N	2026-03-17 09:24:16.745164	2026-03-17 09:24:16.745164	f
5409	2024-04-12	10:40:00	19:56, 00:17, 4:10, 6:00	Kibble	歐那特	多種魚	❌ No, not interested	47.40	18.70	🔺 So So	28.70	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-17 09:24:16.746838	2026-03-17 09:24:16.746838	f
5410	2024-04-13	01:10:00	10:57	Wet	ciao	近海鮪魚罐91號 (鰹魚+鮪魚片)	💖 Yes, eat right away	80.00	23.10	💕 Love it So Much	56.90	1	💖 - 💕	35	\N	\N	2	\N	2026-03-17 09:24:16.748635	2026-03-17 09:24:16.748635	f
5411	2024-04-13	01:10:00	10:16, 	Kibble	歐那特	多種魚	❌ No, not interested	20.90	10.00	🔺 So So	10.90	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.750956	2026-03-17 09:24:16.750956	f
5412	2024-04-13	10:20:00	19:27, 21:10, 23:50	Wet	mon petit 貓倍麗	嚴選金罐 極品鮪魚真鯛(特選鯛魚塊)	💖 Yes, eat right away	85.00	1.30	💕 Love it So Much	83.70	3	💖 - 💕	46	20:45 陪玩約15分鐘 23:21陪玩約20分鐘	\N	2	\N	2026-03-17 09:24:16.754076	2026-03-17 09:24:16.754076	f
5413	2024-04-13	10:20:00	19:27, 21:05	Kibble	歐那特	多種魚	❌ No, not interested	40.60	13.00	🔺 So So	27.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.769279	2026-03-17 09:24:16.769279	f
5415	2024-04-14	00:50:00	9:33	Wet	原燒	白身鮪魚+柴魚	💖 Yes, eat right away	80.00	17.10	💕 Love it So Much	62.90	1	💖 - 💕	42	\N	\N	2	\N	2026-03-17 09:24:16.773476	2026-03-17 09:24:16.773476	f
5416	2024-04-14	00:50:00	9:33,	Kibble	歐那特	多種魚	❌ No, not interested	20.20	16.90	🔺 So So	3.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.77526	2026-03-17 09:24:16.77526	f
5418	2024-04-14	10:30:00	20:45, 21:53, 00:30	Wet	nature 養生湯罐	白身鮪魚+吻仔魚	💖 Yes, eat right away	78.90	1.00	💕 Love it So Much	77.90	3	💖 - 💕	46	20:30陪玩約10分鐘, 感覺玩不太起來, 沒像一開始興奮了/21:30 陪玩約10分鐘，一樣感覺玩不太起來	\N	2	\N	2026-03-17 09:24:16.779837	2026-03-17 09:24:16.779837	f
5419	2024-04-14	10:30:00	00:30, 1:15, 4:47, 5:36	Kibble	歐那特	多種魚	❌ No, not interested	46.90	24.60	🔺 So So	22.30	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-17 09:24:16.782162	2026-03-17 09:24:16.782162	f
5422	2024-04-15	01:00:00	9:32, 11:00, 15:55	Wet	奇境	野生鮪魚燉雞湯	💖 Yes, eat right away	55.00	8.30	💕 Love it So Much	46.70	3	💖 - 💕	46	\N	\N	2	\N	2026-03-17 09:24:16.788067	2026-03-17 09:24:16.788067	f
5423	2024-04-15	01:00:00	9:32, 15:55	Kibble	歐那特	多種魚	❌ No, not interested	20.00	12.10	🔺 So So	7.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.790068	2026-03-17 09:24:16.790068	f
5424	2024-04-15	10:20:00	19:15, 22:02, 22:35, 23:45, 4:20	Wet	法麗	室內貓排毛 鮪魚佐鮭魚 - 冰過	💖 Yes, eat right away	38.00	0.70	💕 Love it So Much	37.30	5	💖 - 💕	50	\N	\N	2	\N	2026-03-17 09:24:16.792203	2026-03-17 09:24:16.792203	f
5425	2024-04-15	10:20:00	19:15, 21:30, 22:36, 23:44	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹, 鮮蝦	💖 Yes, eat right away	80.00	8.50	💕 Love it So Much	71.50	4	💖 - 💕	48	21:00 陪玩約20分鐘, 過程用吸管, 束線帶玩不太起來, 改用丟凍乾, 讓阿吉去追\n	\N	2	\N	2026-03-17 09:24:16.793928	2026-03-17 09:24:16.793928	f
5426	2024-04-15	10:20:00	4:15, 	Kibble	歐那特	多種魚	❌ No, not interested	43.20	31.20	🔺 So So	12.00	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.799672	2026-03-17 09:24:16.799672	f
5427	2024-04-16	00:10:00	8:40, 9:46, 16:40, 17:11	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	2.00	💕 Love it So Much	83.00	4	💖 - 💕	48	\N	\N	2	\N	2026-03-17 09:24:16.802897	2026-03-17 09:24:16.802897	f
5428	2024-04-16	00:10:00	9:47, 17:11	Kibble	歐那特	多種魚	❌ No, not interested	20.00	8.70	🔺 So So	11.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.8046	2026-03-17 09:24:16.8046	f
5431	2024-04-16	10:40:00	19:55, 22:17, 23:02, 4:10, 4:40, 5:04	Wet	nature 養生湯罐	白身鮪魚+鮮蝦	💖 Yes, eat right away	81.10	0.80	💕 Love it So Much	80.30	6	💖 - 💕	52	19:38接著吃	\N	2	\N	2026-03-17 09:24:16.810146	2026-03-17 09:24:16.810146	f
5432	2024-04-16	10:40:00	19:38, 19:55, 22:16	Wet	nature 養生湯罐	白身鮪魚+鮭魚	💖 Yes, eat right away	40.30	0.30	💕 Love it So Much	40.00	3	💖 - 💕	46	\N	\N	2	\N	2026-03-17 09:24:16.811749	2026-03-17 09:24:16.811749	f
5433	2024-04-16	10:40:00	4:10, 5:04,	Kibble	歐那特	多種魚	❌ No, not interested	39.90	30.00	🔺 So So	9.90	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.813377	2026-03-17 09:24:16.813377	f
5435	2024-04-17	00:40:00	-	Wet	銀湯匙	三星美食細嫩口感餐包(鮪魚+鰹魚+吻仔魚)	🔺 No, not really. Ate A Little	73.60	38.60	🔺 So So	35.00	0	🔺 - 🔺	18	可能不是很愛, 第一回只吃不到一半, 可能因為肚子餓一直叫, 先填個肚子？	\N	2	\N	2026-03-17 09:24:16.817279	2026-03-17 09:24:16.817279	f
5436	2024-04-17	00:40:00	-	Kibble	歐那特	多種魚	❌ No, not interested	20.90	20.90	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.818886	2026-03-17 09:24:16.818886	f
5438	2024-04-17	03:13:00	16:00	Wet	ciao	近海罐92號 鮪魚+吻仔魚	💖 Yes, eat right away	80.00	21.50	💕 Love it So Much	58.50	1	💖 - 💕	35	吃完活動約半個小時, 目前準備入睡	\N	2	\N	2026-03-17 09:24:16.822023	2026-03-17 09:24:16.822023	f
5439	2024-04-17	08:50:00	21:31, 22:12, 22:56, 5:02	Wet	法麗	室內貓排毛 鮪魚佐柴魚	❌ No, not interested	42.20	0.60	💕 Love it So Much	41.60	4	❌ - 💕	38	\N	\N	2	\N	2026-03-17 09:24:16.823733	2026-03-17 09:24:16.823733	f
5414	2024-04-13	15:59:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮭魚	💖 Yes, eat right away	1.80	0.00	💕 Love it So Much	1.80	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.771586	2026-03-17 09:25:21.295272	f
5434	2024-04-16	10:40:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮪魚	💖 Yes, eat right away	4.90	0.00	💕 Love it So Much	4.90	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.815629	2026-03-17 09:25:42.958948	f
5421	2024-04-14	12:55:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮭魚	💖 Yes, eat right away	2.40	0.00	💕 Love it So Much	2.40	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.786307	2026-03-17 09:26:04.881161	f
5429	2024-04-16	00:10:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮭魚	💖 Yes, eat right away	1.30	0.00	💕 Love it So Much	1.30	0	💖 - 💕	40	9:30 陪玩約10分鐘, 因一直叫	\N	2	\N	2026-03-17 09:24:16.806699	2026-03-17 09:26:15.63717	f
5420	2024-04-14	10:30:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮪魚	💖 Yes, eat right away	1.40	0.00	💕 Love it So Much	1.40	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.784095	2026-03-17 09:26:28.428907	f
5430	2024-04-16	00:10:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮪魚	💖 Yes, eat right away	1.50	0.00	💕 Love it So Much	1.50	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.808437	2026-03-17 09:26:40.591183	f
5417	2024-04-14	08:01:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮭魚	💖 Yes, eat right away	1.30	0.00	💕 Love it So Much	1.30	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.777144	2026-03-17 09:26:52.350347	f
5440	2024-04-17	10:40:00	21:07, 21:32, 22:12, 22:56, 4:25, 5:06	Wet	法麗	室內貓排毛 鮪魚佐鯛魚	❌ No, not interested	79.60	8.30	💕 Love it So Much	71.30	6	❌ - 💕	42	\N	\N	2	\N	2026-03-17 09:24:16.825536	2026-03-17 09:24:16.825536	f
5441	2024-04-17	10:40:00	20:18, 23:38, 4:22	Kibble	歐那特	多種魚	❌ No, not interested	50.90	20.20	🔺 So So	30.70	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-17 09:24:16.827156	2026-03-17 09:24:16.827156	f
5442	2024-04-18	00:50:00	9:50, 16:48	Wet	ciao	鰹魚燒晚餐包 ic-236 (鰹魚+干貝+鰹魚高湯)	🔺 No, not really. Ate A Little	100.00	40.50	🔺 So So	59.50	2	🔺 - 🔺	22	要把餐盤拿到中島上會吃, 下午放到中島上就開始吃起來了/下午約2:30有吐。/懷疑不太愛歐那特乾飼料，換奇境馬上吃了快一半的量/9:10 突然想玩, 有陪玩約10分鐘	\N	2	\N	2026-03-17 09:24:16.828737	2026-03-17 09:24:16.828737	f
5443	2024-04-18	00:50:00	-	Kibble	歐那特	多種魚	❌ No, not interested	20.70	20.70	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.830312	2026-03-17 09:24:16.830312	f
5445	2024-04-18	10:34:00	-	Wet	axia	新金罐濃厚8號 15歲 鮪魚 	💖 Yes, eat right away	70.00	11.00	💕 Love it So Much	59.00	0	💖 - 💕	40	拿到前面聞一下, 馬上走出臉盆馬上吃, 吃了快一半以上/一樣放在中島上讓阿吉吃/吃完愛喜雅, 就在臉盆裡面睡著了	\N	2	\N	2026-03-17 09:24:16.833635	2026-03-17 09:24:16.833635	f
5447	2024-04-18	10:34:00	-	Kibble	歐那特	多種魚	❌ No, not interested	56.90	45.90	🔺 So So	11.00	0	❌ - 🔺	13	\N	\N	2	\N	2026-03-17 09:24:16.836737	2026-03-17 09:24:16.836737	f
5448	2024-04-18	10:34:00	-	Wet	nature 養生湯罐	白身鮪魚+吻仔魚	❌ No, not interested	80.00	3.30	💕 Love it So Much	76.70	0	❌ - 💕	30	\N	\N	2	\N	2026-03-17 09:24:16.838476	2026-03-17 09:24:16.838476	f
5449	2024-04-18	13:30:00	-	Wet	nature 養生湯罐	白身鮪魚+鮭魚	❌ No, not interested	37.80	1.70	💕 Love it So Much	36.10	0	❌ - 💕	30	出門	\N	2	\N	2026-03-17 09:24:16.84008	2026-03-17 09:24:16.84008	f
5450	2024-04-19	10:20:00	5:00	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	❌ No, not interested	79.20	7.90	💕 Love it So Much	71.30	1	❌ - 💕	32	出門	\N	2	\N	2026-03-17 09:24:16.841632	2026-03-17 09:24:16.841632	f
5451	2024-04-19	10:20:00	23:31, 4:06, 	Kibble	歐那特	多種魚	❌ No, not interested	30.20	19.10	🔺 So So	11.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.843371	2026-03-17 09:24:16.843371	f
5452	2024-04-19	13:30:00	-	Wet	法麗	室內貓排毛 鮪魚佐柴魚	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	\N	\N	2	\N	2026-03-17 09:24:16.84505	2026-03-17 09:24:16.84505	f
5453	2024-04-19	13:30:00	23:31, 4:06, 4:58,	Wet	mon petit 貓倍麗	嚴選金罐角切鮮鮪魚(角切吞拿魚塊)	❌ No, not interested	85.00	11.80	💕 Love it So Much	73.20	3	❌ - 💕	36	\N	\N	2	\N	2026-03-17 09:24:16.846529	2026-03-17 09:24:16.846529	f
5455	2024-04-20	01:10:00	10:13, 16:50	Wet	惜時	in 機能湯 白身鮪魚&蝦肉&燒汁	💖 Yes, eat right away	80.00	11.50	💕 Love it So Much	68.50	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.849608	2026-03-17 09:24:16.849608	f
5457	2024-04-20	10:10:00	5:20	Wet	奇境	野生鮪魚燉雞湯	🔺 No, not really. Ate A Little	55.00	7.80	💕 Love it So Much	47.20	1	🔺 - 💕	37	吃一點就離開/沒有很餓？？ (阿吉媽推測)	\N	2	\N	2026-03-17 09:24:16.853373	2026-03-17 09:24:16.853373	f
5458	2024-04-20	10:10:00	00:34, 00:40	Wet	原燒	白身鮪魚+吻仔魚	❌ No, not interested	80.00	7.10	💕 Love it So Much	72.90	2	❌ - 💕	34	19:40 (吃第一回合)	\N	2	\N	2026-03-17 09:24:16.878305	2026-03-17 09:24:16.878305	f
5460	2024-04-21	01:00:00	-	Wet	銀湯匙	貓餐包 鰹魚, 鮪魚, 柴魚片	🔺 No, not really. Ate A Little	60.00	22.60	🔺 So So	37.40	0	🔺 - 🔺	18	\N	\N	2	\N	2026-03-17 09:24:16.882115	2026-03-17 09:24:16.882115	f
5461	2024-04-21	01:00:00	14:30	Kibble	歐那特	多種魚	❌ No, not interested	21.90	19.80	🔺 So So	2.10	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.883827	2026-03-17 09:24:16.883827	f
5462	2024-04-21	10:50:00	22:13, 00:32, 4:20, 7:40	Wet	mon petit 貓倍麗	嚴選金罐鮪魚蟹肉拼盤(吞拿魚及蟹柳)	💖 Yes, eat right away	85.00	44.90	🔺 So So	40.10	4	💖 - 🔺	31	\N	\N	2	\N	2026-03-17 09:24:16.885521	2026-03-17 09:24:16.885521	f
5463	2024-04-21	10:50:00	22:15, 22:48, 00:32	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	35.50	0.60	💕 Love it So Much	34.90	3	💖 - 💕	46	21:50有陪玩約10分鐘, 玩得起來/22:30再陪玩, 有點玩不起來了/00:32 =>吃完	\N	2	\N	2026-03-17 09:24:16.887458	2026-03-17 09:24:16.887458	f
5464	2024-04-21	10:50:00	20:07, 22:50, 00:32, 4:17, 7:38, 	Kibble	歐那特	多種魚	❌ No, not interested	50.10	20.40	🔺 So So	29.70	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-17 09:24:16.88918	2026-03-17 09:24:16.88918	f
5465	2024-04-22	01:10:00	11:12, 15:30	Wet	nature 養生湯罐	白身鮪魚+蔬菜	💖 Yes, eat right away	80.00	21.60	💕 Love it So Much	58.40	2	💖 - 💕	37	10:00 隔壁施工工人在門口施工, 感覺阿吉有警戒/半夜一直有地震, 不確定是否會影響飲食？	\N	2	\N	2026-03-17 09:24:16.890832	2026-03-17 09:24:16.890832	f
5467	2024-04-22	10:50:00	20:40, 21:50, 00:05, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚	💖 Yes, eat right away	120.90	7.60	💕 Love it So Much	113.30	3	💖 - 💕	46	16:55 陪玩約10分鐘, 有跑到鼻子紅紅的, 耳朵也有點紅紅的, 然後自己倒下	\N	2	\N	2026-03-17 09:24:16.894073	2026-03-17 09:24:16.894073	f
5469	2024-04-23	00:50:00	11:30, 15:30, 	Wet	axia	新金罐濃厚8號 15歲 鮪魚 	💖 Yes, eat right away	76.70	10.40	💕 Love it So Much	66.30	2	💖 - 💕	44	改到客聽用電腦, 沒有喵喵叫, 靜靜地坐在地上, 過一陣子自己跑去中島的臉盆睡覺	\N	2	\N	2026-03-17 09:24:16.89728	2026-03-17 09:24:16.89728	f
5470	2024-04-23	00:50:00	9:10, 11:29, 15:30\n	Kibble	歐那特	多種魚	❌ No, not interested	20.20	10.40	🔺 So So	9.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-17 09:24:16.898919	2026-03-17 09:24:16.898919	f
5471	2024-04-23	10:40:00	4:45, 5:32	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	54.40	4.20	💕 Love it So Much	50.20	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.900706	2026-03-17 09:24:16.900706	f
5444	2024-04-18	07:40:00	-	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.90	9.80	🔺 So So	11.10	0	❌ - 🔺	13		\N	2	\N	2026-03-17 09:24:16.83191	2026-03-17 09:27:26.897424	f
5468	2024-04-22	10:50:00	19:57	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	43.30	38.10	🔺 So So	5.20	1	❌ - 🔺	15		\N	2	\N	2026-03-17 09:24:16.895611	2026-03-17 09:27:37.409053	f
5466	2024-04-22	01:10:00	11:09, 15:30	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	22.40	12.00	🔺 So So	10.40	2	❌ - 🔺	17		\N	2	\N	2026-03-17 09:24:16.892417	2026-03-17 09:27:48.226311	f
5456	2024-04-20	01:10:00	16:50,	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.30	2.90	🔺 So So	17.40	1	❌ - 🔺	22		\N	2	\N	2026-03-17 09:24:16.85115	2026-03-17 09:28:08.826488	f
5459	2024-04-20	10:10:00	00:34, 5:20	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	33.20	7.30	🔺 So So	25.90	2	❌ - 🔺	24		\N	2	\N	2026-03-17 09:24:16.880372	2026-03-17 09:28:22.259079	f
5446	2024-04-18	10:34:00	-	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	32.70	21.40	🔺 So So	11.30	0	❌ - 🔺	13		\N	2	\N	2026-03-17 09:24:16.835189	2026-03-17 09:28:32.482704	f
5472	2024-04-23	10:40:00	19:33, 3:03, 4:45, 5:32	Wet	nature 養生湯罐	白身鮪魚+鮮蝦	💖 Yes, eat right away	80.00	15.80	💕 Love it So Much	64.20	4	💖 - 💕	48	18:30有陪玩, 一開始玩不太起來, 後來吃了一點點罐罐, 突然玩得很起勁, 玩了大約30分鐘	\N	2	\N	2026-03-17 09:24:16.902508	2026-03-17 09:24:16.902508	f
5473	2024-04-23	10:40:00	19:38, 21:40, 4:45	Kibble	歐那特	多種魚	❌ No, not interested	40.40	25.70	🔺 So So	14.70	3	❌ - 🔺	19	3am 5am 咬人	\N	2	\N	2026-03-17 09:24:16.904427	2026-03-17 09:24:16.904427	f
5474	2024-04-24	01:30:00	14:15, 16:57, 	Wet	ciao	鰹魚燒晚餐包 ic-232(鰹魚+干貝)	💖 Yes, eat right away	50.00	1.50	💕 Love it So Much	48.50	2	💖 - 💕	44	凌晨5:30有咬人＋攻擊	\N	2	\N	2026-03-17 09:24:16.906236	2026-03-17 09:24:16.906236	f
5476	2024-04-24	10:50:00	22:37, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹,鮭魚 - 冰過	❌ No, not interested	46.30	4.00	💕 Love it So Much	42.30	1	❌ - 💕	32	\N	\N	2	\N	2026-03-17 09:24:16.909947	2026-03-17 09:24:16.909947	f
5477	2024-04-24	10:50:00	21:32, 22:37\n	Wet	法麗	全營養主食罐 關節保健 鮪魚佐番茄	💖 Yes, eat right away	81.90	10.90	💕 Love it So Much	71.00	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.911954	2026-03-17 09:24:16.911954	f
5479	2024-04-25	00:50:00	9:30, 15:08, 16:25, 	Wet	原燒	白身鮪魚+蟹肉	💖 Yes, eat right away	80.00	24.60	💕 Love it So Much	55.40	3	💖 - 💕	39	\N	\N	2	\N	2026-03-17 09:24:16.915409	2026-03-17 09:24:16.915409	f
5480	2024-04-25	00:50:00	14:51, 16:25, 	Kibble	歐那特	多種魚	❌ No, not interested	20.00	11.90	🔺 So So	8.10	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.917343	2026-03-17 09:24:16.917343	f
5482	2024-04-25	10:50:00	4:10, 4:39	Wet	mon petit 貓倍麗	上等鮮嫩鮪魚餐盒lc1	💖 Yes, eat right away	57.00	23.80	🔺 So So	33.20	2	💖 - 🔺	27	\N	\N	2	\N	2026-03-17 09:24:16.921048	2026-03-17 09:24:16.921048	f
5483	2024-04-25	10:50:00	19:31, 23:47	Wet	mon petit 貓倍麗	嚴選鮮味鰹魚餐盒 lc2	💖 Yes, eat right away	57.00	3.20	💕 Love it So Much	53.80	2	💖 - 💕	44	23:47 => 吃光	\N	2	\N	2026-03-17 09:24:16.9227	2026-03-17 09:24:16.9227	f
5484	2024-04-25	10:50:00	23:44, 4:08, 	Kibble	歐那特	多種魚	❌ No, not interested	41.90	18.60	🔺 So So	23.30	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.924407	2026-03-17 09:24:16.924407	f
5485	2024-04-26	01:00:00	15:50, 	Wet	axia	金罐7號高湯 - 鮪魚	💖 Yes, eat right away	70.00	23.20	🔺 So So	46.80	1	💖 - 🔺	25	還在倒罐頭就開始吃了	\N	2	\N	2026-03-17 09:24:16.926159	2026-03-17 09:24:16.926159	f
5486	2024-04-26	01:00:00	9:45, 10:15, 10:55, 15:47, 	Kibble	歐那特	多種魚	❌ No, not interested	20.00	5.90	🔺 So So	14.10	4	❌ - 🔺	21	\N	\N	2	\N	2026-03-17 09:24:16.927961	2026-03-17 09:24:16.927961	f
5487	2024-04-26	10:40:00	19:39, 22:30, 5:13	Wet	ciao	原湯杯51號(鮪+蟹+鰹)	💖 Yes, eat right away	122.10	2.40	💕 Love it So Much	119.70	3	💖 - 💕	46	半夜咬人	\N	2	\N	2026-03-17 09:24:16.929659	2026-03-17 09:24:16.929659	f
5488	2024-04-26	10:40:00	20:03, 22:30, 23:10, 00:48, 5:10, 	Kibble	歐那特	多種魚	❌ No, not interested	35.90	11.30	🔺 So So	24.60	5	❌ - 🔺	23	\N	\N	2	\N	2026-03-17 09:24:16.93154	2026-03-17 09:24:16.93154	f
5489	2024-04-27	01:20:00	10:03, 12:00, 15:18,	Wet	法麗	室內貓排毛 鮪魚佐鮭魚	💖 Yes, eat right away	80.00	22.60	💕 Love it So Much	57.40	3	💖 - 💕	39	還在倒罐頭就開始吃了	\N	2	\N	2026-03-17 09:24:16.93339	2026-03-17 09:24:16.93339	f
5490	2024-04-27	01:20:00	15:18, 	Kibble	歐那特	多種魚	❌ No, not interested	20.00	13.70	🔺 So So	6.30	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.935085	2026-03-17 09:24:16.935085	f
5491	2024-04-27	16:00:00	23:00, \n	Wet	water go	鮪魚broth(肉汁湯罐）	💖 Yes, eat right away	140.00	110.00	🔺 So So	30.00	2	💖 - 🔺	27	還在倒罐頭就開始吃了/21:00 => 有撥沙動作出現, 打翻湯罐,之後就沒再去吃了	\N	2	\N	2026-03-17 09:24:16.937333	2026-03-17 09:24:16.937333	f
5492	2024-04-27	16:00:00	20:36, 23:00, 3:42, 4:53, 	Kibble	歐那特	多種魚	❌ No, not interested	43.70	4.90	🔺 So So	38.80	4	❌ - 🔺	28	\N	\N	2	\N	2026-03-17 09:24:16.938941	2026-03-17 09:24:16.938941	f
5493	2024-04-28	00:50:00	10:06, 10:45, 14:48,	Wet	sheba	金罐 鮪魚及鮭魚 (湯汁)	💖 Yes, eat right away	85.00	3.00	💕 Love it So Much	82.00	3	💖 - 💕	46	還在倒罐頭就開始吃了/14:48 => 吃光	\N	2	\N	2026-03-17 09:24:16.940542	2026-03-17 09:24:16.940542	f
5494	2024-04-28	00:50:00	14:47, 18:00,	Kibble	歐那特	多種魚	❌ No, not interested	20.90	8.30	🔺 So So	12.60	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.942409	2026-03-17 09:24:16.942409	f
5495	2024-04-28	10:00:00	21:39, 4:17, 	Wet	mon petit 貓倍麗	鮪魚蟹肉鰹魚 極品上湯	💖 Yes, eat right away	40.00	5.00	💕 Love it So Much	35.00	2	💖 - 💕	44	還在倒罐頭就開始吃了/半夜很乖	\N	2	\N	2026-03-17 09:24:16.944057	2026-03-17 09:24:16.944057	f
5496	2024-04-28	10:00:00	23:30, 4:18, 8:22, 	Wet	ciao	近海鰹魚罐93號 (干貝味)	💖 Yes, eat right away	80.00	4.30	💕 Love it So Much	75.70	3	💖 - 💕	46	還在倒罐頭就開始吃了	\N	2	\N	2026-03-17 09:24:16.94584	2026-03-17 09:24:16.94584	f
5497	2024-04-28	10:00:00	23:30, 4:13, 8:22, 	Kibble	歐那特	多種魚	❌ No, not interested	38.10	20.60	🔺 So So	17.50	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-17 09:24:16.947401	2026-03-17 09:24:16.947401	f
5498	2024-04-29	00:50:00	9:43, 10:30, 14:45, 	Wet	惜時	in 機能湯 白身鮪魚&花枝&燒汁	💖 Yes, eat right away	80.00	7.00	💕 Love it So Much	73.00	3	💖 - 💕	46	還在倒罐頭就開始吃了	\N	2	\N	2026-03-17 09:24:16.949198	2026-03-17 09:24:16.949198	f
5499	2024-04-29	00:50:00	9:43, 10:28, 14:43, 	Kibble	歐那特	多種魚	❌ No, not interested	20.00	12.20	🔺 So So	7.80	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-17 09:24:16.950946	2026-03-17 09:24:16.950946	f
5500	2024-04-29	10:40:00	19:41, 22:59, 2:43, 4:05, 5:13, 	Wet	petline	極品湯罐 (z17)	💖 Yes, eat right away	80.00	17.50	💕 Love it So Much	62.50	5	💖 - 💕	50	還在倒罐頭就開始吃了	\N	2	\N	2026-03-17 09:24:16.977837	2026-03-17 09:24:16.977837	f
5501	2024-04-29	10:40:00	22:12, 22:57, 5:15	Wet	combo 吻饌	蒸煮餐包 鮪魚+鰹魚 pnr-1	💖 Yes, eat right away	40.00	3.10	💕 Love it So Much	36.90	3	💖 - 💕	46	5:15 => 吃光/還在倒就開始吃了	\N	2	\N	2026-03-17 09:24:16.979879	2026-03-17 09:24:16.979879	f
5502	2024-04-29	10:40:00	19:38, 22:56, 4:02, 	Kibble	歐那特	多種魚	❌ No, not interested	42.20	24.10	🔺 So So	18.10	3	❌ - 🔺	19	\N	\N	2	\N	2026-03-17 09:24:16.981661	2026-03-17 09:24:16.981661	f
5503	2024-04-30	00:50:00	9:36, 16:02, 	Wet	法麗	微湯汁系列 天然黃鰭鮪佐正鰹	💖 Yes, eat right away	80.00	3.40	💕 Love it So Much	76.60	2	💖 - 💕	44	淩晨4:40有咬人/還在倒就開始吃了	\N	2	\N	2026-03-17 09:24:16.983371	2026-03-17 09:24:16.983371	f
5504	2024-04-30	00:50:00	9:39, 16:00,	Kibble	歐那特	多種魚	❌ No, not interested	20.50	9.70	🔺 So So	10.80	2	❌ - 🔺	17	\N	\N	2	\N	2026-03-17 09:24:16.98505	2026-03-17 09:24:16.98505	f
5505	2024-04-30	10:40:00	22:30, 4:10, 	Wet	axia	新金罐濃厚1號-鮪魚	💖 Yes, eat right away	70.00	6.20	💕 Love it So Much	63.80	2	💖 - 💕	44	\N	\N	2	\N	2026-03-17 09:24:16.986872	2026-03-17 09:24:16.986872	f
5478	2024-04-24	10:50:00	21:31, 21:53, 22:37, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	32.70	4.30	🔺 So So	28.40	3	❌ - 🔺	26		\N	2	\N	2026-03-17 09:24:16.913699	2026-03-17 09:27:12.799703	f
5475	2024-04-24	01:30:00	14:15, 17:18, 	Kibble	奇境	澳洲鮭魚 + 紐西蘭 羊肺凍乾	❌ No, not interested	20.00	2.50	🔺 So So	17.50	2	❌ - 🔺	24		\N	2	\N	2026-03-17 09:24:16.908048	2026-03-17 09:27:58.666747	f
5506	2024-04-30	10:40:00	20:32, 4:13, 7:47, 	Wet	axia	金罐1號-鮪魚(gn-1)	💖 Yes, eat right away	70.00	7.40	💕 Love it So Much	62.60	3	💖 - 💕	46	\N	\N	2	\N	2026-03-17 09:24:16.988533	2026-03-17 09:24:16.988533	f
5507	2024-04-30	10:40:00	20:30, 	Kibble	歐那特	多種魚	❌ No, not interested	39.70	28.50	🔺 So So	11.20	1	❌ - 🔺	15	\N	\N	2	\N	2026-03-17 09:24:16.990265	2026-03-17 09:24:16.990265	f
5508	2024-04-30	10:40:00	-	Freeze-Dried	法麗	原肉凍乾 鮭魚	💖 Yes, eat right away	1.40	0.00	💕 Love it So Much	1.40	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.992117	2026-03-17 09:24:54.050612	f
5437	2024-04-17	00:40:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮭魚	💖 Yes, eat right away	1.80	0.00	💕 Love it So Much	1.80	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.820465	2026-03-17 09:25:08.082452	f
5454	2024-04-19	13:30:00	-	Freeze-Dried	法麗	原肉凍乾零食 鮭魚	💖 Yes, eat right away	2.80	0.00	💕 Love it So Much	2.80	0	💖 - 💕	40		\N	2	\N	2026-03-17 09:24:16.848102	2026-03-17 09:25:52.749948	f
5305	2026-03-17	01:23:00	10:12, 12:31, 13:35, 15:05, 	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	💖 Yes, eat right away	80.00	40.40	🔺 So So	39.60	4	💖 - 🔺	31		\N	2	\N	2026-03-17 01:23:29.728023	2026-03-17 12:37:10.399808	f
5509	2026-03-17	10:40:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	💖 Yes, eat right away	40.00	17.10	❌ No!!!	22.90	0	💖 - ❌	18		\N	2	\N	2026-03-17 10:40:11.390326	2026-03-17 12:37:58.60164	f
5511	2026-03-17	12:32:00	23:22, 	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	20.00	19.00	🔺 So So	1.00	1	❌ - 🔺	15		\N	2	\N	2026-03-17 12:33:05.704897	2026-03-18 01:21:57.965075	f
5512	2026-03-17	12:35:00	22:13, 00:18, 3;56,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	26.90	11.30	🔺 So So	15.60	3	❌ - 🔺	19	加誠實貓 雞塊 5g	\N	2	56	2026-03-17 12:35:57.985135	2026-03-18 01:22:26.586672	t
5517	2026-03-18	02:12:00	-	Kibble	法米納	無穀鯡魚甜橙 oc1	❌ No, not interested	13.60	13.60	❌ No!!!	0.00	0	❌ - ❌	8	有點躁動, 倒掉換曙光鴨	\N	2	\N	2026-03-18 02:12:52.879787	2026-03-18 02:25:44.308637	f
5526	2026-03-19	01:40:00	11:41, 16:12, 18:30, 20:28, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	38.20	💕 Love it So Much	91.80	4	💖 - 💕	41		\N	2	\N	2026-03-19 01:46:53.050109	2026-03-19 13:06:32.889382	f
5179	2024-06-09	22:30:00	7:13, 12:26, 19:21, 20:20,	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	9.30	💕 Love it So Much	75.70	4	💖 - 💕	48	8:30出門 00:12到家	\N	2	\N	2026-03-16 14:39:14.892957	2026-03-19 03:22:01.470071	f
5524	2026-03-19	01:03:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-19 01:03:13.563409	2026-03-20 00:48:28.904004	f
5518	2026-03-18	02:21:00	10:35, 15:47, 20:17, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x2	🔺 No, not really. Ate A Little	70.00	24.10	💕 Love it So Much	45.90	3	🔺 - 💕	34		\N	2	\N	2026-03-18 02:21:52.307321	2026-03-18 13:05:28.574078	f
5513	2026-03-18	01:20:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x2	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	一直叫, 有點躁動, 換掉	\N	2	\N	2026-03-18 01:20:49.378712	2026-03-18 13:07:04.422102	f
3327	2025-09-19	07:30:00	18:05, 20:27, 22:32, 23:46, 00:13, 2:54, 7:51,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	39.10	7.80	💕 Love it So Much	31.30	7	❌ - 💕	44		\N	2	56	2026-03-10 11:49:56.719615	2026-03-10 11:51:30.128678	t
3337	2025-10-08	00:50:00	10:20, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.40	16.80	🔺 So So	3.60	1	❌ - 🔺	15		\N	2	56	2026-03-10 13:40:49.058173	2026-03-10 15:03:11.398087	t
5527	2026-03-19	10:25:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.20	5.30	❌ No!!!	4.90	0	💖 - ❌	18		\N	2	53	2026-03-19 10:32:34.47479	2026-03-20 00:49:32.166935	t
3331	2026-03-10	12:29:00	22:07, 1:23, 3:35,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	18.30	🔺 So So	6.90	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.2g/1:40有點躁動，一直叫	\N	2	56	2026-03-10 12:30:07.09222	2026-03-11 01:21:04.122172	t
5519	2026-03-18	02:25:00	10:34, 13:42, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.20	15.60	🔺 So So	4.60	2	❌ - 🔺	17		\N	2	\N	2026-03-18 02:25:17.059214	2026-03-18 12:58:46.418912	f
3680	2026-03-13	01:40:00	15:35, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	24.70	🔺 So So	0.50	1	❌ - 🔺	15	加汪喵 櫻桃鴨 5g	\N	2	56	2026-03-13 01:40:47.854829	2026-03-13 12:39:08.467533	t
3324	2025-09-12	00:49:00	17:33, 20:22, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	41.40	29.40	🔺 So So	12.00	2	❌ - 🔺	17		\N	2	56	2026-03-10 09:57:43.305373	2026-03-10 09:59:06.794744	t
3319	2026-03-10	01:30:00	10:32, 13:23, 16:02, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	9.60	🔺 So So	15.40	3	❌ - 🔺	19		\N	2	56	2026-03-10 01:30:49.747662	2026-03-10 12:27:52.467782	t
5535	2026-03-20	12:30:00	00:26, 8:23, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	16.00	🔺 So So	4.00	2	❌ - 🔺	17		\N	2	\N	2026-03-20 12:30:25.149316	2026-03-21 01:03:07.710407	f
5539	2026-03-20	13:19:00	22:28, 00:33, 1:59, 5:16, 	Wet	ciao	旨定濃湯罐系列 a-233 (雞肉+干貝)	❌ No, not interested	75.00	21.70	💕 Love it So Much	53.30	4	❌ - 💕	31	3/21 => 5:13手肘被咬	\N	2	\N	2026-03-20 14:36:35.400489	2026-03-21 01:04:17.589317	f
5536	2026-03-20	13:19:00	22:29, 8:25, 	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	💖 Yes, eat right away	80.00	31.10	🔺 So So	48.90	2	💖 - 🔺	27		\N	2	\N	2026-03-20 13:19:24.146897	2026-03-21 01:05:01.917373	f
5533	2026-03-20	01:00:00	10:20, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	18.80	🔺 So So	1.20	1	❌ - 🔺	15		\N	2	\N	2026-03-20 01:00:28.776361	2026-03-20 12:29:44.680938	f
5531	2026-03-20	00:50:00	15:51, 19:12, 20:24, 	Wet	ciao	imc-223 果凍杯 鮪魚+雞肉+銀魚 x3	💖 Yes, eat right away	105.00	39.00	🔺 So So	66.00	3	💖 - 🔺	29		\N	2	\N	2026-03-20 00:53:28.919212	2026-03-20 12:32:15.056376	f
5530	2026-03-19	14:46:00	-	Kibble	indigo 英迪格	有機貓糧 幼貓 & 腸道配方	❌ No, not interested	41.00	41.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-19 14:47:04.059413	2026-03-20 00:49:02.326287	f
5529	2026-03-19	13:34:00	00:05, 1:31, 5:22,  ,6:54, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x3	💖 Yes, eat right away	105.00	39.80	💕 Love it So Much	65.20	4	💖 - 💕	41		\N	2	\N	2026-03-19 13:34:53.585705	2026-03-20 00:54:07.23496	f
3340	2026-03-11	01:26:00	11:40, 14:46, 16:51, 20:10, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	5.10	💕 Love it So Much	20.20	4	❌ - 💕	38	加汪喵 櫻桃鴨 5.3g	\N	2	56	2026-03-11 01:26:38.101637	2026-03-11 12:18:20.557273	t
4572	2026-03-14	01:03:00	9:44, 16:39, 19:25, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	14.00	🔺 So So	11.10	3	❌ - 🔺	19	加誠實貓 雞塊 4.9g	\N	2	56	2026-03-14 01:03:58.840144	2026-03-14 12:32:34.4252	t
4578	2026-03-14	12:33:00	20:41, 22:01, 23:17, 5:27, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	9.10	🔺 So So	15.90	4	❌ - 🔺	21	加誠實貓 雞塊 5g	\N	2	56	2026-03-14 12:34:01.716634	2026-03-15 01:32:13.670936	t
5552	2026-03-22	01:18:00	18:17, 19:52, 	Kibble	奧藍多	天然無穀貓糧 雞肉+火雞肉+鴨肉	❌ No, not interested	20.00	12.80	🔺 So So	7.20	2	❌ - 🔺	17		\N	2	65	2026-03-22 01:19:09.273102	2026-03-22 12:53:17.400514	t
5532	2026-03-20	00:57:00	10:21, 15:49, 19:11, 20:23, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	8.30	🔺 So So	16.70	4	❌ - 🔺	21	加誠實貓 雞塊 5g	6.70	2	56	2026-03-20 00:57:18.622132	2026-03-20 12:27:15.778408	t
5554	2026-03-22	01:25:00	19:53, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	5.10	🔺 So So	4.90	1	❌ - 🔺	15		\N	2	53	2026-03-22 01:26:19.601417	2026-03-22 12:54:47.448111	t
5538	2026-03-20	12:28:00	22:26, 00:27, 1:58, 8:24, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	12.40	🔺 So So	12.90	4	❌ - 🔺	21	加誠實貓 雞塊 5.3g	\N	2	56	2026-03-20 14:27:47.766074	2026-03-21 01:03:37.142858	t
5550	2026-03-21	13:38:00	9:00, 	Kibble	奧藍多	天然無穀貓糧 雞肉+火雞肉+鴨肉	❌ No, not interested	20.00	17.90	🔺 So So	2.10	1	❌ - 🔺	15		\N	2	\N	2026-03-21 13:38:59.817914	2026-03-22 01:15:33.598593	f
5549	2026-03-21	12:07:00	1:35, 3:09, 8:56, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	56.30	🔺 So So	73.70	3	💖 - 🔺	29		\N	2	\N	2026-03-21 12:07:53.222859	2026-03-22 01:16:30.289777	f
5543	2026-03-21	01:16:00	10:30, 16:44, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.40	0.60	💕 Love it So Much	9.80	2	💖 - 💕	44		\N	2	53	2026-03-21 01:17:15.824976	2026-03-21 12:00:29.211099	t
5542	2026-03-21	01:11:00	14:39, 16:47, 	Wet	銀湯匙	國產鮪魚餐包 片狀雞肉 p-5 x2	💖 Yes, eat right away	70.00	42.20	🔺 So So	27.80	2	💖 - 🔺	27		\N	2	\N	2026-03-21 01:12:47.640225	2026-03-21 12:03:38.179312	f
5544	2026-03-21	02:13:00	-	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	🔺 No, not really. Ate A Little	80.00	69.70	❌ No!!!	10.30	0	🔺 - ❌	13		\N	2	\N	2026-03-21 02:13:34.7052	2026-03-21 12:04:28.98573	f
5545	2026-03-21	02:29:00	-	Kibble	法米納	qc5 天然藜麥無穀機能 鴨肉蔓越莓	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	很躁動, 換野性魅力 觀察看看	\N	2	\N	2026-03-21 02:30:24.960988	2026-03-21 12:05:31.7746	f
2368	2026-03-07	12:42:00	21:41, 1:40, 03:27, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	13.80	🔺 So So	6.20	3	❌ - 🔺	19	21:42 吐食物	\N	2	\N	2026-03-07 12:42:18.794999	2026-03-08 02:21:49.376658	f
5540	2026-03-21	01:07:00	11:11, 18:13, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.70	17.70	🔺 So So	8.00	2	❌ - 🔺	17	加誠實貓 雞塊 5.3g	\N	2	56	2026-03-21 01:09:18.282778	2026-03-21 11:57:43.522283	t
2377	2026-03-08	02:41:00	14:15, 16:57, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	5.70	🔺 So So	4.30	2	❌ - 🔺	17		\N	2	53	2026-03-08 02:41:46.891073	2026-03-08 12:17:15.812448	t
2381	2026-03-08	12:18:00	22:44, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.80	🔺 So So	3.20	1	❌ - 🔺	15		\N	2	53	2026-03-08 12:18:17.078684	2026-03-09 01:20:26.698256	t
3679	2026-03-13	01:38:00	12:51, 17:36, 18:53, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	12.30	🔺 So So	7.70	3	❌ - 🔺	19		\N	2	\N	2026-03-13 01:38:24.654666	2026-03-13 12:36:11.469332	f
2383	2026-03-08	12:23:00	22:43, 00:33, 3:26,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	12.10	🔺 So So	7.90	3	❌ - 🔺	19		\N	2	\N	2026-03-08 12:23:57.941252	2026-03-09 01:19:09.372793	f
3325	2025-09-12	00:49:00	9:46, 11:49, 20:23,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.00	15.60	🔺 So So	5.40	3	❌ - 🔺	19		\N	2	\N	2026-03-10 10:05:08.123178	2026-03-10 10:06:34.405835	f
3385	2026-03-12	17:21:00	3:49, 	Kibble	曙光	無穀滋養鴨肉食譜	💖 Yes, eat right away	20.00	14.00	🔺 So So	6.00	1	💖 - 🔺	25	一直叫, 跟上跟下	\N	2	\N	2026-03-11 17:21:42.344163	2026-03-12 01:09:08.711469	f
5522	2026-03-18	12:59:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-18 12:59:24.845507	2026-03-19 00:59:48.993833	f
5541	2026-03-21	01:10:00	-	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	19.40	19.40	❌ No!!!	0.00	0	❌ - ❌	8	一直叫, 換成法米納 QC5	\N	2	\N	2026-03-21 01:10:34.087677	2026-03-21 02:31:10.463736	f
5548	2026-03-21	12:02:00	21:31, 1:19, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.40	🔺 So So	6.60	2	❌ - 🔺	17		\N	2	53	2026-03-21 12:02:24.488743	2026-03-22 01:14:44.84173	t
5551	2026-03-22	01:11:00	10:21, 15:17, 18:18, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	52.00	🔺 So So	53.00	3	💖 - 🔺	29		\N	2	\N	2026-03-22 01:11:52.567604	2026-03-22 12:56:38.187558	f
5565	2026-03-23	09:19:00	-	Wet	ciao	綜合海鮮慕斯啾嚕杯 nc-96 雞柳	💖 Yes, eat right away	60.00	31.80	❌ No!!!	28.20	0	💖 - ❌	18		\N	2	\N	2026-03-23 09:21:06.417141	2026-03-24 00:54:10.272303	f
5570	2026-03-23	12:40:00	23:32, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.40	7.40	🔺 So So	3.00	1	❌ - 🔺	15		\N	2	53	2026-03-23 12:40:39.148955	2026-03-24 00:52:28.657469	t
5559	2026-03-23	00:48:00	11:50, 	Wet	ciao	柴魚鮮味餐包(鮪魚+扇貝) ic-353 x2	🔺 No, not really. Ate A Little	80.00	53.80	🔺 So So	26.20	1	🔺 - 🔺	20	9:30 => 有點躁動，加放ciao IC-533/17:15 => 吐 (感覺過餓)	\N	2	\N	2026-03-23 00:48:56.1401	2026-03-23 09:22:54.932579	f
5564	2026-03-23	01:45:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	🔺 No, not really. Ate A Little	60.00	45.00	❌ No!!!	15.00	0	🔺 - ❌	13		\N	2	\N	2026-03-23 01:45:29.349621	2026-03-23 09:23:57.663384	f
5558	2026-03-22	12:55:00	8:38, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	7.20	🔺 So So	3.00	1	❌ - 🔺	15		\N	2	53	2026-03-22 12:55:40.51981	2026-03-23 00:51:04.365951	t
5563	2026-03-23	01:38:00	-	Freeze-Dried	曙光	無穀鴨肉凍乾生食	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-23 01:38:46.744393	2026-03-23 09:24:28.24903	f
5555	2026-03-22	12:47:00	22:42, 00:03, 4:15, 8:36, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	17.90	💕 Love it So Much	87.10	4	💖 - 💕	48		\N	2	\N	2026-03-22 12:47:55.855878	2026-03-23 00:51:59.597603	f
5576	2026-03-24	04:07:00	16:20, 19:22, 20:02, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	43.60	💕 Love it So Much	61.40	3	💖 - 💕	39		\N	2	\N	2026-03-24 04:08:07.109404	2026-03-24 13:20:53.585042	f
5578	2026-03-24	13:16:00	23:41, 2:07, 7:42,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.80	10.30	🔺 So So	11.50	3	❌ - 🔺	19	加1.7g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	67	2026-03-24 13:17:00.886112	2026-03-25 00:55:01.57431	f
5547	2026-03-21	11:59:00	22:04, 23:19, 3:06,  8:14, 8:54, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	8.10	🔺 So So	17.20	5	❌ - 🔺	23	加誠實貓 雞塊 5.1g	\N	2	56	2026-03-21 11:59:26.582014	2026-03-22 01:13:17.674068	t
5571	2026-03-24	00:49:00	-	Wet	ciao	多樂米濃湯罐 a-111 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	50.90	❌ No!!!	29.10	0	💖 - ❌	18	12:04 => 要回頭吃時, 聞一聞就不吃了	\N	2	\N	2026-03-24 00:50:06.890201	2026-03-24 04:07:48.222835	f
5553	2026-03-22	01:23:00	10:20, 14:54, 15:16, 20:42, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	16.80	🔺 So So	8.20	4	❌ - 🔺	21	加誠實貓 雞塊 5g	\N	2	56	2026-03-22 01:23:15.982209	2026-03-22 12:49:31.549551	t
5557	2026-03-22	12:54:00	00:01, 8:36, 	Kibble	奧藍多	天然無穀貓糧 雞肉+火雞肉+鴨肉	❌ No, not interested	20.00	14.80	🔺 So So	5.20	2	❌ - 🔺	17		\N	2	65	2026-03-22 12:54:12.517961	2026-03-23 00:50:42.382308	t
5572	2026-03-24	00:56:00	12:03, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	24.80	🔺 So So	0.60	1	❌ - 🔺	15	加汪喵 櫻桃鴨 5g	\N	2	56	2026-03-24 00:56:53.574273	2026-03-25 00:54:30.555447	t
5567	2026-03-23	10:07:00	19:17, 20:09, 23:57, 1:04, 3:50, 	Wet	ciao 	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	🔺 No, not really. Ate A Little	80.00	18.90	💕 Love it So Much	61.10	5	🔺 - 💕	45		\N	2	\N	2026-03-23 10:07:13.960887	2026-03-24 00:53:20.474758	f
5574	2026-03-24	01:44:00	-	Kibble	安娜美廚	極鮮 泌尿保健配方 雞肉&白魚	❌ No, not interested	28.70	28.70	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-24 01:45:02.418846	2026-03-24 11:26:07.222944	f
5577	2026-03-24	13:12:00	22:16, 23:42, 2:10, 6:16, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	41.40	💕 Love it So Much	88.60	4	💖 - 💕	41		\N	2	\N	2026-03-24 13:14:32.729678	2026-03-25 00:57:04.788964	f
5575	2026-03-24	02:03:00	12:02, 18:27, 19:21, 20:01, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.80	9.00	💕 Love it So Much	12.80	4	❌ - 💕	31	加1.1g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	67	2026-03-24 02:03:41.808619	2026-03-24 13:15:22.509378	f
5580	2026-03-25	00:46:00	-	Wet	銀湯匙	濃郁鮪魚 鰹魚 雞胸肉 tw tmc 124	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	完全不吃, 直接換掉	\N	2	\N	2026-03-25 00:49:48.6849	2026-03-25 00:50:13.543067	f
5556	2026-03-22	12:52:00	22:41, 00:02, 4:14, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	16.40	🔺 So So	9.00	3	❌ - 🔺	19	加誠實貓 雞塊 5.4g	\N	2	56	2026-03-22 12:52:22.203202	2026-03-23 00:50:19.296485	t
5560	2026-03-23	00:55:00	11:49, 17:47, 20:08, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	10.30	🔺 So So	14.70	3	❌ - 🔺	19	加誠實貓 雞塊 5g/17:15 => 吐 (感覺過餓)	\N	2	56	2026-03-23 00:55:51.996302	2026-03-23 12:37:40.739987	t
5566	2026-03-23	09:45:00	-	Freeze-Dried	ve 唯一	貓用酥脆顆粒 鴨肉	❌ No, not interested	10.20	10.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-23 09:46:06.163106	2026-03-24 00:51:26.011467	f
5581	2026-03-25	00:52:00	17:04, 17:59, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	23.50	🔺 So So	36.50	2	💖 - 🔺	27		\N	2	\N	2026-03-25 00:52:31.994454	2026-03-25 12:25:41.083363	f
5582	2026-03-25	00:52:00	9:41, 11:45, 	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉	💖 Yes, eat right away	35.00	3.40	💕 Love it So Much	31.60	2	💖 - 💕	44		\N	2	\N	2026-03-25 00:53:15.08665	2026-03-25 12:26:15.849801	f
5585	2026-03-25	01:02:00	-	Freeze-Dried	ve 唯一	貓用酥脆顆粒 鴨肉	❌ No, not interested	10.00	10.00	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-25 01:02:46.957943	2026-03-26 00:50:44.264207	f
3313	2026-03-09	03:12:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.30	20.30	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-03-09 03:12:52.280326	2026-03-10 01:25:37.543551	f
5584	2026-03-25	01:01:00	11:43, 14:43, 17:03, 17:57, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.50	8.40	💕 Love it So Much	13.10	4	❌ - 💕	31	加1.5g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	67	2026-03-25 01:01:15.755526	2026-03-25 12:22:18.240887	f
5596	2026-03-27	01:23:00	-	Kibble	法米納	天然頂級無穀系列 雞肉石榴 (室內/結紮貓) gc6	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8	加1.0g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	\N	2026-03-27 01:24:09.108697	2026-03-28 00:59:43.476458	f
5598	2026-03-27	01:30:00	11:44, 	Wet	ciao	imc-223 果凍杯 鮪魚+雞肉+銀魚 x3	💖 Yes, eat right away	105.00	66.70	🔺 So So	38.30	1	💖 - 🔺	25	18:00 在腳邊一直繞來繞去	\N	2	\N	2026-03-27 01:30:44.204408	2026-03-27 10:02:19.870707	f
5561	2026-03-23	00:56:00	16:52, 3:49, 	Kibble	奧藍多	天然無穀貓糧 雞肉+火雞肉+鴨肉	❌ No, not interested	15.00	10.20	🔺 So So	4.80	2	❌ - 🔺	17		\N	2	65	2026-03-23 00:57:08.946509	2026-03-24 00:51:57.474129	t
5590	2026-03-26	00:58:00	10:36, 16:18, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	6.10	🔺 So So	3.90	2	❌ - 🔺	17		\N	2	53	2026-03-26 00:58:23.735662	2026-03-27 01:18:31.234024	t
5586	2026-03-25	12:23:00	21:46, 1:23, 3:54, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	21.80	10.30	🔺 So So	11.50	3	❌ - 🔺	19	加1.6g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	67	2026-03-25 12:24:05.095742	2026-03-26 00:51:46.008376	f
5587	2026-03-25	12:33:00	21:46, 23:34, 2:10, 3:55, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	16.90	💕 Love it So Much	88.10	4	💖 - 💕	48		\N	2	\N	2026-03-25 12:33:42.942308	2026-03-26 00:52:57.844548	f
3315	2026-03-09	13:07:00	-	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	10.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	53	2026-03-09 13:07:15.609368	2026-03-10 01:25:02.9911	t
5591	2026-03-26	12:34:00	22:11, 3:07, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	20.40	14.30	🔺 So So	6.10	2	❌ - 🔺	17		\N	2	67	2026-03-26 12:34:17.297777	2026-03-27 01:17:59.084483	f
5604	2026-03-28	01:06:00	-	Kibble	奧藍多	天然無穀貓糧 雞肉+火雞肉+鴨肉	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	不吃, 一直叫, 倒掉, 改天再放	\N	2	65	2026-03-28 01:06:25.004626	2026-03-28 02:02:19.627942	f
5592	2026-03-26	12:54:00	22:12, 3:10, 6:53	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x3	💖 Yes, eat right away	105.00	41.10	💕 Love it So Much	63.90	3	💖 - 💕	39		\N	2	\N	2026-03-26 12:54:43.958973	2026-03-27 01:19:15.591788	f
5593	2026-03-27	17:13:00	-	Wet	ciao	多樂米濃湯罐 a-44 雞肉+鰹魚+干貝	🔺 No, not really. Ate A Little	80.00	73.00	❌ No!!!	7.00	0	🔺 - ❌	13	一直叫, 有點躁動	\N	2	\N	2026-03-26 17:13:26.750731	2026-03-27 01:19:55.857928	f
5589	2026-03-26	00:55:00	15:24, 16:17, 19:11, 19:49, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	22.10	15.10	💕 Love it So Much	7.00	4	❌ - 💕	31	加1.8g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	67	2026-03-26 00:55:59.579318	2026-03-26 12:33:03.791059	f
5588	2026-03-26	00:49:00	10:37, 15:25, 	Wet	ciao	豪華罐 a-141 鮪魚+雞肉+頂級鮪魚	💖 Yes, eat right away	80.00	36.10	🔺 So So	43.90	2	💖 - 🔺	27		\N	2	\N	2026-03-26 00:50:08.025436	2026-03-26 12:36:58.732021	f
5597	2026-03-27	01:25:00	-	Wet	sheba	鮮饌包 鮪魚+雞肉 (sri103) x2	❌ No, not interested	70.00	70.00	❌ No!!!	0.00	0	❌ - ❌	8	聞一聞, 馬上走掉, 直接換掉	\N	2	\N	2026-03-27 01:27:32.459449	2026-03-27 01:31:09.916341	f
5573	2026-03-24	00:59:00	10:22, 16:19, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	3.60	🔺 So So	6.40	2	❌ - 🔺	17		\N	2	53	2026-03-24 00:59:40.64428	2026-03-24 13:18:27.336064	t
5600	2026-03-27	12:50:00	21:56, 22:56, 1:17, 4:27, 8:28,	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	28.90	💕 Love it So Much	76.10	5	💖 - 💕	43		\N	2	\N	2026-03-27 12:50:11.962102	2026-03-28 01:00:58.005484	f
5608	2026-03-29	18:01:00	2:31, 	Wet	ciao	多樂米濃湯罐 a-41 雞肉+鮪魚+干貝	🔺 No, not really. Ate A Little	80.00	55.10	🔺 So So	24.90	1	🔺 - 🔺	20		\N	2	\N	2026-03-28 18:01:58.754534	2026-03-29 01:32:48.579606	f
5579	2026-03-24	13:19:00	22:15, 23:40, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	5.20	🔺 So So	4.80	2	❌ - 🔺	17		\N	2	53	2026-03-24 13:19:31.260712	2026-03-25 00:55:39.164944	t
5602	2026-03-28	00:58:00	15:15, 16:52, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	46.00	🔺 So So	59.00	2	💖 - 🔺	27		\N	2	\N	2026-03-28 00:58:58.9492	2026-03-28 12:39:23.372007	f
5594	2026-03-27	17:19:00	3:08, 6:51,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	💖 Yes, eat right away	20.50	0.70	💕 Love it So Much	19.80	2	💖 - 💕	44	加0.5g 卡尼 雞胸原肉 誘食凍乾粉/換了罐頭只吃一點點, 還是一直叫, 懷疑不想吃曙光	\N	2	56	2026-03-26 17:19:28.223911	2026-03-27 01:17:35.260825	t
5562	2026-03-23	00:58:00	14:19, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	6.40	🔺 So So	3.80	1	❌ - 🔺	15	17:15 => 吐 (感覺過餓)	\N	2	53	2026-03-23 00:58:18.043614	2026-03-23 12:39:33.788949	t
5657	2026-04-02	10:22:00	20:23, 	Wet	ciao	布丁杯 雞肉 imc-153	💖 Yes, eat right away	65.00	29.40	💕 Love it So Much	35.60	1	💖 - 💕	35		\N	2	\N	2026-04-02 10:22:36.77453	2026-04-02 13:08:02.020467	f
5606	2026-03-28	12:36:00	21:34, 1:47, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	110.60	🔺 So So	19.40	2	💖 - 🔺	27	3/29 1:48 => 吃完馬上吐	\N	2	\N	2026-03-28 12:36:29.378557	2026-03-28 18:14:38.598252	f
5617	2026-03-29	03:03:00	-	Wet	ciao	旅日系列餐包 ic-167 長崎小魚乾高湯+北海道干貝高湯 - 長崎小魚乾高湯 ic-16g x2	❌ No, not interested	40.00	40.00	❌ No!!!	0.00	0	❌ - ❌	8	很躁動, 感覺肚子餓, 但沒吃, 改放IC-533就馬上吃	\N	2	\N	2026-03-29 03:04:29.396584	2026-03-29 03:13:29.676809	f
5614	2026-03-29	01:29:00	-	Wet	axia	新金罐濃厚4號- 鮪, 雞gnt-4	💖 Yes, eat right away	70.00	46.30	❌ No!!!	23.70	0	💖 - ❌	18	後來回頭沒吃, 換IC-533	\N	2	\N	2026-03-29 01:30:08.590855	2026-03-29 03:15:29.952626	f
5611	2026-03-29	18:16:00	2:30, 4:33, 	Kibble	奧藍多	天然無穀貓糧 雞肉+火雞肉+鴨肉	❌ No, not interested	20.00	17.60	🔺 So So	2.40	2	❌ - 🔺	17		\N	2	65	2026-03-28 18:16:55.442395	2026-03-29 01:31:13.773049	f
5613	2026-03-29	18:35:00	4:32, 	Wet	ciao	旨定濃湯罐系列 a-232 (鰹魚+雞肉+柴魚片)	🔺 No, not really. Ate A Little	75.00	53.60	🔺 So So	21.40	1	🔺 - 🔺	20		\N	2	\N	2026-03-28 18:35:19.003662	2026-03-29 01:33:49.622581	f
5622	2026-03-29	12:51:00	22:13, 00:09, 00:36, 4:57, 8:20, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	14.00	💕 Love it So Much	91.00	5	💖 - 💕	50		\N	2	\N	2026-03-29 12:51:10.76109	2026-03-30 01:02:17.029973	f
5607	2026-03-28	12:38:00	21:33, 23:23, 1:44, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	10.60	🔺 So So	19.40	3	❌ - 🔺	19	3/29 1:48 => 吃完馬上吐	\N	2	56	2026-03-28 12:38:27.294369	2026-03-28 18:07:43.384543	t
5615	2026-03-29	01:36:00	10:48, 18:41, 	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.40	18.50	🔺 So So	6.90	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.4g	\N	2	67	2026-03-29 01:36:53.623358	2026-03-29 12:21:43.268291	f
5626	2026-03-30	01:07:00	-	Kibble	奧藍多	天然無穀貓糧 雞肉+火雞肉+鴨肉	❌ No, not interested	20.20	20.20	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	65	2026-03-30 01:07:42.830578	2026-03-30 07:00:04.39153	f
5619	2026-03-29	04:18:00	18:42, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	55.20	🔺 So So	29.80	1	💖 - 🔺	25		\N	2	\N	2026-03-29 04:19:10.977801	2026-03-29 12:25:07.433993	f
5618	2026-03-29	03:13:00	-	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味)	🔺 No, not really. Ate A Little	60.00	48.80	❌ No!!!	11.20	0	🔺 - ❌	13		\N	2	\N	2026-03-29 03:13:55.605736	2026-03-29 12:25:49.395665	f
5621	2026-03-29	12:23:00	20:47, 00:08, 8:23,	Kibble	曙光	無穀滋養鴨肉食譜	❌ No, not interested	25.10	20.00	🔺 So So	5.10	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.1g	\N	2	67	2026-03-29 12:23:59.06917	2026-03-30 01:01:00.426793	f
5583	2026-03-25	00:58:00	14:44, 00:37,	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	5.60	🔺 So So	4.40	2	❌ - 🔺	17		\N	2	53	2026-03-25 00:58:48.522468	2026-03-26 00:51:17.416704	t
5605	2026-03-28	02:01:00	13:09, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	3.40	🔺 So So	6.80	1	❌ - 🔺	15		\N	2	53	2026-03-28 02:01:50.984458	2026-03-29 01:30:42.930545	t
5624	2026-03-30	00:58:00	-	Wet	ciao	ic49 多樂米雞肉沾醬 20g x4	💖 Yes, eat right away	80.00	43.20	❌ No!!!	36.80	0	💖 - ❌	18		\N	2	\N	2026-03-30 00:59:07.446885	2026-03-30 02:28:54.476255	f
5627	2026-03-30	01:11:00	19:11, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	9.10	🔺 So So	0.90	1	❌ - 🔺	15		\N	2	53	2026-03-30 01:12:11.279215	2026-03-31 01:07:50.047897	f
5623	2026-03-30	00:54:00	-	Wet	ciao 	每日魚肉凍餐包 ic-615 鮪魚鰹魚雞肉鮪魚片	🔺 No, not really. Ate A Little	60.00	55.60	❌ No!!!	4.40	0	🔺 - ❌	13		\N	2	\N	2026-03-30 00:58:19.392808	2026-03-30 02:01:46.53184	f
5628	2026-03-30	02:01:00	-	Wet	ciao	imc-221 果凍杯 鮪魚+雞肉 x3	❌ No, not interested	105.00	105.00	❌ No!!!	0.00	0	❌ - ❌	8	沒吃, 有點躁動	\N	2	\N	2026-03-30 02:02:08.135391	2026-03-30 02:21:28.730609	f
5651	2026-04-02	16:08:00	1:04, 1:06, 6:08, 	Freeze-Dried	卡尼	純肉零食 熟 無刺鮮香 虱目魚凍乾	❌ No, not interested	5.00	0.90	💕 Love it So Much	4.10	3	❌ - 💕	36		\N	2	\N	2026-04-01 16:09:41.880503	2026-04-02 00:59:46.162518	f
5638	2026-03-31	02:15:00	-	Kibble	原點	雞肉無穀全貓配方	❌ No, not interested	20.00	20.00	❌ No!!!	0.00	0	❌ - ❌	8	00:20 加卡尼雞胸肉 誘食粉	\N	2	69	2026-03-31 02:30:02.689322	2026-04-01 01:13:17.137711	f
5639	2026-03-31	02:37:00	16:05, 2:37, 4:19, 6:47, 	Freeze-Dried	誠實貓	雞肉凍乾	💖 Yes, eat right away	5.50	0.00	💕 Love it So Much	5.50	4	💖 - 💕	48		\N	2	70	2026-03-31 02:37:30.375393	2026-04-01 01:13:34.901699	f
5630	2026-03-30	02:20:00	13:35, 16:30, 	Wet	ciao 	a-143 豪華罐 (鮭魚+鮪魚+雞肉)	💖 Yes, eat right away	80.00	40.30	🔺 So So	39.70	2	💖 - 🔺	27		\N	2	\N	2026-03-30 02:20:35.854075	2026-03-30 12:55:30.528925	f
5640	2026-03-31	07:48:00	16:07, 18:11, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x2	💖 Yes, eat right away	70.00	31.60	💕 Love it So Much	38.40	2	💖 - 💕	37		\N	2	\N	2026-03-31 07:48:46.497911	2026-03-31 12:47:50.558099	f
5636	2026-03-31	01:16:00	12:45, 	Wet	ciao	多樂米濃湯罐 a-43 (雞肉+鮪魚+蟹肉)	💖 Yes, eat right away	80.00	42.40	🔺 So So	37.60	1	💖 - 🔺	25		\N	2	\N	2026-03-31 01:17:18.480504	2026-03-31 12:48:26.812298	f
5629	2026-03-30	02:15:00	-	Kibble	第一饗宴 firstmate	無穀低敏 鴨肉藍莓全貓配方	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	68	2026-03-30 02:15:35.561116	2026-03-31 01:07:14.269151	f
5631	2026-03-30	10:35:00	-	Wet	ciao	旨定濃湯罐系列 a-231(鮪魚+雞肉)	🔺 No, not really. Ate A Little	75.00	61.30	❌ No!!!	13.70	0	🔺 - ❌	13		\N	2	\N	2026-03-30 10:36:08.74119	2026-03-31 01:08:37.028819	f
5633	2026-03-30	12:59:00	21:37, 23:23, 1:25, 3:11,	Wet	ciao	布丁杯 雞肉 imc-153 x2	❌ No, not interested	130.00	60.00	🔺 So So	70.00	4	❌ - 🔺	21		\N	2	\N	2026-03-30 12:59:24.095298	2026-03-31 01:09:39.683517	f
5641	2026-03-31	12:43:00	22:02, 00:21, 2:36, 6:49, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	25.30	💕 Love it So Much	79.70	4	💖 - 💕	48		\N	2	\N	2026-03-31 12:43:50.934838	2026-04-01 01:14:43.259506	f
5647	2026-04-01	01:23:00	6:16, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	💖 Yes, eat right away	10.00	1.90	💕 Love it So Much	8.10	1	💖 - 💕	42		\N	2	53	2026-04-01 01:23:36.257036	2026-04-02 01:00:38.748351	f
5646	2026-04-01	01:22:00	-	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	20.40	20.40	❌ No!!!	0.00	0	❌ - ❌	8		\N	2	\N	2026-04-01 01:22:10.555554	2026-04-02 01:00:13.707037	t
5643	2026-04-01	01:09:00	9:56, 14:01, 15:57, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	23.90	💕 Love it So Much	81.10	3	💖 - 💕	46		\N	2	\N	2026-04-01 01:10:02.933504	2026-04-01 13:06:56.759474	f
5648	2026-04-01	10:29:00	20:21, 	Wet	ciao	imc-224 雙喵杯 鮪魚+雞肉+柴魚片	❌ No, not interested	35.00	21.30	🔺 So So	13.70	1	❌ - 🔺	15		\N	2	\N	2026-04-01 10:29:16.956274	2026-04-01 13:07:30.065456	f
5650	2026-04-01	13:19:00	22:05, 1:05, 2:06, 	Wet	ciao	豪華罐 a-142 鮪魚+雞肉+干貝	💖 Yes, eat right away	80.00	35.90	🔺 So So	44.10	3	💖 - 🔺	29		\N	2	\N	2026-04-01 13:20:07.574594	2026-04-02 01:02:06.766852	f
5655	2026-04-02	02:25:00	11:06, 13:25, 15:59, 	Wet	ciao	豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	60.00	20.40	🔺 So So	39.60	3	💖 - 🔺	29		\N	2	\N	2026-04-02 02:25:37.174335	2026-04-02 10:23:17.864696	f
5654	2026-04-02	01:26:00	-	Wet	銀湯匙	貓罐頭 濃郁鮪魚 tw tmp 123	🔺 No, not really. Ate A Little	70.00	54.30	❌ No!!!	15.70	0	🔺 - ❌	13		\N	2	\N	2026-04-02 01:26:56.205563	2026-04-02 04:28:30.900205	f
5653	2026-04-02	01:08:00	12:04, 20:22, 	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	25.40	19.20	🔺 So So	6.20	2	❌ - 🔺	17	加誠實貓 雞塊 5.1g	\N	2	\N	2026-04-02 01:08:20.839203	2026-04-02 13:03:25.412663	t
5656	2026-04-02	10:10:00	21:45, 	Freeze-Dried	汪喵星球	凍乾主食餐 安心雞肉	💖 Yes, eat right away	10.00	5.90	🔺 So So	4.10	1	💖 - 🔺	25		\N	2	73	2026-04-02 10:10:59.354126	2026-04-03 01:38:50.254646	f
5660	2026-04-02	13:45:00	00:14, 00:58, 8:46, 	Wet	mon petit 貓倍麗	嚴選金罐懷石鮪魚料理(嚴選吞拿魚塊)	💖 Yes, eat right away	85.00	35.80	🔺 So So	49.20	3	💖 - 🔺	29		\N	2	\N	2026-04-02 13:46:04.473753	2026-04-03 01:40:05.029321	f
5677	2026-04-05	01:21:00	11:00, 13:54, 16:12, 17:18, 20:06, 	Wet	ciao	布丁杯 雞肉 imc-153 x2	💖 Yes, eat right away	130.00	50.00	🔺 So So	80.00	5	💖 - 🔺	33		\N	2	\N	2026-04-05 01:21:54.191516	2026-04-05 13:23:47.488954	f
5625	2026-03-30	01:05:00	13:33, 16:28, 19:08, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	4.90	💕 Love it So Much	20.40	3	❌ - 💕	36	加汪喵 櫻桃鴨 5.3g	\N	2	56	2026-03-30 01:05:54.297834	2026-03-30 12:50:01.147919	t
5679	2026-04-05	01:27:00	17:16, 22:13, 	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	12.00	6.90	🔺 So So	5.10	2	❌ - 🔺	17		\N	2	\N	2026-04-05 01:27:57.078034	2026-04-06 01:10:09.949645	f
5682	2026-04-05	01:25:00	13:51, 16:10, 17:18, 20:05, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	23.60	9.60	💕 Love it So Much	14.00	4	❌ - 💕	31	加 卡尼 純肉零食 熟 無刺鮮香 虱目魚凍乾 3.6g	\N	2	56	2026-04-05 01:32:16.736958	2026-04-05 13:21:27.520236	t
5620	2026-03-29	12:20:00	22:12, 00:35, 4:56,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	12.40	🔺 So So	13.00	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.2g	\N	2	56	2026-03-29 12:21:01.075757	2026-03-30 01:01:26.971045	t
5658	2026-04-02	13:05:00	3:17,  7:06, 	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	25.10	22.00	🔺 So So	3.10	2	❌ - 🔺	17	加誠實貓 雞塊 5.1g	\N	2	\N	2026-04-02 13:05:16.032564	2026-04-03 01:38:02.521309	t
5612	2026-03-29	18:17:00	4:31, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	14.90	🔺 So So	5.10	1	❌ - 🔺	15		\N	2	56	2026-03-28 18:17:24.316194	2026-03-29 01:31:43.124043	t
5667	2026-04-03	12:31:00	22:17, 7:42, 	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	25.10	21.40	🔺 So So	3.70	2	❌ - 🔺	17	加誠實貓 雞塊 5.1g	\N	2	\N	2026-04-03 12:32:01.419586	2026-04-04 02:21:37.738965	t
4961	2026-03-16	13:08:00	21:32, 23:19,  2:21, 4:58, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	4.20	🔺 So So	20.80	4	❌ - 🔺	28	加誠實貓 雞塊 5g	\N	2	56	2026-03-16 13:09:09.887836	2026-03-17 01:13:55.501533	t
5664	2026-04-03	03:40:00	17:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 安心雞肉	🔺 No, not really. Ate A Little	9.70	7.50	🔺 So So	2.20	1	🔺 - 🔺	20		\N	2	\N	2026-04-03 03:45:44.170712	2026-04-04 02:22:19.845499	f
5666	2026-04-03	12:30:00	21:20, 1:17, 2:52, 7:42, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	29.40	💕 Love it So Much	75.60	4	💖 - 💕	41		\N	2	\N	2026-04-03 12:30:13.706031	2026-04-04 02:23:12.984479	f
5662	2026-04-03	01:46:00	13:42, 	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	25.10	20.00	🔺 So So	5.10	1	❌ - 🔺	15	加誠實貓 雞塊 5.1g	\N	2	\N	2026-04-03 01:46:27.052942	2026-04-03 12:30:48.371646	f
5661	2026-04-03	01:43:00	20:26, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	22.60	🔺 So So	2.70	1	❌ - 🔺	15	加誠實貓 雞塊 5.3g	\N	2	\N	2026-04-03 01:43:59.576716	2026-04-03 12:32:40.155452	f
5665	2026-04-03	03:58:00	16:31, 17:22, 19:24, 	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	🔺 No, not really. Ate A Little	105.00	48.90	🔺 So So	56.10	3	🔺 - 🔺	24		\N	2	\N	2026-04-03 03:58:30.78085	2026-04-03 12:34:54.384024	f
5663	2026-04-03	01:50:00	11:44, 	Wet	ciao	多樂米濃湯罐 a-42 ( 雞肉+鮪魚+柴魚片)	🔺 No, not really. Ate A Little	80.00	53.20	🔺 So So	26.80	1	🔺 - 🔺	20	整天有點躁動	\N	2	\N	2026-04-03 01:50:27.228493	2026-04-03 12:35:48.100163	f
5668	2026-04-03	12:33:00	21:17, 1:15, 2:50, 7:39, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	4.20	🔺 So So	21.00	4	❌ - 🔺	28	加誠實貓 雞塊 5.2g	\N	2	56	2026-04-03 12:33:35.837912	2026-04-04 02:21:16.581735	t
5684	2026-04-05	14:15:00	2:59, 4:34, 	Wet	ciao	原湯杯54號 (雞肉+蟹肉+吻仔魚) x2	💖 Yes, eat right away	120.00	59.00	🔺 So So	61.00	2	💖 - 🔺	27	3:00 => 一直叫，很躁動	\N	2	\N	2026-04-05 14:16:21.398862	2026-04-06 01:11:21.269264	f
5685	2026-04-06	01:07:00	10:02, 	Wet	ciao	imc-222 果凍杯 鮪魚+雞肉+干貝 x3	💖 Yes, eat right away	105.00	72.10	🔺 So So	32.90	1	💖 - 🔺	25		\N	2	\N	2026-04-06 01:07:45.615204	2026-04-06 12:07:03.118642	f
5671	2026-04-04	02:30:00	11:11, 18:21, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.00	1.70	💕 Love it So Much	8.30	2	❌ - 💕	34		\N	2	53	2026-04-04 02:30:31.625273	2026-04-05 01:23:26.392618	f
5674	2026-04-04	10:46:00	19:27, 1:05, 	Freeze-Dried	卡尼	純肉零食 熟 無刺鮮香 虱目魚凍乾	❌ No, not interested	5.50	1.10	💕 Love it So Much	4.40	2	❌ - 💕	34		\N	2	\N	2026-04-04 10:46:25.833288	2026-04-05 01:24:03.819502	f
5642	2026-03-31	12:46:00	22:01, 23:22, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	26.00	15.10	🔺 So So	10.90	2	❌ - 🔺	17	加誠實貓 雞塊 5.6g/00:20 加卡尼雞胸肉 誘食粉	\N	2	56	2026-03-31 12:46:16.066036	2026-04-01 01:13:59.727421	t
5672	2026-04-04	02:32:00	11:56, 13:24, 16:11, 	Wet	ciao	啾嚕奢華果凍杯 tsc-46 雞肉+干貝 x3	💖 Yes, eat right away	105.00	31.10	💕 Love it So Much	73.90	3	💖 - 💕	39		\N	2	\N	2026-04-04 02:32:31.098295	2026-04-04 12:45:13.277354	f
5676	2026-04-04	10:31:00	20:33, 21:12, 1:04, 4:03, 	Wet	ciao	四連串包 tcr-145 乳酸菌 2000億個 雞肉& 鮭魚 x4	🔺 No, not really. Ate A Little	140.00	42.20	💕 Love it So Much	97.80	4	🔺 - 💕	36	20:40 追加2 x35g	\N	2	\N	2026-04-04 12:46:47.453151	2026-04-05 01:26:17.946521	f
5670	2026-04-04	02:28:00	-	Kibble	法米納	qc6 天然藜麥無穀機能系列 室內貓體態泌尿保健 鴨肉蘆筍	❌ No, not interested	22.30	22.30	❌ No!!!	0.00	0	❌ - ❌	8	加2.1g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	\N	2026-04-04 02:28:28.693656	2026-04-05 01:22:28.33314	t
5634	2026-03-31	01:13:00	12:44, 18:09, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.60	11.80	🔺 So So	13.80	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.4g	\N	2	56	2026-03-31 01:13:47.841583	2026-03-31 12:44:26.120204	t
5644	2026-04-01	01:17:00	11:21, 14:00, 15:53, 17:02, 20:19, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	6.80	💕 Love it So Much	18.20	5	❌ - 💕	33	加誠實貓 雞塊 5g	\N	2	56	2026-04-01 01:17:45.764775	2026-04-01 13:03:45.874443	t
5649	2026-04-01	13:05:00	21:18, 22:03, 1:05, 2:05	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.50	10.60	🔺 So So	14.90	4	❌ - 🔺	21	加誠實貓 雞塊 5.5g	\N	2	56	2026-04-01 13:05:28.539278	2026-04-02 01:01:11.825819	t
5659	2026-04-02	13:06:00	21:44, 3:15, 7:04, 8:44, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.00	7.80	🔺 So So	17.20	4	❌ - 🔺	21		\N	2	56	2026-04-02 13:06:48.409235	2026-04-03 01:38:27.324083	t
5652	2026-04-02	01:04:00	13:23, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	21.20	🔺 So So	4.20	1	❌ - 🔺	15	加誠實貓 雞塊 5.1g	\N	2	56	2026-04-02 01:04:21.261413	2026-04-02 13:06:35.747334	t
4956	2026-03-16	01:47:00	10:24, 12:29, 16:51, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	15.10	🔺 So So	10.00	3	❌ - 🔺	19	加誠實貓 雞塊 5.1g	\N	2	56	2026-03-16 01:47:57.454681	2026-03-16 13:07:14.298131	t
5698	2026-04-07	13:53:00	2:32, 5:11, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.60	12.90	🔺 So So	12.70	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.3g	\N	2	56	2026-04-07 13:53:31.149108	2026-04-08 00:58:42.132093	f
5699	2026-04-07	13:55:00	00:22, 1:22, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.30	6.90	🔺 So So	3.40	2	❌ - 🔺	17		\N	2	53	2026-04-07 13:56:02.673001	2026-04-08 00:59:08.193455	f
5693	2026-04-07	02:07:00	11:31, 15:02, 16:52, 18:41, 20:54, 	Wet	ciao	豪華雞三味餐包 ic-533 (雞軟骨口味) + 豪華雞三味餐包 ic-531 (雞肉口味)	💖 Yes, eat right away	120.00	57.20	💕 Love it So Much	62.80	5	💖 - 💕	43		\N	2	\N	2026-04-07 02:07:51.830984	2026-04-07 13:57:01.512088	f
5525	2026-03-19	01:06:00	11:39, 16:10, 20:27, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.30	13.40	🔺 So So	11.90	3	❌ - 🔺	19	加誠實貓 雞塊 5.3g	\N	2	56	2026-03-19 01:06:16.82323	2026-03-19 13:03:06.820355	t
5520	2026-03-18	07:14:00	15:41, 18:01, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	19.60	🔺 So So	5.60	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.2g	\N	2	56	2026-03-18 07:14:18.671843	2026-03-19 00:59:28.728929	t
5523	2026-03-18	13:04:00	00:04, 2:17,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	10.00	🔺 So So	15.10	2	❌ - 🔺	17	加誠實貓 雞塊 5.1g	\N	2	56	2026-03-18 13:04:10.80412	2026-03-19 01:00:31.963955	t
5687	2026-04-06	01:18:00	15:19, 16:54, 	Kibble	第一饗宴 firstmate	無穀低敏 鴨肉藍莓全貓配方	❌ No, not interested	25.50	18.10	🔺 So So	7.40	2	❌ - 🔺	17	加誠實貓 雞塊 5.2g	\N	2	68	2026-04-06 01:19:05.671018	2026-04-06 11:59:29.465529	f
5689	2026-04-06	12:00:00	21:44, 	Kibble	第一饗宴 firstmate	無穀低敏 鴨肉藍莓全貓配方	❌ No, not interested	25.20	21.50	🔺 So So	3.70	1	❌ - 🔺	15	加誠實貓 雞塊 5.2g/看起來都只吃凍乾	6.80	2	68	2026-04-06 12:00:58.719717	2026-04-07 01:59:03.454493	f
5528	2026-03-19	13:04:00	00:04, 1:30, 5:20, 6:52,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	4.10	💕 Love it So Much	21.30	4	❌ - 💕	38	加誠實貓 雞塊 5.2g/3-20 5:25 被咬	\N	2	56	2026-03-19 13:05:04.432376	2026-03-20 00:50:21.616076	t
5688	2026-04-06	05:18:00	-	Wet	ciao	a-53 多樂米濃湯罐 雞肉+鮪魚+墨魚	🔺 No, not really. Ate A Little	80.00	69.20	❌ No!!!	10.80	0	🔺 - ❌	13		\N	2	\N	2026-04-06 05:18:34.495038	2026-04-06 12:06:04.450081	f
5692	2026-04-06	12:10:00	20:33, 23:33, 	Freeze-Dried	汪喵星球	凍乾主食餐 低敏鴨肉餐	❌ No, not interested	10.20	3.80	🔺 So So	6.40	2	❌ - 🔺	17		\N	2	53	2026-04-06 12:11:23.805179	2026-04-07 02:03:25.2474	f
5691	2026-04-06	12:08:00	20:35, 21:45, 4:42, 8:52, 	Wet	ciao	多樂米濃湯罐 a-112 鮪魚, 雞肉, 蟹肉	💖 Yes, eat right away	80.00	19.50	💕 Love it So Much	60.50	4	💖 - 💕	48		\N	2	\N	2026-04-06 12:09:04.90113	2026-04-07 02:04:17.493125	f
5595	2026-03-27	01:22:00	11:42, 14:37, 18:41, 20:46	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.40	4.30	💕 Love it So Much	17.10	4	❌ - 💕	38	加1.2g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	56	2026-03-27 01:22:41.521694	2026-03-27 12:52:12.932537	t
5569	2026-03-23	12:37:00	21:52, 23:56, 1:02, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	30.00	9.30	🔺 So So	20.70	3	❌ - 🔺	19	加 5g 凍乾 => 2.9g誠實貓 雞塊 + 2.1g 汪喵 櫻桃鴨	\N	2	56	2026-03-23 12:37:53.186463	2026-03-24 00:50:51.939715	t
5695	2026-04-07	02:10:00	12:24, 20:53, 	Kibble	第一饗宴 firstmate	無穀低敏 鴨肉藍莓全貓配方	❌ No, not interested	25.30	17.50	🔺 So So	7.80	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.3g	\N	2	68	2026-04-07 02:19:23.053879	2026-04-07 13:49:40.696965	f
5601	2026-03-27	12:53:00	21:55, 22:53, 1:06, 1:16, 4:25, 8:27,	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.80	2.60	💕 Love it So Much	19.20	6	❌ - 💕	42	加1.2g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	56	2026-03-27 12:53:44.735459	2026-03-28 01:00:10.961168	t
5603	2026-03-28	01:03:00	16:50, 20:34, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	32.10	23.70	🔺 So So	8.40	2	❌ - 🔺	17	加1.8g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	56	2026-03-28 01:03:56.93391	2026-03-28 12:37:18.948217	t
5616	2026-03-29	01:40:00	10:46, 14:09, 18:40, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.10	9.60	💕 Love it So Much	15.50	3	❌ - 💕	29	加汪喵 櫻桃鴨 5.1g	\N	2	56	2026-03-29 01:40:19.191732	2026-03-29 12:19:19.724661	t
5632	2026-03-30	12:52:00	23:21, 3:09, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.40	7.90	🔺 So So	17.50	2	❌ - 🔺	17	加汪喵 櫻桃鴨 5.4g	\N	2	56	2026-03-30 12:52:21.542208	2026-03-31 01:06:51.408859	t
5697	2026-04-07	13:50:00	23:00, 	Kibble	第一饗宴 firstmate	無穀低敏 鴨肉藍莓全貓配方	❌ No, not interested	25.60	22.00	🔺 So So	3.60	1	❌ - 🔺	15	加汪喵 櫻桃鴨 5.1g	\N	2	68	2026-04-07 13:50:44.901233	2026-04-08 00:58:17.193922	f
5696	2026-04-07	13:47:00	2:33, 5:13, 	Wet	mon petit 貓倍麗	嚴選金罐特選汁煮鮪魚大餐(特選吞拿魚)	💖 Yes, eat right away	85.00	45.50	🔺 So So	39.50	2	💖 - 🔺	27		\N	2	\N	2026-04-07 13:48:15.923817	2026-04-08 01:00:09.240399	f
5669	2026-04-04	02:25:00	13:23, 16:11, 20:31, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	21.80	12.70	🔺 So So	9.10	3	❌ - 🔺	19	加1.5g 卡尼 雞胸原肉 誘食凍乾粉	\N	2	56	2026-04-04 02:25:32.339531	2026-04-04 12:43:00.702348	t
5675	2026-04-04	12:43:00	21:11, 23:23, 2:50, 4:01, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	1.60	💕 Love it So Much	18.40	4	❌ - 💕	38		\N	2	56	2026-04-04 12:44:11.201096	2026-04-05 01:23:00.04065	t
5683	2026-04-05	13:22:00	22:14, 23:53, 2:58, 4:33, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	20.00	4.10	💕 Love it So Much	15.90	4	❌ - 💕	38		\N	2	56	2026-04-05 13:22:38.146609	2026-04-06 01:10:32.882934	t
5686	2026-04-06	01:14:00	10:00, 18:42, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.70	16.40	🔺 So So	9.30	2	❌ - 🔺	17	加誠實貓 雞塊 5.2g	\N	2	56	2026-04-06 01:14:45.354909	2026-04-06 12:04:58.492508	t
5690	2026-04-06	12:03:00	1:30, 4:41, 8:50, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.60	12.80	🔺 So So	12.80	3	❌ - 🔺	19	加誠實貓 雞塊 5.3g	\N	2	56	2026-04-06 12:04:00.494879	2026-04-07 01:59:33.718113	t
5694	2026-04-07	02:08:00	15:01, 18:39, 20:54, 	Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	14.20	🔺 So So	11.00	3	❌ - 🔺	19	加汪喵 櫻桃鴨 5.2g	\N	2	56	2026-04-07 02:18:53.813503	2026-04-07 13:51:57.949578	t
5700	2026-04-08	00:57:00	\N	Wet	ciao	ic-311 巧餐包 奢華鮪魚+雞肉 x2	💖 Yes, eat right away	70.00	\N	\N	\N	\N	\N	0	\N	\N	2	\N	2026-04-08 00:57:43.174904	2026-04-08 00:57:43.174904	f
5701	2026-04-08	01:05:00		Kibble	天然密碼	無穀鴨肉&火雞肉 全齡貓配方	❌ No, not interested	25.20	\N		25.20	0	\N	0	加汪喵 櫻桃鴨 5.2g	\N	2	56	2026-04-08 01:05:44.913716	2026-04-08 01:05:55.006443	f
5702	2026-04-08	01:08:00		Kibble	第一饗宴 firstmate	無穀低敏 鴨肉藍莓全貓配方	❌ No, not interested	25.30	\N		25.30	0	\N	0	加汪喵 櫻桃鴨 5.3g	\N	2	68	2026-04-08 01:08:29.27299	2026-04-08 01:08:40.44354	f
5703	2026-04-08	01:11:00	\N	Freeze-Dried	汪喵星球	凍乾主食餐 安心雞肉	❌ No, not interested	10.30	\N	\N	\N	\N	\N	0	\N	\N	2	73	2026-04-08 01:11:31.532258	2026-04-08 01:11:31.532258	f
5704	2026-04-08	03:00:00	\N	Wet	ciao	啾嚕奢華果凍杯 tsc-45 雞肉 x3	💖 Yes, eat right away	105.00	\N	\N	\N	\N	\N	0	\N	\N	2	\N	2026-04-08 03:09:08.275532	2026-04-08 03:09:08.275532	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email_address, password_digest, created_at, updated_at, username, timezone, sign_in_count, current_sign_in_at, last_sign_in_at) FROM stdin;
4	wae.walton@gmail.com	$2a$12$TypAscCq354nWODQswLO4.fgo5xeuSnW81gBqBkKg7dRkqydbFtGq	2026-02-18 06:18:33.038565	2026-02-18 06:18:33.272561	Wae Walton	Asia/Taipei	1	2026-02-18 06:18:33.27234	\N
5	st3137504@gmail.com	$2a$12$h3MxX5P8qnNUDWd3FFirK.o/olayETLUHzMNZim6CM/afRVNMKiY6	2026-03-25 11:05:02.752784	2026-03-25 11:05:03.261381	Dora Chang	Asia/Taipei	1	2026-03-25 11:05:03.261147	\N
3	yuhruhgrape@gmail.com	$2a$12$qS9JXlnis6JoO7JAtsKc6.L98r46omppJMK/53jB.hJ3cdcbulSDW	2026-02-11 02:17:31.639807	2026-03-28 00:58:42.484788	Rita huang	Asia/Taipei	7	2026-03-28 00:58:42.48377	2026-03-15 21:22:00.006718
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 10, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 10, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 5, true);


--
-- Name: connected_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.connected_services_id_seq', 5, true);


--
-- Name: dry_foods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dry_foods_id_seq', 73, true);


--
-- Name: health_checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.health_checks_id_seq', 4, true);


--
-- Name: pets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pets_id_seq', 4, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 16, true);


--
-- Name: solid_cache_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_cache_entries_id_seq', 6, true);


--
-- Name: solid_queue_blocked_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_blocked_executions_id_seq', 1, false);


--
-- Name: solid_queue_claimed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_claimed_executions_id_seq', 35, true);


--
-- Name: solid_queue_failed_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_failed_executions_id_seq', 1, true);


--
-- Name: solid_queue_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_jobs_id_seq', 35, true);


--
-- Name: solid_queue_pauses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_pauses_id_seq', 1, false);


--
-- Name: solid_queue_processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_processes_id_seq', 124, true);


--
-- Name: solid_queue_ready_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_ready_executions_id_seq', 35, true);


--
-- Name: solid_queue_recurring_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_recurring_executions_id_seq', 32, true);


--
-- Name: solid_queue_recurring_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_recurring_tasks_id_seq', 62, true);


--
-- Name: solid_queue_scheduled_executions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_scheduled_executions_id_seq', 1, false);


--
-- Name: solid_queue_semaphores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.solid_queue_semaphores_id_seq', 1, false);


--
-- Name: trackers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trackers_id_seq', 5704, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: connected_services connected_services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_services
    ADD CONSTRAINT connected_services_pkey PRIMARY KEY (id);


--
-- Name: dry_foods dry_foods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dry_foods
    ADD CONSTRAINT dry_foods_pkey PRIMARY KEY (id);


--
-- Name: health_checks health_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT health_checks_pkey PRIMARY KEY (id);


--
-- Name: pets pets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT pets_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: solid_cache_entries solid_cache_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_cache_entries
    ADD CONSTRAINT solid_cache_entries_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_blocked_executions solid_queue_blocked_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT solid_queue_blocked_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_claimed_executions solid_queue_claimed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT solid_queue_claimed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_failed_executions solid_queue_failed_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT solid_queue_failed_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_jobs solid_queue_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_jobs
    ADD CONSTRAINT solid_queue_jobs_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_pauses solid_queue_pauses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_pauses
    ADD CONSTRAINT solid_queue_pauses_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_processes solid_queue_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_processes
    ADD CONSTRAINT solid_queue_processes_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_ready_executions solid_queue_ready_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT solid_queue_ready_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_executions solid_queue_recurring_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT solid_queue_recurring_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_recurring_tasks solid_queue_recurring_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_tasks
    ADD CONSTRAINT solid_queue_recurring_tasks_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_scheduled_executions solid_queue_scheduled_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT solid_queue_scheduled_executions_pkey PRIMARY KEY (id);


--
-- Name: solid_queue_semaphores solid_queue_semaphores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_semaphores
    ADD CONSTRAINT solid_queue_semaphores_pkey PRIMARY KEY (id);


--
-- Name: trackers trackers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trackers
    ADD CONSTRAINT trackers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_connected_services_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connected_services_on_user_id ON public.connected_services USING btree (user_id);


--
-- Name: index_dry_foods_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dry_foods_on_user_id ON public.dry_foods USING btree (user_id);


--
-- Name: index_health_checks_on_pet_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_health_checks_on_pet_id ON public.health_checks USING btree (pet_id);


--
-- Name: index_pets_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pets_on_user_id ON public.pets USING btree (user_id);


--
-- Name: index_sessions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_user_id ON public.sessions USING btree (user_id);


--
-- Name: index_solid_cache_entries_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_cache_entries_on_key ON public.solid_cache_entries USING btree (key);


--
-- Name: index_solid_cache_entries_on_key_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_cache_entries_on_key_and_created_at ON public.solid_cache_entries USING btree (key, created_at);


--
-- Name: index_solid_cache_entries_on_key_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_cache_entries_on_key_hash ON public.solid_cache_entries USING btree (key_hash);


--
-- Name: index_solid_cache_entries_on_key_hash_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_cache_entries_on_key_hash_and_created_at ON public.solid_cache_entries USING btree (key_hash, created_at);


--
-- Name: index_solid_queue_blocked_executions_for_maintenance; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_blocked_executions_for_maintenance ON public.solid_queue_blocked_executions USING btree (expires_at, concurrency_key);


--
-- Name: index_solid_queue_blocked_executions_for_release; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_blocked_executions_for_release ON public.solid_queue_blocked_executions USING btree (concurrency_key, priority, job_id);


--
-- Name: index_solid_queue_blocked_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_blocked_executions_on_job_id ON public.solid_queue_blocked_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_claimed_executions_on_job_id ON public.solid_queue_claimed_executions USING btree (job_id);


--
-- Name: index_solid_queue_claimed_executions_on_process_id_and_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_claimed_executions_on_process_id_and_job_id ON public.solid_queue_claimed_executions USING btree (process_id, job_id);


--
-- Name: index_solid_queue_dispatch_all; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_dispatch_all ON public.solid_queue_scheduled_executions USING btree (scheduled_at, priority, job_id);


--
-- Name: index_solid_queue_failed_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_failed_executions_on_job_id ON public.solid_queue_failed_executions USING btree (job_id);


--
-- Name: index_solid_queue_jobs_for_alerting; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_for_alerting ON public.solid_queue_jobs USING btree (scheduled_at, finished_at);


--
-- Name: index_solid_queue_jobs_for_filtering; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_for_filtering ON public.solid_queue_jobs USING btree (queue_name, finished_at);


--
-- Name: index_solid_queue_jobs_on_active_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_on_active_job_id ON public.solid_queue_jobs USING btree (active_job_id);


--
-- Name: index_solid_queue_jobs_on_class_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_on_class_name ON public.solid_queue_jobs USING btree (class_name);


--
-- Name: index_solid_queue_jobs_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_jobs_on_finished_at ON public.solid_queue_jobs USING btree (finished_at);


--
-- Name: index_solid_queue_pauses_on_queue_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_pauses_on_queue_name ON public.solid_queue_pauses USING btree (queue_name);


--
-- Name: index_solid_queue_poll_all; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_poll_all ON public.solid_queue_ready_executions USING btree (priority, job_id);


--
-- Name: index_solid_queue_poll_by_queue; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_poll_by_queue ON public.solid_queue_ready_executions USING btree (queue_name, priority, job_id);


--
-- Name: index_solid_queue_processes_on_last_heartbeat_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_processes_on_last_heartbeat_at ON public.solid_queue_processes USING btree (last_heartbeat_at);


--
-- Name: index_solid_queue_processes_on_name_and_supervisor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_processes_on_name_and_supervisor_id ON public.solid_queue_processes USING btree (name, supervisor_id);


--
-- Name: index_solid_queue_processes_on_supervisor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_processes_on_supervisor_id ON public.solid_queue_processes USING btree (supervisor_id);


--
-- Name: index_solid_queue_ready_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_ready_executions_on_job_id ON public.solid_queue_ready_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_job_id ON public.solid_queue_recurring_executions USING btree (job_id);


--
-- Name: index_solid_queue_recurring_executions_on_task_key_and_run_at; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_recurring_executions_on_task_key_and_run_at ON public.solid_queue_recurring_executions USING btree (task_key, run_at);


--
-- Name: index_solid_queue_recurring_tasks_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_recurring_tasks_on_key ON public.solid_queue_recurring_tasks USING btree (key);


--
-- Name: index_solid_queue_recurring_tasks_on_static; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_recurring_tasks_on_static ON public.solid_queue_recurring_tasks USING btree (static);


--
-- Name: index_solid_queue_scheduled_executions_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_scheduled_executions_on_job_id ON public.solid_queue_scheduled_executions USING btree (job_id);


--
-- Name: index_solid_queue_semaphores_on_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_semaphores_on_expires_at ON public.solid_queue_semaphores USING btree (expires_at);


--
-- Name: index_solid_queue_semaphores_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_solid_queue_semaphores_on_key ON public.solid_queue_semaphores USING btree (key);


--
-- Name: index_solid_queue_semaphores_on_key_and_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_solid_queue_semaphores_on_key_and_value ON public.solid_queue_semaphores USING btree (key, value);


--
-- Name: index_trackers_on_dry_food_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_trackers_on_dry_food_id ON public.trackers USING btree (dry_food_id);


--
-- Name: index_trackers_on_pet_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_trackers_on_pet_id ON public.trackers USING btree (pet_id);


--
-- Name: index_users_on_email_address; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email_address ON public.users USING btree (email_address);


--
-- Name: connected_services fk_rails_006b937ba0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_services
    ADD CONSTRAINT fk_rails_006b937ba0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: pets fk_rails_0fa4bae6b1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pets
    ADD CONSTRAINT fk_rails_0fa4bae6b1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: health_checks fk_rails_1cb043d926; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.health_checks
    ADD CONSTRAINT fk_rails_1cb043d926 FOREIGN KEY (pet_id) REFERENCES public.pets(id);


--
-- Name: solid_queue_recurring_executions fk_rails_318a5533ed; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_recurring_executions
    ADD CONSTRAINT fk_rails_318a5533ed FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: solid_queue_failed_executions fk_rails_39bbc7a631; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_failed_executions
    ADD CONSTRAINT fk_rails_39bbc7a631 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: trackers fk_rails_44d936d49f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trackers
    ADD CONSTRAINT fk_rails_44d936d49f FOREIGN KEY (pet_id) REFERENCES public.pets(id);


--
-- Name: solid_queue_blocked_executions fk_rails_4cd34e2228; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_blocked_executions
    ADD CONSTRAINT fk_rails_4cd34e2228 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: trackers fk_rails_6f5f73c25a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trackers
    ADD CONSTRAINT fk_rails_6f5f73c25a FOREIGN KEY (dry_food_id) REFERENCES public.dry_foods(id);


--
-- Name: sessions fk_rails_758836b4f0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_758836b4f0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: solid_queue_ready_executions fk_rails_81fcbd66af; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_ready_executions
    ADD CONSTRAINT fk_rails_81fcbd66af FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: dry_foods fk_rails_8b41e2b8f9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dry_foods
    ADD CONSTRAINT fk_rails_8b41e2b8f9 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: solid_queue_claimed_executions fk_rails_9cfe4d4944; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_claimed_executions
    ADD CONSTRAINT fk_rails_9cfe4d4944 FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: solid_queue_scheduled_executions fk_rails_c4316f352d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solid_queue_scheduled_executions
    ADD CONSTRAINT fk_rails_c4316f352d FOREIGN KEY (job_id) REFERENCES public.solid_queue_jobs(id) ON DELETE CASCADE;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT wal_buffers_full bigint, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT parallel_workers_to_launch bigint, OUT parallel_workers_launched bigint, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT wal_buffers_full bigint, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT parallel_workers_to_launch bigint, OUT parallel_workers_launched bigint, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO cat_feeder_tracker_v4_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO cat_feeder_tracker_v4_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO cat_feeder_tracker_v4_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO cat_feeder_tracker_v4_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO cat_feeder_tracker_v4_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO cat_feeder_tracker_v4_user;


--
-- PostgreSQL database dump complete
--

\unrestrict sPFnJHgvbAGmOXziWlaSpKiqGtP2hQzDNTRDt0xpVxtmOGdwbA1WiIacmexrRnj

