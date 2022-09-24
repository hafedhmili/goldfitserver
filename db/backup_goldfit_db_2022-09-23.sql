--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.4

-- Started on 2022-09-23 20:57:25 EDT

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

DROP DATABASE "postgres";
--
-- TOC entry 3678 (class 1262 OID 14020)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "postgres" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


-- \connect "postgres"

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
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 3678
-- Name: DATABASE "postgres"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE "postgres" IS 'default administrative connection database';


--
-- TOC entry 7 (class 2615 OID 16704)
-- Name: goldfit; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "goldfit";


--
-- TOC entry 832 (class 1247 OID 16706)
-- Name: DifficultyLevel; Type: TYPE; Schema: goldfit; Owner: -
--

CREATE TYPE "goldfit"."DifficultyLevel" AS ENUM (
    'VeryEasy',
    'Easy',
    'Difficult',
    'VeryDifficult'
);


--
-- TOC entry 844 (class 1247 OID 16746)
-- Name: MotivationLevel; Type: TYPE; Schema: goldfit; Owner: -
--

CREATE TYPE "goldfit"."MotivationLevel" AS ENUM (
    'Motivated',
    'NotMotivated'
);


--
-- TOC entry 835 (class 1247 OID 16716)
-- Name: PainLevel; Type: TYPE; Schema: goldfit; Owner: -
--

CREATE TYPE "goldfit"."PainLevel" AS ENUM (
    'NoPain',
    'LittlePain',
    'ModeratePain',
    'SeverePain'
);


--
-- TOC entry 838 (class 1247 OID 16726)
-- Name: SatisfactionLevel; Type: TYPE; Schema: goldfit; Owner: -
--

CREATE TYPE "goldfit"."SatisfactionLevel" AS ENUM (
    'VerySatisfied',
    'Satisfied',
    'Insatisfied',
    'VeryInsatisfied'
);


--
-- TOC entry 841 (class 1247 OID 16736)
-- Name: SelfEfficacy; Type: TYPE; Schema: goldfit; Owner: -
--

CREATE TYPE "goldfit"."SelfEfficacy" AS ENUM (
    'HighlyConfident',
    'Confident',
    'LittleConfident',
    'NotConfident'
);


SET default_table_access_method = "heap";

--
-- TOC entry 211 (class 1259 OID 16751)
-- Name: exercice; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."exercice" (
    "idexercice" smallint NOT NULL,
    "exercicename" character varying(45) NOT NULL,
    "exercicedescription" character varying(320) NOT NULL,
    "exercicenumberrepetitionsmin" integer DEFAULT 0 NOT NULL,
    "exercicenumberrepetitionsmax" integer DEFAULT 0 NOT NULL,
    "exercicedescriptionurl" character varying(45)
);


--
-- TOC entry 212 (class 1259 OID 16756)
-- Name: exercicerecord; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."exercicerecord" (
    "idexercicerecord" smallint NOT NULL,
    "numberseries" smallint DEFAULT 0 NOT NULL,
    "numberrepetitions" smallint DEFAULT 0 NOT NULL,
    "programdayrecordid" smallint NOT NULL,
    "exerciceid" smallint NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 16761)
-- Name: exerciceseries; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."exerciceseries" (
    "idexerciceseries" smallint NOT NULL,
    "exerciceseriesname" character varying(45) NOT NULL,
    "exerciceseriesdescription" character varying(320)
);


--
-- TOC entry 214 (class 1259 OID 16764)
-- Name: exerciceseriesexercice; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."exerciceseriesexercice" (
    "idexerciceseriesexercise" smallint NOT NULL,
    "exerciceseriesid" smallint NOT NULL,
    "exerciceid" smallint NOT NULL,
    "exerciseorder" integer NOT NULL,
    "exercicenumberseriesmin" integer DEFAULT 0 NOT NULL,
    "exercicenumberseriesmax" integer NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16768)
-- Name: patient; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."patient" (
    "idpatient" smallint NOT NULL,
    "patientfirstname" character varying(45) NOT NULL,
    "patientlastname" character varying(45) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16771)
-- Name: program; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."program" (
    "idprogram" smallint NOT NULL,
    "programname" character varying(45) NOT NULL,
    "programdescription" character varying(320) NOT NULL,
    "programduration" integer NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16774)
-- Name: programdayrecord; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."programdayrecord" (
    "idprogramdayrecord" smallint NOT NULL,
    "date" "date" NOT NULL,
    "programenrollmentid" smallint NOT NULL,
    "satisfactionlevel" "goldfit"."SatisfactionLevel",
    "difficultylevel" "goldfit"."DifficultyLevel",
    "selfefficacy" "goldfit"."SelfEfficacy",
    "painlevel" "goldfit"."PainLevel",
    "motivationlevel" "goldfit"."MotivationLevel",
    "exerciseseriesid" smallint NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16777)
-- Name: programenrollment; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."programenrollment" (
    "idprogramenrollment" smallint NOT NULL,
    "patientid" smallint NOT NULL,
    "programid" smallint NOT NULL,
    "programenrollmentdate" "date" NOT NULL,
    "programstartdate" "date" NOT NULL,
    "programenrollmentcode" character varying(45) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16780)
-- Name: programexerciceseries; Type: TABLE; Schema: goldfit; Owner: -
--

CREATE TABLE "goldfit"."programexerciceseries" (
    "programexerciceseriesid" smallint NOT NULL,
    "programid" smallint NOT NULL,
    "exerciceseriesid" smallint NOT NULL,
    "startday" integer NOT NULL,
    "endday" integer NOT NULL
);


--
-- TOC entry 3664 (class 0 OID 16751)
-- Dependencies: 211
-- Data for Name: exercice; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."exercice" ("idexercice", "exercicename", "exercicedescription", "exercicenumberrepetitionsmin", "exercicenumberrepetitionsmax", "exercicedescriptionurl") VALUES (1, 'Sit-Ups', 'These are sit-ups', 10, 30, 'https://youtu.be/ojByzJhwVFE');
INSERT INTO "goldfit"."exercice" ("idexercice", "exercicename", "exercicedescription", "exercicenumberrepetitionsmin", "exercicenumberrepetitionsmax", "exercicedescriptionurl") VALUES (2, 'Lie Down', 'Not as easy as it seems', 40, 50, 'https://youtu.be/LdwS6zf94Wg');
INSERT INTO "goldfit"."exercice" ("idexercice", "exercicename", "exercicedescription", "exercicenumberrepetitionsmin", "exercicenumberrepetitionsmax", "exercicedescriptionurl") VALUES (3, 'Sleeping', 'Don\"t laugh', 50, 60, 'https://youtu.be/ojByzJhwVFE');


--
-- TOC entry 3665 (class 0 OID 16756)
-- Dependencies: 212
-- Data for Name: exercicerecord; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (4, 4, 30, 2, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (5, 5, 50, 2, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (6, 4, 60, 2, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (1, 4, 30, 1, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (2, 5, 50, 1, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (3, 4, 60, 1, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (7, 4, 30, 3, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (8, 5, 50, 3, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (9, 4, 60, 3, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (10, 4, 30, 4, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (11, 5, 50, 4, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (12, 4, 60, 4, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (13, 4, 30, 5, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (14, 5, 50, 5, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (15, 4, 60, 5, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (16, 4, 30, 6, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (17, 5, 50, 6, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (18, 4, 60, 6, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (19, 4, 30, 7, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (20, 5, 50, 7, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (21, 4, 60, 7, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (22, 4, 30, 8, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (23, 5, 50, 8, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (24, 4, 60, 8, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (25, 4, 30, 9, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (26, 5, 50, 9, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (27, 4, 60, 9, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (28, 4, 30, 10, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (29, 5, 50, 10, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (30, 4, 60, 10, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (31, 4, 30, 11, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (32, 5, 50, 11, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (33, 4, 60, 11, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (34, 4, 30, 12, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (35, 5, 50, 12, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (36, 4, 60, 12, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (37, 4, 30, 13, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (38, 5, 50, 13, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (39, 4, 60, 13, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (40, 4, 30, 14, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (41, 5, 50, 14, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (42, 4, 60, 14, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (43, 4, 30, 15, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (44, 5, 50, 15, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (45, 4, 60, 15, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (46, 4, 30, 16, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (47, 5, 50, 16, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (48, 4, 60, 16, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (49, 4, 30, 17, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (50, 5, 50, 17, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (51, 4, 60, 17, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (52, 4, 30, 18, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (53, 5, 50, 18, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (54, 4, 60, 18, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (55, 4, 30, 19, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (56, 5, 50, 19, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (57, 4, 60, 19, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (58, 4, 30, 20, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (59, 5, 50, 20, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (60, 4, 60, 20, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (121, 4, 30, 41, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (122, 5, 50, 41, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (123, 4, 60, 41, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (124, 4, 30, 42, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (125, 5, 50, 42, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (126, 4, 60, 42, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (127, 4, 30, 43, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (128, 5, 50, 43, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (129, 4, 60, 43, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (61, 4, 30, 21, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (62, 5, 50, 21, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (63, 4, 60, 21, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (64, 4, 30, 22, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (65, 5, 50, 22, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (66, 4, 60, 22, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (67, 4, 30, 23, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (68, 5, 50, 23, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (69, 4, 60, 23, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (70, 4, 30, 24, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (71, 5, 50, 24, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (72, 4, 60, 24, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (73, 4, 30, 25, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (74, 5, 50, 25, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (75, 4, 60, 25, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (76, 4, 30, 26, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (77, 5, 50, 26, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (78, 4, 60, 26, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (79, 4, 30, 27, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (80, 5, 50, 27, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (81, 4, 60, 27, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (82, 4, 30, 28, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (83, 5, 50, 28, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (84, 4, 60, 28, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (85, 4, 30, 29, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (86, 5, 50, 29, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (87, 4, 60, 29, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (88, 4, 30, 30, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (89, 5, 50, 30, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (90, 4, 60, 30, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (91, 4, 30, 31, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (92, 5, 50, 31, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (93, 4, 60, 31, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (94, 4, 30, 32, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (95, 5, 50, 32, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (96, 4, 60, 32, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (97, 4, 30, 33, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (98, 5, 50, 33, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (99, 4, 60, 33, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (100, 4, 30, 34, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (101, 5, 50, 34, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (102, 4, 60, 34, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (103, 4, 30, 35, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (104, 5, 50, 35, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (105, 4, 60, 35, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (106, 4, 30, 36, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (107, 5, 50, 36, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (108, 4, 60, 36, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (109, 4, 30, 37, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (110, 5, 50, 37, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (111, 4, 60, 37, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (112, 4, 30, 38, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (113, 5, 50, 38, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (114, 4, 60, 38, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (115, 4, 30, 39, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (116, 5, 50, 39, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (117, 4, 60, 39, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (118, 4, 30, 40, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (119, 5, 50, 40, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (120, 4, 60, 40, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (130, 4, 30, 44, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (131, 5, 50, 44, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (132, 4, 60, 44, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (133, 4, 30, 45, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (134, 5, 50, 45, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (135, 4, 60, 45, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (136, 4, 30, 46, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (137, 5, 50, 46, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (138, 4, 60, 46, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (139, 4, 30, 47, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (140, 5, 50, 47, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (141, 4, 60, 47, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (142, 4, 30, 48, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (143, 5, 50, 48, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (144, 4, 60, 48, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (145, 4, 30, 49, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (146, 5, 50, 49, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (147, 4, 60, 49, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (148, 4, 30, 50, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (149, 5, 50, 50, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (150, 4, 60, 50, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (151, 4, 30, 51, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (152, 5, 50, 51, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (153, 4, 60, 51, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (154, 4, 30, 52, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (155, 5, 50, 52, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (156, 4, 60, 52, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (157, 4, 30, 53, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (158, 5, 50, 53, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (159, 4, 60, 53, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (160, 4, 30, 54, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (161, 5, 50, 54, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (162, 4, 60, 54, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (163, 4, 30, 55, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (164, 5, 50, 55, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (165, 4, 60, 55, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (166, 4, 30, 56, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (167, 5, 50, 56, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (168, 4, 60, 56, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (169, 4, 30, 57, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (170, 5, 50, 57, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (171, 4, 60, 57, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (172, 4, 30, 58, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (173, 5, 50, 58, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (174, 4, 60, 58, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (175, 4, 30, 59, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (176, 5, 50, 59, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (177, 4, 60, 59, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (178, 4, 30, 60, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (179, 5, 50, 60, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (180, 4, 60, 60, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (181, 4, 30, 61, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (182, 5, 50, 61, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (183, 4, 30, 62, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (184, 5, 50, 62, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (185, 4, 30, 63, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (186, 5, 50, 63, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (187, 4, 30, 64, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (188, 5, 50, 64, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (189, 4, 30, 65, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (190, 5, 50, 65, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (191, 4, 30, 66, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (192, 5, 50, 66, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (193, 4, 30, 67, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (194, 5, 50, 67, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (195, 4, 30, 68, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (196, 5, 50, 68, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (197, 4, 30, 69, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (198, 5, 50, 69, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (199, 4, 30, 70, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (200, 5, 50, 70, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (201, 4, 30, 71, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (202, 5, 50, 71, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (203, 4, 30, 72, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (204, 5, 50, 72, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (205, 4, 30, 73, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (206, 5, 50, 73, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (207, 4, 30, 74, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (208, 5, 50, 74, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (209, 4, 30, 75, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (210, 5, 50, 75, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (211, 4, 30, 76, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (212, 5, 50, 76, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (213, 4, 30, 77, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (214, 5, 50, 77, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (215, 4, 30, 78, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (216, 5, 50, 78, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (217, 4, 30, 79, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (218, 5, 50, 79, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (219, 4, 30, 80, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (220, 5, 50, 80, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (261, 4, 30, 101, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (222, 4, 60, 81, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (223, 4, 30, 82, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (224, 4, 60, 82, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (225, 4, 30, 83, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (226, 4, 60, 83, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (227, 4, 30, 84, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (228, 4, 60, 84, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (262, 5, 50, 101, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (263, 4, 60, 101, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (264, 4, 30, 102, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (265, 5, 50, 102, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (266, 4, 60, 102, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (267, 4, 30, 103, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (268, 5, 50, 103, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (269, 4, 60, 103, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (270, 4, 30, 104, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (271, 5, 50, 104, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (272, 4, 60, 104, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (273, 4, 30, 105, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (274, 5, 50, 105, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (275, 4, 60, 105, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (276, 4, 30, 106, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (277, 5, 50, 106, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (278, 4, 60, 106, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (279, 4, 30, 107, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (280, 5, 50, 107, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (281, 4, 60, 107, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (282, 4, 30, 108, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (283, 5, 50, 108, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (229, 4, 30, 85, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (230, 4, 60, 85, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (231, 4, 30, 86, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (232, 4, 60, 86, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (284, 4, 60, 108, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (285, 4, 30, 109, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (286, 5, 50, 109, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (287, 4, 60, 109, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (288, 4, 30, 110, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (289, 5, 50, 110, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (290, 4, 60, 110, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (291, 4, 30, 111, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (292, 5, 50, 111, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (293, 4, 60, 111, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (294, 4, 30, 112, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (295, 5, 50, 112, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (296, 4, 60, 112, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (297, 4, 30, 113, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (298, 5, 50, 113, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (299, 4, 60, 113, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (300, 4, 30, 114, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (301, 5, 50, 114, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (302, 4, 60, 114, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (303, 4, 30, 115, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (304, 5, 50, 115, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (305, 4, 60, 115, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (306, 4, 30, 116, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (307, 5, 50, 116, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (308, 4, 60, 116, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (309, 4, 30, 117, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (310, 5, 50, 117, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (311, 4, 60, 117, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (312, 4, 30, 118, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (313, 5, 50, 118, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (314, 4, 60, 118, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (315, 4, 30, 119, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (316, 5, 50, 119, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (317, 4, 60, 119, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (318, 4, 30, 120, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (319, 5, 50, 120, 2);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (320, 4, 60, 120, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (221, 4, 30, 81, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (233, 4, 30, 87, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (234, 4, 60, 87, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (235, 4, 30, 88, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (236, 4, 60, 88, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (237, 4, 30, 89, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (238, 4, 60, 89, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (239, 4, 30, 90, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (240, 4, 60, 90, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (241, 4, 30, 91, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (242, 4, 60, 91, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (243, 4, 30, 92, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (244, 4, 60, 92, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (245, 4, 30, 93, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (246, 4, 60, 93, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (247, 4, 30, 94, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (248, 4, 60, 94, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (249, 4, 30, 95, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (250, 4, 60, 95, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (251, 4, 30, 96, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (252, 4, 60, 96, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (253, 4, 30, 97, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (254, 4, 60, 97, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (255, 4, 30, 98, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (256, 4, 60, 98, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (257, 4, 30, 99, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (258, 4, 60, 99, 3);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (259, 4, 30, 100, 1);
INSERT INTO "goldfit"."exercicerecord" ("idexercicerecord", "numberseries", "numberrepetitions", "programdayrecordid", "exerciceid") VALUES (260, 4, 60, 100, 3);


--
-- TOC entry 3666 (class 0 OID 16761)
-- Dependencies: 213
-- Data for Name: exerciceseries; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."exerciceseries" ("idexerciceseries", "exerciceseriesname", "exerciceseriesdescription") VALUES (1, 'SeriesOne', 'Consists of exercice 1 (sit-ups) and 2 (lie downs) a few times');
INSERT INTO "goldfit"."exerciceseries" ("idexerciceseries", "exerciceseriesname", "exerciceseriesdescription") VALUES (2, 'SeriesTwo', 'Consists of exercice 1 (sit-ups) and 3 (sleeping)');
INSERT INTO "goldfit"."exerciceseries" ("idexerciceseries", "exerciceseriesname", "exerciceseriesdescription") VALUES (3, 'SeriesThree', 'Consists of exercices 1, 2, and 3');


--
-- TOC entry 3667 (class 0 OID 16764)
-- Dependencies: 214
-- Data for Name: exerciceseriesexercice; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."exerciceseriesexercice" ("idexerciceseriesexercise", "exerciceseriesid", "exerciceid", "exerciseorder", "exercicenumberseriesmin", "exercicenumberseriesmax") VALUES (1, 1, 1, 1, 2, 3);
INSERT INTO "goldfit"."exerciceseriesexercice" ("idexerciceseriesexercise", "exerciceseriesid", "exerciceid", "exerciseorder", "exercicenumberseriesmin", "exercicenumberseriesmax") VALUES (2, 1, 2, 2, 3, 4);
INSERT INTO "goldfit"."exerciceseriesexercice" ("idexerciceseriesexercise", "exerciceseriesid", "exerciceid", "exerciseorder", "exercicenumberseriesmin", "exercicenumberseriesmax") VALUES (3, 2, 1, 1, 2, 4);
INSERT INTO "goldfit"."exerciceseriesexercice" ("idexerciceseriesexercise", "exerciceseriesid", "exerciceid", "exerciseorder", "exercicenumberseriesmin", "exercicenumberseriesmax") VALUES (4, 2, 3, 2, 2, 5);
INSERT INTO "goldfit"."exerciceseriesexercice" ("idexerciceseriesexercise", "exerciceseriesid", "exerciceid", "exerciseorder", "exercicenumberseriesmin", "exercicenumberseriesmax") VALUES (5, 3, 1, 1, 2, 4);
INSERT INTO "goldfit"."exerciceseriesexercice" ("idexerciceseriesexercise", "exerciceseriesid", "exerciceid", "exerciseorder", "exercicenumberseriesmin", "exercicenumberseriesmax") VALUES (6, 3, 2, 2, 4, 5);
INSERT INTO "goldfit"."exerciceseriesexercice" ("idexerciceseriesexercise", "exerciceseriesid", "exerciceid", "exerciseorder", "exercicenumberseriesmin", "exercicenumberseriesmax") VALUES (7, 3, 3, 3, 3, 4);


--
-- TOC entry 3668 (class 0 OID 16768)
-- Dependencies: 215
-- Data for Name: patient; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."patient" ("idpatient", "patientfirstname", "patientlastname") VALUES (1, 'Mylène', 'Aubertin');
INSERT INTO "goldfit"."patient" ("idpatient", "patientfirstname", "patientlastname") VALUES (2, 'Hafedh', 'Mili');
INSERT INTO "goldfit"."patient" ("idpatient", "patientfirstname", "patientlastname") VALUES (3, 'Hyacinth', 'Ali');


--
-- TOC entry 3669 (class 0 OID 16771)
-- Dependencies: 216
-- Data for Name: program; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."program" ("idprogram", "programname", "programdescription", "programduration") VALUES (1, 'PACE', 'This is the PACE program', 60);
INSERT INTO "goldfit"."program" ("idprogram", "programname", "programdescription", "programduration") VALUES (2, 'PATH', 'This is the PATH program', 60);


--
-- TOC entry 3670 (class 0 OID 16774)
-- Dependencies: 217
-- Data for Name: programdayrecord; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (61, '2022-05-20', 2, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (62, '2022-05-21', 2, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (63, '2022-05-22', 2, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (64, '2022-05-23', 2, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (65, '2022-05-24', 2, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (66, '2022-05-25', 2, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (67, '2022-05-26', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (68, '2022-05-27', 2, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (69, '2022-05-28', 2, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (70, '2022-05-29', 2, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (71, '2022-05-30', 2, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (72, '2022-05-31', 2, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (73, '2022-06-01', 2, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (74, '2022-06-02', 2, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (75, '2022-06-03', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (76, '2022-06-04', 2, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (77, '2022-06-05', 2, 'Satisfied', 'Easy', 'LittleConfident', 'NoPain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (78, '2022-06-06', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'LittlePain', 'NotMotivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (79, '2022-06-07', 2, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (80, '2022-06-08', 2, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 1);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (81, '2022-06-09', 2, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (82, '2022-06-10', 2, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (83, '2022-06-11', 2, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (84, '2022-06-12', 2, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (85, '2022-06-13', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (86, '2022-06-14', 2, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (87, '2022-06-15', 2, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (88, '2022-06-16', 2, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (89, '2022-06-17', 2, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (90, '2022-06-18', 2, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (91, '2022-06-19', 2, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (92, '2022-06-20', 2, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (93, '2022-06-21', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (94, '2022-06-22', 2, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (95, '2022-06-23', 2, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (96, '2022-06-24', 2, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (97, '2022-06-25', 2, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (98, '2022-06-26', 2, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (99, '2022-06-27', 2, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (100, '2022-06-28', 2, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 2);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (101, '2022-06-29', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (102, '2022-06-30', 2, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (103, '2022-07-01', 2, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (104, '2022-07-02', 2, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (105, '2022-07-03', 2, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (106, '2022-07-04', 2, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (107, '2022-07-05', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (108, '2022-07-06', 2, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (109, '2022-07-07', 2, 'Satisfied', 'Easy', 'LittleConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (110, '2022-07-08', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'LittlePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (111, '2022-07-09', 2, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (112, '2022-07-10', 2, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (113, '2022-07-11', 2, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (1, '2022-05-20', 1, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (2, '2022-05-21', 1, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (3, '2022-05-22', 1, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (4, '2022-05-23', 1, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (5, '2022-05-24', 1, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (6, '2022-05-25', 1, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (7, '2022-05-26', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (8, '2022-05-27', 1, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (9, '2022-05-28', 1, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (10, '2022-05-29', 1, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (11, '2022-05-30', 1, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (12, '2022-05-31', 1, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (13, '2022-06-01', 1, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (14, '2022-06-02', 1, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (15, '2022-06-03', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (16, '2022-06-04', 1, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (17, '2022-06-05', 1, 'Satisfied', 'Easy', 'LittleConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (18, '2022-06-06', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'LittlePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (19, '2022-06-07', 1, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (20, '2022-06-08', 1, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (21, '2022-06-09', 1, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (22, '2022-06-10', 1, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (23, '2022-06-11', 1, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (24, '2022-06-12', 1, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (25, '2022-06-13', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (26, '2022-06-14', 1, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (27, '2022-06-15', 1, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (28, '2022-06-16', 1, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (29, '2022-06-17', 1, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (30, '2022-06-18', 1, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (31, '2022-06-19', 1, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (32, '2022-06-20', 1, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (33, '2022-06-21', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (34, '2022-06-22', 1, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (35, '2022-06-23', 1, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (36, '2022-06-24', 1, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (37, '2022-06-25', 1, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (38, '2022-06-26', 1, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (39, '2022-06-27', 1, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (40, '2022-06-28', 1, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (41, '2022-06-29', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (42, '2022-06-30', 1, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (43, '2022-07-01', 1, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (44, '2022-07-02', 1, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (45, '2022-07-03', 1, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (46, '2022-07-04', 1, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (47, '2022-07-05', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (48, '2022-07-06', 1, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (49, '2022-07-07', 1, 'Satisfied', 'Easy', 'LittleConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (50, '2022-07-08', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'LittlePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (51, '2022-07-09', 1, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (52, '2022-07-10', 1, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (53, '2022-07-11', 1, 'Satisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (54, '2022-07-12', 1, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (55, '2022-07-13', 1, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (56, '2022-07-14', 1, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (57, '2022-07-15', 1, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (58, '2022-07-16', 1, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (59, '2022-07-17', 1, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (60, '2022-07-18', 1, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (114, '2022-07-12', 2, 'Satisfied', 'VeryEasy', 'HighlyConfident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (115, '2022-07-13', 2, 'VerySatisfied', 'VeryEasy', 'HighlyConfident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (116, '2022-07-14', 2, 'Satisfied', 'Easy', 'Confident', 'LittlePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (117, '2022-07-15', 2, 'Insatisfied', 'Difficult', 'LittleConfident', 'ModeratePain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (118, '2022-07-16', 2, 'VeryInsatisfied', 'VeryDifficult', 'NotConfident', 'SeverePain', 'NotMotivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (119, '2022-07-17', 2, 'Satisfied', 'Easy', 'Confident', 'NoPain', 'Motivated', 3);
INSERT INTO "goldfit"."programdayrecord" ("idprogramdayrecord", "date", "programenrollmentid", "satisfactionlevel", "difficultylevel", "selfefficacy", "painlevel", "motivationlevel", "exerciseseriesid") VALUES (120, '2022-07-18', 2, 'Satisfied', 'Easy', 'LittleConfident', 'LittlePain', 'Motivated', 3);


--
-- TOC entry 3671 (class 0 OID 16777)
-- Dependencies: 218
-- Data for Name: programenrollment; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."programenrollment" ("idprogramenrollment", "patientid", "programid", "programenrollmentdate", "programstartdate", "programenrollmentcode") VALUES (1, 1, 1, '2022-05-01', '2022-05-20', 'MAL-01');
INSERT INTO "goldfit"."programenrollment" ("idprogramenrollment", "patientid", "programid", "programenrollmentdate", "programstartdate", "programenrollmentcode") VALUES (2, 2, 2, '2022-05-20', '2022-05-20', 'HM-01');
INSERT INTO "goldfit"."programenrollment" ("idprogramenrollment", "patientid", "programid", "programenrollmentdate", "programstartdate", "programenrollmentcode") VALUES (3, 3, 2, '2022-07-01', '2022-07-15', 'HA-01');
INSERT INTO "goldfit"."programenrollment" ("idprogramenrollment", "patientid", "programid", "programenrollmentdate", "programstartdate", "programenrollmentcode") VALUES (4, 3, 1, '2022-08-01', '2022-08-15', 'HA-02');


--
-- TOC entry 3672 (class 0 OID 16780)
-- Dependencies: 219
-- Data for Name: programexerciceseries; Type: TABLE DATA; Schema: goldfit; Owner: -
--

INSERT INTO "goldfit"."programexerciceseries" ("programexerciceseriesid", "programid", "exerciceseriesid", "startday", "endday") VALUES (1, 1, 3, 1, 60);
INSERT INTO "goldfit"."programexerciceseries" ("programexerciceseriesid", "programid", "exerciceseriesid", "startday", "endday") VALUES (2, 2, 1, 1, 20);
INSERT INTO "goldfit"."programexerciceseries" ("programexerciceseriesid", "programid", "exerciceseriesid", "startday", "endday") VALUES (3, 2, 2, 21, 40);
INSERT INTO "goldfit"."programexerciceseries" ("programexerciceseriesid", "programid", "exerciceseriesid", "startday", "endday") VALUES (4, 2, 3, 41, 60);


--
-- TOC entry 3484 (class 2606 OID 16784)
-- Name: exercice exercice_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exercice"
    ADD CONSTRAINT "exercice_pkey" PRIMARY KEY ("idexercice");


--
-- TOC entry 3488 (class 2606 OID 16786)
-- Name: exercicerecord exercicerecord_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exercicerecord"
    ADD CONSTRAINT "exercicerecord_pkey" PRIMARY KEY ("idexercicerecord");


--
-- TOC entry 3492 (class 2606 OID 16788)
-- Name: exerciceseries exerciceseries_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exerciceseries"
    ADD CONSTRAINT "exerciceseries_pkey" PRIMARY KEY ("idexerciceseries");


--
-- TOC entry 3495 (class 2606 OID 16790)
-- Name: exerciceseriesexercice exerciceseriesexercice_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exerciceseriesexercice"
    ADD CONSTRAINT "exerciceseriesexercice_pkey" PRIMARY KEY ("idexerciceseriesexercise");


--
-- TOC entry 3499 (class 2606 OID 16792)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."patient"
    ADD CONSTRAINT "patient_pkey" PRIMARY KEY ("idpatient");


--
-- TOC entry 3501 (class 2606 OID 16794)
-- Name: program program_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."program"
    ADD CONSTRAINT "program_pkey" PRIMARY KEY ("idprogram");


--
-- TOC entry 3505 (class 2606 OID 16796)
-- Name: programdayrecord programdayrecord_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programdayrecord"
    ADD CONSTRAINT "programdayrecord_pkey" PRIMARY KEY ("idprogramdayrecord");


--
-- TOC entry 3509 (class 2606 OID 16798)
-- Name: programenrollment programenrollment_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programenrollment"
    ADD CONSTRAINT "programenrollment_pkey" PRIMARY KEY ("idprogramenrollment");


--
-- TOC entry 3514 (class 2606 OID 16800)
-- Name: programexerciceseries programexerciceseries_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programexerciceseries"
    ADD CONSTRAINT "programexerciceseries_pkey" PRIMARY KEY ("programexerciceseriesid");


--
-- TOC entry 3486 (class 1259 OID 16862)
-- Name: exercice-id_program-day-id_index; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE UNIQUE INDEX "exercice-id_program-day-id_index" ON "goldfit"."exercicerecord" USING "btree" ("programdayrecordid", "exerciceid");


--
-- TOC entry 3485 (class 1259 OID 16802)
-- Name: exercicename_unique; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE UNIQUE INDEX "exercicename_unique" ON "goldfit"."exercice" USING "btree" ("exercicename");


--
-- TOC entry 3493 (class 1259 OID 16803)
-- Name: exerciceseriesname_unique; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE UNIQUE INDEX "exerciceseriesname_unique" ON "goldfit"."exerciceseries" USING "btree" ("exerciceseriesname");


--
-- TOC entry 3511 (class 1259 OID 16804)
-- Name: fk_exercise_series_id_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_exercise_series_id_idx" ON "goldfit"."programexerciceseries" USING "btree" ("exerciceseriesid");


--
-- TOC entry 3496 (class 1259 OID 16805)
-- Name: fk_exerciseid_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_exerciseid_idx" ON "goldfit"."exerciceseriesexercice" USING "btree" ("exerciceid");


--
-- TOC entry 3497 (class 1259 OID 16806)
-- Name: fk_exerciseseriesid_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_exerciseseriesid_idx" ON "goldfit"."exerciceseriesexercice" USING "btree" ("exerciceseriesid");


--
-- TOC entry 3489 (class 1259 OID 16807)
-- Name: fk_exerice_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_exerice_idx" ON "goldfit"."exercicerecord" USING "btree" ("exerciceid");


--
-- TOC entry 3506 (class 1259 OID 16808)
-- Name: fk_patient_id_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_patient_id_idx" ON "goldfit"."programenrollment" USING "btree" ("patientid");


--
-- TOC entry 3490 (class 1259 OID 16809)
-- Name: fk_program_day_record_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_program_day_record_idx" ON "goldfit"."exercicerecord" USING "btree" ("programdayrecordid");


--
-- TOC entry 3502 (class 1259 OID 16810)
-- Name: fk_program_enrollment_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_program_enrollment_idx" ON "goldfit"."programdayrecord" USING "btree" ("programenrollmentid");


--
-- TOC entry 3507 (class 1259 OID 16811)
-- Name: fk_program_id_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_program_id_idx" ON "goldfit"."programenrollment" USING "btree" ("programid");


--
-- TOC entry 3512 (class 1259 OID 16812)
-- Name: fk_programid_idx; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE INDEX "fk_programid_idx" ON "goldfit"."programexerciceseries" USING "btree" ("programid");


--
-- TOC entry 3503 (class 1259 OID 16861)
-- Name: program_enrollement_id-date; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE UNIQUE INDEX "program_enrollement_id-date" ON "goldfit"."programdayrecord" USING "btree" ("programenrollmentid", "date");


--
-- TOC entry 3510 (class 1259 OID 16813)
-- Name: programenrollmentcode_unique; Type: INDEX; Schema: goldfit; Owner: -
--

CREATE UNIQUE INDEX "programenrollmentcode_unique" ON "goldfit"."programenrollment" USING "btree" ("programenrollmentcode");


--
-- TOC entry 3520 (class 2606 OID 16863)
-- Name: programdayrecord fk_exercise_series; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programdayrecord"
    ADD CONSTRAINT "fk_exercise_series" FOREIGN KEY ("exerciseseriesid") REFERENCES "goldfit"."exerciceseries"("idexerciceseries") NOT VALID;


--
-- TOC entry 3523 (class 2606 OID 16814)
-- Name: programexerciceseries fk_exercise_series_id; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programexerciceseries"
    ADD CONSTRAINT "fk_exercise_series_id" FOREIGN KEY ("exerciceseriesid") REFERENCES "goldfit"."exerciceseries"("idexerciceseries");


--
-- TOC entry 3517 (class 2606 OID 16819)
-- Name: exerciceseriesexercice fk_exerciseid; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exerciceseriesexercice"
    ADD CONSTRAINT "fk_exerciseid" FOREIGN KEY ("exerciceid") REFERENCES "goldfit"."exercice"("idexercice");


--
-- TOC entry 3518 (class 2606 OID 16824)
-- Name: exerciceseriesexercice fk_exerciseseriesid; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exerciceseriesexercice"
    ADD CONSTRAINT "fk_exerciseseriesid" FOREIGN KEY ("exerciceseriesid") REFERENCES "goldfit"."exerciceseries"("idexerciceseries") ON UPDATE CASCADE;


--
-- TOC entry 3515 (class 2606 OID 16829)
-- Name: exercicerecord fk_exerice; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exercicerecord"
    ADD CONSTRAINT "fk_exerice" FOREIGN KEY ("exerciceid") REFERENCES "goldfit"."exercice"("idexercice");


--
-- TOC entry 3521 (class 2606 OID 16834)
-- Name: programenrollment fk_patient_id; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programenrollment"
    ADD CONSTRAINT "fk_patient_id" FOREIGN KEY ("patientid") REFERENCES "goldfit"."patient"("idpatient");


--
-- TOC entry 3516 (class 2606 OID 16839)
-- Name: exercicerecord fk_program_day_record; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."exercicerecord"
    ADD CONSTRAINT "fk_program_day_record" FOREIGN KEY ("programdayrecordid") REFERENCES "goldfit"."programdayrecord"("idprogramdayrecord");


--
-- TOC entry 3519 (class 2606 OID 16844)
-- Name: programdayrecord fk_program_enrollment; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programdayrecord"
    ADD CONSTRAINT "fk_program_enrollment" FOREIGN KEY ("programenrollmentid") REFERENCES "goldfit"."programenrollment"("idprogramenrollment");


--
-- TOC entry 3522 (class 2606 OID 16849)
-- Name: programenrollment fk_program_id; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programenrollment"
    ADD CONSTRAINT "fk_program_id" FOREIGN KEY ("programid") REFERENCES "goldfit"."program"("idprogram");


--
-- TOC entry 3524 (class 2606 OID 16854)
-- Name: programexerciceseries fk_programid; Type: FK CONSTRAINT; Schema: goldfit; Owner: -
--

ALTER TABLE ONLY "goldfit"."programexerciceseries"
    ADD CONSTRAINT "fk_programid" FOREIGN KEY ("programid") REFERENCES "goldfit"."program"("idprogram");


-- Completed on 2022-09-23 20:57:27 EDT

--
-- PostgreSQL database dump complete
--
