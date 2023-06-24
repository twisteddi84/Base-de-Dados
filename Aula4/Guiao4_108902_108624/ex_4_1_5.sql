create table conferencias4.Instituicao(
	nome varchar(40) not null,
	endereco varchar(40) not null,
	constraint PK_Instituicao primary key(nome)
)
go

create table conferencias4.Participante(
	nome varchar(40) not null,
	email varchar(40) not null,
	data_inscricao date not null,
	morada varchar(40) not null,
	nome_instituicao varchar(40) not null,
	constraint PK_Participante primary key(nome),
	constraint FK_ParticipanteInstituicao foreign key(nome_instituicao) references conferencias4.Instituicao(nome)
)
go

create table conferencias4.Conferencias(
	codigo_conferencia varchar(40) not null,
	constraint PK_Conferencias primary key(codigo_conferencia)
)
go

create table conferencias4.Estudante(
	nome_participante varchar(40) not null,
	custo_inscricao smallint null,
	comprovativo bit null,
	constraint FK_EstudanteParticipante foreign key(nome_participante) references conferencias4.Participante(nome)
)
go

create table conferencias4.NaoEstudante(
	nome_participante varchar(40) not null,
	referencia_transferencia_bancaria int not null,
	constraint FK_NaoEstudanteParticipante foreign key(nome_participante) references conferencias4.Participante(nome)
)
go

create table conferencias4.Comprovativos(
	id int identity(1,1) not null,
	nome_instituicao varchar(40) not null,
	localizacao_eletronica varchar(40) not null,
	constraint PK_Comprovativos primary key(id),
	constraint FK_ComprovativoInstituicao foreign key(nome_instituicao) references conferencias4.Instituicao(nome)
)
go
create table conferencias4.Autor(
	nome varchar(40) not null,
	email varchar(40) not null,
	nome_instituicao varchar(40) not null,
	constraint PK_Autor primary key(nome),
	constraint FK_AutorInstituicao foreign key(nome_instituicao) references conferencias4.Instituicao(nome)
)
go

create table conferencias4.Artigos_Cientificos(
	numero_artigo int not null,
	titulo varchar(40) not null,
	codigo_conferencia varchar(40) not null,
	nome_autor varchar(40) not null,
	constraint PK_Artigos_Cientificos primary key(numero_artigo),
	constraint FK_ArtigoConferencia foreign key(codigo_conferencia) references conferencias4.Conferencias(codigo_conferencia),
	constraint FK_ArtigoAutor foreign key(nome_autor) references conferencias4.autor(nome)
)
go