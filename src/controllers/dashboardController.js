const dashboardModel = require('../models/dashboardModel');

module.exports = {
  async kpis(req, res) {
    const { idUsuario } = req.params;
    try {
      const dados = await dashboardModel.obterKPIs(idUsuario);
      res.json(dados);
    } catch (erro) {
      console.error('Erro obterKPIs:', erro);
      res.status(500).json({ erro: 'Erro ao obter KPIs' });
    }
  },

  async generos(req, res) {
    const { idUsuario } = req.params;
    try {
      const dados = await dashboardModel.obterGenerosLidos(idUsuario);
      const labels = dados.map(l => l.genero);
      const valores = dados.map(l => l.total);
      res.json({ labels, valores });
    } catch (erro) {
      console.error('Erro obterGenerosLidos:', erro);
      res.status(500).json({ erro: 'Erro ao obter gêneros lidos' });
    }
  },

  async quiz(req, res) {
    const { idUsuario } = req.params;
    try {
      const dados = await dashboardModel.obterQuiz(idUsuario);
      res.json(dados);
    } catch (erro) {
      console.error('Erro obterQuiz:', erro);
      res.status(500).json({ erro: 'Erro ao obter dados do quiz' });
    }
  }
};
