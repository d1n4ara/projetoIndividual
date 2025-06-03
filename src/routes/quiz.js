const express = require("express");
const router = express.Router();
const quizController = require("../controllers/quizController");

router.post("/respostas", quizController.registrarResposta);
router.post("/resultados", quizController.registrarResultado);
router.get("/perguntas", quizController.listarPerguntas);
router.get("/alternativas", quizController.listarAlternativas);

module.exports = router;
