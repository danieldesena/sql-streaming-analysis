CREATE DATABASE streaming;
USE streaming;

CREATE TABLE filmes (
    id_filme 				INT PRIMARY KEY AUTO_INCREMENT,
    titulo 					VARCHAR(255) NOT NULL,
	genero 					VARCHAR(100) NOT NULL,
	ano_lancamento 			INT,
	duracao_min				INT,
	classificacao			VARCHAR(10) NOT NULL,
	nota_imdb DECIMAL(3,1) CHECK (nota_imdb >= 0 AND nota_imdb <= 10)
);


CREATE TABLE usuarios (
    id_usuario				INT PRIMARY KEY AUTO_INCREMENT,
	nome					VARCHAR(150) NOT NULL,
	email					VARCHAR(255) NOT NULL UNIQUE,
	pais					VARCHAR(100) NOT NULL,
	plano					VARCHAR(50)  NOT NULL,
	data_cadastro 			DATE
);


CREATE TABLE avaliacoes (
    id_avaliacao			INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario_fk 			INT NOT NULL,
	id_filme_fk				INT NOT NULL,
	nota DECIMAL(3,1) CHECK (nota >= 0 AND nota <= 10),
	data_avaliacao			DATE,
	assistiu_completo 		BOOLEAN,
		FOREIGN KEY (id_usuario_fk) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
		FOREIGN KEY (id_filme_fk) REFERENCES filmes(id_filme) ON DELETE CASCADE
);



SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'filmes.csv'
INTO TABLE filmes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_filme, titulo, genero, ano_lancamento, duracao_min, classificacao, nota_imdb);

LOAD DATA INFILE 'usuarios.csv'
INTO TABLE usuarios
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_usuario, nome, email, pais, plano, data_cadastro);

LOAD DATA INFILE 'avaliacoes.csv'
INTO TABLE avaliacoes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_avaliacao, id_usuario_fk, id_filme_fk, nota, data_avaliacao, assistiu_completo);