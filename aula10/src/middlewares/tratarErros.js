function tratarErros(err, req, res, next) {
  // Captura erros de sintaxe no JSON (corpo da requisição malformado)
  if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
    return res.status(400).json({
      error: 'Bad Request',
      message: 'O corpo da requisição contém um JSON inválido. Verifique a sintaxe.'
    });
  }

  // Outros tratamentos de erro genéricos do seu app (exemplo)
  console.error(err.stack);
  return res.status(500).json({ 
    error: 'Internal Server Error',
    message: 'Ocorreu um erro interno no servidor.' 
  });
}

module.exports = tratarErros;

