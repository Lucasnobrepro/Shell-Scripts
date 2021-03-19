#!/bin/bash

# Install Apache
apt install -y apache2

# Escrevendo um script no servidor viar userData
cat << 'EOF' > /usr/local/bin/ativ16.sh
#!/bin/bash

   DATA=$(date +%D-%H:%M:%S)
   TIME_START=$(uptime | tr ',' ' ' | tr -s [:space:] ' ' | cut -d' ' -f4)
   LOAD_AVERAGE=$(uptime | tr -s [:space:] ' ' | cut -d' ' -f10-)
   MEM_USE=$(free -m | grep  'Mem' | tr -s [:space:] ' ' | cut -d' ' -f3)
   MEM_FREE=$(free -m | grep  'Mem' | tr -s [:space:] ' ' | cut -d' ' -f7)
   RECEIVE=$(cat /proc/net/dev | grep -e "eth0" | tr -s [:space:] ' ' | cut -d' ' -f3)
   TRANSMIT=$(cat /proc/net/dev | grep -e "eth0" | tr -s [:space:] ' ' | cut -d' ' -f11)
   echo "$DATA - $TIME_START - $LOAD_AVERAGE - $MEM_USE - $MEM_FREE - $RECEIVE - $TRANSMIT" >> /var/log/mensagens.log

   cat << EOT > /var/www/html/index.html
<!DOCTYPE html>
<html>
    <head>
        <title>Scripts </title>
    </head>

    <body>
      <p>Aluno: Francisco Lucas Sousa Nobre</p>
      <p> Matricula:392030</p>
      <p>
        
      </p>
      <p>O horário e data da coleta de informações:  $DATA  </p>
      <p>Tempo que a máquina está ativa: $TIME_START</p>
      <p>Carga média do sistema: $LOAD_AVERAGE</p>
      <p>Quantidade de memória livre: $MEM_FREE</p>
      <p>Quantidade de memória ocupada: $MEM_USE </p>
      <p>Quantidade de bytes recebidos e enviados através da interface eth0: $TRANSMIT </p>
  
  </body>
</html>
EOT
EOF

# Dar permisão
chmod 744 /usr/local/bin/ativ16.sh

# Insere no CRON
echo "*/1 *   * * *   root    /usr/local/bin/ativ16.sh" >> /etc/crontab
