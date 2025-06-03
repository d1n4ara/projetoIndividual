const db = require('../database/config'); 

function listarLivros() {
    return db.executar(`
        SELECT livro.id, livro.titulo, livro.autor, livro.descricao, fkGenero AS genero
        FROM livro
        JOIN genero ON livro.fkGenero = genero.id
        ORDER BY livro.titulo ASC
    `);
}

function cadastrarLivro(titulo, autor, descricao, fkGenero) {
    return db.executar(`
        INSERT INTO livro (titulo, autor, descricao, fkGenero)
        VALUES ('${titulo}', '${autor}', '${descricao}', ${fkGenero})
    `);
}

module.exports = {
    listarLivros,
    cadastrarLivro
};
