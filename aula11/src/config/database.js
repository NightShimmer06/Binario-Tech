const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');

const conectarBanco = async () => {
  try {
    const mongoServer = await MongoMemoryServer.create();
    const uri = mongoServer.getUri();

    await mongoose.connect(uri);
    console.log('[Binário Tech] Conexão com MongoDB em Memória estabelecida com sucesso!');
  } catch (erro) {
    console.error(`[ERRO MONGODB]: Falha ao conectar ao banco local - ${erro.message}`);
    process.exit(1);
  }
};

module.exports = conectarBanco;
