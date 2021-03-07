# Usando o Quantum-GIS na A4A

[QGIS](https://en.wikipedia.org/wiki/QGIS) é uma das ferramentas eleitas pelo Instituto AddressForAll para efetivar seus propósitos e instrumentalizar a sua equipe e comunidade.

É um software livre com código-fonte aberto, multiplataforma de SIG ([sistema de informação geográfica](https://pt.wikipedia.org/wiki/Sistema_de_informa%C3%A7%C3%A3o_geogr%C3%A1fica)). Em particular:

* Roda nos sistemas **Ubuntu** e **Windows**;

* Abre arquivos **GeoJSON** e conecta com banco de dados **PostreSQL**. 

A presente documentação tem como escopo apenas os elementos destacados em negrito.

## Conexão com server

QGIS com servidor online da AddressForAll... requer conexão SSH por segurança... 

### No Ubuntu

Create a localhost:port for a SSH tunnel, as described by this answer:   https://askubuntu.com/a/539953/439867

... Um tunel postgres

`ssh -L localhost:5432:localhost:5432 -o ServerAliveInterval=5 fulano@addressforall.org`

![](_assets/usingTolls-QGIS-box1.jpeg)

![](_assets/usingTolls-QGIS-box2.jpeg)

... No qgis, botão direito no postgis, nova conexão

...
 
### No Windows

Apesar do sistema operacional preferencial da A4A ser o Linux, para usuários finais é dada a opção de, em tarefas menos crítcas, usar o Windows. 

A visualização de dados por QGIS é uma destas tarefas, mas ainda assim se for conectar com o servidor online, são solicitaods critérios adicionais de segurança e isolamento do Windows. Usuários Windows possuem a **restrição de acesso apenas para leitura**.
 
Como o Windows não tem um ambiente de sistema interoperável, seu terminal (tela preta DOS) não realiza as tarefas mínimas de interoperabilidade de sistemas abertos.
A solução é usar uma das ferramentas complementares, que podem ser o antigo [PuTTY](https://www.putty.org/) ou o moderno [MobaXterm](https://mobaxterm.mobatek.net/), que oferece também SFTP integrado. Na A4A optamos pelo Moba.

...



