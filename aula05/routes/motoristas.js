const express = require('express');
const router = express.Router();
const validaCnh = require('../middlewares/validaCnh');

router.post('/', validaCnh, (req, res) => {
    res.status(201).json({ msg: "Motorista cadastrado com sucesso!" });
});

module.exports = router;
