const express = require('express');
const { body } = require('express-validator');
const authController = require('../controllers/authController');
const validarJWT = require('../middlewares/validarJWT');

const router = express.Router();

const validacaoAuth = [
  body('email').isEmail().withMessage('Informe um e-mail válido.'),
  body('senha').isLength({ min: 6 }).withMessage('A senha deve ter no mínimo 6 caracteres.')
];

// Rota Questão 1
router.post('/register', validacaoAuth, authController.registrar);

// Rota Questão 2
router.post('/login', validacaoAuth, authController.login);

// Rota Questão 3 (Protegida por JWT)
router.get('/relatorio', validarJWT, authController.obterRelatorio);

module.exports = router;
