--	I n d i c e s
-- 

USE standemigrante;

-- Index
-- Indice para o prazo de Seguro
CREATE INDEX idxVeiculosPrazoSeguro ON veiculos(prazoSeguro);

-- Indice para o prazo de Inspecao
CREATE INDEX idxVeiculosPrazoInspecao ON veiculos(prazoInspecao);

-- Demonstra os indices dos veiculo
-- SHOW INDEX FROM veiculos;

-- Indice para o NIF do Cliente
CREATE INDEX idxClientesNIF ON Clientes(NIF);

-- Demonstra os indices do cliente
SHOW INDEX FROM clientes;

-- Indice para a matricula
CREATE INDEX idxVeiculosMatricula ON veiculos(matricula);

-- Demonstra os indices do veiculo
SHOW INDEX FROM veiculos;

SELECT DISTINCT TABLE_NAME, INDEX_NAME
	FROM INFORMATION_SCHEMA.STATISTICS
	WHERE TABLE_SCHEMA = 'standemigrante';

-- DROP INDEX idxVeiculosPrazoSeguro ON veiculos;
-- DROP INDEX idxVeiculosPrazoInspecao ON veiculos;
-- DROP INDEX idxVeiculosMatricula ON veiculos;
-- DROP INDEX idxClientesNIF ON clientes;