const express = require('express');
const cors = require('cors');
const loggerMiddleware = require('./middlewares/logger');
const authMiddleware = require('./middlewares/auth');
const manutencoesRouter = require('./routes/manutencoes');
const validaCnh = require('./middlewares/validaCnh');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use(loggerMiddleware);

app.get('/api/v1/health', (req, res) => {
    res.status(200).json({ status: "ONLINE", aplicacao: "Binario Tech API v2" });
});

app.use('/api/v1/manutencoes', authMiddleware, manutencoesRouter);

// Rota de motoristas direta com validação inclusa para evitar erros de arquivo
app.post('/api/v1/motoristas', validaCnh, (req, res) => {
    res.status(201).json({ msg: "Motorista cadastrado com sucesso!" });
});

app.use((req, res) => {
    res.status(404).json({ erro: "Endpoint nao encontrado no servidor Binario Tech." });
});

app.listen(PORT, () => {
    console.log(`[Binario Tech Servidor de Middlewares ativo na porta ${PORT}]`);
});
