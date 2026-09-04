const express = require('express');
const app = express();
const PORT = 3001

app.use(express.json());

//rota Scania
app.get('/api/v1/scania', (req, res) => {
	res.json({ montadora: "Scania", modelo: "R450", status: "OK", conexao: true, velocidade_media: 82});
});

//rota Mercedes-Benz
app.get('/api/v1/mercedes', (req, res) => {
	res.json({ montadora: "Mercedes-Benz", modelo: "Actros", status: "OK", conexao: true, velocidade_media: 78});
});

//rota Volswagen
app.get('/api/v1/vw', (req, res) => {
	res.json({ montadora: "Volswagen", modelo: "Delivery", status: "ALERTA", conexao: false, velocidade_media: 0});
});

app.get('/api/v1/volvo', (req, res) => {
        res.json({ montadora: "Volvo", modelo: "FH540", status: "ALERTA", conexao: false, velocidade_media: 0});
});

app.listen(PORT, () => {
	console.log(`[Binario Tech] Servidor de Telemetria rodando em http://localhost:${PORT}`);
});

