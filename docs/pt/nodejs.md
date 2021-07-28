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

