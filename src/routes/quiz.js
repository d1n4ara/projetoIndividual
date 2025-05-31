const express = require('express');
const router = express.Router();
const quizController = require('../controllers/quizController');

router.get('/perguntas', quizController.obterPerguntas);
router.post('/respostas', quizController.registrarResposta);
router.post('/resultados', quizController.registrarResultado);
router.get('/estatisticas/:idUsuario', quizController.obterEstatisticas);
router.get('/grafico/:idUsuario', quizController.obterDadosGrafico);

router.get('/verificar', (req, res) => {
    if (req.session.usuario) {
        return res.json({ 
            autenticado: true,
            idUsuario: req.session.usuario.id,
            nome: req.session.usuario.nome
        });
    }
    res.status(401).json({ autenticado: false });
});

module.exports = router;