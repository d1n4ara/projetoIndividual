const express = require("express");
const router = express.Router();
const dashboardController = require("../controllers/dashboardController");

router.get("/maior-pontuacao/:idUsuario", dashboardController.buscarMaiorPontuacao);
router.get("/genero-favorito/:idUsuario", dashboardController.buscarGeneroFavorito);
router.get("/quantidade-quizzes/:idUsuario", dashboardController.buscarQuantidadeQuizzes);
router.get("/pontuacoes-quiz/:idUsuario", dashboardController.buscarPontuacoesQuiz);

module.exports = router;
