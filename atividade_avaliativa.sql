-- Alunos: Aislan, Gisele, João Victor e Stephanie

create database horarios_escolares;

use horarios_escolares;
-- drop database horarios_escolares;
create table Disciplina(
id_disciplina int auto_increment primary key,
nome varchar(100),
carga_horaria varchar(6)
);

create table Professor(
id_professor int auto_increment primary key,
nome varchar(100),
especialidade varchar(100),
id_disciplina int,
foreign key (id_disciplina) references Disciplina (id_disciplina)
);

create table Turma(
id_turma int auto_increment primary key,
ano varchar(5),
nivel varchar(50),
letra varchar(1)
);

create table Sala(
id_sala int auto_increment primary key,
nome varchar(7),
localizacao varchar(100)
);

create table Horario(
id_horario int auto_increment primary key,
dia_semana varchar(15),
horario_inicio varchar(6),
horario_termino varchar(6),
id_disciplina int,
id_professor int,
foreign key (id_disciplina) references Disciplina (id_disciplina),
foreign key (id_professor) references Professor (id_professor)
);

create table Periodo_Letivo(
id_periodo int auto_increment primary key,
ano_letivo varchar(4),
semestre varchar(1),
id_horario int,
foreign key (id_horario) references Horario (id_horario)
);

insert into Disciplina (nome, carga_horaria) values
('Portugues','400h'),
('Matematica','450h'),
('Ingles','180h'),
('Geografia','200h');

insert into Professor (nome, especialidade, id_disciplina) values
('Celso','Ingles', 3),
('Fabiana','Matematica', 2),
('Armando','Portugues', 1),
('Maria','Geografia', 4);

insert into Turma (ano, nivel, letra) values
('1 ano','ensino medio', 'A'),
('5 ano','ensino fundamental', 'A'),
('1 ano','ensino medio', 'B'),
('2 ano','ensino medio', 'A');

insert into Sala (nome, localizacao) values
('sala 1', 'bloco a'),
('sala 3', 'bloco b'),
('sala 4', 'bloco c'),
('sala 2', 'bloco a');

insert into Horario (dia_semana, horario_inicio, horario_termino, id_disciplina, id_professor) values
('seg', '8h', '9h', 1, 3),
('seg', '9h', '10h', 2, 2),
('qua', '10h', '11h', 3, 1),
('sex', '8h', '9h', 4, 4);

insert into Periodo_Letivo (ano_letivo, semestre, id_horario) values
('2024', '1', 1),
('2024', '2', 2),
('2025', '1', 3),
('2025', '2', 4);

select p.nome, d.nome from Professor as p inner join Disciplina as d on p.id_professor = 1 and p.id_disciplina = d.id_disciplina;

select h.dia_semana, h.horario_inicio, h.horario_termino from Horario as h inner join Periodo_Letivo as p on p.ano_letivo = '2024' and p.semestre = '1' and p.id_horario = h.id_horario;

select p.nome from Professor as p inner join Disciplina as d on d.id_disciplina = 2 and p.id_disciplina = d.id_disciplina;

select nome, especialidade from Professor;

select nome, localizacao from Sala where localizacao = 'bloco a';

select nome, carga_horaria from Disciplina;

select p.nome, d.nome from Professor as p inner join Disciplina as d on p.id_disciplina = d.id_disciplina;











