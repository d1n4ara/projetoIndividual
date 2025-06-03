const dashboardModel = require("../models/dashboardModel");

function buscarMaiorPontuacao(req, res) {
  const idUsuario = req.params.idUsuario;

  dashboardModel.buscarMaiorPontuacao(idUsuario).then(resultado => {
    res.json(resultado[0]);
  }).catch(erro => {
    console.log(erro);
    res.status(500).json({ erro: erro.sqlMessage });
  });
}

function buscarGeneroFavorito(req, res) {
  const idUsuario = req.params.idUsuario;

  dashboardModel.buscarGeneroFavorito(idUsuario).then(resultado => {
    res.json(resultado[0]);
  }).catch(erro => {
    console.log(erro);
    res.status(500).json({ erro: erro.sqlMessage });
  });
}

function buscarQuantidadeQuizzes(req, res) {
  const idUsuario = req.params.idUsuario;

  dashboardModel.buscarQuantidadeQuizzes(idUsuario).then(resultado => {
    res.json(resultado[0]);
  }).catch(erro => {
    console.log(erro);
    res.status(500).json({ erro: erro.sqlMessage });
  });
}

function buscarPontuacoesQuiz(req, res) {
  const idUsuario = req.params.idUsuario;

  dashboardModel.buscarPontuacoesQuiz(idUsuario).then(resultado => {
    res.json(resultado);
  }).catch(erro => {
    console.log(erro);
    res.status(500).json({ erro: erro.sqlMessage });
  });
}

module.exports = {
  buscarMaiorPontuacao,
  buscarGeneroFavorito,
  buscarQuantidadeQuizzes,
  buscarPontuacoesQuiz
};
