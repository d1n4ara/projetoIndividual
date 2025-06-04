const database = require("../database/config");

function listar() {
    const instrucao = `
        SELECT p.id, p.titulo, p.descricao, p.dataPostagem, u.nome 
        FROM postagem p 
        JOIN usuario u ON p.fkUsuario = u.idUsuario 
        ORDER BY p.dataPostagem DESC;
    `;
    return database.executar(instrucao);
}

function criar(titulo, descricao, fkUsuario) {
    const instrucao = `
        INSERT INTO postagem (titulo, descricao, fkUsuario)
        VALUES ('${titulo}', '${descricao}', ${fkUsuario});
    `;
    return database.executar(instrucao);
}

module.exports = {
    listar,
    criar
};
