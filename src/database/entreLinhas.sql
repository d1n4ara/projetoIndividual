CREATE DATABASE entreLinhas;

USE entreLinhas;

-- GÊNERO
CREATE TABLE genero (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50)
);

-- USUÁRIO
CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT
    , nome VARCHAR(50)
    , email VARCHAR(50)
    , senha VARCHAR(50)
    , pontos INT default 0
    , nivel INT default 1
    , fkGeneroFavorito INT
    , FOREIGN KEY (fkGeneroFavorito) REFERENCES genero(id)
);

-- PERFIL (1:1 com USUÁRIO)
CREATE TABLE perfil (
	id INT PRIMARY KEY AUTO_INCREMENT,
	bio TEXT,
	fotoPerfil VARCHAR(255),
	fkUsuario INT UNIQUE, -- garante 1:1
	FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- POSTAGEM (1:N com USUÁRIO)
CREATE TABLE postagem (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(100),
	descricao VARCHAR(150),
	dataPostagem DATETIME DEFAULT CURRENT_TIMESTAMP,
	fkUsuario INT,
	FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- LIVRO
create table livro (
	id INT PRIMARY KEY AUTO_INCREMENT
    , titulo VARCHAR(100)
    , autor VARCHAR(100)
    , genero VARCHAR(50)
    , descricao VARCHAR(300) 
    , fkGenero INT
    , FOREIGN KEY (fkGenero) REFERENCES genero(id)
);

-- LIVRO FAVORITO (N:N entre USUÁRIO e LIVRO)
CREATE TABLE livro_favorito (
	id INT PRIMARY KEY AUTO_INCREMENT,
	fkUsuario INT,
	fkLivro INT,
	dataFavorito DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (fkUsuario) REFERENCES usuario(usuario),
	FOREIGN KEY (fkLivro) REFERENCES livro(id)
); 

-- INTERAÇÃO (N:N disfarçado — permite múltiplos registros por usuário/livro)
CREATE TABLE interacao (
	id INT PRIMARY KEY AUTO_INCREMENT,
	porcentagemLida DECIMAL(5,2),
	dataAtualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
	fkUsuario INT,
	fkLivro INT,
	FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
	FOREIGN KEY (fkLivro) REFERENCES livro(id)
);

INSERT INTO genero (nome) VALUES 
	('Romance'),
	('Mistério'),
	('Fantasia'),
	('Ficção'),
	('Suspense e Terror');

-- LIVROS (Agrupados por fk_genero)
-- ROMANCE (fk_genero = 1)
INSERT INTO livro (titulo, autor, descricao, fkGenero) VALUES
('A Culpa é das Estrelas', 'John Green', 'Dois adolescentes com câncer vivem uma história de amor.', 1),
('A Seleção', 'Kiera Cass', 'Uma competição por amor e poder em uma monarquia futurista.', 1),
('Me Chame Pelo Seu Nome', 'André Aciman', 'Um verão inesquecível na Itália e um romance intenso.', 1),
('O Visconde que Me Amava', 'Julia Quinn', 'Um romance de época da série Bridgerton.', 1),
('Como Eu Era Antes de Você', 'Jojo Moyes', 'Uma cuidadora transforma a vida de um homem tetraplégico.', 1);

-- MISTÉRIO (fk_genero = 2)
INSERT INTO livro (titulo, autor, descricao, fkGenero) VALUES
('A Rainha Vermelha', 'Victoria Aveyard', 'Uma jovem descobre poderes em uma sociedade dividida por sangue.', 2),
('E Não Sobrou Nenhum', 'Agatha Christie', 'Dez estranhos presos em uma ilha com segredos mortais.', 2),
('Misery', 'Stephen King', 'Um autor sequestrado por sua fã número um.', 2),
('O Homem de Giz', 'C. J. Tudor', 'Um grupo de amigos se envolve com assassinatos e segredos.', 2),
('A Paciente Silenciosa', 'Alex Michaelides', 'Uma mulher que comete um crime brutal e para de falar.', 2);

-- FANTASIA (fk_genero = 3)
INSERT INTO livro (titulo, autor, descricao, fkGenero) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'Uma jornada épica para destruir o Um Anel.', 3),
('As Crônicas de Nárnia', 'C.S. Lewis', 'Crianças descobrem um mundo mágico através de um guarda-roupa.', 3),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Um garoto bruxo descobre seu destino em Hogwarts.', 3),
('Trono de Vidro', 'Sarah J. Maas', 'Uma assassina luta por sua liberdade e um trono.', 3),
('Alice no País das Maravilhas', 'Lewis Carroll', 'Uma garota cai na toca de um coelho e entra em um mundo estranho.', 3);

-- FICÇÃO (fk_genero = 4)
INSERT INTO livro (titulo, autor, descricao, fkGenero) VALUES
('O Guia do Mochileiro das Galáxias', 'Douglas Adams', 'Aventura absurda no espaço com um humano e seu amigo alien.', 4),
('1984', 'George Orwell', 'Um futuro distópico de vigilância e controle totalitário.', 4),
('Fahrenheit 451', 'Ray Bradbury', 'Uma sociedade onde livros são proibidos e queimados.', 4),
('Bird Box', 'Josh Malerman', 'Uma força invisível leva pessoas à loucura e ao suicídio.', 4),
('Eu, Robô', 'Isaac Asimov', 'Contos sobre as leis da robótica e dilemas éticos.', 4);

-- SUSPENSE E TERROR (fk_genero = 5)
INSERT INTO livro (titulo, autor, descricao, fkGenero) VALUES
('It: A Coisa', 'Stephen King', 'Um grupo enfrenta um ser aterrorizante que muda de forma.', 5),
('O Rei da Terra do Nunca', 'Stephen King', 'Terror psicológico envolvendo infância e monstros.', 5),
('A Estrada da Noite', 'Joe Hill', 'Um colecionador de objetos macabros compra um terno assombrado.', 5),
('O Corvo e Outras Histórias', 'Edgar Allan Poe', 'Contos sombrios com horror psicológico.', 5),
('O Cemitério', 'Stephen King', 'Uma família descobre um cemitério com poderes sombrios.', 5);