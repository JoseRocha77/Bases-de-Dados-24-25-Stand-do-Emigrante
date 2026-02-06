-- Povoamento Stands
INSERT INTO Stands
	(idStand, rua, numero, localidade, codigoPostal, anoAbertura, telefone)
	VALUES
	('1', 'Avenida Dr. João Lobo', '46', 'Vila Verde', '4730-752', '1990', '253956012'),
    ('2', 'Largo São José do Rio', '23', 'Braga', '4700-487', '1998', '253105823'),
    ('3', 'Rua do Arranjinho', '9', 'Barcelos', '4750-145', '2000', '253436381');


-- Povoamento Veiculos
INSERT INTO Veiculos
	(idVeiculo, matricula, marca, modelo, cor, anoFabrico, tipoCombustivel, quilometragem, prazoSeguro, prazoInspecao, precoDia, idStand)
    VALUES
    ('1', '12-VA-76', 'Mercedes', 'Class A', 'Cinzento', '2018', 'Diesel', '120000', '2026/01/12', '2027/02/16', '40.00', '1'),
	('2', 'BG-01-TY', 'Renault', 'Clio', 'Branco', '2017', 'Gasolina', '95000', '2025/06/15', '2026/06/15', '25.00', '1'),
	('3', 'IU-70-PO', 'Porsche', 'Carrera S', 'Preto', '2021', 'Diesel', '40000', '2025/10/28', '2026/03/20', '750.00', '2'),
	('4', '01-AA-10', 'Seat', 'Ibiza', 'Cinzento', '2014', 'Diesel', '180000', '2025/08/02', '2027/04/05', '28.00', '2'),
	('5', '45-LB-03', 'Volkswagen', 'Golf', 'Azul', '2019', 'Gasolina', '70000', '2026/01/01', '2027/01/01', '35.00', '3'),
	('6', '07-CR-07', 'Toyota', 'Yaris', 'Vermelho', '2020', 'Híbrido', '50000', '2026/03/01', '2027/03/01', '32.00', '3');


-- Povoamento Funcionarios
INSERT INTO Funcionarios
	(idFuncionario, nome, rua, numero, localidade, codigoPostal, dataNascimento, cargo, idStand)
    VALUES
    ('1', 'Jacinto Silva da Lama', 'Rua das Oliveiras', '12', 'Vila Verde', '4730-123', '1980-05-14', 'Funcionário', '1'),
    ('2', 'Maria Arminda do Céu Costa', 'Avenida do Mar', '45', 'Vila Verde', '4730-087', '1975-08-22', 'Funcionário', '2'),
    ('3', 'Armando Quintino Barbosa', 'Travessa do Sol', '8', 'Famalicão', '4760-250', '1990-03-10', 'Funcionário', '3');


-- Povoamento Clientes
INSERT INTO Clientes
	(idCliente, nome, nacionalidade, NIF, rua, numero, localidade, codigoPostal)
    VALUES
    ('1', 'João Ferreira', 'Portuguesa', '123456789', 'Rua do Tejo', '15', 'Lisboa', '1100-451'),
    ('2', 'Sofia Marques', 'Portuguesa', '987654321', 'Avenida da Liberdade', '200', 'Porto', '4000-100'),
    ('3', 'Carlos Hernández', 'Espanhola', '567891234', 'Calle Mayor', '10', 'Madrid', '28013'),
    ('4', 'Albino Santos', 'Portugusa', '394857162', 'Avenida Portugal', '35', 'Braga', '3700-421'),
    ('5', 'Joana Sousa', 'Portuguesa', '736491028', 'Rua da Dobrinha', '76', 'Aveiro', '3800-982');
    


-- Povoamneto Alugueres
INSERT INTO Alugueres
	(idAluguer, idVeiculo, idFuncionario, idCliente, dataInicio, dataFinalPrevista, dataFinalEfetiva, valorTotal, tipoPagamento, estado)
	VALUES
	(1, 1, 1, 1, '2024-05-01 09:00:00', '2024-05-07 09:00:00', '2024-05-07 08:50:00', 280.00, 'A Pronto', 'Inativo'),
	(2, 3, 2, 2, '2024-05-15 14:00:00', '2024-05-20 14:00:00', '2024-05-21 10:00:00', 4500.00, 'Parcial', 'Inativo'),
	(3, 6, 3, 3, '2024-06-01 10:00:00', '2024-06-10 10:00:00', NULL, 288.00, 'A Pronto', 'Ativo'),
    (4, 4, 2, 4, '2025-06-01 09:00:00', '2025-06-06 16:00:00', NULL, 160.00, 'Parcial', 'Ativo'),
    (5, 5, 3, 1, '2025-04-23 10:00:00', '2025-04-25 18:00:00', '2025-04-25 18:00:00', 70.00, 'A Pronto', 'Inativo');
    
    
-- Povoamento Pagamento
INSERT INTO Pagamentos
	(idPagamento, idAluguer, valor, dataHora, metodo)
	VALUES
	(1, 1, 280.00, '2024-05-01 09:10:00', 'Cartão'),
	(2, 2, 2250.00, '2024-05-15 14:30:00', 'Transferência Bancária'),
	(3, 2, 2250.00, '2024-05-20 14:00:00', 'Transferência Bancária'),
	(4, 3, 288.00, '2024-06-01 10:15:00', 'Dinheiro'),
    (5, 4, 80.00, '2025-06-06 16:00:00', 'Dinheiro'),
    (6, 5, 70.00, '2025-04-23 10:00:00', 'Cartão');
    

-- Povoamento Contactos
INSERT INTO contactos (idCliente, contacto)
VALUES
	(1, '+351 912345678'),
	(1, '+33 612345678'),
	(2, '+351 932112233'),
	(3, '+351 911998877'),
	(3, '+34 612345678'),
    (4, '+351 968204918'),
    (5, '+351 927591112');