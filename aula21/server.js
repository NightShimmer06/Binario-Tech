require('dotenv').config();
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3005;

app.use(express.json());

app.get('/api/v1/versao', (req, res) => {
	res.json({
		aplicacao: "API Binario Tech - CI/CD Pipeline",
		versao: "1.0.0",
		ambiente: "Servidor de homologação local",
		uptime: process.uptime(),
		timestamp: new Date()
	});
});

app.listen(PORT, () => {
	console.log(`[Binario Tech] Aplicação CI/CD ativa na porta ${PORT}`);
});
