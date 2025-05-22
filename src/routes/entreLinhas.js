const express = require('express');
const router = express.Router();
const controller = require('../controllers/entreLinhasController');

router.get('/kpis/:idUsuario', controller.obterKPIs);
router.get('/generos/:idUsuario', controller.obterGenerosLidos);
router.get('/ranking', controller.obterRanking);
router.get('/quiz/:idUsuario', controller.obterQuiz);

module.exports = router;
