const config = require('../database/config');

// 1. Função para obter perguntas
async function obterPerguntas(req, res) {
    try {
        const perguntas = await config.executar(`
            SELECT q.idQuestao, q.pergunta, q.fkQuiz 
            FROM questao q
            WHERE q.fkQuiz = 1
            ORDER BY q.idQuestao
        `);
        
        const alternativas = await config.executar(`
            SELECT a.idAlternativa, a.texto, a.isCorreta, a.fkQuestao 
            FROM alternativa a
            JOIN questao q ON a.fkQuestao = q.idQuestao
            WHERE q.fkQuiz = 1
            ORDER BY a.fkQuestao, a.idAlternativa
        `);
        
        res.json({
            questoes: perguntas,
            alternativas: alternativas
        });
    } catch (error) {
        console.error('Erro ao obter perguntas:', error);
        res.status(500).json({ error: 'Erro ao carregar perguntas' });
    }
}

// 2. Função para registrar respostas
async function registrarResposta(req, res) {
    const { fkUsuario, fkQuestao, fkAlternativa } = req.body;
    
    try {
        await config.executar(`
            INSERT INTO respostaUsuario 
            (fkUsuario, fkQuiz, fkQuestao, fkAlternativa)
            VALUES (${fkUsuario}, 1, ${fkQuestao}, ${fkAlternativa})
        `);
        res.json({ success: true });
    } catch (error) {
        console.error('Erro ao registrar resposta:', error);
        res.status(500).json({ error: 'Erro ao registrar resposta' });
    }
}

// 3. Função para registrar resultados
async function registrarResultado(req, res) {
    const { fkUsuario, pontuacao, porcentagem } = req.body;
    
    try {
        await config.executar(`
            INSERT INTO resultadoQuiz 
            (fkUsuario, fkQuiz, pontuacao, porcentagemAcertos)
            VALUES (${fkUsuario}, 1, ${pontuacao}, ${porcentagem})
        `);
        res.json({ success: true });
    } catch (error) {
        console.error('Erro ao registrar resultado:', error);
        res.status(500).json({ error: 'Erro ao registrar resultado' });
    }
}

// 4. Função para obter estatísticas
async function obterEstatisticas(req, res) {
    const idUsuario = req.params.idUsuario;
    
    try {
        const [maiorPontuacao] = await config.executar(`
            SELECT MAX(pontuacao) as maiorPontuacao 
            FROM resultadoQuiz 
            WHERE fkUsuario = ${idUsuario}
        `);
        
        const [menorPontuacao] = await config.executar(`
            SELECT MIN(pontuacao) as menorPontuacao 
            FROM resultadoQuiz 
            WHERE fkUsuario = ${idUsuario}
        `);
        
        const [totalTentativas] = await config.executar(`
            SELECT COUNT(*) as totalTentativas 
            FROM resultadoQuiz 
            WHERE fkUsuario = ${idUsuario}
        `);
        
        res.json({
            maiorPontuacao: maiorPontuacao.maiorPontuacao || 0,
            menorPontuacao: menorPontuacao.menorPontuacao || 0,
            totalTentativas: totalTentativas.totalTentativas || 0
        });
    } catch (error) {
        console.error('Erro ao obter estatísticas:', error);
        res.status(500).json({ error: 'Erro ao obter estatísticas' });
    }
}

// 5. Função para obter dados do gráfico
async function obterDadosGrafico(req, res) {
    const idUsuario = req.params.idUsuario;
    
    try {
        const dados = await config.executar(`
            SELECT 
                q.idQuestao,
                q.pergunta as questao,
                COUNT(CASE WHEN a.isCorreta = 1 THEN 1 END) as acertos,
                COUNT(CASE WHEN a.isCorreta = 0 THEN 1 END) as erros
            FROM respostaUsuario r
            JOIN alternativa a ON r.fkAlternativa = a.idAlternativa
            JOIN questao q ON r.fkQuestao = q.idQuestao
            WHERE r.fkUsuario = ${idUsuario}
            GROUP BY q.idQuestao, q.pergunta
            ORDER BY q.idQuestao
        `);
        
        res.json(dados);
    } catch (error) {
        console.error('Erro ao obter dados para gráfico:', error);
        res.status(500).json({ error: 'Erro ao obter dados para gráfico' });
    }
}

// Exportação correta de todas as funções
module.exports = {
    obterPerguntas,
    registrarResposta,
    registrarResultado,
    obterEstatisticas,
    obterDadosGrafico
};