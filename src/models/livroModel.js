// models/livroModel.js
const database = require("../database/config");

function listar(search = '', idUsuario = 0) {
    console.log("ACESSEI O LIVRO MODEL");
    
    let query = `
        SELECT l.idLivro, l.titulo, l.autor, g.genero, l.descricao,
               (SELECT COUNT(*) FROM livroFavorito WHERE fkLivro = l.idLivro) as totalFavoritos,
               EXISTS(SELECT 1 FROM livroFavorito WHERE fkLivro = l.idLivro AND fkUsuario = ${idUsuario}) as favoritado
        FROM livro l
        LEFT JOIN genero g ON l.fkGenero = g.idGenero
    `;
    
    if (search) {
        query += ` WHERE l.titulo LIKE '%${search}%' OR l.autor LIKE '%${search}%' OR g.genero LIKE '%${search}%'`;
    }
    
    console.log("Executando a instrução SQL: \n" + query);
    return new Promise((resolve, reject) => {
        database.query(query, (erro, resultado) => {
            if (erro) {
                reject(erro);
            } else {
                resolve(resultado);
            }
        });
    });
}

function favoritar(idLivro, idUsuario) {
    console.log("ACESSEI O LIVRO MODEL - favoritar");
    const query = `
        INSERT INTO livroFavorito (fkUsuario, fkLivro) 
        VALUES (${idUsuario}, ${idLivro})
        ON DUPLICATE KEY DELETE FROM livroFavorito 
        WHERE fkUsuario = ${idUsuario} AND fkLivro = ${idLivro};
    `;
    
    console.log("Executando a instrução SQL: \n" + query);
    return new Promise((resolve, reject) => {
        database.query(query, (erro, resultado) => {
            if (erro) {
                reject(erro);
            } else {
                resolve(resultado);
            }
        });
    });
}

module.exports = {
    listar,
    favoritar
};