const quizModel = require("../models/quizModel");


function registrarResposta(req, res) {
    const { fkUsuario, fkQuestao, fkAlternativa } = req.body;

    if (!fkUsuario || !fkQuestao || !fkAlternativa) {
        return res.status(400).json({ error: "Dados incompletos" });
    }

    quizModel.registrarResposta(fkUsuario, fkQuestao, fkAlternativa)
        .then(() => res.status(200).json({ message: "Resposta registrada com sucesso" }))
        .catch(error => {
            console.error(error);
            res.status(500).json({ error: "Erro ao registrar resposta" });
        });
}

function registrarResultado(req, res) {
    const { fkUsuario, pontuacao, porcentagem } = req.body;

    if (!fkUsuario || pontuacao == null || porcentagem == null) {
        return res.status(400).json({ error: "Dados incompletos" });
    }

    quizModel.registrarResultado(fkUsuario, pontuacao, porcentagem)
        .then(() => res.status(200).json({ message: "Resultado registrado com sucesso" }))
        .catch(error => {
            console.error(error);
            res.status(500).json({ error: "Erro ao registrar resultado" });
        });
}

function listarPerguntas(req, res) {
    quizModel.listarPerguntas()
        .then(resultado => res.status(200).json(resultado))
        .catch(error => {
            console.error(error);
            res.status(500).json({ error: "Erro ao listar perguntas" });
        });
}

function listarAlternativas(req, res) {
    quizModel.listarAlternativas()
        .then(resultado => res.status(200).json(resultado))
        .catch(error => {
            console.error(error);
            res.status(500).json({ error: "Erro ao listar alternativas" });
        });
}

module.exports = {
    registrarResposta,
    registrarResultado,
    listarPerguntas,
    listarAlternativas
};
