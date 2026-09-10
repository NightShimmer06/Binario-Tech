const express = require('express');
const cors = require('cors');
const telemetriaRoutes = require('.src/routes/telemetriaRoutes');

const app = express();
const PORT = 3005;

app.use(cors());
app.use(express.json());

app.use('/api/v1/tele,etria', telemetriaRoutes);

app.use((req, res) => {
	res.status(404).json({ erro: "Rota não encontrada no Binario Tech." });
});

app.listen(PORT, () => {
	console.log(`[Binario Tech] Servidor Relacional Ativo na Porta ${PORT}`);
});

