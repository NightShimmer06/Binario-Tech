const express = require('express');
const router = express.Router();
const telemetriaController = require('../controllers/telemetriaController');

// Define a rota especificada
router.get('/veiculo/:id', telemetriaController.buscarPorVeiculo);
router.post('/cadastrar', telemetriaController.cadastrar);
router.get('/relatorio', telemetriaController.listarRelatorioCompleto);

module.exports = router;
