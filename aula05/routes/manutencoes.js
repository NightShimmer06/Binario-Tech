const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.status(200).json({ mensagem: 'Listagem de manutenções realizada com sucesso.' });
});

module.exports = router;
