const validaCnh = (req, res, next) => {
    const { cnh } = req.body;
    const apenasNumeros = /^[0-9]{11}$/;

    if (!cnh || !apenasNumeros.test(cnh)) {
        return res.status(400).json({ 
            erro: "CNH inválida. Deve conter 11 dígitos numéricos." 
        });
    }

    next();
};

module.exports = validaCnh;
