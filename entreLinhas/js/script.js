document.addEventListener("DOMContentLoaded", function () {
    // Abre o modal correto ao clicar no botão de gênero
    const genreButtons = document.querySelectorAll(".genre-btn");
    const modals = document.querySelectorAll(".modal");
    const closeButtons = document.querySelectorAll(".close");
  
    genreButtons.forEach(button => {
      button.addEventListener("click", () => {
        const modalId = `modal-${button.dataset.modal}`;
        const modal = document.getElementById(modalId);
        if (modal) modal.style.display = "block";
      });
    });
  
    closeButtons.forEach(btn => {
      btn.addEventListener("click", () => {
        modals.forEach(modal => modal.style.display = "none");
      });
    });
  
    // Fecha ao clicar fora do modal
    window.addEventListener("click", (e) => {
      modals.forEach(modal => {
        if (e.target === modal) modal.style.display = "none";
      });
    });
  });
  