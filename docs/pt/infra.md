# Infraestrutura do AddressForAl

No presente documento o termo  *infraestrutura* pode ser referente a:

* **infraestrutura de comunicação**: ambientes de comunicação do AddressForAl, por hora apenas [Comunidade aberta](https://dadosabertos.social/c/dados-espaciais/12).

* **infraestrutura básica**: vinculada à manutenção e preservação do patrimônio. Exemplo: gestão técnica dos nomes de domínio, gestão das contas de e-mail `fulano@openstreetmap.com.br`, gestão dos [servidores-web](https://en.wikipedia.org/wiki/Web_server) e dos bancos de dados de uso comum (institucionais ou sendo reutilizados para mais de um projeto).

* **infraestrutura de desenvolvimento**: infra dos projetos... [repositórios git-OSMBrasil](https://github.com/OSMBrasil) de desenvolvimento, servidores-web de teste, bancos de dados temporários, etc.

Quando o termo *infraestrutura* não vier especificado, refere-se ao "caso geral", dado pela união dos casos listados acima.

## Ambientes e ferramentas de uso geral

Designamos de  "ambiente" o sistema operacional, as linguagens de programação e os frameworks de uso geral. Cada um deles deve ser mantido em conformidade com a respectiva **versão estável** (*long term support* - **LTS**). Ambientes que formam o **núcleo da infraestrutura** AddressForAll:

|Ambiente           | Nome    | em 2021     | em 2022       |
|-------------------|---------|-------------|---------------|
| Sistema Operacional (*server*)| **Ubuntu**| 20.04 LTS |  22.04 LTS  | 
| Banco de dados   (*SQL server*)  | **PostgreSQL** | v12 | v14
| *Web Server* | **NGINX** | v1.21  | v1.22|
| *Microservices* (API) server | **PostgREST** |  v8 stable  | v9 stable |
| Framework, website  | **ReactJS** | v17 stable | v18 stable  |
| Framework, website, language   | **NodeJS** |   v16 LTS | v16 LTS |
| Framework, server-side scripts, low-level language | GNU **Bash**  |  v4 | v5 |
| Framework, server-side scripts, high-level language | **Python**  |  v3.8 | v3.9 |
| Framework, server-side orchestration  | GNU **makefile** |v4 | v4 |

