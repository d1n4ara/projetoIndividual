CREATE DATABASE entreLinhas;

USE entreLinhas;

-- GÊNERO
CREATE TABLE genero (
    idGenero INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
);

-- USUÁRIO
CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    senha VARCHAR(100),
    pontos INT DEFAULT 0,
    nivel INT DEFAULT 1,
    fkGeneroFavorito INT,
    FOREIGN KEY (fkGeneroFavorito) REFERENCES genero(idGenero)
);

-- POSTAGEM
CREATE TABLE postagem (
    idPostagem INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    descricao VARCHAR(150),
    data_postagem DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkUsuario INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- LIVRO (coluna "genero" REMOVIDA)
CREATE TABLE livro (
    idLivro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    autor VARCHAR(100),
    genero VARCHAR(50),
    descricao VARCHAR(300),
    fkGenero INT,
    FOREIGN KEY (fkGenero) REFERENCES genero(idGenero)
);

-- LIVRO FAVORITO
CREATE TABLE livroFavorito (
    idLivroFavorito INT PRIMARY KEY AUTO_INCREMENT,
    fkUsuario INT,
    fkLivro INT,
    data_favorito DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkLivro) REFERENCES livro(idLivro)
);

-- INTERAÇÃO DE LEITURA
CREATE TABLE interacao (
    idInteracao INT PRIMARY KEY AUTO_INCREMENT,
    porcentagem_lida DECIMAL(5,2),
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkUsuario INT,
    fkLivro INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkLivro) REFERENCES livro(idLivro)
);

-- QUIZ
CREATE TABLE quiz (
    idQuiz INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('conhecimento', 'recomendacao') NOT NULL
);

-- PERGUNTAS DO QUIZ
CREATE TABLE perguntaQuiz (
    idPergunta INT PRIMARY KEY AUTO_INCREMENT,
    texto VARCHAR(255) NOT NULL,
    ordem INT NOT NULL,
    fkQuiz INT,
    FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz)
);

-- RESPOSTAS DO QUIZ
CREATE TABLE respostaQuiz (
    idResposta INT PRIMARY KEY AUTO_INCREMENT,
    texto VARCHAR(255) NOT NULL,
    valor VARCHAR(50) NOT NULL, -- usado para calcular o resultado
    ordem INT NOT NULL,
    fkPergunta INT,
    FOREIGN KEY (fkPergunta) REFERENCES perguntaQuiz(idPergunta)
);

-- RESULTADOS DO QUIZ (relaciona padrões de resposta com livros)
CREATE TABLE resultadoQuiz (
    idResultado INT PRIMARY KEY AUTO_INCREMENT,
    padraoRespostas VARCHAR(255) NOT NULL, -- formato: "valor1,valor2,valor3"
    fkQuiz INT,
    fkLivro INT,
    FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz),
    FOREIGN KEY (fkLivro) REFERENCES livro(idLivro)
);

-- HISTÓRICO DE QUIZ DOS USUÁRIOS
CREATE TABLE historicoQuiz (
    idHistorico INT PRIMARY KEY AUTO_INCREMENT,
    dataRealizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkUsuario INT,
    fkQuiz INT,
    fkLivroRecomendado INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz),
    FOREIGN KEY (fkLivroRecomendado) REFERENCES livro(idLivro)
);

CREATE TABLE respostaUsuario (
  idRespostaUsuario INT AUTO_INCREMENT PRIMARY KEY,
  fkUsuario INT NOT NULL,
  fkRespostaQuiz INT NOT NULL,
  dataResposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
  FOREIGN KEY (fkRespostaQuiz) REFERENCES respostaQuiz(idResposta)
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

INSERT INTO livro (titulo, autor, genero, descricao, fkGenero) VALUES
('A Culpa é das Estrelas', 'John Green', 'Romance', 'Dois adolescentes com câncer vivem uma história de amor.', 1),
('A Seleção', 'Kiera Cass', 'Romance', 'Uma competição por amor e poder em uma monarquia futurista.', 1),
('Me Chame Pelo Seu Nome', 'André Aciman', 'Romance', 'Um verão inesquecível na Itália e um romance intenso.', 1),
('O Visconde que Me Amava', 'Julia Quinn', 'Romance', 'Um romance de época da série Bridgerton.', 1),
('Como Eu Era Antes de Você', 'Jojo Moyes', 'Romance', 'Uma cuidadora transforma a vida de um homem tetraplégico.', 1);

-- MISTÉRIO (fk_genero = 2)
INSERT INTO livro (titulo, autor, genero, descricao, fkGenero) VALUES
('A Rainha Vermelha', 'Victoria Aveyard', 'Mistério', 'Uma jovem descobre poderes em uma sociedade dividida por sangue.', 2),
('E Não Sobrou Nenhum', 'Agatha Christie', 'Mistério', 'Dez estranhos presos em uma ilha com segredos mortais.', 2),
('Misery', 'Stephen King', 'Mistério', 'Um autor sequestrado por sua fã número um.', 2),
('O Homem de Giz', 'C. J. Tudor', 'Mistério', 'Um grupo de amigos se envolve com assassinatos e segredos.', 2),
('A Paciente Silenciosa', 'Alex Michaelides', 'Mistério', 'Uma mulher que comete um crime brutal e para de falar.', 2);

-- FANTASIA (fk_genero = 3)
INSERT INTO livro (titulo, autor, genero, descricao, fkGenero) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'Fantasia', 'Uma jornada épica para destruir o Um Anel.', 3),
('As Crônicas de Nárnia', 'C.S. Lewis', 'Fantasia', 'Crianças descobrem um mundo mágico através de um guarda-roupa.', 3),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Fantasia', 'Um garoto bruxo descobre seu destino em Hogwarts.', 3),
('Trono de Vidro', 'Sarah J. Maas', 'Fantasia', 'Uma assassina luta por sua liberdade e um trono.', 3),
('Alice no País das Maravilhas', 'Lewis Carroll', 'Fantasia', 'Uma garota cai na toca de um coelho e entra em um mundo estranho.', 3);

-- FICÇÃO (fk_genero = 4)
INSERT INTO livro (titulo, autor, genero, descricao, fkGenero) VALUES
('O Guia do Mochileiro das Galáxias', 'Douglas Adams', 'Ficção', 'Aventura absurda no espaço com um humano e seu amigo alien.', 4),
('1984', 'George Orwell', 'Ficção', 'Um futuro distópico de vigilância e controle totalitário.', 4),
('Fahrenheit 451', 'Ray Bradbury', 'Ficção', 'Uma sociedade onde livros são proibidos e queimados.', 4),
('Bird Box', 'Josh Malerman', 'Ficção', 'Uma força invisível leva pessoas à loucura e ao suicídio.', 4),
('Eu, Robô', 'Isaac Asimov', 'Ficção', 'Contos sobre as leis da robótica e dilemas éticos.', 4);

-- SUSPENSE E TERROR (fk_genero = 5)
INSERT INTO livro (titulo, autor, genero, descricao, fkGenero) VALUES
('It: A Coisa', 'Stephen King', 'Suspense e Terror', 'Um grupo enfrenta um ser aterrorizante que muda de forma.', 5),
('O Rei da Terra do Nunca', 'Stephen King', 'Suspense e Terror', 'Terror psicológico envolvendo infância e monstros.', 5),
('A Estrada da Noite', 'Joe Hill', 'Suspense e Terror', 'Um colecionador de objetos macabros compra um terno assombrado.', 5),
('O Corvo e Outras Histórias', 'Edgar Allan Poe', 'Suspense e Terror', 'Contos sombrios com horror psicológico.', 5),
('O Cemitério', 'Stephen King', 'Suspense e Terror', 'Uma família descobre um cemitério com poderes sombrios.', 5);

-- Inserir um quiz de recomendação
INSERT INTO quiz (nome, tipo) VALUES ('Quiz de Recomendação Literária', 'recomendacao');

-- Inserir perguntas
INSERT INTO perguntaQuiz (texto, ordem, fkQuiz) VALUES 
('Qual seu tipo de leitura preferida?', 1, 1),
('Como você gosta que suas histórias terminem?', 2, 1),
('Qual ambiente você prefere?', 3, 1);

-- Inserir respostas para a primeira pergunta
INSERT INTO respostaQuiz (texto, valor, ordem, fkPergunta) VALUES 
('Romances emocionantes', 'romance', 1, 1),
('Mistérios intrigantes', 'misterio', 2, 1),
('Aventuras fantásticas', 'fantasia', 3, 1),
('Ficção científica', 'ficcao', 4, 1),
('Histórias assustadoras', 'terror', 5, 1);

-- Respostas para a segunda pergunta
INSERT INTO respostaQuiz (texto, valor, ordem, fkPergunta) VALUES 
('Felizes para sempre', 'feliz', 1, 2),
('Com um grande mistério resolvido', 'misterio', 2, 2),
('Com uma reviravolta inesperada', 'reviravolta', 3, 2),
('Deixando perguntas no ar', 'aberto', 4, 2),
('Com um final sombrio', 'sombrio', 5, 2);

-- Respostas para a terceira pergunta
INSERT INTO respostaQuiz (texto, valor, ordem, fkPergunta) VALUES 
('Ambientes românticos', 'romantico', 1, 3),
('Cidades misteriosas', 'cidade', 2, 3),
('Mundos fantásticos', 'fantasia', 3, 3),
('Futuros distópicos', 'futuro', 4, 3),
('Lugares assustadores', 'terror', 5, 3);

-- Exemplo de resultados (padrões de resposta -> livro)
-- Padrão: romance, feliz, romantico -> Como Eu Era Antes de Você
INSERT INTO resultadoQuiz (padraoRespostas, fkQuiz, fkLivro) VALUES 
('romance,feliz,romantico', 1, 5),
('misterio,misterio,cidade', 1, 7),
('fantasia,reviravolta,fantasia', 1, 11),
('ficcao,aberto,futuro', 1, 16),
('terror,sombrio,terror', 1, 21);

SELECT * FROM usuario;