# Instalação
Logado como usuário pm2
```
pm2 install pm2-logrotate
```

# Configuração
```
#Reter 60 arquivos de logs
pm2 set pm2-logrotate:retain 60
#Compactar os arquivos
pm2 set pm2-logrotate:compress true
```
( Regerencia https://github.com/keymetrics/pm2-logrotate#configure )

