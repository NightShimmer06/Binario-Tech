require('dotenv').config();
const express = require('express');
const cors = require('cors');
const conectarBanco = require('./src/config/database');
const autenticar = require('./src/middlewares/autenticar');

const app = express();
const PORT = process.env.PORT || 3005;

app.use(cors());
app.use(express.json());

// Importar o pacote jsonwebtoken no topo do arquivo caso não esteja importado
const jwt = require('jsonwebtoken');

// [EXERCÍCIO 2] Endpoint para gerar token de teste válido por 5 minutos
app.post('/api/v1/auth/token-teste', (req, res) => {
  const payload = { 
    id: "aluno_simulado_2026", 
    nome: "Caroline Melo", 
    role: "developer" 
  };

  // Assina o token usando o segredo do .env com expiração de 5m
  const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '5m' });

  res.json({ token });
});

// Rota Pública de Healthcheck
app.get('/api/v1/health', (req, res) => {
  res.json({ status: "PRONTO_PARA_EXAME", timestamp: new Date() });
});

// Rota Protegida do Simulado
app.get('/api/v1/simulado/status', autenticar, (req, res) => {
  res.json({ mensagem: "Acesso autorizado no Servidor Local!", usuario: req.usuario });
});

app.listen(PORT, () => {
  console.log(`[Binário Tech] Servidor da Aula 17 ativo na porta ${PORT}`);
});

conectarBanco().catch(erro => console.error("Erro ao conectar banco:", erro.message));

