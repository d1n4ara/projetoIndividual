const express = require("express");
const router = express.Router();
const postagemController = require("../controllers/postagemController");

router.get("/listar", postagemController.listar);
router.post("/criar", postagemController.criar);

module.exports = router;
