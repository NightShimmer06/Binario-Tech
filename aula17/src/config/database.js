const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');

const conectarBanco = async () => {
  try {
    let uri = process.env.MONGO_URI;
    
    // Se o banco local falhar, ele inicia o banco em memória automaticamente
    if (uri.includes('127.0.0.1') || uri.includes('localhost')) {
      console.log('[Binário Tech] Iniciando MongoDB em memória para testes...');
      const mongoServer = await MongoMemoryServer.create();
      uri = mongoServer.getUri();
    }

    await mongoose.connect(uri);
    console.log('[Binário Tech] Banco de Dados do Simulado conectado!');
  } catch (erro) {
    console.error(`[ERRO BANCO]: ${erro.message}`);
    process.exit(1);
  }
};

module.exports = conectarBanco;

