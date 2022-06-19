
Instalação de verão razoável, 

1. Se por acaso já instalou algo com `apt` direto, desinstalar! `apt install nodejs` instala versão muito muito velha. Se foi instalado com PPA mas `node -v` mostra versão velha, também desinstalar. 

     1.1. `sudo apt purge nodejs`


     1.2. Residual PPA?  confira com `grep node /etc/apt/sources.list.d/*`


     1.3. Remova o PPA antigo com `sudo add-apt-repository --remove ppa:chris-lea/node.js`

2.  Seguir o Guia, [digitalocean.com/tutorials/how to install NodeJs on Ubuntu 20, Part 2](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04#option-2-installing-node-js-with-apt-using-a-nodesource-ppa).

-----

## LIXO Perigo, não usar PM2!

### Todo
* Gerenciar logs https://github.com/AddressForAll/suporte/blob/master/docs/pt/pm2-log.md
 
### Procedimento de instalação do nodejs e serviços

* nodejs
Fazer Download do arquivo node-v16.14.2-linux-x64.tar.xz ou uma versão mais nova. Adaptar os caminhos se usar outra versão.
https://nodejs.org/en/download/

Instalação do Node.js 16 LTS seria extrair na pasta /usr/local/node-v16.14.2-linux-x64 e colocar no final do arquivo /home/pm2/.bashrc

```
export PATH=/usr/local/node-v16.14.2-linux-x64/bin/:$PATH
```

* PM2
Referencia: https://github.com/Unitech/pm2

Realiza a parte de serviço do sistema para inicializar o node.js e o site

```
sudo npm install pm2 -g
```

```
su - pm2
pm2 startup
#copiar a linha gerada para /etc/rc.local 
```



Consultar o site acima para outros exemplos

* deployment com usuário comum 

Evitar de usar root para rodar programas com acesso externo

adicionar usuário pm2
```
  sudo su - 
  adduser --disabled-password pm2
```

adicionar site no pm2
```
  sudo su - 
  su - pm2
  cd /var/www/hello
  pm2 start app.js
```

Comandos uteis
```
  #listar sites 
  pm2 list
  
  #parar site 
  pm2 stop site
  
  #inicialiaz site 
  pm2 start site
  
  #reiniciar site 
  pm2 restart site
  
  #apagar site
  pm2 delete site
  
  #update site
  pm2 update app.js
  
  
```

Colocar site no boot
```
  pm2 start site
  pm2 save
  pm2 startup
  #copiar a linha gerada para /etc/rc.local 

```

Colocar o site a4a no ar
```
yarn start
pm2 start yarn --name api -- start
```
