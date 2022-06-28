--
-- TOC entry 6 (class 2615 OID 16496)
-- Name: goldfit; Type: SCHEMA; Schema: -; Owner: postgres
--
DROP SCHEMA goldfit CASCADE;

CREATE SCHEMA goldfit;


-- ALTER SCHEMA goldfit OWNER TO postgres;

--
-- TOC entry 861 (class 1247 OID 16638)
-- Name: DifficultyLevel; Type: TYPE; Schema: goldfit; Owner: postgres
--

CREATE TYPE goldfit."DifficultyLevel" AS ENUM (
    'Easy',
    'RelativelyEasy',
    'Average',
    'RelativelyDifficult',
    'Difficult'
);


-- ALTER TYPE goldfit."DifficultyLevel" OWNER TO postgres;

--
-- TOC entry 864 (class 1247 OID 16658)
-- Name: PainLevel; Type: TYPE; Schema: goldfit; Owner: postgres
--

CREATE TYPE goldfit."PainLevel" AS ENUM (
    'NoPain',
    'LittlePain',
    'ModeratePain',
    'SeverePain'
);


-- ALTER TYPE goldfit."PainLevel" OWNER TO postgres;

--
-- TOC entry 867 (class 1247 OID 16668)
-- Name: SatisfactionLevel; Type: TYPE; Schema: goldfit; Owner: postgres
--

CREATE TYPE goldfit."SatisfactionLevel" AS ENUM (
    'VerySatisfied',
    'Satisfied',
    'Insatisfied',
    'VeryInsatisfied'
);


-- ALTER TYPE goldfit."SatisfactionLevel" OWNER TO postgres;

--
-- TOC entry 858 (class 1247 OID 16628)
-- Name: SelfEfficacy; Type: TYPE; Schema: goldfit; Owner: postgres
--

CREATE TYPE goldfit."SelfEfficacy" AS ENUM (
    'HighlyConfident',
    'Confident',
    'LittleConfident',
    'NotConfident'
);

-- ALTER TYPE goldfit."SelfEfficacy" OWNER TO postgres;

CREATE TYPE goldfit."MotivationLevel" AS ENUM (
    'Motivated',
    'NotMotivated'
);

-- ALTER TYPE goldfit."MotivationLevel" OWNER TO postgres;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 16502)
-- Name: exercice; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.exercice (
    idexercice smallint NOT NULL,
    exercicename character varying(45) NOT NULL,
    exercicedescription character varying(320) NOT NULL,
    exercicenumberrepetitionsmin integer DEFAULT 0 NOT NULL,
    exercicenumberrepetitionsmax integer DEFAULT 0 NOT NULL,
    exercicedescriptionurl character varying(45)
);


-- ALTER TABLE goldfit.exercice OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16586)
-- Name: exercicerecord; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.exercicerecord (
    idexercicerecord smallint NOT NULL,
    numberseries smallint DEFAULT 0 NOT NULL,
    numberrepetitions smallint DEFAULT 0 NOT NULL,
    programdayrecordid smallint NOT NULL,
    exerciceid smallint NOT NULL
);


-- ALTER TABLE goldfit.exercicerecord OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16510)
-- Name: exerciceseries; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.exerciceseries (
    idexerciceseries smallint NOT NULL,
    exerciceseriesname character varying(45) NOT NULL,
    exerciceseriesdescription character varying(320)
);


-- ALTER TABLE goldfit.exerciceseries OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16533)
-- Name: exerciceseriesexercice; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.exerciceseriesexercice (
    idexerciceseriesexercise smallint NOT NULL,
    exerciceseriesid smallint NOT NULL,
    exerciceid smallint NOT NULL,
    exerciseorder integer NOT NULL,
    exercicenumberseriesmin integer DEFAULT 0 NOT NULL,
    exercicenumberseriesmax integer NOT NULL
);


-- ALTER TABLE goldfit.exerciceseriesexercice OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16551)
-- Name: patient; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.patient (
    idpatient smallint NOT NULL,
    patientfirstname character varying(45) NOT NULL,
    patientlastname character varying(45) NOT NULL
);


-- ALTER TABLE goldfit.patient OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16497)
-- Name: program; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.program (
    idprogram smallint NOT NULL,
    programname character varying(45) NOT NULL,
    programdescription character varying(320) NOT NULL,
    programduration integer NOT NULL
);


-- ALTER TABLE goldfit.program OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16574)
-- Name: programdayrecord; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.programdayrecord (
    idprogramdayrecord smallint NOT NULL,
    date date NOT NULL,
    programenrollmentid smallint NOT NULL,
    satisfactionlevel goldfit."SatisfactionLevel",
    difficultylevel goldfit."DifficultyLevel",
    selfefficacy goldfit."SelfEfficacy",
    painlevel goldfit."PainLevel",
    motivationLevel goldfit."MotivationLevel"
);


-- ALTER TABLE goldfit.programdayrecord OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16556)
-- Name: programenrollment; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.programenrollment (
    idprogramenrollment smallint NOT NULL,
    patientid smallint NOT NULL,
    programid smallint NOT NULL,
    programenrollmentdate date NOT NULL,
    programstartdate date NOT NULL,
    programenrollmentcode character varying(45) NOT NULL
);


-- ALTER TABLE goldfit.programenrollment OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16516)
-- Name: programexerciceseries; Type: TABLE; Schema: goldfit; Owner: postgres
--

CREATE TABLE goldfit.programexerciceseries (
    programexerciceseriesid smallint NOT NULL,
    programid smallint NOT NULL,
    exerciceseriesid smallint NOT NULL,
    startday integer NOT NULL,
    endday integer NOT NULL
);


-- ALTER TABLE goldfit.programexerciceseries OWNER TO postgres;

--
-- TOC entry 3660 (class 0 OID 16502)
-- Dependencies: 211
-- Data for Name: exercice; Type: TABLE DATA; Schema: goldfit; Owner: postgres
--

INSERT INTO goldfit.exercice (idexercice, exercicename, exercicedescription, exercicenumberrepetitionsmin, exercicenumberrepetitionsmax, exercicedescriptionurl) VALUES (1, 'Sit-Ups', 'These are sit-ups', 10, 30, 'https://youtu.be/ojByzJhwVFE');
INSERT INTO goldfit.exercice (idexercice, exercicename, exercicedescription, exercicenumberrepetitionsmin, exercicenumberrepetitionsmax, exercicedescriptionurl) VALUES (2, 'Lie Down', 'Not as easy as it seems', 40, 50, 'https://youtu.be/LdwS6zf94Wg');
INSERT INTO goldfit.exercice (idexercice, exercicename, exercicedescription, exercicenumberrepetitionsmin, exercicenumberrepetitionsmax, exercicedescriptionurl) VALUES (3, 'Sleeping', 'Don\"t laugh', 50, 60, 'https://youtu.be/ojByzJhwVFE');


--
-- TOC entry 3661 (class 0 OID 16510)
-- Dependencies: 212
-- Data for Name: exerciceseries; Type: TABLE DATA; Schema: goldfit; Owner: postgres
--

INSERT INTO goldfit.exerciceseries (idexerciceseries, exerciceseriesname, exerciceseriesdescription) VALUES (1, 'SeriesOne', 'Consists of exercice 1 (sit-ups) and 2 (lie downs) a few times');
INSERT INTO goldfit.exerciceseries (idexerciceseries, exerciceseriesname, exerciceseriesdescription) VALUES (2, 'SeriesTwo', 'Consists of exercice 1 (sit-ups) and 3 (sleeping)');
INSERT INTO goldfit.exerciceseries (idexerciceseries, exerciceseriesname, exerciceseriesdescription) VALUES (3, 'SeriesThree', 'Consists of exercices 1, 2, and 3');


--
-- TOC entry 3663 (class 0 OID 16533)
-- Dependencies: 214
-- Data for Name: exerciceseriesexercice; Type: TABLE DATA; Schema: goldfit; Owner: postgres
--

INSERT INTO goldfit.exerciceseriesexercice (idexerciceseriesexercise, exerciceseriesid, exerciceid, exerciseorder, exercicenumberseriesmin, exercicenumberseriesmax) VALUES (1, 1, 1, 1, 2, 3);
INSERT INTO goldfit.exerciceseriesexercice (idexerciceseriesexercise, exerciceseriesid, exerciceid, exerciseorder, exercicenumberseriesmin, exercicenumberseriesmax) VALUES (2, 1, 2, 2, 3, 4);
INSERT INTO goldfit.exerciceseriesexercice (idexerciceseriesexercise, exerciceseriesid, exerciceid, exerciseorder, exercicenumberseriesmin, exercicenumberseriesmax) VALUES (3, 2, 1, 1, 2, 4);
INSERT INTO goldfit.exerciceseriesexercice (idexerciceseriesexercise, exerciceseriesid, exerciceid, exerciseorder, exercicenumberseriesmin, exercicenumberseriesmax) VALUES (4, 2, 3, 2, 2, 5);
INSERT INTO goldfit.exerciceseriesexercice (idexerciceseriesexercise, exerciceseriesid, exerciceid, exerciseorder, exercicenumberseriesmin, exercicenumberseriesmax) VALUES (5, 3, 1, 1, 2, 4);
INSERT INTO goldfit.exerciceseriesexercice (idexerciceseriesexercise, exerciceseriesid, exerciceid, exerciseorder, exercicenumberseriesmin, exercicenumberseriesmax) VALUES (6, 3, 2, 2, 4, 5);
INSERT INTO goldfit.exerciceseriesexercice (idexerciceseriesexercise, exerciceseriesid, exerciceid, exerciseorder, exercicenumberseriesmin, exercicenumberseriesmax) VALUES (7, 3, 3, 3, 3, 4);


--
-- TOC entry 3664 (class 0 OID 16551)
-- Dependencies: 215
-- Data for Name: patient; Type: TABLE DATA; Schema: goldfit; Owner: postgres
--

INSERT INTO goldfit.patient (idpatient, patientfirstname, patientlastname) VALUES (1, 'Mylène', 'Aubertin');
INSERT INTO goldfit.patient (idpatient, patientfirstname, patientlastname) VALUES (2, 'Hafedh', 'Mili');
INSERT INTO goldfit.patient (idpatient, patientfirstname, patientlastname) VALUES (3, 'Hyacinth', 'Ali');


--
-- TOC entry 3659 (class 0 OID 16497)
-- Dependencies: 210
-- Data for Name: program; Type: TABLE DATA; Schema: goldfit; Owner: postgres
--

INSERT INTO goldfit.program (idprogram, programname, programdescription, programduration) VALUES (1, 'PACE', 'This is the PACE program', 60);
INSERT INTO goldfit.program (idprogram, programname, programdescription, programduration) VALUES (2, 'PATH', 'This is the PATH program', 60);



--
-- TOC entry 3665 (class 0 OID 16556)
-- Dependencies: 216
-- Data for Name: programenrollment; Type: TABLE DATA; Schema: goldfit; Owner: postgres
--

INSERT INTO goldfit.programenrollment (idprogramenrollment, patientid, programid, programenrollmentdate, programstartdate, programenrollmentcode) VALUES (1, 1, 1, '2022-06-01', '2022-06-20', 'MAL-01');
INSERT INTO goldfit.programenrollment (idprogramenrollment, patientid, programid, programenrollmentdate, programstartdate, programenrollmentcode) VALUES (2, 2, 2, '2022-06-20', '2022-06-20', 'HM-01');
INSERT INTO goldfit.programenrollment (idprogramenrollment, patientid, programid, programenrollmentdate, programstartdate, programenrollmentcode) VALUES (3, 3, 1, '2022-03-13', '2022-03-13', 'HA-01');
INSERT INTO goldfit.programenrollment (idprogramenrollment, patientid, programid, programenrollmentdate, programstartdate, programenrollmentcode) VALUES (4, 3, 2, '2022-06-20', '2022-08-01', 'HA-02');


--
-- TOC entry 3662 (class 0 OID 16516)
-- Dependencies: 213
-- Data for Name: programexerciceseries; Type: TABLE DATA; Schema: goldfit; Owner: postgres
--

INSERT INTO goldfit.programexerciceseries (programexerciceseriesid, programid, exerciceseriesid, startday, endday) VALUES (1, 1, 3, 1, 60);
INSERT INTO goldfit.programexerciceseries (programexerciceseriesid, programid, exerciceseriesid, startday, endday) VALUES (2, 2, 1, 1, 20);
INSERT INTO goldfit.programexerciceseries (programexerciceseriesid, programid, exerciceseriesid, startday, endday) VALUES (3, 2, 2, 21, 40);
INSERT INTO goldfit.programexerciceseries (programexerciceseriesid, programid, exerciceseriesid, startday, endday) VALUES (4, 2, 3, 41, 60);


--
-- TOC entry 3483 (class 2606 OID 16508)
-- Name: exercice exercice_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exercice
    ADD CONSTRAINT exercice_pkey PRIMARY KEY (idexercice);


--
-- TOC entry 3508 (class 2606 OID 16592)
-- Name: exercicerecord exercicerecord_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exercicerecord
    ADD CONSTRAINT exercicerecord_pkey PRIMARY KEY (idexercicerecord);


--
-- TOC entry 3486 (class 2606 OID 16514)
-- Name: exerciceseries exerciceseries_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exerciceseries
    ADD CONSTRAINT exerciceseries_pkey PRIMARY KEY (idexerciceseries);


--
-- TOC entry 3493 (class 2606 OID 16538)
-- Name: exerciceseriesexercice exerciceseriesexercice_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exerciceseriesexercice
    ADD CONSTRAINT exerciceseriesexercice_pkey PRIMARY KEY (idexerciceseriesexercise);


--
-- TOC entry 3497 (class 2606 OID 16555)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (idpatient);


--
-- TOC entry 3481 (class 2606 OID 16501)
-- Name: program program_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (idprogram);


--
-- TOC entry 3506 (class 2606 OID 16578)
-- Name: programdayrecord programdayrecord_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programdayrecord
    ADD CONSTRAINT programdayrecord_pkey PRIMARY KEY (idprogramdayrecord);


--
-- TOC entry 3501 (class 2606 OID 16560)
-- Name: programenrollment programenrollment_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programenrollment
    ADD CONSTRAINT programenrollment_pkey PRIMARY KEY (idprogramenrollment);


--
-- TOC entry 3491 (class 2606 OID 16520)
-- Name: programexerciceseries programexerciceseries_pkey; Type: CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programexerciceseries
    ADD CONSTRAINT programexerciceseries_pkey PRIMARY KEY (programexerciceseriesid);


--
-- TOC entry 3503 (class 1259 OID 16584)
-- Name: date_unique; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE UNIQUE INDEX date_unique ON goldfit.programdayrecord USING btree (date);


--
-- TOC entry 3484 (class 1259 OID 16509)
-- Name: exercicename_unique; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE UNIQUE INDEX exercicename_unique ON goldfit.exercice USING btree (exercicename);


--
-- TOC entry 3487 (class 1259 OID 16515)
-- Name: exerciceseriesname_unique; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE UNIQUE INDEX exerciceseriesname_unique ON goldfit.exerciceseries USING btree (exerciceseriesname);


--
-- TOC entry 3488 (class 1259 OID 16532)
-- Name: fk_exercise_series_id_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_exercise_series_id_idx ON goldfit.programexerciceseries USING btree (exerciceseriesid);


--
-- TOC entry 3494 (class 1259 OID 16549)
-- Name: fk_exerciseid_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_exerciseid_idx ON goldfit.exerciceseriesexercice USING btree (exerciceid);


--
-- TOC entry 3495 (class 1259 OID 16550)
-- Name: fk_exerciseseriesid_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_exerciseseriesid_idx ON goldfit.exerciceseriesexercice USING btree (exerciceseriesid);


--
-- TOC entry 3509 (class 1259 OID 16604)
-- Name: fk_exerice_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_exerice_idx ON goldfit.exercicerecord USING btree (exerciceid);


--
-- TOC entry 3498 (class 1259 OID 16573)
-- Name: fk_patient_id_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_patient_id_idx ON goldfit.programenrollment USING btree (patientid);


--
-- TOC entry 3510 (class 1259 OID 16603)
-- Name: fk_program_day_record_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_program_day_record_idx ON goldfit.exercicerecord USING btree (programdayrecordid);


--
-- TOC entry 3504 (class 1259 OID 16585)
-- Name: fk_program_enrollment_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_program_enrollment_idx ON goldfit.programdayrecord USING btree (programenrollmentid);


--
-- TOC entry 3499 (class 1259 OID 16572)
-- Name: fk_program_id_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_program_id_idx ON goldfit.programenrollment USING btree (programid);


--
-- TOC entry 3489 (class 1259 OID 16531)
-- Name: fk_programid_idx; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE INDEX fk_programid_idx ON goldfit.programexerciceseries USING btree (programid);


--
-- TOC entry 3502 (class 1259 OID 16571)
-- Name: programenrollmentcode_unique; Type: INDEX; Schema: goldfit; Owner: postgres
--

CREATE UNIQUE INDEX programenrollmentcode_unique ON goldfit.programenrollment USING btree (programenrollmentcode);


--
-- TOC entry 3512 (class 2606 OID 16526)
-- Name: programexerciceseries fk_exercise_series_id; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programexerciceseries
    ADD CONSTRAINT fk_exercise_series_id FOREIGN KEY (exerciceseriesid) REFERENCES goldfit.exerciceseries(idexerciceseries);


--
-- TOC entry 3513 (class 2606 OID 16539)
-- Name: exerciceseriesexercice fk_exerciseid; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exerciceseriesexercice
    ADD CONSTRAINT fk_exerciseid FOREIGN KEY (exerciceid) REFERENCES goldfit.exercice(idexercice);


--
-- TOC entry 3514 (class 2606 OID 16544)
-- Name: exerciceseriesexercice fk_exerciseseriesid; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exerciceseriesexercice
    ADD CONSTRAINT fk_exerciseseriesid FOREIGN KEY (exerciceseriesid) REFERENCES goldfit.exerciceseries(idexerciceseries) ON UPDATE CASCADE;


--
-- TOC entry 3519 (class 2606 OID 16598)
-- Name: exercicerecord fk_exerice; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exercicerecord
    ADD CONSTRAINT fk_exerice FOREIGN KEY (exerciceid) REFERENCES goldfit.exercice(idexercice);


--
-- TOC entry 3515 (class 2606 OID 16561)
-- Name: programenrollment fk_patient_id; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programenrollment
    ADD CONSTRAINT fk_patient_id FOREIGN KEY (patientid) REFERENCES goldfit.patient(idpatient);


--
-- TOC entry 3518 (class 2606 OID 16593)
-- Name: exercicerecord fk_program_day_record; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.exercicerecord
    ADD CONSTRAINT fk_program_day_record FOREIGN KEY (programdayrecordid) REFERENCES goldfit.programdayrecord(idprogramdayrecord);


--
-- TOC entry 3517 (class 2606 OID 16579)
-- Name: programdayrecord fk_program_enrollment; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programdayrecord
    ADD CONSTRAINT fk_program_enrollment FOREIGN KEY (programenrollmentid) REFERENCES goldfit.programenrollment(idprogramenrollment);


--
-- TOC entry 3516 (class 2606 OID 16566)
-- Name: programenrollment fk_program_id; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programenrollment
    ADD CONSTRAINT fk_program_id FOREIGN KEY (programid) REFERENCES goldfit.program(idprogram);


--
-- TOC entry 3511 (class 2606 OID 16521)
-- Name: programexerciceseries fk_programid; Type: FK CONSTRAINT; Schema: goldfit; Owner: postgres
--

ALTER TABLE ONLY goldfit.programexerciceseries
    ADD CONSTRAINT fk_programid FOREIGN KEY (programid) REFERENCES goldfit.program(idprogram);


-- Completed on 2022-05-13 21:55:32 EDT

--
-- PostgreSQL database dump complete
--
