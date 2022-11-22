CREATE DATABASE `projetowasabi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE projetowasabi;

CREATE TABLE cliente (
  cpf varchar(11) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(45) NOT NULL,
  endereco varchar(150),
  telefone varchar(20) not null,
  numeroCartao varchar(20) not null,
  PRIMARY KEY (cpf),
  UNIQUE INDEX email_UNIQUE (email ASC) VISIBLE,
  UNIQUE INDEX cpf_UNIQUE (cpf ASC) VISIBLE);
  
CREATE TABLE cardapio (
  tipo int NOT NULL,
  nome varchar(80) NOT NULL,
  PRIMARY KEY (tipo),
  UNIQUE KEY nome_UNIQUE (nome),
  UNIQUE KEY tipo_UNIQUE (tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
  
  CREATE TABLE produto (
  idProduto INT NOT NULL auto_increment,
  nome VARCHAR(80) NOT NULL,
  preco double NOT NULL,
  descricao VARCHAR(250) NULL,
  tipoProduto int not null,
  PRIMARY KEY (idProduto),
  UNIQUE INDEX idProduto_UNIQUE (idProduto ASC) VISIBLE,
  constraint FK_ProdutoCardapio foreign key (tipoProduto) references cardapio(tipo)
  );
  
  CREATE TABLE loginusuario (
  cpf_cliente varchar(11) NOT NULL,
  senha varchar(8) NOT NULL,
  PRIMARY KEY (cpf_cliente),
  UNIQUE KEY cpf_UNIQUE (cpf_cliente),
  CONSTRAINT FK_LoginCliente FOREIGN KEY (cpf_cliente) REFERENCES cliente (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table pedido (
	idPedido int not Null AUTO_INCREMENT UNIQUE KEY,
    cpfCliente varchar(11) not null,
    `nomeCliente` varchar(45) NOT NULL,
    constraint FK_PedidoCliente foreign key (cpfCliente) references cliente(cpf)
);

CREATE TABLE itens_do_pedido (
  idItem int NOT NULL,
  idPedido int NOT NULL,
  idProduto int NOT NULL,
  PRIMARY KEY (idItem),
  constraint FK_ItemPedido foreign key (idPedido) references pedido(idPedido),
  constraint FK_ItemProduto foreign key (idProduto) references produto(idProduto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE sacola (
  cpfCliente varchar(100) NOT NULL,
  idProduto int NOT NULL,
  NomeProduto varchar(100) NOT NULL,
  preco double not null,
  constraint FK_SacolaCliente foreign key (cpfCliente) references cliente(cpf),
  constraint FK_SacolaProduto foreign key (idProduto) references produto(idProduto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `produtos_sacola` (
  `ProdutoSacolaID` double NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL,
  `ativo` int NOT NULL,
  PRIMARY KEY (`ProdutoSacolaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

alter table sacola change idItem idItem int not null auto_increment;