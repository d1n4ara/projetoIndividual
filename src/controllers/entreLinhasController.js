const database = require('../database/config');

async function obterKPIs(req, res) {
  const { idUsuario } = req.params;

  try {
    const livrosLidosRows = await database.executar(`
      SELECT COUNT(*) AS total FROM leitura WHERE idUsuario = ? AND finalizado = 1
    `, [idUsuario]);

    const paginasMesRows = await database.executar(`
      SELECT SUM(paginasLidas) AS total FROM leitura 
      WHERE idUsuario = ? AND MONTH(dataLeitura) = MONTH(CURDATE())
    `, [idUsuario]);

    const favoritosRows = await database.executar(`
      SELECT COUNT(*) AS total FROM livro_favorito WHERE idUsuario = ?
    `, [idUsuario]);

    const pontuacaoRows = await database.executar(`
      SELECT pontuacao FROM usuario WHERE id = ?
    `, [idUsuario]);

    let nivel = 'Iniciante';
    const pontos = pontuacaoRows[0]?.pontuacao || 0;

    if (pontos >= 1000) nivel = 'Leitor Mestre';
    else if (pontos >= 500) nivel = 'Avançado';

    res.json({
      livrosLidos: livrosLidosRows[0]?.total || 0,
      paginasPorMes: paginasMesRows[0]?.total || 0,
      favoritos: favoritosRows[0]?.total || 0,
      pontuacao: pontos,
      nivel
    });

  } catch (erro) {
    console.error('Erro obterKPIs:', erro);
    res.status(500).json({ erro: 'Erro ao buscar KPIs' });
  }
}

async function obterGenerosLidos(req, res) {
  const { idUsuario } = req.params;

  try {
    const rows = await database.executar(`
      SELECT g.nome AS genero, COUNT(*) AS total
      FROM leitura l
      JOIN livro lv ON l.idLivro = lv.id
      JOIN genero g ON lv.fkGenero = g.id
      WHERE l.idUsuario = ?
      GROUP BY g.nome
    `, [idUsuario]);

    const labels = rows.map(r => r.genero);
    const valores = rows.map(r => r.total);

    res.json({ labels, valores });

  } catch (erro) {
    console.error('Erro obterGenerosLidos:', erro);
    res.status(500).json({ erro: 'Erro ao buscar gêneros lidos' });
  }
}

async function obterRanking(req, res) {
  try {
    const rows = await database.executar(`
      SELECT nome, pontuacao FROM usuario ORDER BY pontuacao DESC LIMIT 5
    `);

    const usuarios = rows.map(u => u.nome);
    const pontos = rows.map(u => u.pontuacao);

    res.json({ usuarios, pontos });

  } catch (erro) {
    console.error('Erro obterRanking:', erro);
    res.status(500).json({ erro: 'Erro ao buscar ranking' });
  }
}

async function obterQuiz(req, res) {
  const { idUsuario } = req.params;

  try {
    const resultado = await database.executar(`
      SELECT 
        SUM(CASE WHEN correta = 1 THEN 1 ELSE 0 END) AS certas,
        SUM(CASE WHEN correta = 0 THEN 1 ELSE 0 END) AS erradas
      FROM resposta_quiz
      WHERE idUsuario = ?
    `, [idUsuario]);

    res.json(resultado[0]);

  } catch (erro) {
    console.error('Erro obterQuiz:', erro);
    res.status(500).json({ erro: 'Erro ao buscar resultados do quiz' });
  }
}

module.exports = {
  obterKPIs,
  obterGenerosLidos,
  obterRanking,
  obterQuiz
};
