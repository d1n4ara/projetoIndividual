const express = require('express');
const router = express.Router();
const missaoController = require('../controllers/missaoController');

router.post('/missao/concluir', missaoController.concluirMissao);

module.exports = router;
