// routes/livroRoutes.js
const express = require("express");
const router = express.Router();
const livroController = require("../controllers/livroController");

router.get("/listar", livroController.listar);
router.post("/favoritar", livroController.toggleFavorito);

module.exports = router;