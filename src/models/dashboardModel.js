const database = require("../database/config");

function buscarMaiorPontuacao(idUsuario) {
  const instrucao = `SELECT MAX(pontuacao) AS maiorPontuacao FROM resultadoQuiz WHERE fkUsuario = ${idUsuario};`;
  return database.executar(instrucao);
}

function buscarGeneroFavorito(idUsuario) {
  const instrucao = `
    SELECT fkGeneroFavorito
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
    SELECT DATE_FORMAT(dataQuiz, '%d/%m/%Y %h:%m') AS dataQuiz, pontuacao
    FROM resultadoQuiz 
    WHERE fkUsuario = ${idUsuario}
    ORDER BY dataQuiz DESC
    LIMIT 7;
  `;
  return database.executar(instrucao);
}

module.exports = {
  buscarMaiorPontuacao,
  buscarGeneroFavorito,
  buscarQuantidadeQuizzes,
  buscarPontuacoesQuiz
}
