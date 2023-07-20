# Rick e Morty Travel Plans

## Descrição do projeto

Esse projeto se trata de uma API Rest para o controle de viagens interdimensionais dentro dos planetas do universo de Rick e Morty. Com isso, é possível cadastrar, listar, atualizar e excluir um plano de viagem. Para cada
plano de viagem, é cadastrado uma lista de planetas em que a viagem irá passar.

A API conta também com recursos para otimizar e expandir a rota dos planetas em que a viagem irá passar, sendo usado a [The Rick and Morty API](https://rickandmortyapi.com/) para obter os dados de cada planeta, tornando possível a expansão e otimização dos dados.

## Instalação e execução

Para executar o projeto, basta fazer o clone desse repositório e usar o docker-compose. O docker vai subir o container da aplicação e do banco de dados, já executando as migrações necessárias.

```
docker-compose up
```

Com o container no ar, basta fazer chamadas HTTP à API através do endereço http://localhost:3000.

<!-- ## Documentação

Para visualizar a documentação das rotas da API, acesse [/docs](http://localhost:3000/docs) quando o projeto estiver executando, ou acesse a [documentação online](https://docs-milenio-challenge.vercel.app/). -->

---

## Tecnologias

As seguintes ferramentas foram usadas:

- [Crystal Programming Language](https://crystal-lang.org/)
- [Kemal Web Framework](https://kemalcr.com/)
- [Jennifer ORM](https://imdrasil.github.io/)
- [Docker](https://www.docker.com/)

## Autor

Fábio Júnior

- [Github](https://github.com/fjrleao)
