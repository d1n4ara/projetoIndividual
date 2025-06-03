const db = require('../database/config'); 

function listarLivros() {
    return db.executar(`
        SELECT livro.id, livro.titulo, livro.autor, livro.descricao, genero.nome AS genero
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


const livroFavoritoModel = {
  adicionar(fkUsuario, fkLivro, callback) {
    const query = "INSERT INTO livro_favorito (fkUsuario, fkLivro) VALUES (?, ?)";
    db.query(query, [fkUsuario, fkLivro], callback);
  },

  remover(fkUsuario, fkLivro, callback) {
    const query = "DELETE FROM livro_favorito WHERE fkUsuario = ? AND fkLivro = ?";
    db.query(query, [fkUsuario, fkLivro], callback);
  },

  verificar(fkUsuario, fkLivro, callback) {
    const query = "SELECT 1 FROM livro_favorito WHERE fkUsuario = ? AND fkLivro = ?";
    db.query(query, [fkUsuario, fkLivro], (err, results) => {
      if (err) return callback(err);
      const isFavorito = results.length > 0;
      callback(null, isFavorito);
    });
  },

  listarPorUsuario(fkUsuario, callback) {
    const query = `
      SELECT l.* 
      FROM livro_favorito lf
      JOIN livro l ON lf.fkLivro = l.idLivro
      WHERE lf.fkUsuario = ?
    `;
    db.query(query, [fkUsuario], callback);
  }
};

module.exports = livroFavoritoModel;


module.exports = {
    listarLivros,
    cadastrarLivro
};
