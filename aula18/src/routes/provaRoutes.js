const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const validarJWT = require('../middlewares/validarJWT');
const validarPerfil = require('../middlewares/validarPerfil');

// Rotas públicas
router.post('/register', authController.registrar);
router.post('/login', authController.login);

// Rota privada (exige Token JWT)
	router.get('/perfil', validarJWT, authController.perfil);

router.get('/admin-dashboard', validarJWT, validarPerfil(['ADMIN']), (req, res) => {
  res.json({ mensagem: "Bem-vindo ao painel administrativo!" });
});

module.exports = router;
