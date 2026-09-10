const express = require('express');
const app = express();
const PORT = 3005;

app.use(express.json());

//Rota de status do Binario Tech
app.get('/status', (req, res) => {
	res.json({
		servidor: "Binario Tech Core",
		status: "OPERACIONAL",
		montadoras_atendidas: ["Scania", "Mercedes", "VW"],
		uptime_segundos: process.uptime()
	});
});

//Rota de Infomacoes da Montadora Scania
app.get('/scania/info', (req, res) => {
	res.json({
		montadora: "Scania",
		foco: "Caminhoes Pesados e Ônibus",
		sistema_telemetria: "Ativo",
		unidades_conectadas: 1420
	});
});

//Rota de Infomacoes da Montadora Volswagen
app.get('/vw/info', (req, res) => {
        res.json({
                montadora: "Volkswagen",
                foco: "Carros de Passeio e SUVs",
                sistema_telemetria: "Ativo",
                unidades_conectadas: 1000
	});
});

app.listen(PORT, () => {
	console.log(`Servidor rodando com sucesso na porta ${PORT}`);
});
