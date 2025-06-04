const postagemModel = require("../models/postagemModel");

function listar(req, res) {
    postagemModel.listar()
        .then((resultado) => res.json(resultado))
        .catch((erro) => {
            console.error("Erro ao listar postagens:", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function criar(req, res) {
    const { titulo, descricao, fkUsuario } = req.body;

    if (!titulo || !descricao || !fkUsuario) {
        return res.status(400).send("Título, descrição ou fkUsuario está faltando!");
    }

    postagemModel.criar(titulo, descricao, fkUsuario)
        .then(() => res.status(201).send("Postagem criada com sucesso"))
        .catch((erro) => {
            console.error("Erro ao criar postagem:", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    listar,
    criar
};
