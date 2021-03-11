#!/bin/bash

apt install -y apache2

cat << 'EOF' > /usr/local/bin/atividade.sh
#!/bin/bash

while true
do
   DATA=$(date +%D-%H:%M:%S)
   TIME_START=$(uptime | tr ',' ' ' | tr -s [:space:] ' ' | cut -d' ' -f4)
   LOAD_AVERAGE=$(uptime | tr -s [:space:] ' ' | cut -d' ' -f10-)
   MEM_USE=$(free -m | grep  'Mem' | tr -s [:space:] ' ' | cut -d' ' -f3)
   MEM_FREE=$(free -m | grep  'Mem' | tr -s [:space:] ' ' | cut -d' ' -f7)
   RECEIVE=$(cat /proc/net/dev | grep -e "eth0" | tr -s [:space:] ' ' | cut -d' ' -f3)
   TRANSMIT=$(cat /proc/net/dev | grep -e "eth0" | tr -s [:space:] ' ' | cut -d' ' -f11)
   echo "$DATA - $TIME_START - $LOAD_AVERAGE - $MEM_USE - $MEM_FREE - $RECEIVE - $TRANSMIT" >> /var/log/mensagens.log

    echo '<!DOCTYPE html>
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
</html>' > /var/www/html/index.html

   sleep 5
done
EOF

chmod 744 /usr/local/bin/atividade.sh

cat << 'EOF' > /etc/systemd/system/my-script.service
[Unit]
After=network.target

[Service]
ExecStart=/usr/local/bin/atividade.sh

[Install]
WantedBy=default.target" 
EOF

chmod 664 /etc/systemd/system/my-script.service

systemctl daemon-reload

systemctl enable my-script.service

systemctl start my-script.service
