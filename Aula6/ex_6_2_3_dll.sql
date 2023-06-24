CREATE TABLE medico (
  numSNS INT PRIMARY KEY,
  nome VARCHAR(50),
  especialidade VARCHAR(50)
);

CREATE TABLE paciente (
  numUtente INT PRIMARY KEY,
  nome VARCHAR(50),
  dataNasc DATE,
  endereco VARCHAR(100)
);

CREATE TABLE farmacia (
  nome VARCHAR(50) PRIMARY KEY,
  telefone INT,
  endereco VARCHAR(100)
);

CREATE TABLE farmaceutica (
  numReg INT PRIMARY KEY,
  nome VARCHAR(50),
  endereco VARCHAR(100)
);

CREATE TABLE farmaco (
  numRegFarm INT,
  nome VARCHAR(50),
  formula VARCHAR(50),
  PRIMARY KEY (numRegFarm, nome),
  FOREIGN KEY (numRegFarm) REFERENCES farmaceutica(numReg)
);

CREATE TABLE prescricao (
  numPresc INT PRIMARY KEY,
  numUtente INT,
  numMedico INT,
  farmacia VARCHAR(50),
  dataProc DATE,
  FOREIGN KEY (numUtente) REFERENCES paciente(numUtente),
  FOREIGN KEY (numMedico) REFERENCES medico(numSNS),
  FOREIGN KEY (farmacia) REFERENCES farmacia(nome)
);

CREATE TABLE presc_farmaco (
  numPresc INT,
  numRegFarm INT,
  nomeFarmaco VARCHAR(50),
  PRIMARY KEY (numPresc, numRegFarm, nomeFarmaco),
  FOREIGN KEY (numPresc) REFERENCES prescricao(numPresc),
  FOREIGN KEY (numRegFarm, nomeFarmaco) REFERENCES farmaco(numRegFarm, nome)
);