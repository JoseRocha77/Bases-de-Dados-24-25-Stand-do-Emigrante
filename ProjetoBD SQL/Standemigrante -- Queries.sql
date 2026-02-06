USE standemigrante;

-- Verificar o cliente que tem o NIF '123456789' 
SELECT Clientes.*
	FROM Clientes
    WHERE NIF = '123456789';
    
-- Selecionar veiculos cujo prazo de Seguro esteja a acabar nos proximos 60 e fazer um count de cada aluguer que esse carro ja tenha dias ordenado pelo prazoSeguro
SELECT V.idVeiculo, V.marca, V.modelo, V.prazoSeguro, COUNT(A.idAluguer) AS totalAlugueres
	FROM Veiculos V
		LEFT JOIN Alugueres A ON V.idVeiculo = A.idVeiculo
			WHERE V.prazoSeguro BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 60 DAY) -- Quem escolhe so existe 1 carro
	GROUP BY V.idVeiculo, V.marca, V.modelo, V.prazoSeguro
ORDER BY V.prazoSeguro ASC;

-- M01
SELECT COUNT(*) AS totalAlugueresMesAtual
FROM Alugueres
WHERE dataFinalEfetiva IS NOT NULL
  AND MONTH(dataFinalEfetiva) = MONTH(NOW())
  AND YEAR(dataFinalEfetiva) = YEAR(NOW());

-- M02 ->
SELECT SUM(valorTotal) AS receitaMesAtual
FROM Alugueres
WHERE dataFinalEfetiva IS NOT NULL
  AND MONTH(dataFinalEfetiva) = MONTH(NOW())
  AND YEAR(dataFinalEfetiva) = YEAR(NOW());

-- M02 
SELECT SUM(valorTotal) AS receitaTotal
FROM Alugueres
WHERE dataFinalEfetiva IS NOT NULL;

-- Teste do indice que criamos para prazoInspecao
SELECT idVeiculo, matricula, marca, modelo, prazoInspecao
	FROM Veiculos
ORDER BY prazoInspecao ASC;

-- M10
SELECT A.idAluguer, A.idVeiculo, A.idCliente, A.dataInicio, A.dataFinalPrevista, A.dataFinalEfetiva, A.estado
	FROM standEmigrante.Alugueres AS A
	WHERE A.dataFinalEfetiva IS NULL OR A.dataFinalEfetiva > NOW();
    
-- M07 -> O sistema deverá ser capaz de fornecer um relatório completo sobre cada aluguer e o seu pagamento. 
SELECT a.idAluguer, a.dataInicio, a.dataFinalPrevista, a.dataFinalEfetiva,
		a.valorTotal, a.tipoPagamento, a.estado, p.idPagamento, p.valor AS valorPago
	FROM Alugueres a JOIN Pagamentos p ON a.idAluguer = p.idAluguer
ORDER BY a.idAluguer;
    
-- M09 -> O sistema deverá permitir a emissão de faturas e recibos para os clientes, contendo o seu nome, NIF, o respetivo aluguer, a data de início e o valor. 
SELECT c.nome AS nomeCliente, c.NIF, a.idAluguer, a.dataInicio, a.valorTotal AS valorFatura, a.tipoPagamento
	FROM Alugueres a
		JOIN (
			SELECT idAluguer, SUM(valor) AS valorPago
			FROM Pagamentos
			GROUP BY idAluguer
		) AS pagamentos ON a.idAluguer = pagamentos.idAluguer
			JOIN Clientes c ON a.idCliente = c.idCliente
	WHERE pagamentos.valorPago = a.valorTotal;

-- M05 -> O sistema deverá ser capaz de apresentar os alugueres cujo pagamento não tenha sido concluído, caso o tipo de pagamento escolhido seja parcial. 
SELECT 	a.idAluguer, c.nome AS nomeCliente, c.NIF, a.dataInicio, a.dataFinalPrevista, a.valorTotal,
		p.valorPago AS valorPago, (a.valorTotal - p.valorPago) AS valorEmFalta
	FROM Alugueres a
		JOIN Clientes c ON a.idCliente = c.idCliente
			LEFT JOIN (
				SELECT idAluguer, SUM(valor) AS valorPago
					FROM Pagamentos
				GROUP BY idAluguer
			) p ON a.idAluguer = p.idAluguer
	WHERE a.tipoPagamento = 'Parcial'AND p.valorPago < a.valorTotal;

-- VIEWS!!
-- M04 -> O sistema deverá diferenciar os veículos que estão disponíveis daqueles que se encontram alugados ou em manutenção. 
CREATE VIEW VeiculosDisponiveis AS
SELECT v.*
	FROM Veiculos v
WHERE v.idVeiculo NOT IN (
    SELECT idVeiculo
		FROM Alugueres
    WHERE estado = 'Ativo'
);

SELECT * FROM VeiculosDisponiveis;

-- View dos clientes e dos pagamentos que os mesmos fizeram
CREATE VIEW ResumoClientes AS
SELECT c.idCliente, c.nome, COUNT(a.idAluguer) AS totalAlugueres, SUM(a.valorTotal) AS totalGasto
	FROM Clientes c
		LEFT JOIN Alugueres a ON c.idCliente = a.idCliente
GROUP BY c.idCliente, c.nome;

SELECT * FROM ResumoClientes;

-- M03 -> O sistema deverá alertar sobre os prazos de inspeção e seguros próximos do vencimento (até 30 dias).  
CREATE VIEW VeiculosSeguroAVencer AS
SELECT idVeiculo, matricula, marca, modelo, prazoSeguro
	FROM Veiculos
WHERE prazoSeguro BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY)
ORDER BY prazoSeguro;

CREATE VIEW VeiculosInspecaoAVencer AS
SELECT idVeiculo, matricula, marca, modelo, prazoInspecao
	FROM Veiculos
WHERE prazoInspecao BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY)
ORDER BY prazoInspecao;

SELECT * FROM VeiculosInspecaoAVencer;
SELECT * FROM VeiculosSeguroAVencer;

-- DROP VIEW VeiculosInspecaoAVencer;
-- DROP VIEW VeiculosSeguroAVencer;