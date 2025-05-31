document.addEventListener('DOMContentLoaded', async () => {
    // Carrega os livros ao iniciar
    await loadLivros();
    
    // Evento de busca
    document.getElementById('btn-search').addEventListener('click', async () => {
        const searchTerm = document.getElementById('search').value;
        await loadLivros(searchTerm);
    });
});

async function loadLivros(search = '') {
    try {
        let url = '/api/livros';
        if (search) {
            url += `?search=${encodeURIComponent(search)}`;
        }
        
        const response = await fetch(url);
        const livros = await response.json();
        
        renderLivros(livros);
    } catch (error) {
        console.error('Erro ao carregar livros:', error);
    }
}

function renderLivros(livros) {
    const catalogo = document.getElementById('catalogo');
    catalogo.innerHTML = '';
    
    livros.forEach(livro => {
        const livroCard = document.createElement('div');
        livroCard.className = 'livro-card';
        livroCard.innerHTML = `
            <button class="favorito-btn ${livro.favoritado ? 'favoritado' : ''}" data-livro-id="${livro.id}">
                <i class="${livro.favoritado ? 'fas' : 'far'} fa-heart"></i>
            </button>
            <h2 class="livro-titulo">${livro.titulo}</h2>
            <p class="livro-autor">${livro.autor}</p>
            <p class="livro-descricao">${livro.descricao}</p>
        `;
        catalogo.appendChild(livroCard);
    });
    
    // Adiciona eventos aos botões de favorito
    document.querySelectorAll('.favorito-btn').forEach(btn => {
        btn.addEventListener('click', async function() {
            const livroId = this.getAttribute('data-livro-id');
            await toggleFavorito(livroId, this);
        });
    });
}

async function toggleFavorito(livroId, btn) {
    try {
        const response = await fetch('/api/favoritos', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ livroId })
        });
        
        const result = await response.json();
        
        if (result.success) {
            const icon = btn.querySelector('i');
            if (result.action === 'added') {
                btn.classList.add('favoritado');
                icon.classList.remove('far');
                icon.classList.add('fas');
            } else {
                btn.classList.remove('favoritado');
                icon.classList.remove('fas');
                icon.classList.add('far');
            }
        }
    } catch (error) {
        console.error('Erro ao favoritar livro:', error);
    }
}