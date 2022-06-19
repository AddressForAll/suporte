
Instalação de verão AddressForAll-compatível do compilador *server-side* da [linguagem Node.js](https://en.wikipedia.org/wiki/Node.js).  

## Procedimento de instalação do NodeJS LTS


1. Antes de instalar, confira se ambiente (SO) precisa mesmo instalação: o comando `node -v` deve retornar **versão compatível** com [diretivas da infraestrutura](https://github.com/AddressForAll/suporte/blob/master/docs/pt/infra.md#ambientes-e-ferramentas-de-uso-geral). <br/> Se existir, mas a versão for inferior ou incompatível (ex. não-LTS) deve-se remover conforme seção "Desinstalando versões incompatíveis" abaixo.
  
2. Conferir também se não existe algum **PPA residual**: o comando `grep node /etc/apt/sources.list.d/*` deve retornar vazio se "ok", ou linhas onde os indícios de versão incompatível podem ser averiguados. <br/>Se não estiver "ok" remover conforme seção "Desinstalando versões incompatíveis" abaixo.

3.  Seguir o Guia, [digitalocean.com/tutorials/how to install NodeJs on Ubuntu 20, Part 2](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04#option-2-installing-node-js-with-apt-using-a-nodesource-ppa).<br/> Resumo: o guia indica como realizar comandos `curl`, `bash /tmp/nodesource_setup.sh` e `apt install nodejs`. Atentar para a escolha da versão, precisa ser aquela indicada pelas [diretivas da infraestrutura](https://github.com/AddressForAll/suporte/blob/master/docs/pt/infra.md#ambientes-e-ferramentas-de-uso-geral).

## Desinstalando versões incompatíveis

Se por acaso já instalou algo com `apt` direto, desinstalar! O comando `apt install nodejs` instala versão muito muito velha. Se foi instalado com PPA mas `node -v` mostra versão velha, também desinstalar. Passo-a-passo:

1. Desinstala do sistema (sem efeito se ausente). `sudo apt purge nodejs`
2. Remove PPA residual (sem efeito se ausente).  `sudo add-apt-repository --remove ppa:chris-lea/node.js`

