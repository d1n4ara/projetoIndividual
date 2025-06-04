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
    , descricao VARCHAR(300) 
    , fkGenero INT
    , FOREIGN KEY (fkGenero) REFERENCES genero(id)
);

CREATE TABLE questao (
    idQuestao INT PRIMARY KEY AUTO_INCREMENT,
    pergunta TEXT NOT NULL
);

CREATE TABLE alternativa (
    idAlternativa INT PRIMARY KEY AUTO_INCREMENT,
    texto VARCHAR(255) NOT NULL,
    isCorreta BOOLEAN NOT NULL,
    fkQuestao INT NOT NULL,
    FOREIGN KEY (fkQuestao) REFERENCES questao(idQuestao)
);

CREATE TABLE resposta (
    idResposta INT PRIMARY KEY AUTO_INCREMENT,
    fkUsuario INT NOT NULL,
    fkQuestao INT NOT NULL,
    fkAlternativa INT NOT NULL,
    dataResposta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkQuestao) REFERENCES questao(idQuestao),
    FOREIGN KEY (fkAlternativa) REFERENCES alternativa(idAlternativa)
);

CREATE TABLE resultadoQuiz (
    idResultado INT PRIMARY KEY AUTO_INCREMENT,
    fkUsuario INT NOT NULL,
    pontuacao INT NOT NULL,
    porcentagem DECIMAL(5,2) NOT NULL,
    dataQuiz DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
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

-- Tabela de perguntas
INSERT INTO questao (pergunta) VALUES
('Quem escreveu "Dom Casmurro"?'),
('Qual obra começa com a frase "Todas as famílias felizes se parecem, cada família infeliz é infeliz à sua maneira"?'),
('Quem é o autor de "Grande Sertão: Veredas"?'),
('Qual personagem é conhecido por viver num quarto de despejo em São Paulo?'),
('Quem escreveu a peça "O Auto da Compadecida"?');

-- Alternativas para pergunta 1
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Machado de Assis', TRUE, 1),
('José de Alencar', FALSE, 1),
('Clarice Lispector', FALSE, 1),
('Monteiro Lobato', FALSE, 1);

-- Alternativas para pergunta 2
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Liev Tolstói', TRUE, 2),
('Fiódor Dostoiévski', FALSE, 2),
('Anton Tchekhov', FALSE, 2),
('Franz Kafka', FALSE, 2);

-- Alternativas para pergunta 3
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('João Guimarães Rosa', TRUE, 3),
('Graciliano Ramos', FALSE, 3),
('Jorge Amado', FALSE, 3),
('Carlos Drummond de Andrade', FALSE, 3);

-- Alternativas para pergunta 4
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Carolina Maria de Jesus', TRUE, 4),
('Rachel de Queiroz', FALSE, 4),
('Maria Firmina dos Reis', FALSE, 4),
('Cecília Meireles', FALSE, 4);

-- Alternativas para pergunta 5
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Ariano Suassuna', TRUE, 5),
('Nelson Rodrigues', FALSE, 5),
('Dias Gomes', FALSE, 5),
('Machado de Assis', FALSE, 5);
