const validarPerfil = (perfisPermitidos) => {
  return (req, res, next) => {
    // req.usuario foi injetado previamente pelo middleware autenticarToken
    if (!req.usuario || !perfisPermitidos.includes(req.usuario.perfil)) {
      return res.status(403).json({ 
        status: "ERRO", 
        mensagem: "Acesso proibido. Seu perfil não tem permissão para acessar este recurso." 
      });
    }
    next();
  };
};

module.exports = validarPerfil;

