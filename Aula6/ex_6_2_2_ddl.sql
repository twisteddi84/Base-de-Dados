CREATE TABLE tipo_fornecedor (
  codigo INTEGER PRIMARY KEY,
  designacao VARCHAR(50) NOT NULL
);

CREATE TABLE fornecedor (
  nif INTEGER PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  fax VARCHAR(20),
  endereco VARCHAR(100),
  condpag INTEGER NOT NULL,
  tipo INTEGER NOT NULL,
  FOREIGN KEY (tipo) REFERENCES tipo_fornecedor(codigo)
);

CREATE TABLE produto (
  codigo INTEGER PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  preco DECIMAL(5,2) NOT NULL,
  iva INTEGER NOT NULL,
  unidades INTEGER NOT NULL
);

CREATE TABLE encomenda (
  numero INT PRIMARY KEY,
  data DATE,
  fornecedor INT,
  FOREIGN KEY (fornecedor) REFERENCES fornecedor (nif)
);

CREATE TABLE item (
  numEnc INT,
  codProd INT,
  unidades INT,
  PRIMARY KEY (numEnc, codProd),
  FOREIGN KEY (numEnc) REFERENCES encomenda (numero),
  FOREIGN KEY (codProd) REFERENCES produto (codigo)
);