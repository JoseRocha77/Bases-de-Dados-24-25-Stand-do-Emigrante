import csv
import json
import mysql.connector

# Conexão à base de dados
conn = mysql.connector.connect(
    host='localhost',
    user='admin_jose',
    password='Jose1234',
    database='standEmigrante'
)
cursor = conn.cursor()

# Perguntar ao utilizador o formato dos ficheiros
formato = input("Deseja carregar os dados a partir de ficheiros CSV ou JSON? (csv/json): ").strip().lower()

def carregar_csv(nome_ficheiro, callback):
    with open(nome_ficheiro, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)
        for row in reader:
            callback(row)

def carregar_json(nome_ficheiro, callback):
    with open(nome_ficheiro, encoding='utf-8') as jsonfile:
        dados = json.load(jsonfile)
        for registo in dados:
            callback(list(registo.values()))

# Define as funções de inserção para cada tabela
def inserir_stand(row):
    cursor.execute("""
        INSERT INTO Stands (idStand, rua, numero, localidade, codigoPostal, anoAbertura, telefone)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, row)

def inserir_veiculo(row):
    cursor.execute("""
        INSERT INTO Veiculos (idVeiculo, matricula, marca, modelo, cor, anoFabrico, tipoCombustivel, quilometragem, prazoSeguro, prazoInspecao, precoDia, idStand)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, row)

def inserir_funcionario(row):
    cursor.execute("""
        INSERT INTO Funcionarios (idFuncionario, nome, rua, numero, localidade, codigoPostal, dataNascimento, cargo, idStand)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, row)

def inserir_cliente(row):
    cursor.execute("""
        INSERT INTO Clientes (idCliente, nome, nacionalidade, NIF, rua, numero, localidade, codigoPostal)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """, row)

def inserir_aluguer(row):
    row = [None if col == '' else col for col in row]
    cursor.execute("""
        INSERT INTO Alugueres (idAluguer, idVeiculo, idFuncionario, idCliente, dataInicio, dataFinalPrevista, dataFinalEfetiva, valorTotal, tipoPagamento, estado)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, row)

def inserir_pagamento(row):
    cursor.execute("""
        INSERT INTO Pagamentos (idPagamento, idAluguer, valor, dataHora, metodo)
        VALUES (%s, %s, %s, %s, %s)
    """, row)

def inserir_contacto(row):
    cursor.execute("""
        INSERT INTO Contactos (idCliente, contacto)
        VALUES (%s, %s)
    """, row)

# Tabela e função associada
tabelas = [
    ("stands", inserir_stand),
    ("veiculos", inserir_veiculo),
    ("funcionarios", inserir_funcionario),
    ("clientes", inserir_cliente),
    ("alugueres", inserir_aluguer),
    ("pagamentos", inserir_pagamento),
    ("contactos", inserir_contacto)
]

try:
    for nome, funcao in tabelas:
        if formato == 'csv':
            carregar_csv(f"{nome}.csv", funcao)
        elif formato == 'json':
            carregar_json(f"{nome}.json", funcao)
        else:
            raise ValueError("Formato inválido! Utilize 'csv' ou 'json'.")
        print(f"[{nome.capitalize()}] Inseridos com sucesso.")

    conn.commit()
    print("Inserção completa com sucesso.")
except Exception as e:
    print(f"Erro ao carregar dados: {e}")
    conn.rollback()
finally:
    cursor.close()
    conn.close()
