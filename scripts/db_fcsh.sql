-- DROP SCHEMA uaslp_fcsh;

CREATE SCHEMA uaslp_fcsh AUTHORIZATION uaslp_fcsh;

-- Drop table

-- DROP TABLE uaslp_fcsh.clasificacion;

CREATE TABLE uaslp_fcsh.clasificacion (
	clasificacion_id int4 NOT NULL,
	nombre varchar NOT NULL,
	descripcion varchar NULL,
	CONSTRAINT clasificacion_pk PRIMARY KEY (clasificacion_id)
);


-- uaslp_fcsh.facultad definition

-- Drop table

-- DROP TABLE uaslp_fcsh.facultad;

CREATE TABLE uaslp_fcsh.facultad (
	clave_facultad int4 NOT NULL,
	nombre varchar NOT NULL,
	CONSTRAINT facultad_pk PRIMARY KEY (clave_facultad)
);


-- uaslp_fcsh.carrera definition

-- Drop table

-- DROP TABLE uaslp_fcsh.carrera;

CREATE TABLE uaslp_fcsh.carrera (
	clave_carrera int4 NOT NULL,
	nombre varchar NOT NULL,
	clave_facultad int4 NOT NULL,
	CONSTRAINT carrera_pk PRIMARY KEY (clave_carrera),
	CONSTRAINT carrera_fk FOREIGN KEY (clave_facultad) REFERENCES uaslp_fcsh.facultad(clave_facultad) ON DELETE CASCADE
);


-- uaslp_fcsh.materia definition

-- Drop table

-- DROP TABLE uaslp_fcsh.materia;

CREATE TABLE uaslp_fcsh.materia (
	clave_materia int4 NOT NULL,
	nombre varchar NOT NULL,
	creditos int4 NOT NULL,
	horas_teoria_semana int4 NULL,
	horas_practica_semana int4 NULL,
	horas_independientes int4 NOT NULL,
	electiva bool NOT NULL,
	clasificacion_id int4 NOT NULL,
	CONSTRAINT materia_pk PRIMARY KEY (clave_materia),
	CONSTRAINT materia_fk_2 FOREIGN KEY (clasificacion_id) REFERENCES uaslp_fcsh.clasificacion(clasificacion_id) ON DELETE CASCADE
);


-- uaslp_fcsh.plan_estudios definition

-- Drop table

-- DROP TABLE uaslp_fcsh.plan_estudios;

CREATE TABLE uaslp_fcsh.plan_estudios (
	plan_estudios_id int4 NOT NULL,
	clave_acreditacion varchar NULL,
	creditos_totales int4 NULL,
	anio_acreditacion int4 NULL,
	informacion varchar NULL,
	clave_carrera int4 NOT NULL,
	CONSTRAINT plan_estudios_pk PRIMARY KEY (plan_estudios_id),
	CONSTRAINT plan_estudios_fk FOREIGN KEY (clave_carrera) REFERENCES uaslp_fcsh.carrera(clave_carrera) ON DELETE CASCADE
);


-- uaslp_fcsh.semestre definition

-- Drop table

-- DROP TABLE uaslp_fcsh.semestre;

CREATE TABLE uaslp_fcsh.semestre (
	semestre_id int4 NOT NULL,
	nivel int4 NOT NULL,
	plan_estudios_id int4 NOT NULL,
	CONSTRAINT semestre_pk PRIMARY KEY (semestre_id),
	CONSTRAINT semestre_fk FOREIGN KEY (plan_estudios_id) REFERENCES uaslp_fcsh.plan_estudios(plan_estudios_id) ON DELETE CASCADE
);


-- uaslp_fcsh.alumno definition

-- Drop table

-- DROP TABLE uaslp_fcsh.alumno;

CREATE TABLE uaslp_fcsh.alumno (
	clave_unica int4 NOT NULL,
	nombre varchar NOT NULL,
	fecha_nacimiento date NOT NULL,
	clave_carrera int4 NOT NULL,
	CONSTRAINT alumno_pk PRIMARY KEY (clave_unica),
	CONSTRAINT alumno_fk FOREIGN KEY (clave_carrera) REFERENCES uaslp_fcsh.carrera(clave_carrera) ON DELETE CASCADE
);


-- uaslp_fcsh.materia_semestre definition

-- Drop table

-- DROP TABLE uaslp_fcsh.materia_semestre;

CREATE TABLE uaslp_fcsh.materia_semestre (
	materia_semestre_id int4 NOT NULL,
	clave_materia int4 NOT NULL,
	semestre_id int4 NOT NULL,
	CONSTRAINT materia_plan_estudios_pk PRIMARY KEY (materia_semestre_id),
	CONSTRAINT materia_semestre_fk FOREIGN KEY (clave_materia) REFERENCES uaslp_fcsh.materia(clave_materia) ON DELETE CASCADE,
	CONSTRAINT materia_semestre_fk_1 FOREIGN KEY (semestre_id) REFERENCES uaslp_fcsh.semestre(semestre_id) ON DELETE CASCADE
);


-- uaslp_fcsh.kardex definition

-- Drop table

-- DROP TABLE uaslp_fcsh.kardex;

CREATE TABLE uaslp_fcsh.kardex (
	kardex_id serial4 NOT NULL,
	clave_unica int4 NOT NULL,
	materia_semestre int4 NOT NULL,
	tipo_examen varchar NULL,
	calificacion_final varchar NULL,
	CONSTRAINT kardex_pk PRIMARY KEY (kardex_id),
	CONSTRAINT kardex_fk FOREIGN KEY (materia_semestre) REFERENCES uaslp_fcsh.materia_semestre(materia_semestre_id) ON DELETE CASCADE,
	CONSTRAINT kardex_fk_1 FOREIGN KEY (clave_unica) REFERENCES uaslp_fcsh.alumno(clave_unica) ON DELETE CASCADE
);
