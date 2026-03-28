#!/bin/bash
echo "[+] Iniciando HoneyPot en el puerto 22..."
sudo -u cowrie bash -c "cd /home/cowrie/cowrie && source cowrie-env/bin/activate && export PYTHONPATH=\$PYTHONPATH:\$(pwd)/src && python3 -m cowrie.scripts.cowrie start"
echo "[+] ¡Trampa lista! Monitorea con: sudo -u cowrie tail -f /home/cowrie/cowrie/var/log/cowrie/cowrie.log"
