const express = require('express');
const cors = require('cors');
const frotaRoutes = require('./src/routes/frotaRoutes');
const telemetriaRoutes = require('./src/routes/telemetriaRoutes');
const tratarErros = require('./src/middlewares/tratarErros');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

app.use('/api/v1/frota', frotaRoutes);
app.use('/api/v1/telemetria', telemetriaRoutes);

app.use((req, res) => {
	res.status(404).json({ erro: "Rota não encontrada no servidor."});
});

//registrar middleware de erro (após as rotas)
app.use(tratarErros);

app.listen(PORT, () => {
	console.log(`[Binario Tech] Servidor da Aula10 ativo na porta ${PORT}`);
});
