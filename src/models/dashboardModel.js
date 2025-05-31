const db = require('../database/config');

module.exports = {
  async obterKPIs(idUsuario) {
    const sql = `
      SELECT 
        (SELECT COUNT(*) FROM interacao WHERE fkUsuario = ${idUsuario} AND porcentagem_lida = 100) AS livrosLidos,
        (SELECT COUNT(*) FROM interacao WHERE fkUsuario = ${idUsuario} AND MONTH(data_atualizacao) = MONTH(CURDATE())) AS paginasPorMes,
        (SELECT COUNT(*) FROM livroFavorito WHERE fkUsuario = ${idUsuario}) AS favoritos,
        (SELECT pontos FROM usuario WHERE idUsuario = ${idUsuario}) AS pontuacao
    `;

    const resultados = await db.executar(sql);
    const dados = resultados[0];

    const pontuacao = dados.pontuacao || 0;
    const nivel = pontuacao >= 1000 ? "📘 Avançado"
      : pontuacao >= 500 ? "📗 Intermediário"
        : "📕 Iniciante";

    return {
      livrosLidos: dados.livrosLidos || 0,
      paginasPorMes: dados.paginasPorMes || 0,
      favoritos: dados.favoritos || 0,
      pontuacao,
      nivel
    };
  },

  async obterGenerosLidos(idUsuario) {
    const sql = `
      SELECT g.nome AS genero, COUNT(*) AS total
      FROM interacao i
      JOIN livro l ON i.fkLivro = l.idLivro
      JOIN genero g ON l.fkGenero = g.idGenero
      WHERE i.fkUsuario = ${idUsuario} AND i.porcentagem_lida = 100
      GROUP BY g.nome
    `;
    const resultados = await db.executar(sql);
    return resultados;
  },

  async obterQuiz(idUsuario) {
    const sql = `
     SELECT 
      SUM(CASE WHEN a.isCorreta = 1 THEN 1 ELSE 0 END) AS certas,
      SUM(CASE WHEN a.isCorreta = 0 THEN 1 ELSE 0 END) AS erradas
    FROM respostaUsuario ru
    JOIN alternativa a ON ru.fkAlternativa = a.idAlternativa
      WHERE ru.fkUsuario = 1

    `;
    const resultados = await db.executar(sql);
    return resultados[0] || { certas: 0, erradas: 0 };
  }
};
