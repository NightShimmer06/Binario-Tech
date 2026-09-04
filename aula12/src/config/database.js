const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');

const conectarBanco = async () => {
	try {
		  // Cria um MongoDB falso e temporário direto na memória do Node
		  const mongoServer = await MongoMemoryServer.create();
		  const uri = mongoServer.getUri();
		               
		  await mongoose.connect(uri);
		  console.log('[Binário Tech] Conexão NoSQL ativa!');
	  } catch (erro) {
		  console.error(`[ERRO MONGODB]: ${erro.message}`);
		  process.exit(1);
		  }
};

module.exports = conectarBanco;
