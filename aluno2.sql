create database aluno2;

use aluno2;

create table Aluno(
ra VARCHAR(10) PRIMARY KEY NOT NULL,
nome VARCHAR(100),
dtcad DATE,
curso VARCHAR(10),
turno VARCHAR(20) 
);

CREATE TABLE Professor(
id VARCHAR(4) PRIMARY KEY NOT NULL,
nome VARCHAR(100),
grau VARCHAR(100)
);

CREATE TABLE Disciplina(
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
uc VARCHAR(100),
idprof VARCHAR(4),
FOREIGN KEY (idprof) REFERENCES Professor(id)
); 

CREATE TABLE Boletim(
iddisc INT,
ra VARCHAR(10),
nota1 DECIMAL(10, 2), 
nota2 DECIMAL(10, 2),
media DECIMAL(10, 2),
situacao ENUM('AP', 'REC', 'REP'),
FOREIGN KEY (iddisc) REFERENCES Disciplina(id),
FOREIGN KEY (ra) REFERENCES Aluno(ra),
CONSTRAINT id PRIMARY KEY (iddisc, ra)
);

INSERT INTO Aluno VALUES
('020.758519', 'LETICIA MASCARENHAS', '2023-01-30', 'DS', 'VESPERTINO'),
('020.758520', 'RAMON PAPES', '2023-01-30', 'DS', 'VESPERTINO'),
('020.758521', 'LUIS HENRIQUE', '2023-07-31', 'REDES', 'NOTURNO'),
('020.758522', 'JOSEANE SILVA', '2023-07-31', 'REDES', 'NOTURNO')
;

INSERT INTO Professor VALUES
('7934', 'JAILSON SANTOS', 'MESTRE'),
('7935', 'JAILTON RODRIGUES', 'ESPECIALISTA'),
('7936', 'WEST SILVA', 'GRADUADO'),
('7937', 'JOSE MARIVALDO', 'MESTRE')
;

INSERT INTO Disciplina (uc, idprof)  
VALUES
('BANCO DE DADOS', '7934'),
('FUNDAMENTOS DE TI', '7935'),
('PROGRAMACAO WEB', '7936'),
('REDES', '7937')
;

INSERT INTO Boletim (iddisc, ra, nota1, nota2, nota3)
VALUES
(1, '020.758519', 5.8, 6.2, 8.0),
(2, '020.758519', 6.0, 5.8, 7.9),
(3, '020.758519', 7.0, 8.0, 7.5),
(4, '020.758519', 7.9, 0.0, 8.7),
(1, '020.758520', 8.0, 7.0, 9.1),
(2, '020.758520', 9.3, 9.0, 7.0)
;

ALTER TABLE Boletim ADD COLUMN nota3 DECIMAL(10,2);
ALTER TABLE Boletim MODIFY nota3 DECIMAL(10,2) AFTER nota2;

SELECT
	ra, iddisc, nota1, nota2, nota3, 
    ROUND((nota1 + nota2 + nota3) / 3, 2) AS media, 
    CASE
		WHEN (nota1 + nota2 + nota3) / 3 >=  7 THEN 'AP'
        WHEN (nota1 + nota2 + nota3) / 3 >=  4 THEN 'REC'
        ELSE 'REP'
	END AS situacao
FROM Boletim
-- WHERE (nota1 + nota2 + nota3) / 3 >=4
-- AND (nota1 + nota2 + nota3) / 3 < 7
WHERE (nota1 + nota2 + nota3) / 3 >= 7;

SELECT a.nome, a.ra, b.iddisc, b.nota1, b.nota2, b.nota3 FROM Aluno AS a INNER JOIN Boletim AS b ON a.ra = b.ra
WHERE (nota1 + nota2 + nota3) / 3 >= 7;

SELECT a.nome, b.iddisc, b.nota1, b.nota2, b.nota3 FROM Aluno AS a INNER JOIN Boletim AS b ON a.ra = b.ra
WHERE (nota1 + nota2 + nota3) / 3 >= 4 AND (nota1 + nota2 + nota3) / 3 < 7;

SELECT DISTINCT 
	b.ra, a.nome, b.iddisc, d.uc, b.nota1, b.nota2, b.nota3,
    ROUND((b.nota1 + b.nota2 + b.nota3) / 3, 2) AS media,
    CASE 
		WHEN (b.nota1 + b.nota2 + b.nota3) / 3 >= 7 THEN 'AP'
		WHEN (b.nota1 + b.nota2 + b.nota3) / 3 < 4  THEN 'REC'
        ELSE 'REP'
	END AS situacao
FROM boletim AS b 
INNER JOIN aluno AS a
INNER JOIN disciplina ON a.ra = b.ra
INNER JOIN disciplina AS d ON d.id = b. iddisc
ORDER BY media DESC;
-- WHERE (b.nota1 + b.nota2 + b.nota3) / 3 >= 4 AND (b.nota1 + b.nota2 + b.nota3) / 3 < 7;

