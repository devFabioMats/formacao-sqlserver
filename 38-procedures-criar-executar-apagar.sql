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
SELECT T.id_curso AS IDC, T.id_turma AS IDT, T.data_inicio AS "DATA COMEÇO"
	FROM dbo.Turmas T

--Segunda forma
SELECT tt.id_curso IDC, tt.id_turma IDT, tt.data_inicio "DATA COMEÇO"
	FROM dbo.Turmas TT

---------------------------------------------------------------------------------------------
--selecionando especificamente um aluno (=)
SELECT a.*
	FROM dbo.Alunos a
	WHERE a.nome = 'Fabio Eizo Rodriguez Matsumoto'

--selecionando todos, com excessão de um aluno (<>)
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

----------------------------------------------------------------------------

--TRATAMENTO DE ERROS
--Exemplo 1
--Tabela não existe
BEGIN TRY
	SELECT * FROM tempTable;
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS Número_erro,
		ERROR_MESSAGE() as Mensagem_erro;
END CATCH;

--Exemplo 2
--Utilizando em uma procedure
DROP PROCEDURE	prc_Exemplo;

CREATE PROCEDURE prc_Exemplo
AS
	SELECT * FROM tempTable;
GO

BEGIN TRY
	EXECUTE prc_Exemplo;
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS Numero_erro,
		ERROR_MESSAGE() as Mensagem_erro;
END CATCH;

--Exemplo 3
------------

BEGIN
	BEGIN TRY
		SELECT 1/0;
	END TRY
	BEGIN CATCH
		PRINT 'Erro número   : ' + convert(varchar, error_number());
		PRINT 'Erro mensagem : ' + error_message();
		PRINT 'Erro severiry : ' + convert(varchar, error_severity());
		PRINT 'Erro state    : ' + convert(varchar, error_state());
		PRINT 'Erro line     : ' + convert(varchar, error_line());
		PRINT 'Erro proc     : ' + error_procedure();
	END CATCH
END

----------------------------------------------------------------------------------------------------------------------
--Aula 37
--Triggers (gatilhos)


CREATE TABLE tbSaldos
(
	produto VARCHAR(10),
	saldo_inicial VARCHAR(10),
	saldo_final VARCHAR(10),
	data_ult_mov DATETIME
);
GO

INSERT INTO dbo.tbSaldos (produto, saldo_inicial, saldo_final, data_ult_mov)
	VALUES ('Produto A', 0, 100, getdate());
GO

CREATE TABLE tbVendas
(
	id_vendas INT,
	produto VARCHAR(10),
	quantidade INT,
	data DATETIME
);
GO

CREATE SEQUENCE seq_tbVendas
	AS NUMERIC
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE tbHistoricoVendas
(
	produto VARCHAR(10),
	quantidade INT,
	data_venda DATETIME
);
GO

CREATE TRIGGER trg_AjustaSaldo
ON tbVendas
FOR INSERT
AS
BEGIN
	DECLARE @quantidade INT,
			@data DATETIME,
			@produto VARCHAR(10)

	SELECT @data = data, @quantidade = quantidade, @produto = produto from INSERTED

	UPDATE tbSaldos
		SET saldo_final = saldo_final - @quantidade,
			data_ult_mov = @data
		WHERE produto = @produto

	INSERT INTO tbHistoricoVendas (produto, quantidade, data_venda)
		VALUES (@produto, @quantidade, @data);
END
GO

INSERT INTO tbVendas (id_vendas, produto, quantidade, data)
	VALUES (NEXT VALUE FOR seq_tbVendas, 'Produto A', 2, getdate());

SELECT * FROM tbVendas
SELECT * FROM tbSaldos
SELECT * FROM tbHistoricoVendas

SELECT * FROM tbVendas
SELECT * FROM tbSaldos
SELECT * FROM tbHistoricoVendas

-----------------------------------------------------------------------------------
CREATE PROCEDURE BuscaCurso
	@NomeCurso VARCHAR(20)
AS

SET @nomecurso = '%' + @NomeCurso + '%';

SELECT c.id_curso, c.nome_curso, a.nome, isnull(a.sexo, 'NI') sexo
	FROM Cursos C
		INNER JOIN Turmas t on (t.id_turma = c.id_curso)
		INNER JOIN AlunosxTurmas alt on (alt.id_turma = t.id_turma)
		INNER JOIN Alunos a on (a.id_aluno = alt.id_aluno)
	WHERE nome_curso like @NomeCurso

EXEC BuscaCurso 'VBA I';
EXEC BuscaCurso '%';
EXEC BuscaCurso 'Excel';

--Procedure com retorno
-----------------------
CREATE PROCEDURE IncluirNovoCurso
	@NomeCurso VARCHAR(100),
	@LoginCadastro VARCHAR(100)
AS
BEGIN
	DECLARE @vIdCurso INT;

	SELECT @vIdCurso = max(id_curso) + 1 FROM cursos;

	INSERT INTO cursos (id_curso, nome_curso, data_cadastro, login_cadastro)
		VALUES (@vIdCurso, @NomeCurso, getdate(), @LoginCadastro);

	SELECT @vIdCurso = id_curso FROM cursos WHERE id_curso = @vIdCurso;

	SELECT @vIdCurso AS retorno;
END;
GO;