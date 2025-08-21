create database supermercadoMix;
use supermercadoMix;
-- drop database supermercadoMix; comando para apagar o banco de dados

create table Endereco(
CEP varchar(8) primary key not null,
LOGRADOURO varchar(20),
local_ varchar(100),
Bairro varchar(50),
Cidade varchar(50),
UF enum("BA", "RJ", "SP"),
PAIS varchar(50)
);

create table Fornecedor(
CNPJ varchar(15) primary key not null,
NomeFantasia varchar(100),
RazaoSocial varchar(100),
TipoFornecedor varchar(100),
InscricaoEstadual varchar(100),
Telefone varchar(11),
Email varchar(100),
Representante varchar(100),
FreteMin int,
RAMAL varchar(10), 
SITE varchar(100) unique,
DataCadastro date,
CEP varchar(8),
Endereco varchar(100),

FOREIGN KEY(CEP) REFERENCES Endereco(CEP) on update cascade on delete restrict
);

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

FOREIGN KEY(CEP) REFERENCES Endereco(CEP) on update cascade on delete restrict
);

ALTER TABLE Funcionario ADD COLUMN Cargo VARCHAR(50);
 UPDATE Funcionario SET Cargo = 'Caixa' WHERE RA = 'F001'; 
 UPDATE Funcionario SET Cargo = 'Gerente' WHERE RA = 'F002'; 
 UPDATE Funcionario SET Cargo = 'Repositor' WHERE RA = 'F003';
 UPDATE Funcionario SET Cargo = 'Supervisora' WHERE RA = 'F004';

create table Produto(
CodBarra varchar(25) primary key not null,
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
CNPJ varchar(15) not null,

FOREIGN KEY(CNPJ) REFERENCES Fornecedor(CNPJ) on update cascade on delete restrict
);

create table Venda(
CodVenda int auto_increment primary key,
RA varchar(20), 
DataVenda date,
ValorVenda double not null, 

FOREIGN KEY(RA) REFERENCES Funcionario(RA) on update cascade on delete restrict
);

create table ItensVenda(
CodVenda int,
CodBarra varchar(25),
qtdVendida int,
subTotal real default(0),
foreign key(CodVenda) references Venda(CodVenda) on update cascade on delete restrict,
foreign key(CodBarra) references Produto(CodBarra) on update cascade on delete restrict,
primary key(CodVenda, CodBarra)
);

INSERT INTO Endereco (CEP, LOGRADOURO, local_, Bairro, Cidade, UF, PAIS)
VALUES
('40210700', 'Rua', 'Professor Severo Pessoa', 'Federação', 'Salvador', 'BA', 'Brasil'),
('40210090', 'Avenida', 'Garibaldi', 'Federação', 'Salvador', 'BA', 'Brasil'),
('48005135', 'Praça', 'Barão do Rio Branco', 'Centro', 'Alagoinhas', 'BA', 'Brasil'),
('47811003', 'Rua', 'Rua das Turbinas', 'Bela Vista', 'Barreiras', 'BA', 'Brasil'),
('42800605', 'Avenida', 'Jorge Amado', 'Loteamento Espaço Alpha', 'Camaçari', 'BA', 'Brasil');
                    
INSERT INTO Fornecedor
(CNPJ, NomeFantasia, RazaoSocial, TipoFornecedor, InscricaoEstadual, Telefone, Email, Representante, FreteMin, RAMAL, SITE, DataCadastro, CEP, Endereco)
VALUES
('12345678000199', 'Distribuidora Bahia', 'Distribuidora Bahia LTDA', 'Alimentos', 'BA123456', '71999999999', 'contato@distribuidorabahia.com', 'Carlos Mendes', 500, '101', 'www.distribuidorabahia.com', '2023-01-10', '40210700', 'Rua Professor Severo Pessoa'),
('98765432000188', 'Refrigerantes RJ', 'Refrigerantes Rio de Janeiro S/A', 'Bebidas', 'RJ987654', '21988888888', 'vendas@refrirj.com', 'Ana Souza', 300, '202', 'www.refrirj.com', '2023-02-15', '40210090', 'Avenida Garibaldi'),
('55566677000155', 'Produtos do Centro', 'Produtos do Centro ME', 'Mercearia', 'BA555666', '7533333333', 'atendimento@produtosdocentro.com', 'Paulo Lima', 200, '303', 'www.produtosdocentro.com', '2023-03-05', '48005135', 'Praça Barão do Rio Branco'); 

INSERT INTO Funcionario
(RA, Nome, Idade, DataAdmissao, CPF, CEP, RG, Telefone, EmailTrabalho, Salario, ContaBancaria)
VALUES
('F001', 'João Pereira', '30', '2022-05-10', '12345678901', '40210700', '112223334', '71911111111', 'joao.pereira@mix.com', 2500.00, '00012345-6'),
('F002', 'Maria Silva', '28', '2021-08-20', '98765432100', '40210090', '223334445', '71922222222', 'maria.silva@mix.com', 2800.00, '00067890-1'),
('F003', 'Carlos Santos', '35', '2020-02-01', '11122233344', '48005135', '334445556', '7533333333', 'carlos.santos@mix.com', 3000.00, '00011223-4');

INSERT INTO Funcionario
(RA, Nome, Idade, DataAdmissao, CPF, CEP, RG, Telefone, EmailTrabalho, Salario, ContaBancaria)
VALUES
('F004', 'Fernanda Oliveira', '26', '2023-11-15', '22233344455', '47811003', '445556667', '7594444444', 'fernanda.oliveira@mix.com', 2200.00, '00033445-7');

INSERT INTO Produto
(CodBarra, Categoria, Marca, ValorVenda, ValorCompra, Quantidade, Estoque, Fornecedor, Descricao, Montante, Subcategoria, DataValidade, Lote, CNPJ)
VALUES
('7891000054321', 'Bebida', 'Coca-Cola', 6.50, 4.00, 100, 100, 'Refrigerantes RJ', 'Refrigerante Coca-Cola 2L', 400.00, 'Refrigerante', '2024-12-31', 'L001', '98765432000188'),
('7892000076543', 'Alimento', 'Arroz Bahia', 25.00, 18.00, 50, 50, 'Distribuidora Bahia', 'Arroz Branco Tipo 1 - 5kg', 900.00, 'Grãos', '2025-05-10', 'L002', '12345678000199'),
('7893000098765', 'Mercearia', 'Feijão Centro', 8.50, 6.00, 80, 80, 'Produtos do Centro', 'Feijão Carioca Tipo 1 - 1kg', 480.00, 'Grãos', '2025-03-15', 'L003', '55566677000155');

INSERT INTO Venda
(RA, DataVenda, ValorVenda)
VALUES
('F001', '2025-08-01', 58.00),
('F002', '2025-08-02', 50.00),
('F003', '2025-08-03', 33.00);

INSERT INTO ItensVenda
(CodVenda, CodBarra, qtdVendida, subTotal)
VALUES
(1, '7892000076543', 2, 50.00), -- 2 x Arroz Bahia
(1, '7891000054321', 1, 6.50),  -- 1 x Coca-Cola
(2, '7893000098765', 5, 42.50), -- 5 x Feijão Centro
(3, '7891000054321', 2, 13.00); -- 2 x Coca-Cola

start transaction;
delete from Funcionario where RA = 'F004';
rollback; -- truncate table -> acabar com a tabela toda


