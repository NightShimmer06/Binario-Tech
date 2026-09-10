const express = require('express');
const cors = require('cors');
const scaniaRoutes = require('./src/routes/scaniaRoutes');
const mercedesRoutes = require('./src/routes/mercedesRoutes');
const validaVin = require('./src/middlewares/validaVin');

const app = express();
const PORT = 3005;

//middlewares
app.use(cors());
app.use(express.json());

//logger de requisiçoes
app.use((req, res, next) => {
	console.log(`[${new Date().toISOString()}] ${req.method} em ${req.url}`);
	next();
});

//agrupamento de routes por montadora
app.use('/api/v1/telemetria/scania', scaniaRoutes);

app.use('/api/v1/telemetria/mercedes', mercedesRoutes);

//rota 404
app.use((req, res) => {
	res.status(404).json({ erro: "Modulo ou Rota de telemetria não encontrada." });
});

app.listen(PORT, () => {
	console.log(`[Binario Tech] Servidor modularizado ativo na porta ${PORT}`);
});
