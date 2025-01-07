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
	situacao varchar(35) NOT NULL,
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

-------------------------------------------------------------------------------------------------------
INSERT INTO dbo.Alunos (id_aluno, nome, data_nascimento, sexo, data_cadastro, login_cadastro)
VALUES
(4, 'Maria Fernanda Maki Kanashiro Katakura','18/07/2003','F','07/01/2025 09:23:00','FABIO')

select * from dbo.Alunos

insert into dbo.Cursos (id_curso, nome_curso, data_cadastro, login_cadastro) values
(1, 'VBA I','06/01/2025 11:03:00','FABIO')

SELECT * FROM DBO.Cursos

INSERT INTO dbo.Situacao (id_situacao, situacao, data_cadastro, login_cadastro) values
(1, 'Presenca confirmada','06/01/2025 15:00:00','FABIO')

INSERT INTO dbo.Situacao (id_situacao, situacao, data_cadastro, login_cadastro) values
(2, 'Ausente Sem Justificativa','06/01/2025 15:00:00','FABIO')

INSERT INTO dbo.Situacao (id_situacao, situacao, data_cadastro, login_cadastro) values
(3, 'Ausente Com Justificativa','06/01/2025 15:00:00','FABIO')

SELECT * FROM Cursos -- * Todos os registros
select * from Turmas

--DBA = DataBase Administrator

--Exemplo de Query utilizando o nome da tabela
SELECT turmas.* FROM turmas

--Selecionar apenas alguns campos da tabela
SELECT id_turma, id_curso, data_inicio
	FROM dbo.Turmas

--Utilizar Alias (APELIDO) para Nome da Tabela
SELECT *
	FROM dbo.Turmas T

SELECT T.*
	FROM dbo.Turmas T

SELECT T.id_turma, T.id_curso, T.data_inicio
	FROM dbo.Turmas T

--Utilizar Nomes Personalizados para nossos campos
SELECT T.id_curso AS IDC, T.id_turma AS IDT, T.data_inicio AS "DATA COME�O"
	FROM dbo.Turmas T

--Segunda forma
SELECT tt.id_curso IDC, tt.id_turma IDT, tt.data_inicio "DATA COME�O"
	FROM dbo.Turmas TT

---------------------------------------------------------------------------------------------
--selecionando especificamente um aluno (=)
SELECT a.*
	FROM dbo.Alunos a
	WHERE a.nome = 'Fabio Eizo Rodriguez Matsumoto'

--selecionando todos, com excess�o de um aluno (<>)
SELECT a.*
	FROM dbo.Alunos a
	WHERE a.nome <> 'Fabio Eizo Rodriguez Matsumoto'

--selecionando todos que tenham idade >= a tal
SELECT a.*
	FROM Alunos a
	WHERE a.data_nascimento >= '10/12/2003'

-- > maior
-- < menor
-- >= maior igual
-- <= menor igual
-- <> diferente
-- = igual

SELECT a.*
	FROM alunos a
	WHERE a.sexo = 'F'

SELECT a.*
	FROM alunos a
	WHERE a.sexo = 'M'
	AND a.data_nascimento >= '10/12/2003'