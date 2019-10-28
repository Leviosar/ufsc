### Sistema de livraria

O código pode ser rodado em qualquer sistema operacional, usando apenas bibliotecas padrões do Python, com execeção do PIL e o Tkinter que em alguns distribuições Linux devem ser baixadas separadamente

### Estrutura do projeto

Como o tempo era curto, são apenas duas telas principais, a primeira tela faz o cadastro e o login do usuário. Por padrão, estou colocando em um arquivo .json lido pelo sistema um usuário com as seguintes credenciais:

- login: alex
- senha: professor

Para adicionar novos usuários basta colocar os dados nos inputs da primeira tela e clicar em "Sign up", esses novos usuários serão salvos apenas durante a execução do script, não havendo persistência de dados neste caso.

A segunda tela mostra a listagem dos livros disponíveis na livraria, essa listagem constitui de 13,7k livros, consumidos a partir de um arquivo CSV retirado de um open dataset. Os dados do livro são titulo, autor e isbn.