const livroModel = require("../models/livroModel");

async function listar(req, res) {
    try {
        const livros = await livroModel.listarLivros();
        res.status(200).json(livros);
    } catch (err) {
        console.error("Erro ao listar livros:", err);
        res.status(500).json({ erro: "Erro ao listar livros." });
    }
}

async function cadastrar(req, res) {
    const { titulo, autor, descricao, fkGenero } = req.body;

    if (!titulo || !autor || !descricao || !fkGenero) {
        return res.status(400).json({ erro: "Preencha todos os campos!" });
    }

    try {
        await livroModel.cadastrarLivro(titulo, autor, descricao, fkGenero);
        res.status(201).json({ mensagem: "Livro cadastrado com sucesso!" });
    } catch (err) {
        console.error("Erro ao cadastrar livro:", err);
        res.status(500).json({ erro: "Erro ao cadastrar livro." });
    }
}



module.exports = {
    listar,
    cadastrar
};
