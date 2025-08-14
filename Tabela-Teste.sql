create database supermercadoMix;
use supermercadoMix;
-- drop database supermercadoMix; comando para apagar o banco de dados
create table Endereco(
CEP varchar(8) not null,
LOGRADOURO varchar(100) not null,
Bairro varchar(50) not null,
Cidade varchar(50),
UF enum("BA", "RJ", "SP"),
PAIS varchar(50));

create table Fornecedor(
CNPJ varchar(15) primary key not null,
NomeFantasia varchar(100) not null,
RazaoSocial varchar(100) not null,
TipoFornecedor varchar(100) not null,
InscricaoEstadual varchar(100) unique,
Telefone varchar(11) not null,
Email varchar(100),
Representante varchar(100) not null,
FreteMin int,
RAMAL varchar(10), 
SITE varchar(100) unique,
DataCadastro date,
CEP varchar(8) not null,
Endereco varchar(100) not null);

create table Funcionario(
RA varchar(20) primary key not null, 
Nome varchar(100) not null, 
Idade varchar(2) not null, 
DataAdmissao date not null,
CPF varchar(11) unique not null, 
CEP varchar(8) not null, 
RG varchar(10) unique not null, 
Telefone varchar(11), 
EmailTrabalho varchar(100) not null, 
Salario real, 
ContaBancaria varchar(20) not null,
FOREIGN KEY(CEP) REFERENCES Endereco(CEP));

create table Produto(
CodigoBarra varchar(25) primary key not null,
Categoria varchar(50) not null,
Marca varchar(50) not null, 
ValorVenda double not null default 0.0,
ValorCompra double not null default 0.0,
Quantidade int not null, 
Estoque int not null,
Fornecedor varchar(100),
Descricao varchar(100),
Montante double not null ,
Subcategoria varchar(50), 
DataValidade date,
Lote varchar(10), 
CNPJ varchar(15) unique not null,

FOREIGN KEY(CNPJ) REFERENCES Fornecedor(CNPJ));

create table Venda(
CodVenda varchar(50) primary key not null,
RA varchar(20) unique not null, 
DataVenda date,
ValorVenda double not null, 

FOREIGN KEY(RA) REFERENCES Funcionario(RA));
