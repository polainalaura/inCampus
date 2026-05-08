-- ========================================================
-- BASE DE DATOS: GESTION_ACADEMICA
-- ========================================================

DROP DATABASE IF EXISTS gestion_academica;
CREATE DATABASE gestion_academica;
USE gestion_academica;

-- ========================================================
-- TABLA: usuario
-- ========================================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    email VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('ALUMNO','PROFESOR','ADMIN') NOT NULL,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo TINYINT(1) DEFAULT 1,
    PRIMARY KEY (id_usuario),
    UNIQUE KEY uq_usuario_email (email),
    KEY idx_usuario_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO usuario (id_usuario,nombre,apellido1,apellido2,email,password_hash,rol) VALUES
(1,'Carlos','Lopez','Garcia','carlos.lopez@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','PROFESOR'),
(2,'Ana','Martinez','Ruiz','ana.martinez@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','PROFESOR'),
(3,'Laura','Sanchez','Perez','laura.sanchez@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','PROFESOR'),
(4,'Mario','Fernandez','Diaz','mario.fernandez@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO'),
(5,'Lucia','Gomez','Navarro','lucia.gomez@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO'),
(6,'David','Torres','Santos','david.torres@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO'),
(7,'Paula','Romero','Iglesias','paula.romero@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO'),
(8,'Sergio','Vazquez','Molina','sergio.vazquez@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO'),
(9,'Elena','Castro','Ortega','elena.castro@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO'),
(10,'Javier','Herrera','Gil','javier.herrera@email.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO');
(11,'Test','Prueba','Prueba','alumno@test.com','$2b$10$k6JxQMQ2gA3d/LWEVUqmGeA2ImlmopIKHoDdcs5VCcdBnf9lMSTAm','ALUMNO');

-- ========================================================
-- TABLA: asignatura
-- ========================================================
CREATE TABLE asignatura (
    id_asignatura INT AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    descripcion TEXT,
    PRIMARY KEY (id_asignatura),
    UNIQUE KEY uq_asignatura_codigo (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO asignatura VALUES
(1,'Bases de Datos','BD01','Diseño y administración de bases de datos'),
(2,'Sistemas Operativos','SO01','Administración de sistemas'),
(3,'Implantación de Aplicaciones Web','IAW01','Despliegue de aplicaciones web'),
(4,'Seguridad Informática','SEG01','Seguridad en sistemas y redes');

-- ========================================================
-- TABLA: profesor_asignatura
-- ========================================================
CREATE TABLE profesor_asignatura (
    id_profesor INT NOT NULL,
    id_asignatura INT NOT NULL,
    PRIMARY KEY (id_profesor,id_asignatura),
    KEY idx_pa_asignatura (id_asignatura),
    FOREIGN KEY (id_profesor) REFERENCES usuario(id_usuario)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id_asignatura)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO profesor_asignatura VALUES
(1,1),(1,3),(2,2),(2,4),(3,1),(3,4);

-- ========================================================
-- TABLA: matricula
-- ========================================================
CREATE TABLE matricula (
    id_alumno INT NOT NULL,
    id_asignatura INT NOT NULL,
    fecha_matricula DATE NOT NULL,
    PRIMARY KEY (id_alumno,id_asignatura),
    KEY idx_matricula_asignatura (id_asignatura),
    FOREIGN KEY (id_alumno) REFERENCES usuario(id_usuario)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id_asignatura)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO matricula VALUES
(4,1,'2024-09-01'),(4,2,'2024-09-01'),
(5,1,'2024-09-01'),(5,3,'2024-09-01'),
(6,2,'2024-09-01'),(6,4,'2024-09-01'),
(7,1,'2024-09-01'),(8,3,'2024-09-01'),
(9,4,'2024-09-01'),(10,2,'2024-09-01');

-- ========================================================
-- TABLA: tutoria (ERROR ID_PROFESOR CORREGIDO)
-- ========================================================
CREATE TABLE tutoria (
    id_tutoria INT AUTO_INCREMENT,
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL,
    ubicacion VARCHAR(150),
    estado_slot ENUM('DISPONIBLE','RESERVADA','CANCELADA') DEFAULT 'DISPONIBLE',
    id_profesor INT NOT NULL,
    id_alumno INT DEFAULT NULL,
    PRIMARY KEY (id_tutoria),
    KEY idx_tutoria_profesor (id_profesor),
    KEY idx_tutoria_alumno (id_alumno),
    FOREIGN KEY (id_profesor) REFERENCES usuario(id_usuario)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_alumno) REFERENCES usuario(id_usuario)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO tutoria VALUES
(1,'2025-03-01 10:00','2025-03-01 11:00','Aula 1','DISPONIBLE',1,NULL),
(2,'2025-03-02 09:00','2025-03-02 10:00','Aula 2','DISPONIBLE',2,NULL),
(3,'2025-03-03 12:00','2025-03-03 13:00','Aula 3','DISPONIBLE',3,NULL),
(4,'2025-03-04 10:00','2025-03-04 11:00','Aula 1','DISPONIBLE',1,NULL),
(5,'2025-03-05 09:00','2025-03-05 10:00','Aula 2','DISPONIBLE',2,NULL),
(6,'2025-03-05 11:00','2025-03-05 12:00','Aula 3','DISPONIBLE',2,NULL);


-- ========================================================
-- TABLA: reserva_tutoria
-- ========================================================
CREATE TABLE reserva_tutoria (
    id_reserva INT AUTO_INCREMENT,
    fecha_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('PENDIENTE','CONFIRMADA','CANCELADA') DEFAULT 'PENDIENTE',
    motivo TEXT,
    id_tutoria INT NOT NULL,
    id_alumno INT NOT NULL,
    PRIMARY KEY (id_reserva),
    UNIQUE KEY uq_reserva_tutoria (id_tutoria),
    KEY idx_reserva_alumno (id_alumno),
    FOREIGN KEY (id_tutoria) REFERENCES tutoria(id_tutoria)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_alumno) REFERENCES usuario(id_usuario)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO reserva_tutoria VALUES
(1,NULL,'CONFIRMADA','Dudas examen',1,4),
(2,NULL,'PENDIENTE','Consulta proyecto',2,5),
(3,NULL,'CONFIRMADA','Revisión práctica',3,6);

-- ========================================================
-- TABLA: documento
-- ========================================================
CREATE TABLE documento (
    id_documento INT AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    url_archivo VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_profesor INT NOT NULL,
    id_asignatura INT NOT NULL,
    PRIMARY KEY (id_documento),
    KEY idx_documento_profesor (id_profesor),
    KEY idx_documento_asignatura (id_asignatura),
    FOREIGN KEY (id_profesor) REFERENCES usuario(id_usuario)
      ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id_asignatura)
      ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO documento VALUES
(1,'Tema 1 BD','/docs/bd_tema1.pdf','pdf',NULL,1,1),
(2,'Tema 2 BD','/docs/bd_tema2.pdf','pdf',NULL,1,1),
(3,'Guía SO','/docs/so_guia.pdf','pdf',NULL,2,2),
(4,'Manual Seguridad','/docs/seg_manual.pdf','pdf',NULL,2,4),
(5,'Práctica IAW','/docs/iaw_practica.zip','zip',NULL,1,3);

-- ========================================================
-- TABLA: evento
-- ========================================================
CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha DATETIME NOT NULL,
    ubicacion VARCHAR(100),
    id_profesor INT,
    PRIMARY KEY (id_evento),
    KEY idx_evento_fecha (fecha),
    FOREIGN KEY (id_profesor) REFERENCES usuario(id_usuario)
      ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO evento VALUES
(1,'Charla IA','Introducción a la inteligencia artificial','2026-05-10 10:00','Aula 1',2);

-- ========================================================
-- INDICES ADICIONALES
-- ========================================================
CREATE INDEX idx_usuario_nombre ON usuario(nombre);
CREATE INDEX idx_usuario_apellido1 ON usuario(apellido1);
CREATE INDEX idx_usuario_apellido2 ON usuario(apellido2);
CREATE INDEX idx_usuario_rol ON usuario(rol);

CREATE INDEX idx_asignatura_nombre ON asignatura(nombre);

CREATE INDEX idx_documento_titulo ON documento(titulo);

CREATE INDEX idx_evento_titulo ON evento(titulo);

CREATE INDEX idx_tutoria_fecha_inicio ON tutoria(fecha_inicio);
CREATE INDEX idx_tutoria_estado ON tutoria(estado_slot);

CREATE INDEX idx_reserva_estado ON reserva_tutoria(estado);
CREATE INDEX idx_reserva_fecha ON reserva_tutoria(fecha_reserva);
