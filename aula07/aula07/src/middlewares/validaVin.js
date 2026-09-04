const validaVin = (req, res, next) => {
  const { vin } = req.body;

  // Verifica se o VIN foi enviado e se tem exatamente 12 caracteres
  if (!vin || vin.length !== 12) {
    return res.status(400).json({ 
      error: 'O código VIN deve possuir exatamente 12 caracteres.' 
    });
  }

  // Passa para o próximo passo se estiver correto
  next();
};

module.exports = validaVin;

/* 
======================================================================
ENUNCIADO DO EXERCÍCIO
======================================================================
Exercício 03:
Crie um middleware exclusivo de validação de Chassis/VIN em 'src/middlewares/validaVin.js' 
que garante que o código VIN enviado no POST possua exatamente 12 caracteres.
======================================================================
COMO SE CHEGA NESSE CÓDIGO? (PASSO A PASSO DO RACIOCÍNIO LÓGICO)
===============================================================================

1. ENTENDER O QUE É UM MIDDLEWARE:
   Um middleware no Express é como um "guarda de trânsito" entre a requisição do usuário 
   e a rota final. Ele precisa receber 3 coisas básicas: (req, res, next).
   
2. IDENTIFICAR ONDE ESTÁ O DADO:
   O exercício diz que o dado é enviado em um "POST". Em APIs REST, dados enviados via POST 
   ficam guardados dentro do corpo da requisição, ou seja, em `req.body`.

3. DEFINIR A REGRA DE NEGÓCIO (A VALIDAÇÃO):
   O enunciado pede que o VIN tenha exatamente 12 caracteres. 
   Então pensamos na negação: "Se o VIN NÃO existir OU o tamanho do VIN for DIFERENTE de 12...".
   Isso vira o código: `if (!vin || vin.length !== 12)`.

4. TRATAR O ERRO:
   Se a regra acima falhar, a API precisa parar e avisar o usuário. 
   O padrão HTTP para dados enviados errados é o status 400 (Bad Request).
   Usamos `return res.status(400).json(...)` para enviar a mensagem e encerrar o fluxo ali mesmo.

5. LIBERAR O ACESSO (O "SINAL VERDE"):
   Se o código passar pelo teste do `if` sem dar erro, significa que o VIN é válido.
   Para a API não ficar travada, chamamos a função `next()`, que diz: "Pode seguir para a rota!".

6. EXPORTAR O MÓDULO:
   Como o arquivo está na pasta separada 'src/middlewares', precisamos usar o 
   `module.exports` para que os arquivos de rotas consigam enxergar e usar essa função.
*/

