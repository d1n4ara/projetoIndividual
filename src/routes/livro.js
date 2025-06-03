const express = require("express");
const router = express.Router();
const livroController = require("../controllers/livroController");

router.get("/listar", livroController.listar);
router.post("/cadastrar", livroController.cadastrar);

module.exports = router;
