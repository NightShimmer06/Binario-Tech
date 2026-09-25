const mongoose = require('mongoose');

const conectarBanco = async () => {
  try {
    const uri = process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/binario_tech_prova';
    await mongoose.connect(uri);
    console.log('[Binário Tech] Banco de Dados da Prova conectado com sucesso!');
  } catch (erro) {
    console.error(`[ERRO BANCO]: ${erro.message}`);
    process.exit(1);
  }
};

module.exports = conectarBanco;
