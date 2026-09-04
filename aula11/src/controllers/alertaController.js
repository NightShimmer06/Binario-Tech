const Alerta = require('../models/Alerta');

const alertaController = {
  // Salvar novo documento BSON (Atualizado para incluir tags)
  criarAlerta: async (req, res) => {
    try {
      const { equipamentoId, nivelSeveridade, temperaturaMedida, tags, metadados } = req.body;

      const novoAlerta = await Alerta.create({
        equipamentoId,
        nivelSeveridade,
        temperaturaMedida,
        tags, // Adicionado no Exercício 2
        metadados
      });

      res.status(201).json(novoAlerta);
    } catch (erro) {
      // Captura erros de validação (importante para o Exercício 3)
      res.status(400).json({ erro: "Erro ao salvar alerta no MongoDB", detalhe: erro.message });
    }
  },

  // Listar todos os alertas registrados
  listarAlertas: async (req, res) => {
    try {
      const alertas = await Alerta.find().sort({ registradoEm: -1 });
      res.status(200).json(alertas);
    } catch (erro) {
      res.status(500).json({ erro: "Erro ao consultar coleção no MongoDB" });
    }
  },

  // EXERCÍCIO 1: Filtrar documentos por nível de severidade via parâmetro de rota
  buscarPorSeveridade: async (req, res) => {
    try {
      const { nivel } = req.params; // Captura o parâmetro ':nivel'
      
      // Converte o texto recebido para maiúsculo para bater com o Enum do banco (ex: baixo -> BAIXO)
      const nivelSeveridade = nivel.toUpperCase(); 

      const alertas = await Alerta.find({ nivelSeveridade });
      res.status(200).json(alertas);
    } catch (erro) {
      res.status(500).json({ erro: "Erro ao buscar alertas por severidade" });
    }
  }
};

module.exports = alertaController;

