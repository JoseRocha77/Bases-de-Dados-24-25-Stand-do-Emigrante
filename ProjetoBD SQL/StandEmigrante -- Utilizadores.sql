-- Administrador (Sr. José da Lama) com permissões restritas
CREATE USER 'admin_jose'@'localhost' IDENTIFIED BY 'Jose1234';
GRANT SELECT, INSERT, UPDATE, DELETE ON standEmigrante.* TO 'admin_jose'@'localhost';

-- Role para Funcionários
CREATE ROLE 'funcionarios';

-- Permissões do role 'funcionarios'
GRANT SELECT, INSERT, UPDATE ON standEmigrante.Alugueres TO 'funcionarios';
GRANT SELECT, INSERT, UPDATE ON standEmigrante.Clientes TO 'funcionarios';
GRANT SELECT, INSERT, UPDATE ON standEmigrante.Veiculos TO 'funcionarios';
GRANT SELECT, INSERT, UPDATE ON standEmigrante.Pagamentos TO 'funcionarios';

-- Criação dos utilizadores dos funcionários
CREATE USER 'func_jacinto'@'localhost' IDENTIFIED BY 'Jacinto1234';
CREATE USER 'func_maria'@'localhost' IDENTIFIED BY 'Maria1234';
CREATE USER 'func_armando'@'localhost' IDENTIFIED BY 'Armando1234';

-- Atribuição do role 'funcionarios' aos funcionários
GRANT 'funcionarios' TO 'func_jacinto'@'localhost';
GRANT 'funcionarios' TO 'func_maria'@'localhost';
GRANT 'funcionarios' TO 'func_armando'@'localhost';

-- Valério da Lama (apenas leitura de veículos)
CREATE USER 'valerio'@'localhost' IDENTIFIED BY 'Valerio1234';
GRANT SELECT ON standEmigrante.Veiculos TO 'valerio'@'localhost';

-- Atualizar privilégios
FLUSH PRIVILEGES;

