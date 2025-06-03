const express = require("express");
const router = express.Router();
const db = require("../database/config");

router.get("/listar", async (req, res) => {
    try {
        const resultado = await db.executar("SELECT * FROM genero");
        res.status(200).json(resultado);
    } catch (err) {
        res.status(500).json({ erro: "Erro ao listar gêneros." });
    }
});

module.exports = router;
