import csv
import json
import mysql.connector

# Conexão à base de dados
conn = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="stand_emigrante"
)
cursor = conn.cursor()

# Função genérica para executar inserts
def executar_insert(sql, valores):
    cursor.execute(sql, valores)

# Função para importar CSV
def importar_csv(ficheiro, sql, campos):
    with open(ficheiro, mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            valores = tuple(row[campo] for campo in campos)
            executar_insert(sql, valores)

# Função para importar JSON
def importar_json(ficheiro, sql, campos):
    with open(ficheiro, encoding='utf-8') as f:
        dados = json.load(f)
        for registo in dados:
            valores = tuple(registo[campo] for campo in campos)
            executar_insert(sql, valores)

# Tabelas e queries associadas
tabelas = [
    {
        "nome": "Clientes",
        "ficheiros": ["clientes.csv", "clientes.json"],
        "sql": "INSERT INTO Clientes (idCliente, nome, nacionalidade, NIF, rua, numero, localidade, codigoPostal) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
        "campos": ["idCliente", "nome", "nacionalidade", "NIF", "rua", "numero", "localidade", "codigoPostal"]
    },
    {
        "nome": "Contactos",
        "ficheiros": ["contactos.csv"],
        "sql": "INSERT INTO Contactos (idCliente, contacto) VALUES (%s, %s)",
        "campos": ["idCliente", "contacto"]
    },
    {
        "nome": "Stands",
        "ficheiros": ["stands.csv"],
        "sql": "INSERT INTO Stands (idStand, rua, numero, localidade, codigoPostal, anoAbertura, nrFuncionarios, nrCarros, telefone) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        "campos": ["idStand", "rua", "numero", "localidade", "codigoPostal", "anoAbertura", "nrFuncionarios", "nrCarros", "telefone"]
    },
    {
        "nome": "Funcionarios",
        "ficheiros": ["funcionarios.csv"],
        "sql": "INSERT INTO Funcionarios (idFuncionario, nome, rua, numero, localidade, codigoPostal, dataNascimento, cargo, idStand) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        "campos": ["idFuncionario", "nome", "rua", "numero", "localidade", "codigoPostal", "dataNascimento", "cargo", "idStand"]
    },
    {
        "nome": "Veiculos",
        "ficheiros": ["veiculos.csv"],
        "sql": "INSERT INTO Veiculos (idVeiculo, matricula, marca, modelo, cor, anoFabrico, tipoCombustivel, quilometragem, estado, prazoSeguro, prazoInspecao, precoDia, idStand) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
        "campos": ["idVeiculo", "matricula", "marca", "modelo", "cor", "anoFabrico", "tipoCombustivel", "quilometragem", "estado", "prazoSeguro", "prazoInspecao", "precoDia", "idStand"]
    },
    {
        "nome": "Alugueres",
        "ficheiros": ["alugueres.csv"],
        "sql": "INSERT INTO Alugueres (idAluguer, idVeiculo, idFuncionario, idCliente, dataInicio, dataFinalPrevista, dataFinalEfetiva, valorTotal, tipoPagamento, estado) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
        "campos": ["idAluguer", "idVeiculo", "idFuncionario", "idCliente", "dataInicio", "dataFinalPrevista", "dataFinalEfetiva", "valorTotal", "tipoPagamento", "estado"]
    },
    {
        "nome": "Pagamentos",
        "ficheiros": ["pagamentos.csv"],
        "sql": "INSERT INTO Pagamentos (idPagamento, idAluguer, valor, dataHora, metodo) VALUES (%s, %s, %s, %s, %s)",
        "campos": ["idPagamento", "idAluguer", "valor", "dataHora", "metodo"]
    }
]

# Correr importação de todas as tabelas
for tabela in tabelas:
    print(f"Migrar dados para a tabela {tabela['nome']}...")
    for ficheiro in tabela["ficheiros"]:
        if ficheiro.endswith(".csv"):
            importar_csv(ficheiro, tabela["sql"], tabela["campos"])
        elif ficheiro.endswith(".json"):
            importar_json(ficheiro, tabela["sql"], tabela["campos"])

# Confirmar alterações
conn.commit()
print("Migração concluída com sucesso!")
conn.close()
