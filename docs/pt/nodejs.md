# Procedimento de instalação do nodejs e serviços

* nodejs
Referencia: https://nodejs.org/en/download/package-manager/#snap, https://github.com/nodejs/snap 

Instalação do Node.js 14 LTS

```
sudo snap install node --classic --channel=14
```


* PM2
Referencia: https://github.com/Unitech/pm2

Realiza a parte de serviço do sistema para inicializar o node.js e o site

```
sudo npm install pm2 -g
pm2 startup
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
  
```
