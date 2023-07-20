# Rick e Morty Travel Plans

Esse projeto se trata de uma API REST para o controle de viagens interdimensionais dentro dos planetas do universo de Rick e Morty. Com isso, é possível cadastrar, listar, atualizar e excluir os planetas por onde uma determinada viagem interdiomensional irá passar. A API conta também com recursos para otimizar e expandir a rota dos planetas em que a viagem irá passar, sendo usado a [The Rick and Morty API](https://rickandmortyapi.com/) para obter os dados de cada planeta, tornando possível a expansão e otimização dos dados.

## Executando o projeto

Para executar o projeto, basta fazer o clone desse repositório e usar o docker-compose:

```
docker-compose up
```

O docker vai subir o container da aplicação e do banco de dados, já executando as migrações necessárias. Quando o docker compose inicializar todos os containers, basta fazer chamadas HTTP à API através do endereço `http://localhost:3000`.

## Documentação

Consulte a **[documentação de rotas das API](https://fjrleao.github.io/rick-and-morty-travel-plans/)** para saber mais detalhes sobre cada rota.

## Tecnologias

As seguintes ferramentas foram usadas:

- [Crystal Programming Language](https://crystal-lang.org/)
- [Kemal Web Framework](https://kemalcr.com/)
- [Jennifer ORM](https://imdrasil.github.io/)
- [Docker](https://www.docker.com/)
