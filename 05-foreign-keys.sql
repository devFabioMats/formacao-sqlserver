CREATE TABLE Alunos
(
	id_aluno int PRIMARY KEY NOT NULL,
	nome varchar(200) NOT NULL,
	data_nascimento date NOT NULL,
	sexo varchar(1) NOT NULL, --M para Masculino e F para Feminino
	data_cadastro datetime NOT NULL,
	login_cadastro varchar(15) NOT NULL
);

CREATE TABLE Situacao
(
	id_situacao int PRIMARY KEY NOT NULL,
	situacao varchar(15) NOT NULL,
	data_cadastro datetime,
	login_cadastro varchar(15),
);

CREATE TABLE Cursos
(
	id_curso int PRIMARY KEY not null,
	nome_curso varchar(200) not null,
	data_cadastro datetime not null,
	login_cadastro varchar(15) not null
);

CREATE TABLE Turmas
(
	id_turma int PRIMARY KEY NOT NULL,
	id_aluno int NOT NULL,
	id_curso int NOT NULL,
	valor_turma numeric(15,2) NOT NULL,
	desconto numeric(3,2) not null,
	data_inicio date not null,
	data_termino date not null,
	data_cadastro datetime not null,
	login_cadastro varchar(15)
);

CREATE TABLE Registro_Presenca
(
	id_turma int not null,
	id_aluno int not null,
	id_situacao  int not null,
	data_presenca date not null,
	data_cadastro date not null,
	login_cadastro varchar(15) not null
);

/*
DROP TABLE Turmas;
DROP TABLE Situacao;
DROP TABLE Registro_Presenca;
DROP TABLE Cursos;
DROP TABLE Alunos;
--DROP TABLE Alunos;
*/

--Turmas x Alunos
ALTER TABLE Turmas
ADD CONSTRAINT fk_TurmasALunos FOREIGN KEY (id_aluno) REFERENCES Alunos (id_aluno);

--Turmas x Cursos
ALTER TABLE Turmas
ADD CONSTRAINT fk_TurmasCursos FOREIGN KEY (id_curso) REFERENCES Cursos (id_curso);

-- RegistroPresenca x Turmas
ALTER TABLE Registro_Presenca
	ADD CONSTRAINT fk_RPTurmas FOREIGN KEY (id_turma) REFERENCES Turmas (id_turma);

--Registro_Presenca x Alunos
ALTER TABLE Registro_Presenca
	ADD CONSTRAINT fk_RPAlunos FOREIGN KEY (id_aluno) REFERENCES Alunos (id_aluno);

--Registro_Presenca x Situacao
ALTER TABLE Registro_Presenca
	ADD CONSTRAINT fk_RPSituacao FOREIGN KEY (id_situacao) REFERENCES Situacao (id_situacao);

