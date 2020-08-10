--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

-- DROP DATABASE node_dev;




--
-- Drop roles
--

-- DROP ROLE postgres;


--
-- Roles
--

-- CREATE ROLE postgres;
-- ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md514231b87c4109a5bc000d2a0cdb430f8';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Debian 12.3-1.pgdg100+1)
-- Dumped by pg_dump version 12.3 (Debian 12.3-1.pgdg100+1)

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
-- DROP DATABASE template1;
-- --
-- -- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
-- --

-- CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


-- ALTER DATABASE template1 OWNER TO postgres;

-- \connect template1

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- --
-- -- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
-- --

-- COMMENT ON DATABASE template1 IS 'default template for new databases';


-- --
-- -- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
-- --

-- ALTER DATABASE template1 IS_TEMPLATE = true;


-- \connect template1

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- --
-- -- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
-- --

-- REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
-- GRANT CONNECT ON DATABASE template1 TO PUBLIC;


-- --
-- -- PostgreSQL database dump complete
-- --

-- --
-- -- Database "node_dev" dump
-- --

-- --
-- -- PostgreSQL database dump
-- --

-- -- Dumped from database version 12.3 (Debian 12.3-1.pgdg100+1)
-- -- Dumped by pg_dump version 12.3 (Debian 12.3-1.pgdg100+1)

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- --
-- -- Name: node_dev; Type: DATABASE; Schema: -; Owner: postgres
-- --

-- CREATE DATABASE node_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE node_dev OWNER TO postgres;

\connect node_dev

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: eth_tx_attempts_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.eth_tx_attempts_state AS ENUM (
    'in_progress',
    'broadcast'
);


ALTER TYPE public.eth_tx_attempts_state OWNER TO postgres;

--
-- Name: eth_txes_state; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.eth_txes_state AS ENUM (
    'unstarted',
    'in_progress',
    'fatal_error',
    'unconfirmed',
    'confirmed'
);


ALTER TYPE public.eth_txes_state OWNER TO postgres;

--
-- Name: run_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.run_status AS ENUM (
    'unstarted',
    'in_progress',
    'pending_incoming_confirmations',
    'pending_outgoing_confirmations',
    'pending_connection',
    'pending_bridge',
    'pending_sleep',
    'errored',
    'completed',
    'cancelled'
);


ALTER TYPE public.run_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bridge_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bridge_types (
    name text NOT NULL,
    url text NOT NULL,
    confirmations bigint DEFAULT 0 NOT NULL,
    incoming_token_hash text NOT NULL,
    salt text NOT NULL,
    outgoing_token text NOT NULL,
    minimum_contract_payment character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.bridge_types OWNER TO postgres;

--
-- Name: configurations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configurations (
    id bigint NOT NULL,
    name text NOT NULL,
    value text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.configurations OWNER TO postgres;

--
-- Name: configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configurations_id_seq OWNER TO postgres;

--
-- Name: configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.configurations_id_seq OWNED BY public.configurations.id;


--
-- Name: encrypted_secret_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encrypted_secret_keys (
    public_key character varying(68) NOT NULL,
    vrf_key text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.encrypted_secret_keys OWNER TO postgres;

--
-- Name: encumbrances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encumbrances (
    id bigint NOT NULL,
    payment numeric(78,0),
    expiration bigint,
    end_at timestamp with time zone,
    oracles text,
    aggregator bytea NOT NULL,
    agg_initiate_job_selector bytea NOT NULL,
    agg_fulfill_selector bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.encumbrances OWNER TO postgres;

--
-- Name: encumbrances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.encumbrances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.encumbrances_id_seq OWNER TO postgres;

--
-- Name: encumbrances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.encumbrances_id_seq OWNED BY public.encumbrances.id;


--
-- Name: eth_receipts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_receipts (
    id bigint NOT NULL,
    tx_hash bytea NOT NULL,
    block_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    transaction_index bigint NOT NULL,
    receipt jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT chk_hash_length CHECK (((octet_length(tx_hash) = 32) AND (octet_length(block_hash) = 32)))
);


ALTER TABLE public.eth_receipts OWNER TO postgres;

--
-- Name: eth_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eth_receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eth_receipts_id_seq OWNER TO postgres;

--
-- Name: eth_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eth_receipts_id_seq OWNED BY public.eth_receipts.id;


--
-- Name: eth_task_run_txes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_task_run_txes (
    task_run_id uuid NOT NULL,
    eth_tx_id bigint NOT NULL
);


ALTER TABLE public.eth_task_run_txes OWNER TO postgres;

--
-- Name: eth_tx_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_tx_attempts (
    id bigint NOT NULL,
    eth_tx_id bigint NOT NULL,
    gas_price numeric(78,0) NOT NULL,
    signed_raw_tx bytea NOT NULL,
    hash bytea NOT NULL,
    broadcast_before_block_num bigint,
    state public.eth_tx_attempts_state NOT NULL,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT chk_cannot_broadcast_before_block_zero CHECK (((broadcast_before_block_num IS NULL) OR (broadcast_before_block_num > 0))),
    CONSTRAINT chk_eth_tx_attempts_fsm CHECK ((((state = 'in_progress'::public.eth_tx_attempts_state) AND (broadcast_before_block_num IS NULL)) OR (state = 'broadcast'::public.eth_tx_attempts_state))),
    CONSTRAINT chk_hash_length CHECK ((octet_length(hash) = 32)),
    CONSTRAINT chk_signed_raw_tx_present CHECK ((octet_length(signed_raw_tx) > 0))
);


ALTER TABLE public.eth_tx_attempts OWNER TO postgres;

--
-- Name: eth_tx_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eth_tx_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eth_tx_attempts_id_seq OWNER TO postgres;

--
-- Name: eth_tx_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eth_tx_attempts_id_seq OWNED BY public.eth_tx_attempts.id;


--
-- Name: eth_txes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eth_txes (
    id bigint NOT NULL,
    nonce bigint,
    from_address bytea NOT NULL,
    to_address bytea NOT NULL,
    encoded_payload bytea NOT NULL,
    value numeric(78,0) NOT NULL,
    gas_limit bigint NOT NULL,
    error text,
    broadcast_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    state public.eth_txes_state DEFAULT 'unstarted'::public.eth_txes_state NOT NULL,
    CONSTRAINT chk_broadcast_at_is_sane CHECK ((broadcast_at > '2019-01-01 00:00:00+00'::timestamp with time zone)),
    CONSTRAINT chk_error_cannot_be_empty CHECK (((error IS NULL) OR (length(error) > 0))),
    CONSTRAINT chk_eth_txes_fsm CHECK ((((state = 'unstarted'::public.eth_txes_state) AND ((nonce IS NULL) AND (error IS NULL) AND (broadcast_at IS NULL))) OR ((state = 'in_progress'::public.eth_txes_state) AND ((nonce IS NOT NULL) AND (error IS NULL) AND (broadcast_at IS NULL))) OR ((state = 'fatal_error'::public.eth_txes_state) AND ((nonce IS NULL) AND (error IS NOT NULL) AND (broadcast_at IS NULL))) OR ((state = 'unconfirmed'::public.eth_txes_state) AND ((nonce IS NOT NULL) AND (error IS NULL) AND (broadcast_at IS NOT NULL))) OR ((state = 'confirmed'::public.eth_txes_state) AND ((nonce IS NOT NULL) AND (error IS NULL) AND (broadcast_at IS NOT NULL))))),
    CONSTRAINT chk_from_address_length CHECK ((octet_length(from_address) = 20)),
    CONSTRAINT chk_to_address_length CHECK ((octet_length(to_address) = 20))
);


ALTER TABLE public.eth_txes OWNER TO postgres;

--
-- Name: eth_txes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eth_txes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eth_txes_id_seq OWNER TO postgres;

--
-- Name: eth_txes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eth_txes_id_seq OWNED BY public.eth_txes.id;


--
-- Name: external_initiators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_initiators (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    name text NOT NULL,
    url text,
    access_key text NOT NULL,
    salt text NOT NULL,
    hashed_secret text NOT NULL,
    outgoing_secret text NOT NULL,
    outgoing_token text NOT NULL
);


ALTER TABLE public.external_initiators OWNER TO postgres;

--
-- Name: external_initiators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.external_initiators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.external_initiators_id_seq OWNER TO postgres;

--
-- Name: external_initiators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.external_initiators_id_seq OWNED BY public.external_initiators.id;


--
-- Name: flux_monitor_round_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flux_monitor_round_stats (
    id bigint NOT NULL,
    aggregator bytea NOT NULL,
    round_id integer NOT NULL,
    num_new_round_logs integer DEFAULT 0 NOT NULL,
    num_submissions integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.flux_monitor_round_stats OWNER TO postgres;

--
-- Name: flux_monitor_round_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flux_monitor_round_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flux_monitor_round_stats_id_seq OWNER TO postgres;

--
-- Name: flux_monitor_round_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flux_monitor_round_stats_id_seq OWNED BY public.flux_monitor_round_stats.id;


--
-- Name: heads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.heads (
    id bigint NOT NULL,
    hash bytea NOT NULL,
    number bigint NOT NULL,
    parent_hash bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT chk_hash_size CHECK ((octet_length(hash) = 32)),
    CONSTRAINT chk_parent_hash_size CHECK ((octet_length(parent_hash) = 32))
);


ALTER TABLE public.heads OWNER TO postgres;

--
-- Name: heads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.heads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.heads_id_seq OWNER TO postgres;

--
-- Name: heads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.heads_id_seq OWNED BY public.heads.id;


--
-- Name: initiators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.initiators (
    id bigint NOT NULL,
    job_spec_id uuid NOT NULL,
    type text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    schedule text,
    "time" timestamp with time zone,
    ran boolean,
    address bytea,
    requesters text,
    name character varying(255),
    params jsonb,
    from_block numeric(78,0),
    to_block numeric(78,0),
    topics jsonb,
    request_data text,
    feeds text,
    threshold double precision,
    "precision" smallint,
    polling_interval bigint,
    absolute_threshold double precision,
    updated_at timestamp with time zone NOT NULL,
    poll_timer jsonb,
    idle_timer jsonb
);


ALTER TABLE public.initiators OWNER TO postgres;

--
-- Name: initiators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.initiators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.initiators_id_seq OWNER TO postgres;

--
-- Name: initiators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.initiators_id_seq OWNED BY public.initiators.id;


--
-- Name: job_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_runs (
    result_id bigint,
    run_request_id bigint,
    status public.run_status DEFAULT 'unstarted'::public.run_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    finished_at timestamp with time zone,
    updated_at timestamp with time zone NOT NULL,
    initiator_id bigint NOT NULL,
    deleted_at timestamp with time zone,
    creation_height numeric(78,0),
    observed_height numeric(78,0),
    payment numeric(78,0),
    job_spec_id uuid NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE public.job_runs OWNER TO postgres;

--
-- Name: job_spec_errors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_spec_errors (
    id bigint NOT NULL,
    job_spec_id uuid NOT NULL,
    description text NOT NULL,
    occurrences integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.job_spec_errors OWNER TO postgres;

--
-- Name: job_spec_errors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_spec_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_spec_errors_id_seq OWNER TO postgres;

--
-- Name: job_spec_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_spec_errors_id_seq OWNED BY public.job_spec_errors.id;


--
-- Name: job_specs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_specs (
    created_at timestamp with time zone NOT NULL,
    start_at timestamp with time zone,
    end_at timestamp with time zone,
    deleted_at timestamp with time zone,
    min_payment character varying(255),
    id uuid NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.job_specs OWNER TO postgres;

--
-- Name: keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keys (
    address bytea NOT NULL,
    json jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    next_nonce bigint,
    id integer NOT NULL,
    last_used timestamp with time zone,
    CONSTRAINT chk_address_length CHECK ((octet_length(address) = 20))
);


ALTER TABLE public.keys OWNER TO postgres;

--
-- Name: keys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.keys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keys_id_seq OWNER TO postgres;

--
-- Name: keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.keys_id_seq OWNED BY public.keys.id;


--
-- Name: log_consumptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_consumptions (
    id bigint NOT NULL,
    block_hash bytea NOT NULL,
    log_index bigint NOT NULL,
    job_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.log_consumptions OWNER TO postgres;

--
-- Name: log_consumptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_consumptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_consumptions_id_seq OWNER TO postgres;

--
-- Name: log_consumptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_consumptions_id_seq OWNED BY public.log_consumptions.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id character varying(255) NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: run_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.run_requests (
    id bigint NOT NULL,
    request_id bytea,
    tx_hash bytea,
    requester bytea,
    created_at timestamp with time zone NOT NULL,
    block_hash bytea,
    payment numeric(78,0),
    request_params jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.run_requests OWNER TO postgres;

--
-- Name: run_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.run_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_requests_id_seq OWNER TO postgres;

--
-- Name: run_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.run_requests_id_seq OWNED BY public.run_requests.id;


--
-- Name: run_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.run_results (
    id bigint NOT NULL,
    data jsonb,
    error_message text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.run_results OWNER TO postgres;

--
-- Name: run_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.run_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.run_results_id_seq OWNER TO postgres;

--
-- Name: run_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.run_results_id_seq OWNED BY public.run_results.id;


--
-- Name: service_agreements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_agreements (
    id text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    encumbrance_id bigint,
    request_body text,
    signature character varying(255),
    job_spec_id uuid,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.service_agreements OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id text NOT NULL,
    last_used timestamp with time zone,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sync_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sync_events (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    body text NOT NULL
);


ALTER TABLE public.sync_events OWNER TO postgres;

--
-- Name: sync_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sync_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sync_events_id_seq OWNER TO postgres;

--
-- Name: sync_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sync_events_id_seq OWNED BY public.sync_events.id;


--
-- Name: task_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_runs (
    result_id bigint,
    status public.run_status DEFAULT 'unstarted'::public.run_status NOT NULL,
    task_spec_id bigint NOT NULL,
    minimum_confirmations bigint,
    created_at timestamp with time zone NOT NULL,
    confirmations bigint,
    job_run_id uuid NOT NULL,
    id uuid NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.task_runs OWNER TO postgres;

--
-- Name: task_specs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_specs (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    type text NOT NULL,
    confirmations bigint,
    params jsonb,
    job_spec_id uuid NOT NULL
);


ALTER TABLE public.task_specs OWNER TO postgres;

--
-- Name: task_specs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_specs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_specs_id_seq OWNER TO postgres;

--
-- Name: task_specs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_specs_id_seq OWNED BY public.task_specs.id;


--
-- Name: tx_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tx_attempts (
    id bigint NOT NULL,
    tx_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    hash bytea NOT NULL,
    gas_price numeric(78,0) NOT NULL,
    confirmed boolean NOT NULL,
    sent_at bigint NOT NULL,
    signed_raw_tx bytea NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.tx_attempts OWNER TO postgres;

--
-- Name: tx_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tx_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tx_attempts_id_seq OWNER TO postgres;

--
-- Name: tx_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tx_attempts_id_seq OWNED BY public.tx_attempts.id;


--
-- Name: txes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.txes (
    id bigint NOT NULL,
    surrogate_id text,
    "from" bytea NOT NULL,
    "to" bytea NOT NULL,
    data bytea NOT NULL,
    nonce bigint NOT NULL,
    value numeric(78,0) NOT NULL,
    gas_limit bigint NOT NULL,
    hash bytea NOT NULL,
    gas_price numeric(78,0) NOT NULL,
    confirmed boolean NOT NULL,
    sent_at bigint NOT NULL,
    signed_raw_tx bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.txes OWNER TO postgres;

--
-- Name: txes_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.txes_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.txes_id_seq1 OWNER TO postgres;

--
-- Name: txes_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.txes_id_seq1 OWNED BY public.txes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    email text NOT NULL,
    hashed_password text,
    created_at timestamp with time zone NOT NULL,
    token_key text,
    token_salt text,
    token_hashed_secret text,
    updated_at timestamp with time zone NOT NULL,
    token_secret text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: configurations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configurations ALTER COLUMN id SET DEFAULT nextval('public.configurations_id_seq'::regclass);


--
-- Name: encumbrances id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encumbrances ALTER COLUMN id SET DEFAULT nextval('public.encumbrances_id_seq'::regclass);


--
-- Name: eth_receipts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_receipts ALTER COLUMN id SET DEFAULT nextval('public.eth_receipts_id_seq'::regclass);


--
-- Name: eth_tx_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_tx_attempts ALTER COLUMN id SET DEFAULT nextval('public.eth_tx_attempts_id_seq'::regclass);


--
-- Name: eth_txes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_txes ALTER COLUMN id SET DEFAULT nextval('public.eth_txes_id_seq'::regclass);


--
-- Name: external_initiators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_initiators ALTER COLUMN id SET DEFAULT nextval('public.external_initiators_id_seq'::regclass);


--
-- Name: flux_monitor_round_stats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flux_monitor_round_stats ALTER COLUMN id SET DEFAULT nextval('public.flux_monitor_round_stats_id_seq'::regclass);


--
-- Name: heads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heads ALTER COLUMN id SET DEFAULT nextval('public.heads_id_seq'::regclass);


--
-- Name: initiators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.initiators ALTER COLUMN id SET DEFAULT nextval('public.initiators_id_seq'::regclass);


--
-- Name: job_spec_errors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_spec_errors ALTER COLUMN id SET DEFAULT nextval('public.job_spec_errors_id_seq'::regclass);


--
-- Name: keys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keys ALTER COLUMN id SET DEFAULT nextval('public.keys_id_seq'::regclass);


--
-- Name: log_consumptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_consumptions ALTER COLUMN id SET DEFAULT nextval('public.log_consumptions_id_seq'::regclass);


--
-- Name: run_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run_requests ALTER COLUMN id SET DEFAULT nextval('public.run_requests_id_seq'::regclass);


--
-- Name: run_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run_results ALTER COLUMN id SET DEFAULT nextval('public.run_results_id_seq'::regclass);


--
-- Name: sync_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_events ALTER COLUMN id SET DEFAULT nextval('public.sync_events_id_seq'::regclass);


--
-- Name: task_specs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_specs ALTER COLUMN id SET DEFAULT nextval('public.task_specs_id_seq'::regclass);


--
-- Name: tx_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tx_attempts ALTER COLUMN id SET DEFAULT nextval('public.tx_attempts_id_seq'::regclass);


--
-- Name: txes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.txes ALTER COLUMN id SET DEFAULT nextval('public.txes_id_seq1'::regclass);


--
-- Data for Name: bridge_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bridge_types (name, url, confirmations, incoming_token_hash, salt, outgoing_token, minimum_contract_payment, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: configurations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configurations (id, name, value, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: encrypted_secret_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encrypted_secret_keys (public_key, vrf_key, created_at, updated_at) FROM stdin;
0x9b06b7f1a4faa9b05c5b2e31930fc137b87d5f9674725524ae01404a4a07dc6801	{"address":"0b6ca2b5fedd06375051d32617731f93cfa806af","crypto":{"cipher":"aes-128-ctr","ciphertext":"47618aad4f9e4008a8d9aaebfb44963fbebd6af478fea9658cd0327dca348d4d","cipherparams":{"iv":"8c3b169955b1ff933e403f157045c31b"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"0effd0d998d5b4de55b579c0e9efdb1d8841483b495b492a4126258243ff5aab"},"mac":"fd2910e41783d7f959bdf36ae1c6c2eb99b5098b945549b9b22137ef74340423"},"version":3}	2020-08-09 21:18:54.772978+00	2020-08-09 21:18:54.772978+00
\.


--
-- Data for Name: encumbrances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encumbrances (id, payment, expiration, end_at, oracles, aggregator, agg_initiate_job_selector, agg_fulfill_selector, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: eth_receipts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eth_receipts (id, tx_hash, block_hash, block_number, transaction_index, receipt, created_at) FROM stdin;
\.


--
-- Data for Name: eth_task_run_txes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eth_task_run_txes (task_run_id, eth_tx_id) FROM stdin;
\.


--
-- Data for Name: eth_tx_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eth_tx_attempts (id, eth_tx_id, gas_price, signed_raw_tx, hash, broadcast_before_block_num, state, created_at) FROM stdin;
\.


--
-- Data for Name: eth_txes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eth_txes (id, nonce, from_address, to_address, encoded_payload, value, gas_limit, error, broadcast_at, created_at, state) FROM stdin;
\.


--
-- Data for Name: external_initiators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_initiators (id, created_at, updated_at, deleted_at, name, url, access_key, salt, hashed_secret, outgoing_secret, outgoing_token) FROM stdin;
\.


--
-- Data for Name: flux_monitor_round_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flux_monitor_round_stats (id, aggregator, round_id, num_new_round_logs, num_submissions) FROM stdin;
\.


--
-- Data for Name: heads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.heads (id, hash, number, parent_hash, created_at, "timestamp") FROM stdin;
\.


--
-- Data for Name: initiators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.initiators (id, job_spec_id, type, created_at, deleted_at, schedule, "time", ran, address, requesters, name, params, from_block, to_block, topics, request_data, feeds, threshold, "precision", polling_interval, absolute_threshold, updated_at, poll_timer, idle_timer) FROM stdin;
1	778633ef-1888-4692-adc1-fe9592107957	runlog	2020-08-09 21:16:49.059835+00	\N		\N	f	\\x0000000000000000000000000000000000000000			\N	\N	\N	null	\N	\N	0	0	\N	0	2020-08-09 21:16:49.059835+00	{"period": "0s"}	{"duration": "0s"}
\.


--
-- Data for Name: job_runs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_runs (result_id, run_request_id, status, created_at, finished_at, updated_at, initiator_id, deleted_at, creation_height, observed_height, payment, job_spec_id, id) FROM stdin;
\.


--
-- Data for Name: job_spec_errors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_spec_errors (id, job_spec_id, description, occurrences, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: job_specs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_specs (created_at, start_at, end_at, deleted_at, min_payment, id, updated_at) FROM stdin;
2020-08-09 21:16:49.05025+00	\N	\N	\N	1000000000000000000	778633ef-1888-4692-adc1-fe9592107957	2020-08-09 21:16:49.053558+00
\.


--
-- Data for Name: keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keys (address, json, created_at, updated_at, next_nonce, id, last_used) FROM stdin;
\\x0b83e7104b17eb3775f78a4152a7960a43e475dd	{"id": "8c078f55-e490-4b36-8c54-59c5ddeefd45", "crypto": {"kdf": "scrypt", "mac": "938e7fca078988410b7d57a2216084e9a80edbd5c1e8354ab6e6ff9f66c360c8", "cipher": "aes-128-ctr", "kdfparams": {"n": 262144, "p": 1, "r": 8, "salt": "94cf6caf540ecd42b0b56cb98a7b58700409d870f478322b1ecebbdc6d22bf65", "dklen": 32}, "ciphertext": "4b4fa7456e1c8f140aeaa33e0ee224c6be8d88ef503e19e944dee46486d5a812", "cipherparams": {"iv": "43d4a7982b6d06eca0983659e86db848"}}, "address": "0b83e7104b17eb3775f78a4152a7960a43e475dd", "version": 3}	2020-08-09 21:07:57.44109+00	2020-08-09 21:15:10.500642+00	\N	2	\N
\.


--
-- Data for Name: log_consumptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_consumptions (id, block_hash, log_index, job_id, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id) FROM stdin;
0
1559081901
1559767166
1560433987
1560791143
1560881846
1560886530
1560924400
1560881855
1565139192
1564007745
1565210496
1566498796
1565877314
1566915476
1567029116
1568280052
1565291711
1568390387
1568833756
1570087128
1570675883
1573667511
1573812490
1575036327
1574659987
1576022702
1579700934
1580904019
1581240419
1584377646
1585908150
1585918589
1586163842
1586342453
1586369235
1586939705
1587027516
1587580235
1587591248
1587975059
1586956053
1588293486
1586949323
1588088353
1588757164
1588853064
1589470036
1586871710
1590226486
1591141873
1589206996
1589462363
1591603775
1592355365
1594393769
1594642891
1594306515
\.


--
-- Data for Name: run_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.run_requests (id, request_id, tx_hash, requester, created_at, block_hash, payment, request_params) FROM stdin;
\.


--
-- Data for Name: run_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.run_results (id, data, error_message, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: service_agreements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_agreements (id, created_at, encumbrance_id, request_body, signature, job_spec_id, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, last_used, created_at) FROM stdin;
8c1e86166e534d80a247a9904f37feb7	2020-08-09 21:12:12.605372+00	2020-08-09 21:12:08.151211+00
758c1cfecef944c2891f8e36c3c26c1a	2020-08-09 21:16:51.395291+00	2020-08-09 21:16:04.854741+00
\.


--
-- Data for Name: sync_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sync_events (id, created_at, updated_at, body) FROM stdin;
\.


--
-- Data for Name: task_runs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_runs (result_id, status, task_spec_id, minimum_confirmations, created_at, confirmations, job_run_id, id, updated_at) FROM stdin;
\.


--
-- Data for Name: task_specs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_specs (id, created_at, updated_at, deleted_at, type, confirmations, params, job_spec_id) FROM stdin;
1	2020-08-09 21:16:49.071824+00	2020-08-09 21:16:49.071824+00	\N	sleep	\N	\N	778633ef-1888-4692-adc1-fe9592107957
2	2020-08-09 21:16:49.0804+00	2020-08-09 21:16:49.0804+00	\N	ethbool	\N	\N	778633ef-1888-4692-adc1-fe9592107957
3	2020-08-09 21:16:49.08241+00	2020-08-09 21:16:49.08241+00	\N	ethtx	\N	\N	778633ef-1888-4692-adc1-fe9592107957
\.


--
-- Data for Name: tx_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tx_attempts (id, tx_id, created_at, hash, gas_price, confirmed, sent_at, signed_raw_tx, updated_at) FROM stdin;
\.


--
-- Data for Name: txes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.txes (id, surrogate_id, "from", "to", data, nonce, value, gas_limit, hash, gas_price, confirmed, sent_at, signed_raw_tx, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (email, hashed_password, created_at, token_key, token_salt, token_hashed_secret, updated_at, token_secret) FROM stdin;
buffalo@lotto.co	$2a$10$XZfyZWPXeBC8JJjKP.iSUOvrwtnADA7HYOzyeJnJzyjrrHNnB8HaS	2020-08-09 21:07:57.433261+00				2020-08-09 21:07:57.430424+00	\N
\.


--
-- Name: configurations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configurations_id_seq', 1, false);


--
-- Name: encumbrances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.encumbrances_id_seq', 1, false);


--
-- Name: eth_receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eth_receipts_id_seq', 1, false);


--
-- Name: eth_tx_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eth_tx_attempts_id_seq', 1, false);


--
-- Name: eth_txes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eth_txes_id_seq', 1, false);


--
-- Name: external_initiators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.external_initiators_id_seq', 1, false);


--
-- Name: flux_monitor_round_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flux_monitor_round_stats_id_seq', 1, false);


--
-- Name: heads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.heads_id_seq', 1, false);


--
-- Name: initiators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.initiators_id_seq', 1, true);


--
-- Name: job_spec_errors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_spec_errors_id_seq', 1, false);


--
-- Name: keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.keys_id_seq', 5, true);


--
-- Name: log_consumptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_consumptions_id_seq', 1, false);


--
-- Name: run_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.run_requests_id_seq', 1, false);


--
-- Name: run_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.run_results_id_seq', 1, false);


--
-- Name: sync_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sync_events_id_seq', 1, false);


--
-- Name: task_specs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_specs_id_seq', 3, true);


--
-- Name: tx_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tx_attempts_id_seq', 1, false);


--
-- Name: txes_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.txes_id_seq1', 1, false);


--
-- Name: bridge_types bridge_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bridge_types
    ADD CONSTRAINT bridge_types_pkey PRIMARY KEY (name);


--
-- Name: configurations configurations_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configurations
    ADD CONSTRAINT configurations_name_key UNIQUE (name);


--
-- Name: configurations configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configurations
    ADD CONSTRAINT configurations_pkey PRIMARY KEY (id);


--
-- Name: encrypted_secret_keys encrypted_secret_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encrypted_secret_keys
    ADD CONSTRAINT encrypted_secret_keys_pkey PRIMARY KEY (public_key);


--
-- Name: encumbrances encumbrances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encumbrances
    ADD CONSTRAINT encumbrances_pkey PRIMARY KEY (id);


--
-- Name: eth_receipts eth_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_receipts
    ADD CONSTRAINT eth_receipts_pkey PRIMARY KEY (id);


--
-- Name: eth_tx_attempts eth_tx_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_tx_attempts
    ADD CONSTRAINT eth_tx_attempts_pkey PRIMARY KEY (id);


--
-- Name: eth_txes eth_txes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_txes
    ADD CONSTRAINT eth_txes_pkey PRIMARY KEY (id);


--
-- Name: external_initiators external_initiators_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_initiators
    ADD CONSTRAINT external_initiators_name_key UNIQUE (name);


--
-- Name: external_initiators external_initiators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_initiators
    ADD CONSTRAINT external_initiators_pkey PRIMARY KEY (id);


--
-- Name: flux_monitor_round_stats flux_monitor_round_stats_aggregator_round_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flux_monitor_round_stats
    ADD CONSTRAINT flux_monitor_round_stats_aggregator_round_id_key UNIQUE (aggregator, round_id);


--
-- Name: flux_monitor_round_stats flux_monitor_round_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flux_monitor_round_stats
    ADD CONSTRAINT flux_monitor_round_stats_pkey PRIMARY KEY (id);


--
-- Name: heads heads_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heads
    ADD CONSTRAINT heads_pkey1 PRIMARY KEY (id);


--
-- Name: initiators initiators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.initiators
    ADD CONSTRAINT initiators_pkey PRIMARY KEY (id);


--
-- Name: job_runs job_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_runs
    ADD CONSTRAINT job_run_pkey PRIMARY KEY (id);


--
-- Name: job_spec_errors job_spec_errors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_spec_errors
    ADD CONSTRAINT job_spec_errors_pkey PRIMARY KEY (id);


--
-- Name: job_specs job_spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_specs
    ADD CONSTRAINT job_spec_pkey PRIMARY KEY (id);


--
-- Name: keys keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keys
    ADD CONSTRAINT keys_pkey PRIMARY KEY (id);


--
-- Name: log_consumptions log_consumptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_consumptions
    ADD CONSTRAINT log_consumptions_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: run_requests run_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run_requests
    ADD CONSTRAINT run_requests_pkey PRIMARY KEY (id);


--
-- Name: run_results run_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run_results
    ADD CONSTRAINT run_results_pkey PRIMARY KEY (id);


--
-- Name: service_agreements service_agreements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_agreements
    ADD CONSTRAINT service_agreements_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sync_events sync_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_events
    ADD CONSTRAINT sync_events_pkey PRIMARY KEY (id);


--
-- Name: task_runs task_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_runs
    ADD CONSTRAINT task_run_pkey PRIMARY KEY (id);


--
-- Name: task_specs task_specs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_specs
    ADD CONSTRAINT task_specs_pkey PRIMARY KEY (id);


--
-- Name: tx_attempts tx_attempts_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tx_attempts
    ADD CONSTRAINT tx_attempts_pkey1 PRIMARY KEY (id);


--
-- Name: txes txes_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.txes
    ADD CONSTRAINT txes_pkey1 PRIMARY KEY (id);


--
-- Name: txes txes_surrogate_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.txes
    ADD CONSTRAINT txes_surrogate_id_key UNIQUE (surrogate_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: idx_bridge_types_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bridge_types_created_at ON public.bridge_types USING brin (created_at);


--
-- Name: idx_bridge_types_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bridge_types_updated_at ON public.bridge_types USING brin (updated_at);


--
-- Name: idx_configurations_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_configurations_name ON public.configurations USING btree (name);


--
-- Name: idx_encumbrances_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_encumbrances_created_at ON public.encumbrances USING brin (created_at);


--
-- Name: idx_encumbrances_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_encumbrances_updated_at ON public.encumbrances USING brin (updated_at);


--
-- Name: idx_eth_receipts_block_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_receipts_block_number ON public.eth_receipts USING btree (block_number);


--
-- Name: idx_eth_receipts_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_receipts_created_at ON public.eth_receipts USING brin (created_at);


--
-- Name: idx_eth_receipts_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_eth_receipts_unique ON public.eth_receipts USING btree (tx_hash, block_hash);


--
-- Name: idx_eth_task_run_txes_eth_tx_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_eth_task_run_txes_eth_tx_id ON public.eth_task_run_txes USING btree (eth_tx_id);


--
-- Name: idx_eth_task_run_txes_task_run_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_eth_task_run_txes_task_run_id ON public.eth_task_run_txes USING btree (task_run_id);


--
-- Name: idx_eth_tx_attempts_broadcast_before_block_num; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_tx_attempts_broadcast_before_block_num ON public.eth_tx_attempts USING btree (broadcast_before_block_num);


--
-- Name: idx_eth_tx_attempts_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_tx_attempts_created_at ON public.eth_tx_attempts USING brin (created_at);


--
-- Name: idx_eth_tx_attempts_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_eth_tx_attempts_hash ON public.eth_tx_attempts USING btree (hash);


--
-- Name: idx_eth_tx_attempts_in_progress; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_tx_attempts_in_progress ON public.eth_tx_attempts USING btree (state) WHERE (state = 'in_progress'::public.eth_tx_attempts_state);


--
-- Name: idx_eth_tx_attempts_unique_gas_prices; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_eth_tx_attempts_unique_gas_prices ON public.eth_tx_attempts USING btree (eth_tx_id, gas_price);


--
-- Name: idx_eth_txes_broadcast_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_txes_broadcast_at ON public.eth_txes USING brin (broadcast_at);


--
-- Name: idx_eth_txes_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_txes_created_at ON public.eth_txes USING brin (created_at);


--
-- Name: idx_eth_txes_nonce_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_eth_txes_nonce_from_address ON public.eth_txes USING btree (nonce, from_address);


--
-- Name: idx_eth_txes_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_eth_txes_state ON public.eth_txes USING btree (state) WHERE (state <> 'confirmed'::public.eth_txes_state);


--
-- Name: idx_external_initiators_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_external_initiators_deleted_at ON public.external_initiators USING btree (deleted_at);


--
-- Name: idx_heads_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_heads_hash ON public.heads USING btree (hash);


--
-- Name: idx_heads_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_heads_number ON public.heads USING btree (number);


--
-- Name: idx_initiators_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_initiators_address ON public.initiators USING btree (address);


--
-- Name: idx_initiators_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_initiators_created_at ON public.initiators USING btree (created_at);


--
-- Name: idx_initiators_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_initiators_deleted_at ON public.initiators USING btree (deleted_at);


--
-- Name: idx_initiators_job_spec_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_initiators_job_spec_id ON public.initiators USING btree (job_spec_id);


--
-- Name: idx_initiators_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_initiators_type ON public.initiators USING btree (type);


--
-- Name: idx_initiators_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_initiators_updated_at ON public.initiators USING brin (updated_at);


--
-- Name: idx_job_runs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_created_at ON public.job_runs USING brin (created_at);


--
-- Name: idx_job_runs_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_deleted_at ON public.job_runs USING btree (deleted_at);


--
-- Name: idx_job_runs_finished_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_finished_at ON public.job_runs USING brin (finished_at);


--
-- Name: idx_job_runs_initiator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_initiator_id ON public.job_runs USING btree (initiator_id);


--
-- Name: idx_job_runs_job_spec_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_job_spec_id ON public.job_runs USING btree (job_spec_id);


--
-- Name: idx_job_runs_result_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_result_id ON public.job_runs USING btree (result_id);


--
-- Name: idx_job_runs_run_request_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_run_request_id ON public.job_runs USING btree (run_request_id);


--
-- Name: idx_job_runs_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_status ON public.job_runs USING btree (status) WHERE (status <> 'completed'::public.run_status);


--
-- Name: idx_job_runs_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_runs_updated_at ON public.job_runs USING brin (updated_at);


--
-- Name: idx_job_specs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_specs_created_at ON public.job_specs USING btree (created_at);


--
-- Name: idx_job_specs_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_specs_deleted_at ON public.job_specs USING btree (deleted_at);


--
-- Name: idx_job_specs_end_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_specs_end_at ON public.job_specs USING btree (end_at);


--
-- Name: idx_job_specs_start_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_specs_start_at ON public.job_specs USING btree (start_at);


--
-- Name: idx_job_specs_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_specs_updated_at ON public.job_specs USING brin (updated_at);


--
-- Name: idx_only_one_in_progress_attempt_per_eth_tx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_only_one_in_progress_attempt_per_eth_tx ON public.eth_tx_attempts USING btree (eth_tx_id) WHERE (state = 'in_progress'::public.eth_tx_attempts_state);


--
-- Name: idx_only_one_in_progress_tx_per_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_only_one_in_progress_tx_per_account ON public.eth_txes USING btree (from_address) WHERE (state = 'in_progress'::public.eth_txes_state);


--
-- Name: idx_run_requests_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_run_requests_created_at ON public.run_requests USING brin (created_at);


--
-- Name: idx_run_results_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_run_results_created_at ON public.run_results USING brin (created_at);


--
-- Name: idx_run_results_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_run_results_updated_at ON public.run_results USING brin (updated_at);


--
-- Name: idx_service_agreements_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_service_agreements_created_at ON public.service_agreements USING btree (created_at);


--
-- Name: idx_service_agreements_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_service_agreements_updated_at ON public.service_agreements USING brin (updated_at);


--
-- Name: idx_sessions_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sessions_created_at ON public.sessions USING brin (created_at);


--
-- Name: idx_sessions_last_used; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sessions_last_used ON public.sessions USING brin (last_used);


--
-- Name: idx_task_runs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_runs_created_at ON public.task_runs USING brin (created_at);


--
-- Name: idx_task_runs_job_run_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_runs_job_run_id ON public.task_runs USING btree (job_run_id);


--
-- Name: idx_task_runs_result_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_runs_result_id ON public.task_runs USING btree (result_id);


--
-- Name: idx_task_runs_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_runs_status ON public.task_runs USING btree (status) WHERE (status <> 'completed'::public.run_status);


--
-- Name: idx_task_runs_task_spec_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_runs_task_spec_id ON public.task_runs USING btree (task_spec_id);


--
-- Name: idx_task_runs_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_runs_updated_at ON public.task_runs USING brin (updated_at);


--
-- Name: idx_task_specs_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_specs_created_at ON public.task_specs USING brin (created_at);


--
-- Name: idx_task_specs_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_specs_deleted_at ON public.task_specs USING btree (deleted_at);


--
-- Name: idx_task_specs_job_spec_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_specs_job_spec_id ON public.task_specs USING btree (job_spec_id);


--
-- Name: idx_task_specs_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_specs_type ON public.task_specs USING btree (type);


--
-- Name: idx_task_specs_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_task_specs_updated_at ON public.task_specs USING brin (updated_at);


--
-- Name: idx_tx_attempts_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tx_attempts_created_at ON public.tx_attempts USING brin (created_at);


--
-- Name: idx_tx_attempts_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tx_attempts_hash ON public.tx_attempts USING btree (hash);


--
-- Name: idx_tx_attempts_tx_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tx_attempts_tx_id ON public.tx_attempts USING btree (tx_id);


--
-- Name: idx_tx_attempts_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tx_attempts_updated_at ON public.tx_attempts USING brin (updated_at);


--
-- Name: idx_txes_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_txes_created_at ON public.txes USING brin (created_at);


--
-- Name: idx_txes_from; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_txes_from ON public.txes USING btree ("from");


--
-- Name: idx_txes_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_txes_hash ON public.txes USING btree (hash);


--
-- Name: idx_txes_nonce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_txes_nonce ON public.txes USING btree (nonce);


--
-- Name: idx_txes_surrogate_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_txes_surrogate_id ON public.txes USING btree (surrogate_id);


--
-- Name: idx_txes_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_txes_updated_at ON public.txes USING brin (updated_at);


--
-- Name: idx_unique_keys_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_unique_keys_address ON public.keys USING btree (address);


--
-- Name: idx_users_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_created_at ON public.users USING btree (created_at);


--
-- Name: idx_users_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_updated_at ON public.users USING brin (updated_at);


--
-- Name: job_spec_errors_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_spec_errors_created_at_idx ON public.job_spec_errors USING brin (created_at);


--
-- Name: job_spec_errors_occurrences_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_spec_errors_occurrences_idx ON public.job_spec_errors USING btree (occurrences);


--
-- Name: job_spec_errors_unique_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX job_spec_errors_unique_idx ON public.job_spec_errors USING btree (job_spec_id, description);


--
-- Name: job_spec_errors_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_spec_errors_updated_at_idx ON public.job_spec_errors USING brin (updated_at);


--
-- Name: log_consumptions_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX log_consumptions_created_at_idx ON public.log_consumptions USING brin (created_at);


--
-- Name: log_consumptions_unique_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX log_consumptions_unique_idx ON public.log_consumptions USING btree (job_id, block_hash, log_index);


--
-- Name: sync_events_id_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sync_events_id_created_at_idx ON public.sync_events USING btree (id, created_at);


--
-- Name: eth_receipts eth_receipts_tx_hash_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_receipts
    ADD CONSTRAINT eth_receipts_tx_hash_fkey FOREIGN KEY (tx_hash) REFERENCES public.eth_tx_attempts(hash) ON DELETE CASCADE;


--
-- Name: eth_task_run_txes eth_task_run_txes_eth_tx_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_task_run_txes
    ADD CONSTRAINT eth_task_run_txes_eth_tx_id_fkey FOREIGN KEY (eth_tx_id) REFERENCES public.eth_txes(id) ON DELETE CASCADE;


--
-- Name: eth_task_run_txes eth_task_run_txes_task_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_task_run_txes
    ADD CONSTRAINT eth_task_run_txes_task_run_id_fkey FOREIGN KEY (task_run_id) REFERENCES public.task_runs(id) ON DELETE CASCADE;


--
-- Name: eth_tx_attempts eth_tx_attempts_eth_tx_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_tx_attempts
    ADD CONSTRAINT eth_tx_attempts_eth_tx_id_fkey FOREIGN KEY (eth_tx_id) REFERENCES public.eth_txes(id) ON DELETE CASCADE;


--
-- Name: eth_txes eth_txes_from_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eth_txes
    ADD CONSTRAINT eth_txes_from_address_fkey FOREIGN KEY (from_address) REFERENCES public.keys(address);


--
-- Name: initiators fk_initiators_job_spec_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.initiators
    ADD CONSTRAINT fk_initiators_job_spec_id FOREIGN KEY (job_spec_id) REFERENCES public.job_specs(id) ON DELETE RESTRICT;


--
-- Name: job_runs fk_job_runs_initiator_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_runs
    ADD CONSTRAINT fk_job_runs_initiator_id FOREIGN KEY (initiator_id) REFERENCES public.initiators(id) ON DELETE CASCADE;


--
-- Name: job_runs fk_job_runs_result_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_runs
    ADD CONSTRAINT fk_job_runs_result_id FOREIGN KEY (result_id) REFERENCES public.run_results(id) ON DELETE CASCADE;


--
-- Name: job_runs fk_job_runs_run_request_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_runs
    ADD CONSTRAINT fk_job_runs_run_request_id FOREIGN KEY (run_request_id) REFERENCES public.run_requests(id) ON DELETE CASCADE;


--
-- Name: service_agreements fk_service_agreements_encumbrance_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_agreements
    ADD CONSTRAINT fk_service_agreements_encumbrance_id FOREIGN KEY (encumbrance_id) REFERENCES public.encumbrances(id) ON DELETE RESTRICT;


--
-- Name: task_runs fk_task_runs_result_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_runs
    ADD CONSTRAINT fk_task_runs_result_id FOREIGN KEY (result_id) REFERENCES public.run_results(id) ON DELETE CASCADE;


--
-- Name: task_runs fk_task_runs_task_spec_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_runs
    ADD CONSTRAINT fk_task_runs_task_spec_id FOREIGN KEY (task_spec_id) REFERENCES public.task_specs(id) ON DELETE CASCADE;


--
-- Name: job_runs job_runs_job_spec_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_runs
    ADD CONSTRAINT job_runs_job_spec_id_fkey FOREIGN KEY (job_spec_id) REFERENCES public.job_specs(id) ON DELETE CASCADE;


--
-- Name: job_spec_errors job_spec_errors_job_spec_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_spec_errors
    ADD CONSTRAINT job_spec_errors_job_spec_id_fkey FOREIGN KEY (job_spec_id) REFERENCES public.job_specs(id) ON DELETE CASCADE;


--
-- Name: log_consumptions log_consumptions_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_consumptions
    ADD CONSTRAINT log_consumptions_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job_specs(id) ON DELETE CASCADE;


--
-- Name: service_agreements service_agreements_job_spec_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_agreements
    ADD CONSTRAINT service_agreements_job_spec_id_fkey FOREIGN KEY (job_spec_id) REFERENCES public.job_specs(id) ON DELETE CASCADE;


--
-- Name: task_runs task_runs_job_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_runs
    ADD CONSTRAINT task_runs_job_run_id_fkey FOREIGN KEY (job_run_id) REFERENCES public.job_runs(id) ON DELETE CASCADE;


--
-- Name: task_specs task_specs_job_spec_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_specs
    ADD CONSTRAINT task_specs_job_spec_id_fkey FOREIGN KEY (job_spec_id) REFERENCES public.job_specs(id) ON DELETE CASCADE;


--
-- Name: tx_attempts tx_attempts_tx_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tx_attempts
    ADD CONSTRAINT tx_attempts_tx_id_fkey FOREIGN KEY (tx_id) REFERENCES public.txes(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Debian 12.3-1.pgdg100+1)
-- Dumped by pg_dump version 12.3 (Debian 12.3-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

