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
    senha VARCHAR(255),
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

-- LIVRO
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

-- QUIZ (simplificado)
CREATE TABLE quiz (
    idQuiz INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    descricao VARCHAR(300),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- QUESTÕES
CREATE TABLE questao (
    idQuestao INT PRIMARY KEY AUTO_INCREMENT,
    pergunta VARCHAR(300),
    fkQuiz INT,
    FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz)
);

-- ALTERNATIVAS
CREATE TABLE alternativa (
    idAlternativa INT PRIMARY KEY AUTO_INCREMENT,
    texto VARCHAR(300),
    isCorreta BOOLEAN,
    fkQuestao INT,
    FOREIGN KEY (fkQuestao) REFERENCES questao(idQuestao)
);

-- RESPOSTAS DOS USUÁRIOS (tabela única para registrar respostas)
CREATE TABLE respostaUsuario (
    idRespostaUsuario INT PRIMARY KEY AUTO_INCREMENT,
    fkUsuario INT,
    fkQuiz INT,
    fkQuestao INT,
    fkAlternativa INT,
    dataResposta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz),
    FOREIGN KEY (fkQuestao) REFERENCES questao(idQuestao),
    FOREIGN KEY (fkAlternativa) REFERENCES alternativa(idAlternativa)
);

-- RESULTADOS DO QUIZ (para estatísticas)
CREATE TABLE resultadoQuiz (
    idResultado INT PRIMARY KEY AUTO_INCREMENT,
    fkUsuario INT,
    fkQuiz INT,
    pontuacao INT,
    porcentagemAcertos DECIMAL(5,2),
    dataRealizacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkQuiz) REFERENCES quiz(idQuiz)
);

-- INSERÇÕES DE DADOS INICIAIS
INSERT INTO genero (nome) VALUES 
    ('Romance'),
    ('Mistério'),
    ('Fantasia'),
    ('Ficção Científica'),
    ('Suspense e Terror'),
    ('Literatura Brasileira'),
    ('Literatura Estrangeira');

-- LIVROS DE EXEMPLO (apenas alguns para o quiz)
INSERT INTO livro (titulo, autor, genero, descricao, fkGenero) VALUES
('Dom Casmurro', 'Machado de Assis', 'Literatura Brasileira', 'Clássico da literatura brasileira sobre ciúme e traição', 6),
('A Hora da Estrela', 'Clarice Lispector', 'Literatura Brasileira', 'Último romance da autora, sobre a vida de Macabéa', 6),
('O Cortiço', 'Aluísio Azevedo', 'Literatura Brasileira', 'Romance naturalista sobre a vida em um cortiço no Rio de Janeiro', 6),
('Memórias Póstumas de Brás Cubas', 'Machado de Assis', 'Literatura Brasileira', 'Narrado por um defunto autor, crítica à sociedade brasileira', 6),
('Grande Sertão: Veredas', 'Guimarães Rosa', 'Literatura Brasileira', 'Clássico da literatura brasileira com linguagem inovadora', 6),
('1984', 'George Orwell', 'Ficção Científica', 'Distopia sobre vigilância e controle totalitário', 4),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'Fantasia', 'Trilogia épica sobre a Terra Média e o Um Anel', 3);

-- INSERIR QUIZ DE LITERATURA
INSERT INTO quiz (titulo, descricao) VALUES 
('Quiz de Literatura Brasileira', 'Teste seus conhecimentos sobre os clássicos da literatura brasileira');

-- OBTER ID DO QUIZ INSERIDO
SET @idQuiz = LAST_INSERT_ID();

-- PERGUNTAS DO QUIZ
INSERT INTO questao (pergunta, fkQuiz) VALUES 
('Quem é o autor de "Dom Casmurro"?', @idQuiz),
('Qual destes livros foi escrito por Clarice Lispector?', @idQuiz),
('Qual é o movimento literário de "O Cortiço"?', @idQuiz),
('Quem é o narrador de "Memórias Póstumas de Brás Cubas"?', @idQuiz),
('Qual destes autores escreveu "Grande Sertão: Veredas"?', @idQuiz),
('Em que ano foi publicado "Dom Casmurro"?', @idQuiz),
('Qual destes NÃO é um livro de Machado de Assis?', @idQuiz),
('Qual é o tema principal de "O Cortiço"?', @idQuiz),
('Qual destes livros é considerado o marco inicial do Realismo no Brasil?', @idQuiz),
('Quem é o protagonista de "Dom Casmurro"?', @idQuiz);

-- ALTERNATIVAS PARA CADA QUESTÃO
-- Questão 1
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Machado de Assis', TRUE, 1),
('José de Alencar', FALSE, 1),
('Graciliano Ramos', FALSE, 1),
('Guimarães Rosa', FALSE, 1);

-- Questão 2
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('A Hora da Estrela', TRUE, 2),
('Vidas Secas', FALSE, 2),
('O Ateneu', FALSE, 2),
('Memórias Sentimentais de João Miramar', FALSE, 2);

-- Questão 3
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Naturalismo', TRUE, 3),
('Romantismo', FALSE, 3),
('Modernismo', FALSE, 3),
('Parnasianismo', FALSE, 3);

-- Questão 4
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Brás Cubas', TRUE, 4),
('Bentinho', FALSE, 4),
('Capitu', FALSE, 4),
('Quincas Borba', FALSE, 4);

-- Questão 5
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Guimarães Rosa', TRUE, 5),
('Carlos Drummond de Andrade', FALSE, 5),
('Jorge Amado', FALSE, 5),
('Érico Veríssimo', FALSE, 5);

-- Questão 6
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('1899', TRUE, 6),
('1880', FALSE, 6),
('1902', FALSE, 6),
('1875', FALSE, 6);

-- Questão 7
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('O Tempo e o Vento', TRUE, 7),
('Quincas Borba', FALSE, 7),
('Memórias Póstumas de Brás Cubas', FALSE, 7),
('Dom Casmurro', FALSE, 7);

-- Questão 8
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('A vida nos cortiços do Rio de Janeiro no século XIX', TRUE, 8),
('A escravidão no Brasil colonial', FALSE, 8),
('A imigração italiana em São Paulo', FALSE, 8),
('A guerra de Canudos', FALSE, 8);

-- Questão 9
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Memórias Póstumas de Brás Cubas', TRUE, 9),
('O Guarani', FALSE, 9),
('Iracema', FALSE, 9),
('Dom Casmurro', FALSE, 9);

-- Questão 10
INSERT INTO alternativa (texto, isCorreta, fkQuestao) VALUES
('Bentinho', TRUE, 10),
('Brás Cubas', FALSE, 10),
('Rubião', FALSE, 10),
('Riobaldo', FALSE, 10);

select * from usuario;