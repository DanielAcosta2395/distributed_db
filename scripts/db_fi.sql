-- DROP SCHEMA uaslp_fi;

CREATE SCHEMA uaslp_fi AUTHORIZATION uaslp_fi;
-- uaslp_fi.facultad definition

-- Drop table

-- DROP TABLE uaslp_fi.facultad;

CREATE TABLE uaslp_fi.facultad (
	clave_facultad int4 NOT NULL,
	nombre varchar NOT NULL,
	CONSTRAINT facultad_pk PRIMARY KEY (clave_facultad)
);


-- uaslp_fi.cacei definition

-- Drop table

-- DROP TABLE uaslp_fi.cacei;

CREATE TABLE uaslp_fi.cacei (
	cacei_id int4 NOT NULL,
	nombre varchar NOT NULL,
	descripcion varchar NULL,
	CONSTRAINT cacei_pk PRIMARY KEY (cacei_id)
);


-- uaslp_fi.area definition

-- Drop table

-- DROP TABLE uaslp_fi.area;

CREATE TABLE uaslp_fi.area (
	area_id int4 NOT NULL,
	nombre varchar NOT NULL,
	descripcion varchar NULL,
	CONSTRAINT area_pk PRIMARY KEY (area_id)
);


-- uaslp_fi.clasificacion definition

-- Drop table

-- DROP TABLE uaslp_fi.clasificacion;

CREATE TABLE uaslp_fi.clasificacion (
	clasificacion_id int4 NOT NULL,
	nombre varchar NOT NULL,
	descripcion varchar NULL,
	CONSTRAINT clasificacion_pk PRIMARY KEY (clasificacion_id)
);


-- uaslp_fi.carrera definition

-- Drop table

-- DROP TABLE uaslp_fi.carrera;

CREATE TABLE uaslp_fi.carrera (
	clave_carrera int4 NOT NULL,
	nombre varchar NOT NULL,
	clave_facultad int4 NOT NULL,
	CONSTRAINT carrera_pk PRIMARY KEY (clave_carrera),
	CONSTRAINT carrera_fk FOREIGN KEY (clave_facultad) REFERENCES uaslp_fi.facultad(clave_facultad) ON DELETE CASCADE
);


-- uaslp_fi.plan_estudios definition

-- Drop table

-- DROP TABLE uaslp_fi.plan_estudios;

CREATE TABLE uaslp_fi.plan_estudios (
	plan_estudios_id int4 NOT NULL,
	clave_acreditacion varchar NULL,
	creditos_totales int4 NULL,
	anio_acreditacion int4 NULL,
	informacion varchar NULL,
	clave_carrera int4 NOT NULL,
	CONSTRAINT plan_estudios_pk PRIMARY KEY (plan_estudios_id),
	CONSTRAINT plan_estudios_fk FOREIGN KEY (clave_carrera) REFERENCES uaslp_fi.carrera(clave_carrera) ON DELETE CASCADE
);


-- uaslp_fi.materia definition

-- Drop table

-- DROP TABLE uaslp_fi.materia;

CREATE TABLE uaslp_fi.materia (
	clave_materia int4 NOT NULL,
	nombre varchar NOT NULL,
	creditos int4 NOT NULL,
	horas_teoria_semana int4 NULL,
	horas_practica_semana int4 NULL,
	optativa bool NOT NULL,
	cacei_id int4 NOT NULL,
	area_id int4 NOT NULL,
	clasificacion_id int4 NOT NULL,
	CONSTRAINT materia_pk PRIMARY KEY (clave_materia),
	CONSTRAINT materia_fk FOREIGN KEY (cacei_id) REFERENCES uaslp_fi.cacei(cacei_id) ON DELETE CASCADE,
	CONSTRAINT materia_fk_1 FOREIGN KEY (area_id) REFERENCES uaslp_fi.area(area_id) ON DELETE CASCADE,
	CONSTRAINT materia_fk_2 FOREIGN KEY (clasificacion_id) REFERENCES uaslp_fi.clasificacion(clasificacion_id) ON DELETE CASCADE
);


-- uaslp_fi.semestre definition

-- Drop table

-- DROP TABLE uaslp_fi.semestre;

CREATE TABLE uaslp_fi.semestre (
	semestre_id int4 NOT NULL,
	nivel int4 NOT NULL,
	plan_estudios_id int4 NOT NULL,
	CONSTRAINT semestre_pk PRIMARY KEY (semestre_id),
	CONSTRAINT semestre_fk FOREIGN KEY (plan_estudios_id) REFERENCES uaslp_fi.plan_estudios(plan_estudios_id) ON DELETE CASCADE
);


-- uaslp_fi.alumno definition

-- Drop table

-- DROP TABLE uaslp_fi.alumno;

CREATE TABLE uaslp_fi.alumno (
	clave_unica int4 NOT NULL,
	nombre varchar NOT NULL,
	fecha_nacimiento date NOT NULL,
	clave_carrera int4 NOT NULL,
	CONSTRAINT alumno_pk PRIMARY KEY (clave_unica),
	CONSTRAINT alumno_fk FOREIGN KEY (clave_carrera) REFERENCES uaslp_fi.carrera(clave_carrera) ON DELETE CASCADE
);


-- uaslp_fi.materia_semestre definition

-- Drop table

-- DROP TABLE uaslp_fi.materia_semestre;

CREATE TABLE uaslp_fi.materia_semestre (
	materia_semestre_id int4 NOT NULL,
	clave_materia int4 NOT NULL,
	semestre_id int4 NOT NULL,
	CONSTRAINT materia_plan_estudios_pk PRIMARY KEY (materia_semestre_id),
	CONSTRAINT materia_plan_estudios_fk FOREIGN KEY (clave_materia) REFERENCES uaslp_fi.materia(clave_materia) ON DELETE CASCADE,
	CONSTRAINT materia_semestre_fk FOREIGN KEY (semestre_id) REFERENCES uaslp_fi.semestre(semestre_id) ON DELETE CASCADE
);


-- uaslp_fi.kardex definition

-- Drop table

-- DROP TABLE uaslp_fi.kardex;

CREATE TABLE uaslp_fi.kardex (
	kardex_id serial4 NOT NULL,
	clave_unica int4 NOT NULL,
	materia_semestre_id int4 NOT NULL,
	tipo_examen varchar NULL,
	calificacion_final varchar NULL,
	CONSTRAINT kardex_pk PRIMARY KEY (kardex_id),
	CONSTRAINT kardex_fk FOREIGN KEY (materia_semestre_id) REFERENCES uaslp_fi.materia_semestre(materia_semestre_id) ON DELETE CASCADE,
	CONSTRAINT kardex_fk_1 FOREIGN KEY (clave_unica) REFERENCES uaslp_fi.alumno(clave_unica) ON DELETE CASCADE
);
