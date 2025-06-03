const database = require("../database/config");

function buscarFavoritos(idUsuario) {
  const instrucao = `SELECT COUNT(*) AS totalFavoritos FROM livro_favorito WHERE fkUsuario = ${idUsuario};`;
  return database.executar(instrucao);
}

function buscarMaiorPontuacao(idUsuario) {
  const instrucao = `SELECT MAX(pontuacao) AS maiorPontuacao FROM resultadoQuiz WHERE fkUsuario = ${idUsuario};`;
  return database.executar(instrucao);
}

function buscarGeneroFavorito(idUsuario) {
  const instrucao = `
    SELECT g.nome AS genero
    FROM usuario u
    LEFT JOIN genero g ON u.fkGeneroFavorito = g.id
    WHERE u.idUsuario = ${idUsuario};
  `;
  return database.executar(instrucao);
}


function buscarQuantidadeQuizzes(idUsuario) {
  const instrucao = `SELECT COUNT(*) AS totalQuizzes FROM resultadoQuiz WHERE fkUsuario = ${idUsuario};`;
  return database.executar(instrucao);
}

function buscarPontuacoesQuiz(idUsuario) {
  const instrucao = `
    SELECT DATE_FORMAT(dataQuiz, '%d/%m') AS dataQuiz, pontuacao
    FROM resultadoQuiz 
    WHERE fkUsuario = ${idUsuario}
    ORDER BY dataQuiz DESC
    LIMIT 7;
  `;
  return database.executar(instrucao);
}

function buscarFavoritosPorGenero(idUsuario) {
  const instrucao = `
    SELECT genero, COUNT(*) AS total 
    FROM livro_favorito 
    JOIN livro ON livro_favorito.fkLivro = livro.id 
    WHERE livro_favorito.fkUsuario = ${idUsuario}
    GROUP BY genero;
  `;
  return database.executar(instrucao);
}

module.exports = {
  buscarFavoritos,
  buscarMaiorPontuacao,
  buscarGeneroFavorito,
  buscarQuantidadeQuizzes,
  buscarPontuacoesQuiz,
  buscarFavoritosPorGenero
};
