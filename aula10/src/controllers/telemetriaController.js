const database = require('../database/connection'); 

class TelemetriaController {
	async buscarPorVeiculo(req, res, next) {
        	try {
			const { id } = req.params;
            		const leituras = await database('telemetria').where({ veiculo_id: id });
            		return res.status(200).json(leituras);
        	} catch (error) {
            	next(error);
        	}
    	}

    	async cadastrar(req, res, next) {
        	try {
            		const { veiculo_id, velocidade, temperatura_motor } = req.body;

            		// 1. Verifica se o veículo existe
            		const veiculoExiste = await database('veiculos').where({ id: veiculo_id }).first();

            	// 2. Se NÃO existir, retorna HTTP 404
            	if (!veiculoExiste) {
                	return res.status(404).json({ erro: "Veículo não encontrado. Não é possível cadastrar telemetria para um veículo inexistente." });
          	}

            	// 3. Se existir, faz o cadastro no banco
            	const [idNovoRegistro] = await database('telemetria').insert({
                	veiculo_id,
                	velocidade,
                	temperatura_motor
            	});

            	return res.status(201).json({ id: idNovoRegistro, mensagem: "Telemetria cadastrada com sucesso!" });

        	} catch (error) {
            	next(error);
        	}
    	}
	async listarRelatorioCompleto(req, res, next) {
		try {
        	const { alerta } = req.query;

        	let query = database('telemetria');

        	//Se 'alerta' for igual a 'true', filtra as temperaturas acima de 95
        	if (alerta === 'true') {
            		query = query.where('temperatura_motor', '>', 95);
        	}

        	//Executa a busca no banco de dados
        	const relatorio = await query;

        	return res.status(200).json(relatorio);
    		} catch (error) {
        	next(error);
   		}
	}
}

module.exports = new TelemetriaController();

