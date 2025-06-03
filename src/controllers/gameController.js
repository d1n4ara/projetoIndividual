const conexao = require('../database/config');

function concluirMissao(req, res) {
    const { fkUsuario, fkMissaoModelo } = req.body;

    // Pontuação aleatória entre 5 e 15
    let pontosBase = Math.floor(Math.random() * 11) + 5;
    let pontosFinais = pontosBase;

    // Condicional: se número for par, dobra pontos
    if (pontosBase % 2 === 0) {
        pontosFinais *= 2;
    }

    // Se for múltiplo de 5, soma +3
    if (pontosBase % 5 === 0) {
        pontosFinais += 3;
    }

    const recompensa = `+${pontosFinais} XP`;

    const sql = `
        INSERT INTO missao_usuario (fkUsuario, fkMissaoModelo, recompensa, pontosGanho)
        VALUES (?, ?, ?, ?)`;

    conexao.query(sql, [fkUsuario, fkMissaoModelo, recompensa, pontosFinais], (err, result) => {
        if (err) {
            return res.status(500).json({ erro: err });
        }
        res.json({ mensagem: 'Missão concluída!', pontosGanho: pontosFinais });
    });
}

module.exports = { concluirMissao };
