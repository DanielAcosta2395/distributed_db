-- DROP SCHEMA uaslp_fca;

CREATE SCHEMA uaslp_fca AUTHORIZATION uaslp_fca;

-- Drop table

-- DROP TABLE uaslp_fca.facultad;

CREATE TABLE uaslp_fca.facultad (
	clave_facultad int4 NOT NULL,
	nombre varchar NOT NULL,
	CONSTRAINT facultad_pk PRIMARY KEY (clave_facultad)
);


-- uaslp_fca.materia definition

-- Drop table

-- DROP TABLE uaslp_fca.materia;

CREATE TABLE uaslp_fca.materia (
	clave_materia int4 NOT NULL,
	nombre varchar NOT NULL,
	creditos int4 NOT NULL,
	horas_teoria_semana int4 NULL,
	horas_practica_semana int4 NULL,
	horas_adicion int4 NOT NULL,
	optativa bool NOT NULL,
	area_id int4 NOT NULL,
	clasificacion_id int4 NOT NULL,
	CONSTRAINT materia_pk PRIMARY KEY (clave_materia)
);


-- uaslp_fca.carrera definition

-- Drop table

-- DROP TABLE uaslp_fca.carrera;

CREATE TABLE uaslp_fca.carrera (
	clave_carrera int4 NOT NULL,
	nombre varchar NOT NULL,
	clave_facultad int4 NOT NULL,
	CONSTRAINT carrera_pk PRIMARY KEY (clave_carrera),
	CONSTRAINT carrera_fk FOREIGN KEY (clave_facultad) REFERENCES uaslp_fca.facultad(clave_facultad) ON DELETE CASCADE
);


-- uaslp_fca.plan_estudios definition

-- Drop table

-- DROP TABLE uaslp_fca.plan_estudios;

CREATE TABLE uaslp_fca.plan_estudios (
	plan_estudios_id int4 NOT NULL,
	clave_acreditacion varchar NULL,
	creditos_totales int4 NULL,
	anio_acreditacion int4 NULL,
	informacion varchar NULL,
	clave_carrera int4 NOT NULL,
	CONSTRAINT plan_estudios_pk PRIMARY KEY (plan_estudios_id),
	CONSTRAINT plan_estudios_fk FOREIGN KEY (clave_carrera) REFERENCES uaslp_fca.carrera(clave_carrera) ON DELETE CASCADE
);


-- uaslp_fca.semestre definition

-- Drop table

-- DROP TABLE uaslp_fca.semestre;

CREATE TABLE uaslp_fca.semestre (
	semestre_id int4 NOT NULL,
	nivel int4 NOT NULL,
	plan_estudios_id int4 NOT NULL,
	CONSTRAINT semestre_pk PRIMARY KEY (semestre_id),
	CONSTRAINT semestre_fk FOREIGN KEY (plan_estudios_id) REFERENCES uaslp_fca.plan_estudios(plan_estudios_id) ON DELETE CASCADE
);


-- uaslp_fca.alumno definition

-- Drop table

-- DROP TABLE uaslp_fca.alumno;

CREATE TABLE uaslp_fca.alumno (
	clave_unica int4 NOT NULL,
	nombre varchar NOT NULL,
	fecha_nacimiento date NOT NULL,
	clave_carrera int4 NOT NULL,
	CONSTRAINT alumno_pk PRIMARY KEY (clave_unica),
	CONSTRAINT alumno_fk FOREIGN KEY (clave_carrera) REFERENCES uaslp_fca.carrera(clave_carrera) ON DELETE CASCADE
);


-- uaslp_fca.materia_semestre definition

-- Drop table

-- DROP TABLE uaslp_fca.materia_semestre;

CREATE TABLE uaslp_fca.materia_semestre (
	materia_semestre_id int4 NOT NULL,
	clave_materia int4 NOT NULL,
	semestre_id int4 NOT NULL,
	CONSTRAINT materia_plan_estudios_pk PRIMARY KEY (materia_semestre_id),
	CONSTRAINT materia_semestre_fk FOREIGN KEY (clave_materia) REFERENCES uaslp_fca.materia(clave_materia) ON DELETE CASCADE,
	CONSTRAINT materia_semestre_fk_1 FOREIGN KEY (semestre_id) REFERENCES uaslp_fca.semestre(semestre_id) ON DELETE CASCADE
);


-- uaslp_fca.kardex definition

-- Drop table

-- DROP TABLE uaslp_fca.kardex;

CREATE TABLE uaslp_fca.kardex (
	kardex_id serial4 NOT NULL,
	clave_unica int4 NOT NULL,
	materia_semestre int4 NOT NULL,
	tipo_examen varchar NULL,
	calificacion_final varchar NULL,
	CONSTRAINT kardex_pk PRIMARY KEY (kardex_id),
	CONSTRAINT kardex_fk FOREIGN KEY (materia_semestre) REFERENCES uaslp_fca.materia_semestre(materia_semestre_id) ON DELETE CASCADE,
	CONSTRAINT kardex_fk_1 FOREIGN KEY (clave_unica) REFERENCES uaslp_fca.alumno(clave_unica) ON DELETE CASCADE
);
