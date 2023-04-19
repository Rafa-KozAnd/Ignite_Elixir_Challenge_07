<p align="center">
  <img src="http://img.shields.io/static/v1?label=STATUS&message=Concluded&color=blue&style=flat"/>
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/Rafa-KozAnd/Ignite_Elixir_Challenge_07">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/top/Rafa-KozAnd/Ignite_Elixir_Challenge_07">
  <img alt="GitHub repo file count" src="https://img.shields.io/github/directory-file-count/Rafa-KozAnd/Ignite_Elixir_Challenge_07">
  <img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/Rafa-KozAnd/Ignite_Elixir_Challenge_07">
  <img alt="GitHub language count" src="https://img.shields.io/github/license/Rafa-KozAnd/Ignite_Elixir_Challenge_07">
</p>

# Ignite_Elixir_Challenge_07

Elixir challenge done with 'Rocketseat' Ignite course. ("Desafio 07 - Consumindo APIs &amp; Testando requisições com bypass &amp; Autenticação JWT &amp; Token refresh")


# Desafio - Consumindo APIs
## 💻 Sobre o desafio

Nesse desafio, você deverá criar uma aplicação que consome a API do GitHub retornando a lista de repositórios de um usuário informado.
A rota para obter esse dado da API é `[https://api.github.com/users/danilo-vieira/repos](https://api.github.com/users/danilo-vieira/repos)` onde **danilo-vieira** deverá ser o nome do usuário que está solicitando a lista de repositórios, ou seja, esse dado deve ser dinâmico.

# Desafio - Testando requisições com bypass
## 💻 Sobre o desafio

Nesse desafio, você deverá testar o cliente criado no desafio anterior usando a lib bypass (link: https://github.com/PSPDFKit-labs/bypass) aplicando tudo que aprendeu até agora!

# Desafio - Autenticação JWT
## 💻 Sobre o desafio

Nesse desafio, você irá implementar uma nova feature para a aplicação desenvolvida no desafio Consumindo APIs.
A aplicação deve possuir uma entidade User onde cada usuário possuirá apenas um id e senha. Ao fazer uma requisição para a rota de criação de usuários, deve ser enviado apenas a senha a ser cadastrada para o novo usuário, já o id deverá ser gerado pelo servidor e retornado no corpo da resposta.

# Desafio - Token refresh
## 💻 Sobre o desafio

Continuando com o código implementado no desafio Autenticação JWT, você deverá customizar o tempo de validade de um token para um minuto e renovar ele a cada requisição feita desde que ainda esteja válido.
