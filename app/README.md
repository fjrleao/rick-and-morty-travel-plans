# Introdução

Esse projeto se trata de uma API Rest para controle de viagens interdimensionais dentro dos planetas do universo de Rick e Morty. Com isso, é possível cadastrar, listar, atualizar e excluir um plano de viagem. Para cada plano de viagem, é cadastrado uma lista de planetas em que a viagem irá passar. A API conta também com recursos para otimizar a rota dos planetas e expandir as informações dos planetas em que a viagem irá passar.

## Instalação e execução

Para executar o projeto, basta fazer o clone desse repositório e usar o docker-compose na execução. O docker vai subir tanto o container da aplicação quanto o container do banco de dados, vai criar um novo banco e executar as migrações necessárias.

```
docker-compose up
```

Com o container no ar, basta fazer chamadas HTTP à API através do endereço http://localhost:3000.

## Documentação

Para ver a documentação das rotas, acesse [/docs](http://localhost:3000/docs) quando o projeto estiver executando.
