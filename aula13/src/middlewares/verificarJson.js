const verificarJson = (req, res, next) => {
  // Aplica a validação apenas para métodos POST
  if (req.method === 'POST') {
    const contentType = req.headers['content-type'];
    
    if (!contentType || !contentType.includes('application/json')) {
      return res.status(400).json({
        status: "REQUISICAO_INVALIDA",
        mensagem: "O cabeçalho Content-Type deve ser obrigatoriamente application/json para esta requisição."
      });
    }
  }
  next(); // Passa para o próximo middleware se estiver correto
};

module.exports = verificarJson;

