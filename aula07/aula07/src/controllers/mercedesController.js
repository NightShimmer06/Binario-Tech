let telemetriaMercedes = [
        {id: 1, modelo: "Actros", vin: "9CT123456789", temperatura_motor: 88, status: "OK"},
        {id: 2, modelo: "Atego", vin: "9CT987654321", temperatura_motor: 102, status: "ALERTA_AQUECIMENTO"}
];

const mercedesController = {
        listarTelemetria: (req, res) => {
                res.status(200).json({ montadora: "Mercedes-Benz", dados: telemetriaMercedes });
        },

        registrarTelemetria: (req, res) => {
                const { modelo, vin, temperatura_motor } = req.body;

                if (!modelo || !vin) {
                res.status(400).json({ mensagem: "Campos 'modelo' e 'vin' sao obrigatorios." });
                }

                const novoRegistro = {
                        id: telemetriaMercedes.length + 1,
                        modelo,
                        vin,
                        temperatura_motor: temperatura_motor || 85,
                        status: temperatura_motor > 95 ? "ALERTA_AQUECIMENTO" : "OK"
                };

                telemetriaMercedes.push(novoRegistro);
                res.status(201).json(novoRegistro);
        }
};

module.exports = mercedesController;
