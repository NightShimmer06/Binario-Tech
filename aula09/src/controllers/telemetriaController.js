const db = require('../database/connection');

const telemetriaController = {
	//Cadastrar nova leitura de tele. associada a um veiculo
	registrerLeitura: async (req, res) => {
		try {
			const { veiculo_id, velocidade, temperatura_motor } = req.body;
			if (!veiculo_id || velocidade === undefined || temperatura_motor === undefined) {
				return res.status(400).json({ erro: "Campos 'veiculo_id', 'velocidade' e 'temperatura_motor' sao obrigatorios." });
			}

			const veiculoExiste = await db('veiculos').where({ id: veiculo_id }).first();
			if (!veiculoExiste) {
				return res.status(401).json({ erro: "Veiculo informado não existe no banco de dados."});
			}

			const [id] = await db('telemetria').insert({
				veiculos_id,
				velocidade,
				temperatura_motor
			});

			res.status(201).json({ id, veiculo_id, velocidade, temperatura_motor, mensagem: "Leitura registrada com sucesso" });
			} catch (erro) {
				res.status(500).json({ "erro:Erro ao registrar telemetria no banco de dados."});
			}
	},

	listarRelatorioCompleto: async (req, res) => {
		try {
			const relatorio = await db('telemetria')
			.join('veiculos', 'veiculos.id', '=', 'telemetria.veiculos_id').select(
				'telemetria.id as telemetria_id',
				'veiculos.placa',
				'veiculos.montadora',
				'veiculos.modelo',
				'telemetria.velocidade',
				'telemetria.capturado_em'
			);
			res.status(200).json(relatorio);
		} catch (erro) {
			res.status(500).json({ erro: "Erro ao gerar relatorio em Inner Join."});
		}
	}
};
