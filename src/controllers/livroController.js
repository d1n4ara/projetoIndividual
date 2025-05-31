// controllers/livroController.js
const livroModel = require("../models/livroModel");

function listar(req, res) {
    const search = req.query.search || '';
    const idUsuario = req.query.idUsuario || 0; // Em produção, pegar da sessão

    livroModel.listar(search, idUsuario)
        .then(resultado => {
            res.status(200).json(resultado);
        })
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function toggleFavorito(req, res) {
    const idLivro = req.body.idLivro;
    const idUsuario = req.body.idUsuario || 0;

    if (!idLivro) {
        return res.status(400).send("O ID do livro está indefinido!");
    }

    livroModel.favoritar(idLivro, idUsuario)
        .then(() => {
            res.status(200).json({ success: true });
        })
        .catch(erro => {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    listar,
    toggleFavorito
};