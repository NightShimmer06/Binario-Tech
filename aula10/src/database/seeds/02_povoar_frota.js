exports.seed = async function(knex) {

  // Insere os 2 novos veículos de teste
  await knex('veiculos').insert([
    { placa: 'MER-3030', montadora: 'Mercedes-Benz', modelo: 'Actros' },
    { placa: 'DAF-4040', montadora: 'DAF', modelo: 'XF' }
  ]);
};

