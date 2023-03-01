
Instalação de verão AddressForAll-compatível do compilador *server-side* da [linguagem Node.js](https://en.wikipedia.org/wiki/Node.js).  

## Procedimento de instalação do NodeJS LTS


1. Antes de instalar, confira se ambiente (SO) precisa mesmo instalação: o comando `node -v` deve retornar **versão compatível** com [diretivas da infraestrutura](https://github.com/AddressForAll/suporte/blob/master/docs/pt/infra.md#ambientes-e-ferramentas-de-uso-geral). <br/> Se existir, mas a versão for inferior ou incompatível (ex. não-LTS) deve-se remover conforme seção "Desinstalando versões incompatíveis" abaixo.
  
2. Conferir também se não existe algum **PPA residual**: o comando `grep node /etc/apt/sources.list.d/*` deve retornar vazio se "ok", ou linhas onde os indícios de versão incompatível podem ser averiguados. <br/>Se não estiver "ok" remover conforme seção "Desinstalando versões incompatíveis" abaixo.

3. Seguir o Guia, [nodesource](https://github.com/nodesource/distributions) da versão LTS. Atual a 18

## Desinstalando versões incompatíveis

Se por acaso já instalou algo com `apt` direto, desinstalar! O comando `apt install nodejs` instala versão muito muito velha. Se foi instalado com PPA mas `node -v` mostra versão velha, também desinstalar. Passo-a-passo:

1. Desinstala do sistema (sem efeito se ausente). `sudo apt purge nodejs`
2. Remove PPA residual (sem efeito se ausente).  `sudo add-apt-repository --remove ppa:chris-lea/node.js`

