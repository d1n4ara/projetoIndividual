const database = require("../database/config");

function registrarResposta(fkUsuario, fkQuestao, fkAlternativa) {
    const instrucaoSql = `
        INSERT INTO resposta (fkUsuario, fkQuestao, fkAlternativa, dataResposta)
        VALUES (${fkUsuario}, ${fkQuestao}, ${fkAlternativa}, NOW());
    `;
    return database.executar(instrucaoSql);
}

function registrarResultado(fkUsuario, pontuacao, porcentagem) {
    const instrucaoSql = `
        INSERT INTO resultadoQuiz (fkUsuario, pontuacao, porcentagem, dataQuiz)
        VALUES (${fkUsuario}, ${pontuacao}, ${porcentagem}, NOW());
    `;
    return database.executar(instrucaoSql);
}

function listarPerguntas() {
    const instrucaoSql = `SELECT idQuestao, pergunta FROM questao;`;
    return database.executar(instrucaoSql);
}

function listarAlternativas() {
    const instrucaoSql = `SELECT idAlternativa, texto, isCorreta, fkQuestao FROM alternativa;`;
    return database.executar(instrucaoSql);
}

module.exports = {
    registrarResposta,
    registrarResultado,
    listarPerguntas,
    listarAlternativas
};
