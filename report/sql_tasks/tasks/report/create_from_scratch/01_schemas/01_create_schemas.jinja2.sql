DROP SCHEMA IF EXISTS report CASCADE;
CREATE SCHEMA report AUTHORIZATION "{{db_user}}";

DROP SCHEMA IF EXISTS h_us CASCADE;
CREATE SCHEMA h_us AUTHORIZATION "{{db_user}}";

DROP SCHEMA IF EXISTS h_ca CASCADE;
CREATE SCHEMA h_ca AUTHORIZATION "{{db_user}}";

DROP SCHEMA IF EXISTS lms_us CASCADE;
CREATE SCHEMA lms_us AUTHORIZATION "{{db_user}}";

DROP SCHEMA IF EXISTS lms_ca CASCADE;
CREATE SCHEMA lms_ca AUTHORIZATION "{{db_user}}";
