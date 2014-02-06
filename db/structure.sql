--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cohorts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cohorts (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: cohorts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cohorts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cohorts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cohorts_id_seq OWNED BY cohorts.id;


--
-- Name: feedback_entries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feedback_entries (
    id integer NOT NULL,
    recipient_id integer,
    comment text,
    provider_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    viewed boolean DEFAULT false
);


--
-- Name: feedback_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feedback_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feedback_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feedback_entries_id_seq OWNED BY feedback_entries.id;


--
-- Name: pre_test_answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pre_test_answers (
    id integer NOT NULL,
    pre_test_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pre_test_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pre_test_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pre_test_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pre_test_answers_id_seq OWNED BY pre_test_answers.id;


--
-- Name: pre_test_questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pre_test_questions (
    id integer NOT NULL,
    text text NOT NULL
);


--
-- Name: pre_test_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pre_test_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pre_test_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pre_test_questions_id_seq OWNED BY pre_test_questions.id;


--
-- Name: pre_tests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pre_tests (
    id integer NOT NULL,
    user_id integer NOT NULL,
    submitted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pre_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pre_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pre_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pre_tests_id_seq OWNED BY pre_tests.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    github_username character varying(255),
    github_id character varying(255),
    cohort_id integer,
    role_bit_mask integer DEFAULT 0
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cohorts ALTER COLUMN id SET DEFAULT nextval('cohorts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY feedback_entries ALTER COLUMN id SET DEFAULT nextval('feedback_entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pre_test_answers ALTER COLUMN id SET DEFAULT nextval('pre_test_answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pre_test_questions ALTER COLUMN id SET DEFAULT nextval('pre_test_questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pre_tests ALTER COLUMN id SET DEFAULT nextval('pre_tests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: cohorts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cohorts
    ADD CONSTRAINT cohorts_pkey PRIMARY KEY (id);


--
-- Name: feedback_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feedback_entries
    ADD CONSTRAINT feedback_entries_pkey PRIMARY KEY (id);


--
-- Name: pre_test_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pre_test_answers
    ADD CONSTRAINT pre_test_answers_pkey PRIMARY KEY (id);


--
-- Name: pre_test_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pre_test_questions
    ADD CONSTRAINT pre_test_questions_pkey PRIMARY KEY (id);


--
-- Name: pre_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pre_tests
    ADD CONSTRAINT pre_tests_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_pre_test_answers_on_pre_test_id_and_question_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_pre_test_answers_on_pre_test_id_and_question_id ON pre_test_answers USING btree (pre_test_id, question_id);


--
-- Name: index_pre_tests_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_pre_tests_on_user_id ON pre_tests USING btree (user_id);


--
-- Name: index_users_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_email ON users USING btree (lower((email)::text));


--
-- Name: index_users_github_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_github_id ON users USING btree (lower((github_id)::text));


--
-- Name: index_users_on_cohort_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_cohort_id ON users USING btree (cohort_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131209215002');

INSERT INTO schema_migrations (version) VALUES ('20131213155355');

INSERT INTO schema_migrations (version) VALUES ('20131224163815');

INSERT INTO schema_migrations (version) VALUES ('20131226201447');

INSERT INTO schema_migrations (version) VALUES ('20140126221834');

INSERT INTO schema_migrations (version) VALUES ('20140126222638');

INSERT INTO schema_migrations (version) VALUES ('20140128185600');

INSERT INTO schema_migrations (version) VALUES ('20140131221240');

INSERT INTO schema_migrations (version) VALUES ('20140203170204');

INSERT INTO schema_migrations (version) VALUES ('20140206173011');

INSERT INTO schema_migrations (version) VALUES ('20140206175553');

INSERT INTO schema_migrations (version) VALUES ('20140206184130');
