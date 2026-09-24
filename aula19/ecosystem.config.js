module.exports = {
  apps : [{
    name: 'aula19',
    script: './server.js',

    // Configurações gerais
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',

    // Variáveis de ambiente padrão (Desenvolvimento)
    env: {
      NODE_ENV: 'development',
      DB_HOST: 'localhost',
      DB_USER: 'root',
      DB_PASS: 'dev_password'
    },

    // Variáveis de ambiente para Produção (--env production)
    env_production: {
      NODE_ENV: 'production',
      DB_HOST: 'production-db-server',
      DB_USER: 'admin',
      DB_PASS: 'prod_secure_password_123'
    }
  }]
};

