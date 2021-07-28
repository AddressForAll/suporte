# Procedimento de instalação do nodejs e serviços

* nodejs
Referencia: https://nodejs.org/en/download/package-manager/#snap, https://github.com/nodejs/snap 

Instalação do Node.js 14 LTS

<code>
sudo snap install node --classic --channel=14
</code>


* PM2
Referencia: https://github.com/Unitech/pm2

Realiza a parte de serviço do sistema para inicializar o node.js e o site

<code>
sudo npm install pm2 -g
pm2 startup
</code>


Consultar o site acima para outros exemplos

* deployment com usuário comum 

Evitar de usar root para rodar programas com acesso externo

adicionar usuário pm2
<code>
  sudo su - 
  adduser --disabled-password pm2
</code>

adicionar site no pm2
<code>
  sudo su - 
  su - pm2
  cd /var/www/hello
  pm2 start app.js
</code>

Comandos uteis
<code>
  # listar sites
  pm2 list
  # parar site
  pm2 stop site
  # inicialiaz site
  pm2 start site
  # reiniciar site
  pm2 restart site
  #apagar site
  pm2 delete site
  
</code>
