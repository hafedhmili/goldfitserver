PGDMP         2                z           postgres    14.4    14.4 >    [           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            \           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ]           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ^           1262    14020    postgres    DATABASE     S   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE postgres;
                postgres    false            _           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3678                        2615    16704    goldfit    SCHEMA        CREATE SCHEMA goldfit;
    DROP SCHEMA goldfit;
                postgres    false            @           1247    16706    DifficultyLevel    TYPE     t   CREATE TYPE goldfit."DifficultyLevel" AS ENUM (
    'VeryEasy',
    'Easy',
    'Difficult',
    'VeryDifficult'
);
 %   DROP TYPE goldfit."DifficultyLevel";
       goldfit          postgres    false    7            L           1247    16746    MotivationLevel    TYPE     W   CREATE TYPE goldfit."MotivationLevel" AS ENUM (
    'Motivated',
    'NotMotivated'
);
 %   DROP TYPE goldfit."MotivationLevel";
       goldfit          postgres    false    7            C           1247    16716 	   PainLevel    TYPE     r   CREATE TYPE goldfit."PainLevel" AS ENUM (
    'NoPain',
    'LittlePain',
    'ModeratePain',
    'SeverePain'
);
    DROP TYPE goldfit."PainLevel";
       goldfit          postgres    false    7            F           1247    16726    SatisfactionLevel    TYPE     �   CREATE TYPE goldfit."SatisfactionLevel" AS ENUM (
    'VerySatisfied',
    'Satisfied',
    'Insatisfied',
    'VeryInsatisfied'
);
 '   DROP TYPE goldfit."SatisfactionLevel";
       goldfit          postgres    false    7            I           1247    16736    SelfEfficacy    TYPE     �   CREATE TYPE goldfit."SelfEfficacy" AS ENUM (
    'HighlyConfident',
    'Confident',
    'LittleConfident',
    'NotConfident'
);
 "   DROP TYPE goldfit."SelfEfficacy";
       goldfit          postgres    false    7            �            1259    16751    exercice    TABLE     Z  CREATE TABLE goldfit.exercice (
    idexercice smallint NOT NULL,
    exercicename character varying(45) NOT NULL,
    exercicedescription character varying(320) NOT NULL,
    exercicenumberrepetitionsmin integer DEFAULT 0 NOT NULL,
    exercicenumberrepetitionsmax integer DEFAULT 0 NOT NULL,
    exercicedescriptionurl character varying(45)
);
    DROP TABLE goldfit.exercice;
       goldfit         heap    postgres    false    7            �            1259    16756    exercicerecord    TABLE     �   CREATE TABLE goldfit.exercicerecord (
    idexercicerecord smallint NOT NULL,
    numberseries smallint DEFAULT 0 NOT NULL,
    numberrepetitions smallint DEFAULT 0 NOT NULL,
    programdayrecordid smallint NOT NULL,
    exerciceid smallint NOT NULL
);
 #   DROP TABLE goldfit.exercicerecord;
       goldfit         heap    postgres    false    7            �            1259    16761    exerciceseries    TABLE     �   CREATE TABLE goldfit.exerciceseries (
    idexerciceseries smallint NOT NULL,
    exerciceseriesname character varying(45) NOT NULL,
    exerciceseriesdescription character varying(320)
);
 #   DROP TABLE goldfit.exerciceseries;
       goldfit         heap    postgres    false    7            �            1259    16764    exerciceseriesexercice    TABLE     4  CREATE TABLE goldfit.exerciceseriesexercice (
    idexerciceseriesexercise smallint NOT NULL,
    exerciceseriesid smallint NOT NULL,
    exerciceid smallint NOT NULL,
    exerciseorder integer NOT NULL,
    exercicenumberseriesmin integer DEFAULT 0 NOT NULL,
    exercicenumberseriesmax integer NOT NULL
);
 +   DROP TABLE goldfit.exerciceseriesexercice;
       goldfit         heap    postgres    false    7            �            1259    16768    patient    TABLE     �   CREATE TABLE goldfit.patient (
    idpatient smallint NOT NULL,
    patientfirstname character varying(45) NOT NULL,
    patientlastname character varying(45) NOT NULL
);
    DROP TABLE goldfit.patient;
       goldfit         heap    postgres    false    7            �            1259    16771    program    TABLE     �   CREATE TABLE goldfit.program (
    idprogram smallint NOT NULL,
    programname character varying(45) NOT NULL,
    programdescription character varying(320) NOT NULL,
    programduration integer NOT NULL
);
    DROP TABLE goldfit.program;
       goldfit         heap    postgres    false    7            �            1259    16774    programdayrecord    TABLE     �  CREATE TABLE goldfit.programdayrecord (
    idprogramdayrecord smallint NOT NULL,
    date date NOT NULL,
    programenrollmentid smallint NOT NULL,
    satisfactionlevel goldfit."SatisfactionLevel",
    difficultylevel goldfit."DifficultyLevel",
    selfefficacy goldfit."SelfEfficacy",
    painlevel goldfit."PainLevel",
    motivationlevel goldfit."MotivationLevel",
    exerciseseriesid smallint NOT NULL
);
 %   DROP TABLE goldfit.programdayrecord;
       goldfit         heap    postgres    false    832    838    7    841    844    835            �            1259    16777    programenrollment    TABLE       CREATE TABLE goldfit.programenrollment (
    idprogramenrollment smallint NOT NULL,
    patientid smallint NOT NULL,
    programid smallint NOT NULL,
    programenrollmentdate date NOT NULL,
    programstartdate date NOT NULL,
    programenrollmentcode character varying(45) NOT NULL
);
 &   DROP TABLE goldfit.programenrollment;
       goldfit         heap    postgres    false    7            �            1259    16780    programexerciceseries    TABLE     �   CREATE TABLE goldfit.programexerciceseries (
    programexerciceseriesid smallint NOT NULL,
    programid smallint NOT NULL,
    exerciceseriesid smallint NOT NULL,
    startday integer NOT NULL,
    endday integer NOT NULL
);
 *   DROP TABLE goldfit.programexerciceseries;
       goldfit         heap    postgres    false    7            P          0    16751    exercice 
   TABLE DATA                 goldfit          postgres    false    211   �L       Q          0    16756    exercicerecord 
   TABLE DATA                 goldfit          postgres    false    212   �M       R          0    16761    exerciceseries 
   TABLE DATA                 goldfit          postgres    false    213   CV       S          0    16764    exerciceseriesexercice 
   TABLE DATA                 goldfit          postgres    false    214   	W       T          0    16768    patient 
   TABLE DATA                 goldfit          postgres    false    215   �W       U          0    16771    program 
   TABLE DATA                 goldfit          postgres    false    216   QX       V          0    16774    programdayrecord 
   TABLE DATA                 goldfit          postgres    false    217   �X       W          0    16777    programenrollment 
   TABLE DATA                 goldfit          postgres    false    218   �]       X          0    16780    programexerciceseries 
   TABLE DATA                 goldfit          postgres    false    219   �^       �           2606    16784    exercice exercice_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY goldfit.exercice
    ADD CONSTRAINT exercice_pkey PRIMARY KEY (idexercice);
 A   ALTER TABLE ONLY goldfit.exercice DROP CONSTRAINT exercice_pkey;
       goldfit            postgres    false    211            �           2606    16786 "   exercicerecord exercicerecord_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY goldfit.exercicerecord
    ADD CONSTRAINT exercicerecord_pkey PRIMARY KEY (idexercicerecord);
 M   ALTER TABLE ONLY goldfit.exercicerecord DROP CONSTRAINT exercicerecord_pkey;
       goldfit            postgres    false    212            �           2606    16788 "   exerciceseries exerciceseries_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY goldfit.exerciceseries
    ADD CONSTRAINT exerciceseries_pkey PRIMARY KEY (idexerciceseries);
 M   ALTER TABLE ONLY goldfit.exerciceseries DROP CONSTRAINT exerciceseries_pkey;
       goldfit            postgres    false    213            �           2606    16790 2   exerciceseriesexercice exerciceseriesexercice_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY goldfit.exerciceseriesexercice
    ADD CONSTRAINT exerciceseriesexercice_pkey PRIMARY KEY (idexerciceseriesexercise);
 ]   ALTER TABLE ONLY goldfit.exerciceseriesexercice DROP CONSTRAINT exerciceseriesexercice_pkey;
       goldfit            postgres    false    214            �           2606    16792    patient patient_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY goldfit.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (idpatient);
 ?   ALTER TABLE ONLY goldfit.patient DROP CONSTRAINT patient_pkey;
       goldfit            postgres    false    215            �           2606    16794    program program_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY goldfit.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (idprogram);
 ?   ALTER TABLE ONLY goldfit.program DROP CONSTRAINT program_pkey;
       goldfit            postgres    false    216            �           2606    16796 &   programdayrecord programdayrecord_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY goldfit.programdayrecord
    ADD CONSTRAINT programdayrecord_pkey PRIMARY KEY (idprogramdayrecord);
 Q   ALTER TABLE ONLY goldfit.programdayrecord DROP CONSTRAINT programdayrecord_pkey;
       goldfit            postgres    false    217            �           2606    16798 (   programenrollment programenrollment_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY goldfit.programenrollment
    ADD CONSTRAINT programenrollment_pkey PRIMARY KEY (idprogramenrollment);
 S   ALTER TABLE ONLY goldfit.programenrollment DROP CONSTRAINT programenrollment_pkey;
       goldfit            postgres    false    218            �           2606    16800 0   programexerciceseries programexerciceseries_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY goldfit.programexerciceseries
    ADD CONSTRAINT programexerciceseries_pkey PRIMARY KEY (programexerciceseriesid);
 [   ALTER TABLE ONLY goldfit.programexerciceseries DROP CONSTRAINT programexerciceseries_pkey;
       goldfit            postgres    false    219            �           1259    16862     exercice-id_program-day-id_index    INDEX        CREATE UNIQUE INDEX "exercice-id_program-day-id_index" ON goldfit.exercicerecord USING btree (programdayrecordid, exerciceid);
 7   DROP INDEX goldfit."exercice-id_program-day-id_index";
       goldfit            postgres    false    212    212            �           1259    16802    exercicename_unique    INDEX     X   CREATE UNIQUE INDEX exercicename_unique ON goldfit.exercice USING btree (exercicename);
 (   DROP INDEX goldfit.exercicename_unique;
       goldfit            postgres    false    211            �           1259    16803    exerciceseriesname_unique    INDEX     j   CREATE UNIQUE INDEX exerciceseriesname_unique ON goldfit.exerciceseries USING btree (exerciceseriesname);
 .   DROP INDEX goldfit.exerciceseriesname_unique;
       goldfit            postgres    false    213            �           1259    16804    fk_exercise_series_id_idx    INDEX     h   CREATE INDEX fk_exercise_series_id_idx ON goldfit.programexerciceseries USING btree (exerciceseriesid);
 .   DROP INDEX goldfit.fk_exercise_series_id_idx;
       goldfit            postgres    false    219            �           1259    16805    fk_exerciseid_idx    INDEX     [   CREATE INDEX fk_exerciseid_idx ON goldfit.exerciceseriesexercice USING btree (exerciceid);
 &   DROP INDEX goldfit.fk_exerciseid_idx;
       goldfit            postgres    false    214            �           1259    16806    fk_exerciseseriesid_idx    INDEX     g   CREATE INDEX fk_exerciseseriesid_idx ON goldfit.exerciceseriesexercice USING btree (exerciceseriesid);
 ,   DROP INDEX goldfit.fk_exerciseseriesid_idx;
       goldfit            postgres    false    214            �           1259    16807    fk_exerice_idx    INDEX     P   CREATE INDEX fk_exerice_idx ON goldfit.exercicerecord USING btree (exerciceid);
 #   DROP INDEX goldfit.fk_exerice_idx;
       goldfit            postgres    false    212            �           1259    16808    fk_patient_id_idx    INDEX     U   CREATE INDEX fk_patient_id_idx ON goldfit.programenrollment USING btree (patientid);
 &   DROP INDEX goldfit.fk_patient_id_idx;
       goldfit            postgres    false    218            �           1259    16809    fk_program_day_record_idx    INDEX     c   CREATE INDEX fk_program_day_record_idx ON goldfit.exercicerecord USING btree (programdayrecordid);
 .   DROP INDEX goldfit.fk_program_day_record_idx;
       goldfit            postgres    false    212            �           1259    16810    fk_program_enrollment_idx    INDEX     f   CREATE INDEX fk_program_enrollment_idx ON goldfit.programdayrecord USING btree (programenrollmentid);
 .   DROP INDEX goldfit.fk_program_enrollment_idx;
       goldfit            postgres    false    217            �           1259    16811    fk_program_id_idx    INDEX     U   CREATE INDEX fk_program_id_idx ON goldfit.programenrollment USING btree (programid);
 &   DROP INDEX goldfit.fk_program_id_idx;
       goldfit            postgres    false    218            �           1259    16812    fk_programid_idx    INDEX     X   CREATE INDEX fk_programid_idx ON goldfit.programexerciceseries USING btree (programid);
 %   DROP INDEX goldfit.fk_programid_idx;
       goldfit            postgres    false    219            �           1259    16861    program_enrollement_id-date    INDEX     w   CREATE UNIQUE INDEX "program_enrollement_id-date" ON goldfit.programdayrecord USING btree (programenrollmentid, date);
 2   DROP INDEX goldfit."program_enrollement_id-date";
       goldfit            postgres    false    217    217            �           1259    16813    programenrollmentcode_unique    INDEX     s   CREATE UNIQUE INDEX programenrollmentcode_unique ON goldfit.programenrollment USING btree (programenrollmentcode);
 1   DROP INDEX goldfit.programenrollmentcode_unique;
       goldfit            postgres    false    218            �           2606    16863 #   programdayrecord fk_exercise_series    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.programdayrecord
    ADD CONSTRAINT fk_exercise_series FOREIGN KEY (exerciseseriesid) REFERENCES goldfit.exerciceseries(idexerciceseries) NOT VALID;
 N   ALTER TABLE ONLY goldfit.programdayrecord DROP CONSTRAINT fk_exercise_series;
       goldfit          postgres    false    217    213    3492            �           2606    16814 +   programexerciceseries fk_exercise_series_id    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.programexerciceseries
    ADD CONSTRAINT fk_exercise_series_id FOREIGN KEY (exerciceseriesid) REFERENCES goldfit.exerciceseries(idexerciceseries);
 V   ALTER TABLE ONLY goldfit.programexerciceseries DROP CONSTRAINT fk_exercise_series_id;
       goldfit          postgres    false    213    3492    219            �           2606    16819 $   exerciceseriesexercice fk_exerciseid    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.exerciceseriesexercice
    ADD CONSTRAINT fk_exerciseid FOREIGN KEY (exerciceid) REFERENCES goldfit.exercice(idexercice);
 O   ALTER TABLE ONLY goldfit.exerciceseriesexercice DROP CONSTRAINT fk_exerciseid;
       goldfit          postgres    false    214    211    3484            �           2606    16824 *   exerciceseriesexercice fk_exerciseseriesid    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.exerciceseriesexercice
    ADD CONSTRAINT fk_exerciseseriesid FOREIGN KEY (exerciceseriesid) REFERENCES goldfit.exerciceseries(idexerciceseries) ON UPDATE CASCADE;
 U   ALTER TABLE ONLY goldfit.exerciceseriesexercice DROP CONSTRAINT fk_exerciseseriesid;
       goldfit          postgres    false    214    3492    213            �           2606    16829    exercicerecord fk_exerice    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.exercicerecord
    ADD CONSTRAINT fk_exerice FOREIGN KEY (exerciceid) REFERENCES goldfit.exercice(idexercice);
 D   ALTER TABLE ONLY goldfit.exercicerecord DROP CONSTRAINT fk_exerice;
       goldfit          postgres    false    212    211    3484            �           2606    16834    programenrollment fk_patient_id    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.programenrollment
    ADD CONSTRAINT fk_patient_id FOREIGN KEY (patientid) REFERENCES goldfit.patient(idpatient);
 J   ALTER TABLE ONLY goldfit.programenrollment DROP CONSTRAINT fk_patient_id;
       goldfit          postgres    false    215    3499    218            �           2606    16839 $   exercicerecord fk_program_day_record    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.exercicerecord
    ADD CONSTRAINT fk_program_day_record FOREIGN KEY (programdayrecordid) REFERENCES goldfit.programdayrecord(idprogramdayrecord);
 O   ALTER TABLE ONLY goldfit.exercicerecord DROP CONSTRAINT fk_program_day_record;
       goldfit          postgres    false    217    212    3505            �           2606    16844 &   programdayrecord fk_program_enrollment    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.programdayrecord
    ADD CONSTRAINT fk_program_enrollment FOREIGN KEY (programenrollmentid) REFERENCES goldfit.programenrollment(idprogramenrollment);
 Q   ALTER TABLE ONLY goldfit.programdayrecord DROP CONSTRAINT fk_program_enrollment;
       goldfit          postgres    false    3509    217    218            �           2606    16849    programenrollment fk_program_id    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.programenrollment
    ADD CONSTRAINT fk_program_id FOREIGN KEY (programid) REFERENCES goldfit.program(idprogram);
 J   ALTER TABLE ONLY goldfit.programenrollment DROP CONSTRAINT fk_program_id;
       goldfit          postgres    false    216    3501    218            �           2606    16854 "   programexerciceseries fk_programid    FK CONSTRAINT     �   ALTER TABLE ONLY goldfit.programexerciceseries
    ADD CONSTRAINT fk_programid FOREIGN KEY (programid) REFERENCES goldfit.program(idprogram);
 M   ALTER TABLE ONLY goldfit.programexerciceseries DROP CONSTRAINT fk_programid;
       goldfit          postgres    false    219    216    3501            P   �   x���Mk�@�{~��K���
mO-��Rh�^zY�1���.�A�������^=,���2�0q�E9�i��h�=�)PT ��<� N����U�.IC��}���B��\G��g�.����9YG�f���Zj�y��)=�Oqv�|8~m�ԏa�k�t���z�ou�y���_�n�$��w�T`����d@#�ξ���I�e���a����>wo%���W��h��j���ϲ=�5�!      Q   7  x���͊UG��Wq�
M����(B0M��>��hKk ��h��[�_�BKq>Y��S��~����__^�=�����_��}���������������������������\>\��������������O�����ë������+w�~��?rw����O?�����q�\>��qs�=��ѳﻞvs���e=������ӿ�'��z���y���!�3/C�5μ��<�
D^��+y�q���������Y2"�3�ƈ,��#�vF���3�Έl��uFd�3"[gd�gd���@D�~F6���dD�gd�Y;#[����bD6��#����`d�Ԕ�оn���R��H3:�(�4��.�4��q�1�*V��YìBb	1�1$!Ɛ����BRbIY�10$�!�А���CRbIy�1@$"�����DR$bi2c�H�CE�T�,��"�p�&1�4��1d�IF�A#M4bi�g�H��8�F�l�6b.I��KG��#��d���|$>b. I��KH�!$�"�d���$Fb.$I�tUJgTʮB�B�U'�Q'{���(���{dT�^n>2�dW�tF��*��(�]�r�����C��Fbdg0�#;�����<���`�!Fv#1�3y�����C��F�bdg0�#;�����<���`�)Fv#O1�3y�����S��F�b�`0�#���9��d#���%	��,�H0ld�F�a#K6Y��`��*�2ld�'6�ʳ��C8�C:�C<�C>�C@ �CB!�CD"�CF#�CH$�CJ%1��I��$�p3AI0��LR)1��J�d%��3aI0��LZ-1�$�K��%��s�I2��B�@Bځ(�G �@�$�v �$��	iB�@BځP;��v �$��	iB�@BځT;��v �$�H�	iR�@BځT;��v �$�H�	iR�@BځT;� �@�h�v��h�v�� �1P���1NP���1�P���1�P���1Q���1NQ���1�Q���1�Q�� �AR�M#��$��t�I��I��4��t�I��I��4���2�"']r� r�%'"']r� r�%'"'Cr� r2$'"'Cr� r2$'"'Cr� r2$'"'Cr� r2$'"'Cr�!r2$'"'Sr�!r2%'"'Sr�!r2������{wS�G�:��3CbSr�!���tH>���nwi��!�nyp�CZ���P����ToH�J���q�ToHӴJ��4M���P��Cҡ��
F;����`�~�z���U���{{y�h0��^ ����ރ���C�{0��~�z���U���{{y�h0��^ ���[�ތ��[�ތ���WN����K'c������{{y�h0��n�z3��n�z3��^^?9!{���	�{�q��A~�ǤK'�q?�]�{B6��M���p^�E9!��2��������l�]�N&㚗��Ի0!�e��^�s�R�!��̦�kBdW^rx@�e�O��� �+/:< \QfT�5�+S�� BveN�^!�2�z�	�]�� �S�U�5!�+�=<���L�ޣ�ٕWp*S���ٕ�+����ٕ��{M�����=��]�� 8煝 _-��R�C�4!E����zY����߈5��j}.���u��D�kBd���{!";]O�k"dW&��5�+W��FBv��^"�bt1�2!}�DdW�� FW���5!�+Fg�+7����3��E��ǥ��2-}�	�]�q�{M������r�q�	�]1:ctwQF��������M�kBdW��F���^!�27}���]��G:#�+Fg��2:}�	�]qc�J���{M�슫�U��O�C��Wq��D����νH4�U�l����(�_v�!�Σ\6d|�x�ˆ�o/��'��{����S�rAJe�T.H�L�ł`o�z/�����ªe6���j�z/`z�z/�_z�z/z��͐B/����_��V�7������{�R�!{�V�7d�]f�/�޻�_��w+���n�R(d��T_wߏ�U�`�      R   �   x���A�@໿��\����)��i��m@w�ٰ��y0�N�[�ى��x�'���u�nMO�
.H�c(��&�<����N����	p۟��j�O��!k��	l9�c%�V�V�FcU3A�޼���qC�;/^ҿ��Yo��GC��Z6U�89�����t�p�a���Fz�����      S   �   x���v
Q���WH��II�,�K�H-J�LN-N-�P��Ff
6��TT����]��_��Z���+�MJ-�h����!�X�������a�� GF:
ƚ�\�C��F0����`2��ov9<����M`!�ӡ�~S��n��!��s����\\ i��      T   �   x���v
Q���WH��II�,�+H,�L�+Q��L�2u���̢Ⓖ��T�HN"D@S!��'�5XA�PGAݷ2����Tu ӱ4)��$3O]Ӛ˓����HLKM� Y曙�I#��AU&&g敀�r���� \�l�      U      x���v
Q���WH��II�,�+(�O/J�U��L�2u�����T8'%�8�(��$3?!VZ��Ts�	uV�0�QPptvU�!��
@T��� ��ʙhZsy��5F`ׄx`�&��5\\ ��^�      V   �  x��Qo�JF��+x�+%��t�F��ڴjҾ#�s�h�´��}qm���l�}`g�oHH����x>��n??:w�����H�y����|��oi���EY��4O�c�N��ٵ�Ϟ��(��:o��J�|�Lu^>ُ�h�Η�|�׻�UV,��X�X7�&��G~+��G?��̪E��VY�g�<}�|�����gҵ3�\ϻq�ϝ\;^3����y�6�'��j�y}[>/���6o��O��6_}؞�������ݨqx���x��u���l���#�����/��P�Y��'{>�em�"�M��f�z?�͟�+�b�O�pf;8� �u�	Np�"l�|�I�Cr�����.Bs$�5���j����T���r����'rG��ӂA��&,�p"�c�h�r'�9�qi���pfǸ}�f8Q�H��5 "!�3���8E�����0�l]q���D��n�Ĉ(:zQ�t��]�qp� ˌ�`�[�?4co�<@D����f<~8h�tY3?4c���	�1�3?!4c�kf<~Nh�t��u[�tb
�8�p�M��&,�pb�c2ڱ\Éѐ)��� t�ZLl�/h�m��B-n�M�p'tesӉ$ÉQ��65�i�&ln1o8hǞюr��DgJ.��	=&Orщ�F�:�?~Dh�m���%�P�/G]o�%���f��x#���e� ���K�/�H�6˙12���/D4GD�D��K�bu������S!��ϻ���X�����vms��F��n�X@�ԑM�ZB��+I��X��E��$�te\�_G,����i��+�>���!��������R��{�~g��r�f���4�n6�2��6�M��,�m��7j�\�!�qU��ఌ�x�!�qU�bW#'�q=��ۺⰌ����7�Y�U�{,�f��2�j�CD,�f��aW5�˸�7c�e\Ռ�X�U��ȉe\e˸��l������_�qU��ఌ�N�e\���2�j8B,㪆c��2���gW5�-�qU�"bW5�˸��t=,�*�pf,᪆3 ��j8FN,ߪ�k���[�rupX�U+W��[�r�l�V�!m��e�Ē�ڗ3X�U�r��X�U�=���Z���K�����+�q�fLj�}8h�m��h3ЌI��@͘Ԍ_�fld8!:���B�����n:���ۀ����6b%\�6D�j�>���qُ��X��㷮�~���      W   �   x���v
Q���WH��II�,�+(�O/J�M�+���R%
�)�:
�%�@Ff
�	�Eb"�$���K�PE
��SR5�}B]�4u H����H��T��P�gd ��:���5��<�O�t ���<�A�ccd���D����)�#���#&`� Җ�G,�<b� �]�      X   �   x���v
Q���WH��II�,�+(�O/J�M�H-J�LN-N-�L-V��*���� � 11%�K�JR+�ry)@ZS!��'�5XA�PG�������5�����HG�� 2`���B@ǘ�cL�.:�K\\ ���C     