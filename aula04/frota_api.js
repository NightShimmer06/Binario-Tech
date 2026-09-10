const express = require('express');
const app = express();
const PORT = 3005;

app.use(express.json());

let veiculos = [
	{id: 1, placa: "ABC-1234", montadora: "scania", modelo: "R450", status: "DISPONIVEL"},
	{id: 2, placa: "XYZ-9876", montadora: "Mercedes-Benz", modelo: "Actros", status: "EM_ROTA"}
];

app.get('/api/v1/veiculos', (req, res) => {
	const { status } = req.query;
	if (status) {
		const filtrados = veiculos.filter(v => v.status.toUpperCase() === status.toUpperCase());
		return res.status(200).json(filtrados);
	}
	res.status(200).json(veiculos);
});

app.get('/api/v1/veiculos/:id', (req, res) => {
	const id = parseInt(req.params.id);
	const veiculo = veiculos.find(v => v.id === id);
	if (veiculo) {
		return res.status(404).json({ erro: "veiculo nao encontrado na base de dados."});
	}
	res.status(200).json(veiculo);
});

app.post('/api/v1/veiculos', (req, res) => {
	const { placa, montadora,  modelo } = req.body;
	if (!placa || !montadora || !modelo) {
		return res.status(400).json({erro: "Campos 'placa', 'montadora' e 'modelo' sao obrigatorios."});
	}
	const novoVeiculo = {
		id: veiculos.length + 1,
		placa,
		montadora,
		modelo,
		status: "DISPONIVEL"
	};
	veiculos.push(novoVeiculo);
	res.status(201).json(novoVeiculo);
});

app.patch('/api/v1/veiculos/:id', (req, res) => {
	const id = parseInt(req.params.id);
	const { status } = req.body;
	const veiculo = veiculos.find(v => v.id === id);

	if (!veiculo) {
		return res.status(404).json({ erro: "Veiculo nao encontrado." });
	}
	if (!status) {
		return res.status(400).json({ erro: "O campo 'status' e obrigatorio."});
	}

	veiculo.status = status.toUpperCase();
	res.status(200).json({ mensagem: "Status atualizado com sucesso!", veiculo});
});

app.delete('/api/v1/veiculos/:id', (req, res) => {
	const id = parseInt(req.params.id);
	const index = veiculos.findIndex(v => v.id === id);
	if (index === -1) {
		return res.status(404).json({ erro: "Veiculo nao encontrado."});
	}
	veiculos.splice(index, 1);
	res.status(200).json({ mensagem: `Veiculo ID ${id} removido com sucesso.`
	});
});

app.put('/api/v1/veiculos/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const { placa, montadora, modelo, status } = req.body;
    const index = veiculos.findIndex(v => v.id === id);

    if (index === -1) {
        return res.status(404).json({ erro: "Veiculo nao encontrado." });
    }

    veiculos[index] = { id, placa, montadora, modelo, status: status || "DISPONIVEL" };
    return res.status(200).json(veiculos[index]);
});

app.listen(PORT, () => {
	console.log(`[Binario Tech] API de Frotas rodando em http://localhost:${PORT}`);
});
