--
-- PostgreSQL database dump
--

\restrict GE2IIQnYmGvi2l2XSYO1uapjSq6egS5qHV6ZAYPgQVVWucqvtDrJd59BqVTNjKi

-- Dumped from database version 15.18
-- Dumped by pg_dump version 15.18 (Debian 15.18-0+deb12u1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assinatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assinatura (
    idassinatura integer NOT NULL,
    datainicio date NOT NULL,
    datafim date,
    idplano integer NOT NULL,
    idconta integer NOT NULL
);


ALTER TABLE public.assinatura OWNER TO postgres;

--
-- Name: assinatura_idassinatura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assinatura_idassinatura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assinatura_idassinatura_seq OWNER TO postgres;

--
-- Name: assinatura_idassinatura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assinatura_idassinatura_seq OWNED BY public.assinatura.idassinatura;


--
-- Name: ator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ator (
    idator integer NOT NULL,
    nome character varying(150) NOT NULL,
    idnacionalidade integer NOT NULL
);


ALTER TABLE public.ator OWNER TO postgres;

--
-- Name: ator_idator_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ator_idator_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ator_idator_seq OWNER TO postgres;

--
-- Name: ator_idator_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ator_idator_seq OWNED BY public.ator.idator;


--
-- Name: atorelenco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atorelenco (
    idatorelenco integer NOT NULL,
    nomepersonagem character varying(150),
    idelenco integer NOT NULL,
    idator integer NOT NULL
);


ALTER TABLE public.atorelenco OWNER TO postgres;

--
-- Name: atorelenco_idatorelenco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.atorelenco_idatorelenco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.atorelenco_idatorelenco_seq OWNER TO postgres;

--
-- Name: atorelenco_idatorelenco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.atorelenco_idatorelenco_seq OWNED BY public.atorelenco.idatorelenco;


--
-- Name: catalogo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo (
    idcatalogo integer NOT NULL
);


ALTER TABLE public.catalogo OWNER TO postgres;

--
-- Name: catalogo_idcatalogo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catalogo_idcatalogo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogo_idcatalogo_seq OWNER TO postgres;

--
-- Name: catalogo_idcatalogo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catalogo_idcatalogo_seq OWNED BY public.catalogo.idcatalogo;


--
-- Name: cidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cidade (
    idcidade integer NOT NULL,
    nome character varying(100) NOT NULL,
    idestado integer NOT NULL
);


ALTER TABLE public.cidade OWNER TO postgres;

--
-- Name: cidade_idcidade_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cidade_idcidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cidade_idcidade_seq OWNER TO postgres;

--
-- Name: cidade_idcidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cidade_idcidade_seq OWNED BY public.cidade.idcidade;


--
-- Name: conta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta (
    idconta integer NOT NULL,
    email character varying(200) NOT NULL,
    senha character varying(250) NOT NULL,
    idendereco integer NOT NULL
);


ALTER TABLE public.conta OWNER TO postgres;

--
-- Name: conta_idconta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conta_idconta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conta_idconta_seq OWNER TO postgres;

--
-- Name: conta_idconta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conta_idconta_seq OWNED BY public.conta.idconta;


--
-- Name: elenco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elenco (
    idelenco integer NOT NULL,
    idobra integer NOT NULL
);


ALTER TABLE public.elenco OWNER TO postgres;

--
-- Name: elenco_idelenco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.elenco_idelenco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elenco_idelenco_seq OWNER TO postgres;

--
-- Name: elenco_idelenco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.elenco_idelenco_seq OWNED BY public.elenco.idelenco;


--
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    idendereco integer NOT NULL,
    idcidade integer NOT NULL
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- Name: endereco_idendereco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endereco_idendereco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.endereco_idendereco_seq OWNER TO postgres;

--
-- Name: endereco_idendereco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.endereco_idendereco_seq OWNED BY public.endereco.idendereco;


--
-- Name: episodio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.episodio (
    idepisodio integer NOT NULL,
    titulo character varying(250) NOT NULL,
    duracaominutos integer NOT NULL,
    sinopse text,
    idtemporada integer NOT NULL
);


ALTER TABLE public.episodio OWNER TO postgres;

--
-- Name: episodio_idepisodio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.episodio_idepisodio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.episodio_idepisodio_seq OWNER TO postgres;

--
-- Name: episodio_idepisodio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.episodio_idepisodio_seq OWNED BY public.episodio.idepisodio;


--
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    idestado integer NOT NULL,
    nome character varying(100) NOT NULL,
    idpais integer NOT NULL
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- Name: estado_idestado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_idestado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estado_idestado_seq OWNER TO postgres;

--
-- Name: estado_idestado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_idestado_seq OWNED BY public.estado.idestado;


--
-- Name: filme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filme (
    idfilme integer NOT NULL,
    duracaominutos integer NOT NULL,
    anolancamento integer,
    idobra integer NOT NULL
);


ALTER TABLE public.filme OWNER TO postgres;

--
-- Name: filme_idfilme_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filme_idfilme_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filme_idfilme_seq OWNER TO postgres;

--
-- Name: filme_idfilme_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filme_idfilme_seq OWNED BY public.filme.idfilme;


--
-- Name: genero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genero (
    idgenero integer NOT NULL,
    nomegenero character varying(50) NOT NULL
);


ALTER TABLE public.genero OWNER TO postgres;

--
-- Name: genero_idgenero_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genero_idgenero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genero_idgenero_seq OWNER TO postgres;

--
-- Name: genero_idgenero_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genero_idgenero_seq OWNED BY public.genero.idgenero;


--
-- Name: generoobra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generoobra (
    idgeneroobra integer NOT NULL,
    idgenero integer NOT NULL,
    idobra integer NOT NULL
);


ALTER TABLE public.generoobra OWNER TO postgres;

--
-- Name: generoobra_idgeneroobra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.generoobra_idgeneroobra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.generoobra_idgeneroobra_seq OWNER TO postgres;

--
-- Name: generoobra_idgeneroobra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.generoobra_idgeneroobra_seq OWNED BY public.generoobra.idgeneroobra;


--
-- Name: historico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historico (
    idhistorico integer NOT NULL,
    datahora timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    idperfil integer NOT NULL,
    idobra integer NOT NULL
);


ALTER TABLE public.historico OWNER TO postgres;

--
-- Name: historico_idhistorico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historico_idhistorico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historico_idhistorico_seq OWNER TO postgres;

--
-- Name: historico_idhistorico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historico_idhistorico_seq OWNED BY public.historico.idhistorico;


--
-- Name: nacionalidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nacionalidade (
    idnacionalidade integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.nacionalidade OWNER TO postgres;

--
-- Name: nacionalidade_idnacionalidade_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nacionalidade_idnacionalidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nacionalidade_idnacionalidade_seq OWNER TO postgres;

--
-- Name: nacionalidade_idnacionalidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nacionalidade_idnacionalidade_seq OWNED BY public.nacionalidade.idnacionalidade;


--
-- Name: obra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obra (
    idobra integer NOT NULL,
    titulo character varying(250) NOT NULL,
    sinopse text,
    classetaria character varying(10),
    tipoobra character varying(50)
);


ALTER TABLE public.obra OWNER TO postgres;

--
-- Name: obra_idobra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.obra_idobra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.obra_idobra_seq OWNER TO postgres;

--
-- Name: obra_idobra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.obra_idobra_seq OWNED BY public.obra.idobra;


--
-- Name: obracatalogo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obracatalogo (
    idobracatalogo integer NOT NULL,
    idobra integer NOT NULL,
    idcatalogo integer NOT NULL
);


ALTER TABLE public.obracatalogo OWNER TO postgres;

--
-- Name: obracatalogo_idobracatalogo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.obracatalogo_idobracatalogo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.obracatalogo_idobracatalogo_seq OWNER TO postgres;

--
-- Name: obracatalogo_idobracatalogo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.obracatalogo_idobracatalogo_seq OWNED BY public.obracatalogo.idobracatalogo;


--
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    idpais integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- Name: pais_idpais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pais_idpais_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pais_idpais_seq OWNER TO postgres;

--
-- Name: pais_idpais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pais_idpais_seq OWNED BY public.pais.idpais;


--
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    idperfil integer NOT NULL,
    avatar character varying(80),
    nome character varying(150) NOT NULL,
    idconta integer NOT NULL
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- Name: perfil_idperfil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfil_idperfil_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfil_idperfil_seq OWNER TO postgres;

--
-- Name: perfil_idperfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfil_idperfil_seq OWNED BY public.perfil.idperfil;


--
-- Name: perfilcatalogo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfilcatalogo (
    idperfilcatalogo integer NOT NULL,
    idcatalogo integer NOT NULL,
    idperfil integer NOT NULL
);


ALTER TABLE public.perfilcatalogo OWNER TO postgres;

--
-- Name: perfilcatalogo_idperfilcatalogo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfilcatalogo_idperfilcatalogo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfilcatalogo_idperfilcatalogo_seq OWNER TO postgres;

--
-- Name: perfilcatalogo_idperfilcatalogo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfilcatalogo_idperfilcatalogo_seq OWNED BY public.perfilcatalogo.idperfilcatalogo;


--
-- Name: plano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plano (
    idplano integer NOT NULL,
    valor numeric(10,2) NOT NULL,
    duracaomeses integer NOT NULL,
    nome character varying(100) NOT NULL,
    beneficios text
);


ALTER TABLE public.plano OWNER TO postgres;

--
-- Name: plano_idplano_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plano_idplano_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plano_idplano_seq OWNER TO postgres;

--
-- Name: plano_idplano_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plano_idplano_seq OWNED BY public.plano.idplano;


--
-- Name: serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serie (
    idserie integer NOT NULL,
    idobra integer NOT NULL
);


ALTER TABLE public.serie OWNER TO postgres;

--
-- Name: serie_idserie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serie_idserie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.serie_idserie_seq OWNER TO postgres;

--
-- Name: serie_idserie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serie_idserie_seq OWNED BY public.serie.idserie;


--
-- Name: temporada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.temporada (
    idtemporada integer NOT NULL,
    numtemporada integer NOT NULL,
    anolancamento integer,
    idserie integer NOT NULL
);


ALTER TABLE public.temporada OWNER TO postgres;

--
-- Name: temporada_idtemporada_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.temporada_idtemporada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temporada_idtemporada_seq OWNER TO postgres;

--
-- Name: temporada_idtemporada_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.temporada_idtemporada_seq OWNED BY public.temporada.idtemporada;


--
-- Name: assinatura idassinatura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assinatura ALTER COLUMN idassinatura SET DEFAULT nextval('public.assinatura_idassinatura_seq'::regclass);


--
-- Name: ator idator; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ator ALTER COLUMN idator SET DEFAULT nextval('public.ator_idator_seq'::regclass);


--
-- Name: atorelenco idatorelenco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atorelenco ALTER COLUMN idatorelenco SET DEFAULT nextval('public.atorelenco_idatorelenco_seq'::regclass);


--
-- Name: catalogo idcatalogo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo ALTER COLUMN idcatalogo SET DEFAULT nextval('public.catalogo_idcatalogo_seq'::regclass);


--
-- Name: cidade idcidade; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cidade ALTER COLUMN idcidade SET DEFAULT nextval('public.cidade_idcidade_seq'::regclass);


--
-- Name: conta idconta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta ALTER COLUMN idconta SET DEFAULT nextval('public.conta_idconta_seq'::regclass);


--
-- Name: elenco idelenco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elenco ALTER COLUMN idelenco SET DEFAULT nextval('public.elenco_idelenco_seq'::regclass);


--
-- Name: endereco idendereco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco ALTER COLUMN idendereco SET DEFAULT nextval('public.endereco_idendereco_seq'::regclass);


--
-- Name: episodio idepisodio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episodio ALTER COLUMN idepisodio SET DEFAULT nextval('public.episodio_idepisodio_seq'::regclass);


--
-- Name: estado idestado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado ALTER COLUMN idestado SET DEFAULT nextval('public.estado_idestado_seq'::regclass);


--
-- Name: filme idfilme; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filme ALTER COLUMN idfilme SET DEFAULT nextval('public.filme_idfilme_seq'::regclass);


--
-- Name: genero idgenero; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero ALTER COLUMN idgenero SET DEFAULT nextval('public.genero_idgenero_seq'::regclass);


--
-- Name: generoobra idgeneroobra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generoobra ALTER COLUMN idgeneroobra SET DEFAULT nextval('public.generoobra_idgeneroobra_seq'::regclass);


--
-- Name: historico idhistorico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico ALTER COLUMN idhistorico SET DEFAULT nextval('public.historico_idhistorico_seq'::regclass);


--
-- Name: nacionalidade idnacionalidade; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidade ALTER COLUMN idnacionalidade SET DEFAULT nextval('public.nacionalidade_idnacionalidade_seq'::regclass);


--
-- Name: obra idobra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obra ALTER COLUMN idobra SET DEFAULT nextval('public.obra_idobra_seq'::regclass);


--
-- Name: obracatalogo idobracatalogo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obracatalogo ALTER COLUMN idobracatalogo SET DEFAULT nextval('public.obracatalogo_idobracatalogo_seq'::regclass);


--
-- Name: pais idpais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais ALTER COLUMN idpais SET DEFAULT nextval('public.pais_idpais_seq'::regclass);


--
-- Name: perfil idperfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil ALTER COLUMN idperfil SET DEFAULT nextval('public.perfil_idperfil_seq'::regclass);


--
-- Name: perfilcatalogo idperfilcatalogo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfilcatalogo ALTER COLUMN idperfilcatalogo SET DEFAULT nextval('public.perfilcatalogo_idperfilcatalogo_seq'::regclass);


--
-- Name: plano idplano; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plano ALTER COLUMN idplano SET DEFAULT nextval('public.plano_idplano_seq'::regclass);


--
-- Name: serie idserie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie ALTER COLUMN idserie SET DEFAULT nextval('public.serie_idserie_seq'::regclass);


--
-- Name: temporada idtemporada; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporada ALTER COLUMN idtemporada SET DEFAULT nextval('public.temporada_idtemporada_seq'::regclass);


--
-- Data for Name: assinatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assinatura (idassinatura, datainicio, datafim, idplano, idconta) FROM stdin;
1	2025-10-01	2025-11-01	1	1
2	2025-11-01	2025-12-01	2	1
3	2025-12-01	2026-01-01	3	1
4	2026-02-01	2026-03-01	3	1
5	2026-03-03	2026-04-03	2	2
6	2026-03-15	2026-04-15	2	3
7	2026-04-01	2026-05-01	3	1
8	2026-04-01	2026-05-01	1	4
9	2026-04-02	2026-05-02	2	5
10	2026-04-04	2026-05-04	1	2
\.


--
-- Data for Name: ator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ator (idator, nome, idnacionalidade) FROM stdin;
1	Mason Thames	1
2	Nico Parker	2
3	Matthew McConaughey	1
4	Wes Bentley	1
5	Bryan Cranston	1
6	Giancarlo Esposito	1
7	Jennifer Lawrence	1
8	Dylan OBrien	1
\.


--
-- Data for Name: atorelenco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atorelenco (idatorelenco, nomepersonagem, idelenco, idator) FROM stdin;
1	Soluço	1	1
2	Astrid	1	2
3	Cooper	2	3
4	Doyle	2	4
5	Walter White	3	5
6	Gus Fring	3	6
7	Katniss Everdeen	4	7
8	Seneca Crane	4	4
9	Thomas	5	8
10	Jorge	5	6
11	Gus Fring	6	6
12	Moff Gideon	7	6
13	Stan Edgar	8	6
14	Frank Dawson	9	6
15	Tom Neville	10	6
\.


--
-- Data for Name: catalogo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo (idcatalogo) FROM stdin;
1
2
3
4
5
\.


--
-- Data for Name: cidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cidade (idcidade, nome, idestado) FROM stdin;
1	São Paulo	1
2	Niterói	2
3	Belo Horizonte	3
4	Lisboa	4
5	Toronto	5
\.


--
-- Data for Name: conta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conta (idconta, email, senha, idendereco) FROM stdin;
1	ana@gmail.com	Ana123	1
2	bruno@gmail.com	Bruno321	2
3	caio@gmail.com	0C_20	3
4	diana@gmail.com	Diana951	4
5	edna@gmail.com	Edna123	5
\.


--
-- Data for Name: elenco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.elenco (idelenco, idobra) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
\.


--
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endereco (idendereco, idcidade) FROM stdin;
1	1
2	2
3	4
4	3
5	5
\.


--
-- Data for Name: episodio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.episodio (idepisodio, titulo, duracaominutos, sinopse, idtemporada) FROM stdin;
1	Piloto	58	 Professor com câncer começa a fabricar metanfetamina no deserto.	1
2	O Gato está no Saco...	48	Walt e Jesse lidam com dois traficantes no porão.	1
3	Sete Trinta e Sete	47	Tuco sequestra Walt e Jesse após o negócio falhar.	2
4	Na Grelha	47	Walt e Jesse tentam escapar da casa do tio de Tuco.	2
5	No Más	47	Walt lida com o divórcio enquanto Skyler descobre segredos.	3
6	Cavalo sem Nome	47	Walt tenta se reconciliar com a família após o acidente.	3
7	Estilete	47	Gus mata um capanga brutalmente para enviar um aviso.	4
8	Trinta e Oito Cano Curto	47	Walt compra uma arma ilegal para tentar matar Gus.	4
9	Viver Livre ou Morrer	43	Walt usa um superímã para destruir provas da polícia.	5
10	Madrigal	47	Mike e Walt formam uma nova parceria para o tráfico.	5
11	Uno	50	Advogado trapaceiro Jimmy McGill transforma-se no icônico e polêmico Saul.	6
12	The Mandalorian	40	Caçador de recompensas protege criança misteriosa em uma galáxia perigosa.	7
13	The Name of The Game	55	Vigilantes enfrentam super-heróis corruptos que abusam de seus poderes especiais.	8
14	Piloto	42	Sobreviventes buscam respostas em mundo onde toda eletricidade parou misteriosamente.	9
\.


--
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado (idestado, nome, idpais) FROM stdin;
1	São Paulo	1
2	Rio de Janeiro	1
3	Minas Gerais	1
4	Lisboa	2
5	Ontário	3
\.


--
-- Data for Name: filme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filme (idfilme, duracaominutos, anolancamento, idobra) FROM stdin;
1	125	2025	1
2	169	2014	2
3	144	2012	4
4	113	2014	5
5	120	2017	9
\.


--
-- Data for Name: genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genero (idgenero, nomegenero) FROM stdin;
1	Fantasia
2	Aventura
3	Comédia
4	Ação
5	Drama
6	Ficção Científica
7	Suspense
\.


--
-- Data for Name: generoobra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generoobra (idgeneroobra, idgenero, idobra) FROM stdin;
1	1	1
2	2	1
3	3	1
4	6	2
5	5	2
6	5	3
7	7	3
8	4	4
9	6	4
10	4	5
11	7	5
12	3	6
13	4	7
14	2	8
15	7	9
16	5	10
\.


--
-- Data for Name: historico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico (idhistorico, datahora, idperfil, idobra) FROM stdin;
1	2026-03-25 08:45:12	7	4
2	2026-03-30 10:00:05	8	5
3	2026-04-01 15:20:33	8	2
4	2026-04-03 23:59:59	2	1
5	2026-04-04 09:12:11	2	3
6	2026-04-05 18:05:42	6	2
7	2026-04-05 22:15:08	4	4
8	2026-04-06 12:30:00	6	4
9	2026-04-06 14:40:00	5	2
10	2026-04-06 14:44:52	3	2
\.


--
-- Data for Name: nacionalidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nacionalidade (idnacionalidade, nome) FROM stdin;
1	Americano
2	Britânica
\.


--
-- Data for Name: obra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obra (idobra, titulo, sinopse, classetaria, tipoobra) FROM stdin;
1	Como Treinar o Seu Dragão	Soluço é um jovem viking que não tem capacidade para lutar contra os dragões, como é a tradição local. Sua vida muda quando ele ajuda um dragão que lhe mostra toda a verdade. Juntos, eles tentam provar que dragões e humanos podem ser amigos.	10	Filme
2	Interestelar	As reservas naturais da Terra estão chegando ao fim e um grupo de astronautas recebe a missão de verificar possíveis planetas para receberem a população mundial, possibilitando a continuação da espécie. Cooper é chamado para liderar o grupo e aceita a missão sabendo que pode nunca mais ver os filhos. Ao lado de Brand, Jenkins e Doyle, ele seguirá em busca de um novo lar.	10	Filme
3	Breaking Bad	narra a transformação de Walter White (Bryan Cranston), um professor de química frustrado e com câncer terminal, em um impiedoso produtor de metanfetamina. Para garantir o futuro financeiro de sua família, ele se alia ao ex-aluno Jesse Pinkman (Aaron Paul), mergulhando no perigoso mundo do crime em Albuquerque.	16	Série
4	Jogos Vorazes	Na região antigamente conhecida como América do Norte, a Capital de Panem controla 12 distritos e os força a escolher um garoto e uma garota, conhecidos como tributos, para competir em um evento anual televisionado. Todos os cidadãos assistem aos temidos jogos, no qual os jovens lutam até a morte, de modo que apenas um saia vitorioso. A jovem Katniss Everdeen, do Distrito 12, confia na habilidade de caça e na destreza com o arco, além dos instintos aguçados, nesta competição mortal.	14	Filme
5	Maze Runner	Em um futuro apocalíptico, o jovem Thomas é escolher o sistema. Ele acorda num escuro elevador em movimento e não consegue se lembrar nem de seu nome. Na comunidade isolada em que foi abandonado, Thomas conhece outros garotos que passaram pela mesma situação. Para conseguir escapar, ele precisa descobrir os sombrios segredos guardados in sua mente e correr muito.	14	Filme
6	Better Call Saul	Advogado trapaceiro Jimmy McGill transforma-se no icônico e polêmico Saul.	14	Série
7	The Mandalorian	Caçador de recompensas protege criança misteriosa em uma galáxia perigosa.	12	Série
8	The Boys	Vigilantes enfrentam super-heróis corruptos que abusam de seus poderes especiais.	18	Série
9	Okja	Menina luta para salvar criatura gigante de uma corporação cruel.	10	Filme
10	Revolution	Sobreviventes buscam respostas em mundo onde toda eletricidade parou misteriosamente.	10	Série
\.


--
-- Data for Name: obracatalogo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obracatalogo (idobracatalogo, idobra, idcatalogo) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	2	2
7	3	2
8	4	2
9	5	2
10	2	3
11	4	3
12	1	4
13	1	5
14	3	5
15	5	5
16	6	1
17	7	1
18	8	1
19	9	1
20	10	1
\.


--
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais (idpais, nome) FROM stdin;
1	Brasil
2	Portugal
3	Canadá
\.


--
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfil (idperfil, avatar, nome, idconta) FROM stdin;
1	Red_3	Ana	1
2	Cavaleiro_2	Bruno	2
3	Dragao_5	Caio	3
4	Princesa_1	Diana	4
5	Green_4	Edna	5
6	Red_3	Fernando	4
7	Divertidamente_3	Visitas	2
8	Princesa_1	Maria	3
9	Marvel_2	Gabriel	2
\.


--
-- Data for Name: perfilcatalogo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfilcatalogo (idperfilcatalogo, idcatalogo, idperfil) FROM stdin;
1	1	1
2	5	2
3	1	3
4	3	4
5	1	5
6	3	6
7	1	7
8	2	8
9	1	9
\.


--
-- Data for Name: plano; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plano (idplano, valor, duracaomeses, nome, beneficios) FROM stdin;
1	20.90	1	Padrão com anuncios	Veja filme em qualidade FHD com anuncios!
2	44.90	1	Padrão	Veja filmes em qualidade FHD!
3	59.90	1	Premium	Veja filmes em qualidade UHD e com HDR!
\.


--
-- Data for Name: serie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serie (idserie, idobra) FROM stdin;
1	3
2	6
3	7
4	8
5	10
\.


--
-- Data for Name: temporada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.temporada (idtemporada, numtemporada, anolancamento, idserie) FROM stdin;
1	1	2008	1
2	2	2009	1
3	3	2010	1
4	4	2011	1
5	5	2012	1
6	1	2015	2
7	1	2019	3
8	1	2019	4
9	1	2012	5
\.


--
-- Name: assinatura_idassinatura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assinatura_idassinatura_seq', 11, true);


--
-- Name: ator_idator_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ator_idator_seq', 8, true);


--
-- Name: atorelenco_idatorelenco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atorelenco_idatorelenco_seq', 15, true);


--
-- Name: catalogo_idcatalogo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catalogo_idcatalogo_seq', 5, true);


--
-- Name: cidade_idcidade_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cidade_idcidade_seq', 5, true);


--
-- Name: conta_idconta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conta_idconta_seq', 6, true);


--
-- Name: elenco_idelenco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.elenco_idelenco_seq', 10, true);


--
-- Name: endereco_idendereco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_idendereco_seq', 5, true);


--
-- Name: episodio_idepisodio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.episodio_idepisodio_seq', 14, true);


--
-- Name: estado_idestado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_idestado_seq', 5, true);


--
-- Name: filme_idfilme_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filme_idfilme_seq', 5, true);


--
-- Name: genero_idgenero_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genero_idgenero_seq', 7, true);


--
-- Name: generoobra_idgeneroobra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generoobra_idgeneroobra_seq', 16, true);


--
-- Name: historico_idhistorico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_idhistorico_seq', 10, true);


--
-- Name: nacionalidade_idnacionalidade_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nacionalidade_idnacionalidade_seq', 2, true);


--
-- Name: obra_idobra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obra_idobra_seq', 10, true);


--
-- Name: obracatalogo_idobracatalogo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obracatalogo_idobracatalogo_seq', 20, true);


--
-- Name: pais_idpais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pais_idpais_seq', 3, true);


--
-- Name: perfil_idperfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfil_idperfil_seq', 11, true);


--
-- Name: perfilcatalogo_idperfilcatalogo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfilcatalogo_idperfilcatalogo_seq', 9, true);


--
-- Name: plano_idplano_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plano_idplano_seq', 3, true);


--
-- Name: serie_idserie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serie_idserie_seq', 5, true);


--
-- Name: temporada_idtemporada_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.temporada_idtemporada_seq', 9, true);


--
-- Name: assinatura assinatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assinatura
    ADD CONSTRAINT assinatura_pkey PRIMARY KEY (idassinatura);


--
-- Name: ator ator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ator
    ADD CONSTRAINT ator_pkey PRIMARY KEY (idator);


--
-- Name: atorelenco atorelenco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atorelenco
    ADD CONSTRAINT atorelenco_pkey PRIMARY KEY (idatorelenco);


--
-- Name: catalogo catalogo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo
    ADD CONSTRAINT catalogo_pkey PRIMARY KEY (idcatalogo);


--
-- Name: cidade cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cidade
    ADD CONSTRAINT cidade_pkey PRIMARY KEY (idcidade);


--
-- Name: conta conta_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta
    ADD CONSTRAINT conta_email_key UNIQUE (email);


--
-- Name: conta conta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta
    ADD CONSTRAINT conta_pkey PRIMARY KEY (idconta);


--
-- Name: elenco elenco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elenco
    ADD CONSTRAINT elenco_pkey PRIMARY KEY (idelenco);


--
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (idendereco);


--
-- Name: episodio episodio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT episodio_pkey PRIMARY KEY (idepisodio);


--
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (idestado);


--
-- Name: filme filme_idobra_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filme
    ADD CONSTRAINT filme_idobra_key UNIQUE (idobra);


--
-- Name: filme filme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filme
    ADD CONSTRAINT filme_pkey PRIMARY KEY (idfilme);


--
-- Name: genero genero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_pkey PRIMARY KEY (idgenero);


--
-- Name: generoobra generoobra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generoobra
    ADD CONSTRAINT generoobra_pkey PRIMARY KEY (idgeneroobra);


--
-- Name: historico historico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico
    ADD CONSTRAINT historico_pkey PRIMARY KEY (idhistorico);


--
-- Name: nacionalidade nacionalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacionalidade
    ADD CONSTRAINT nacionalidade_pkey PRIMARY KEY (idnacionalidade);


--
-- Name: obra obra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obra
    ADD CONSTRAINT obra_pkey PRIMARY KEY (idobra);


--
-- Name: obracatalogo obracatalogo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obracatalogo
    ADD CONSTRAINT obracatalogo_pkey PRIMARY KEY (idobracatalogo);


--
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (idpais);


--
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (idperfil);


--
-- Name: perfilcatalogo perfilcatalogo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfilcatalogo
    ADD CONSTRAINT perfilcatalogo_pkey PRIMARY KEY (idperfilcatalogo);


--
-- Name: plano plano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plano
    ADD CONSTRAINT plano_pkey PRIMARY KEY (idplano);


--
-- Name: serie serie_idobra_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_idobra_key UNIQUE (idobra);


--
-- Name: serie serie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_pkey PRIMARY KEY (idserie);


--
-- Name: temporada temporada_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT temporada_pkey PRIMARY KEY (idtemporada);


--
-- Name: idx_generoobra_idgenero; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_generoobra_idgenero ON public.generoobra USING btree (idgenero);


--
-- Name: assinatura assinatura_idconta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assinatura
    ADD CONSTRAINT assinatura_idconta_fkey FOREIGN KEY (idconta) REFERENCES public.conta(idconta);


--
-- Name: assinatura assinatura_idplano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assinatura
    ADD CONSTRAINT assinatura_idplano_fkey FOREIGN KEY (idplano) REFERENCES public.plano(idplano);


--
-- Name: ator ator_idnacionalidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ator
    ADD CONSTRAINT ator_idnacionalidade_fkey FOREIGN KEY (idnacionalidade) REFERENCES public.nacionalidade(idnacionalidade);


--
-- Name: atorelenco atorelenco_idator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atorelenco
    ADD CONSTRAINT atorelenco_idator_fkey FOREIGN KEY (idator) REFERENCES public.ator(idator);


--
-- Name: atorelenco atorelenco_idelenco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atorelenco
    ADD CONSTRAINT atorelenco_idelenco_fkey FOREIGN KEY (idelenco) REFERENCES public.elenco(idelenco);


--
-- Name: cidade cidade_idestado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cidade
    ADD CONSTRAINT cidade_idestado_fkey FOREIGN KEY (idestado) REFERENCES public.estado(idestado);


--
-- Name: conta conta_idendereco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta
    ADD CONSTRAINT conta_idendereco_fkey FOREIGN KEY (idendereco) REFERENCES public.endereco(idendereco);


--
-- Name: elenco elenco_idobra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elenco
    ADD CONSTRAINT elenco_idobra_fkey FOREIGN KEY (idobra) REFERENCES public.obra(idobra);


--
-- Name: endereco endereco_idcidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_idcidade_fkey FOREIGN KEY (idcidade) REFERENCES public.cidade(idcidade);


--
-- Name: episodio episodio_idtemporada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episodio
    ADD CONSTRAINT episodio_idtemporada_fkey FOREIGN KEY (idtemporada) REFERENCES public.temporada(idtemporada);


--
-- Name: estado estado_idpais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_idpais_fkey FOREIGN KEY (idpais) REFERENCES public.pais(idpais);


--
-- Name: filme filme_idobra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filme
    ADD CONSTRAINT filme_idobra_fkey FOREIGN KEY (idobra) REFERENCES public.obra(idobra);


--
-- Name: generoobra generoobra_idgenero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generoobra
    ADD CONSTRAINT generoobra_idgenero_fkey FOREIGN KEY (idgenero) REFERENCES public.genero(idgenero);


--
-- Name: generoobra generoobra_idobra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generoobra
    ADD CONSTRAINT generoobra_idobra_fkey FOREIGN KEY (idobra) REFERENCES public.obra(idobra);


--
-- Name: historico historico_idobra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico
    ADD CONSTRAINT historico_idobra_fkey FOREIGN KEY (idobra) REFERENCES public.obra(idobra);


--
-- Name: historico historico_idperfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico
    ADD CONSTRAINT historico_idperfil_fkey FOREIGN KEY (idperfil) REFERENCES public.perfil(idperfil);


--
-- Name: obracatalogo obracatalogo_idcatalogo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obracatalogo
    ADD CONSTRAINT obracatalogo_idcatalogo_fkey FOREIGN KEY (idcatalogo) REFERENCES public.catalogo(idcatalogo);


--
-- Name: obracatalogo obracatalogo_idobra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obracatalogo
    ADD CONSTRAINT obracatalogo_idobra_fkey FOREIGN KEY (idobra) REFERENCES public.obra(idobra);


--
-- Name: perfil perfil_idconta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_idconta_fkey FOREIGN KEY (idconta) REFERENCES public.conta(idconta);


--
-- Name: perfilcatalogo perfilcatalogo_idcatalogo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfilcatalogo
    ADD CONSTRAINT perfilcatalogo_idcatalogo_fkey FOREIGN KEY (idcatalogo) REFERENCES public.catalogo(idcatalogo);


--
-- Name: perfilcatalogo perfilcatalogo_idperfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfilcatalogo
    ADD CONSTRAINT perfilcatalogo_idperfil_fkey FOREIGN KEY (idperfil) REFERENCES public.perfil(idperfil);


--
-- Name: serie serie_idobra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_idobra_fkey FOREIGN KEY (idobra) REFERENCES public.obra(idobra);


--
-- Name: temporada temporada_idserie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT temporada_idserie_fkey FOREIGN KEY (idserie) REFERENCES public.serie(idserie);


--
-- PostgreSQL database dump complete
--

\unrestrict GE2IIQnYmGvi2l2XSYO1uapjSq6egS5qHV6ZAYPgQVVWucqvtDrJd59BqVTNjKi

