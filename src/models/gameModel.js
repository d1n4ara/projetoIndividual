const db = require("../database/config");

function registrarMissaoConcluida(fkUsuario, fkMissaoModelo) {
    const pontosAleatorios = Math.floor(Math.random() * 20 + 1); // de 1 a 20 XP

    const instrucaoSql = `
        INSERT INTO missao_usuario (fkUsuario, fkMissaoModelo, recompensa, pontosGanho)
        VALUES (${fkUsuario}, ${fkMissaoModelo}, '+${pontosAleatorios} XP', ${pontosAleatorios});
    `;

    return db.executar(instrucaoSql);
}

function listarMissoes() {
    const instrucaoSql = `
        SELECT * FROM missao_modelo;
    `;
    return db.executar(instrucaoSql);
}

function listarMissoesConcluidas(fkUsuario) {
    const instrucaoSql = `
        SELECT * FROM missao_usuario WHERE fkUsuario = ${fkUsuario};
    `;
    return db.executar(instrucaoSql);
}

module.exports = {
    registrarMissaoConcluida,
    listarMissoes,
    listarMissoesConcluidas
};
