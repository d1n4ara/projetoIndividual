const express = require('express');
const router = express.Router();
const dashboardController = require('../controllers/dashboardController');

router.get('/kpis/:idUsuario', dashboardController.kpis);
router.get('/generos/:idUsuario', dashboardController.generos);
router.get('/quiz/:idUsuario', dashboardController.quiz);

module.exports = router;
