CREATE DATABASE entreLinhas;

USE entreLinhas;

CREATE TABLE genero (
	id INT PRIMARY KEY AUTO_INCREMENT
    , nome VARCHAR(50)
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT
    , nome VARCHAR(50)
    , email VARCHAR(50)
    , senha VARCHAR(50)
    , pontos INT default 0
    , nivel INT default 1
    , fk_genero_favorito INT
    , FOREIGN KEY (fk_genero_favorito) REFERENCES genero(id)
);

CREATE TABLE postagem (
	id INT PRIMARY KEY AUTO_INCREMENT
    , titulo VARCHAR(100)
    , descricao VARCHAR(150)
    , data_postagem DATETIME default current_timestamp
    , fk_usuario INT
	, FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
);

create table livro (
	id INT PRIMARY KEY AUTO_INCREMENT
    , titulo VARCHAR(100)
    , autor VARCHAR(100)
    , genero VARCHAR(50)
    , descricao VARCHAR(300) 
    , fk_genero INT
    , FOREIGN KEY (fk_genero) REFERENCES genero(id)
);

CREATE TABLE livro_favorito (
	id INT PRIMARY KEY AUTO_INCREMENT
    , fk_usuario INT
    , fk_livro INT
    , data_favorito DATETIME DEFAULT CURRENT_TIMESTAMP
    , FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
    , FOREIGN KEY (fk_livro) REFERENCES livro(id)
);

create table interacao (
	id INT PRIMARY KEY AUTO_INCREMENT
    , porcentagem_lida DECIMAL(5,2)
    , data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
    , fk_usuario INT
    , fk_livro INT
    , FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
    , FOREIGN KEY (fk_livro) REFERENCES livro(id)
);

-- Inserindo gênero
INSERT INTO genero (nome) VALUES 
	('Romance')
    , ('Mistério')
    , ('Fantasia')
    , ('Ficção')
    , ('Suspense e Terror');

-- Inserindo livro, associando ao gênero "Romance" (id = 1)
-- ROMANCE (fk_genero = 1)
INSERT INTO livro (titulo, autor, genero, descricao, fk_genero) VALUES
('A Culpa é das Estrelas', 'John Green', 'Romance', 'Dois adolescentes com câncer vivem uma história de amor.', 1),
('A Seleção', 'Kiera Cass', 'Romance', 'Uma competição por amor e poder em uma monarquia futurista.', 1),
('Me Chame Pelo Seu Nome', 'André Aciman', 'Romance', 'Um verão inesquecível na Itália e um romance intenso.', 1),
('O Visconde que Me Amava', 'Julia Quinn', 'Romance', 'Um romance de época da série Bridgerton.', 1),
('Como Eu Era Antes de Você', 'Jojo Moyes', 'Romance', 'Uma cuidadora transforma a vida de um homem tetraplégico.', 1);
-- MISTÉRIO (fk_genero = 2)
INSERT INTO livro (titulo, autor, genero, descricao, fk_genero) VALUES
('A Rainha Vermelha', 'Victoria Aveyard', 'Mistério', 'Uma jovem descobre poderes em uma sociedade dividida por sangue.', 2),
('E Não Sobrou Nenhum', 'Agatha Christie', 'Mistério', 'Dez estranhos presos em uma ilha com segredos mortais.', 2),
('Misery', 'Stephen King', 'Mistério', 'Um autor sequestrado por sua fã número um.', 2),
('O Homem de Giz', 'C. J. Tudor', 'Mistério', 'Um grupo de amigos se envolve com assassinatos e segredos.', 2),
('A Paciente Silenciosa', 'Alex Michaelides', 'Mistério', 'Uma mulher que comete um crime brutal e para de falar.', 2);

-- FANTASIA (fk_genero = 3)
INSERT INTO livro (titulo, autor, genero, descricao, fk_genero) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'Fantasia', 'Uma jornada épica para destruir o Um Anel.', 3),
('As Crônicas de Nárnia', 'C.S. Lewis', 'Fantasia', 'Crianças descobrem um mundo mágico através de um guarda-roupa.', 3),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Fantasia', 'Um garoto bruxo descobre seu destino em Hogwarts.', 3),
('Trono de Vidro', 'Sarah J. Maas', 'Fantasia', 'Uma assassina luta por sua liberdade e um trono.', 3),
('Alice no País das Maravilhas', 'Lewis Carroll', 'Fantasia', 'Uma garota cai na toca de um coelho e entra em um mundo estranho.', 3);

-- FICÇÃO (fk_genero = 4)
INSERT INTO livro (titulo, autor, genero, descricao, fk_genero) VALUES
('O Guia do Mochileiro das Galáxias', 'Douglas Adams', 'Ficção', 'Aventura absurda no espaço com um humano e seu amigo alien.', 4),
('1984', 'George Orwell', 'Ficção', 'Um futuro distópico de vigilância e controle totalitário.', 4),
('Fahrenheit 451', 'Ray Bradbury', 'Ficção', 'Uma sociedade onde livros são proibidos e queimados.', 4),
('Bird Box', 'Josh Malerman', 'Ficção', 'Uma força invisível leva pessoas à loucura e ao suicídio.', 4),
('Eu, Robô', 'Isaac Asimov', 'Ficção', 'Contos sobre as leis da robótica e dilemas éticos.', 4);

-- SUSPENSE E TERROR (fk_genero = 5)
INSERT INTO livro (titulo, autor, genero, descricao, fk_genero) VALUES
('It: A Coisa', 'Stephen King', 'Suspense e Terror', 'Um grupo enfrenta um ser aterrorizante que muda de forma.', 5),
('O Rei da Terra do Nunca', 'Stephen King', 'Suspense e Terror', 'Terror psicológico envolvendo infância e monstros.', 5),
('A Estrada da Noite', 'Joe Hill', 'Suspense e Terror', 'Um colecionador de objetos macabros compra um terno assombrado.', 5),
('O Corvo e Outras Histórias', 'Edgar Allan Poe', 'Suspense e Terror', 'Contos sombrios com horror psicológico.', 5),
('O Cemitério', 'Stephen King', 'Suspense e Terror', 'Uma família descobre um cemitério com poderes sombrios.', 5);


