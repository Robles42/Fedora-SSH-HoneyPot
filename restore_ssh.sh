#!/bin/bash

# =================================================================
# Script de Restauración: SSH Real a Puerto 22
# Autor: Carlos Santiago Sanchez Robles (Robles42)
# =================================================================

echo "[*] Deteniendo el HoneyPot Cowrie..."
sudo pkill -u cowrie

# 1. Quitar permisos especiales al binario de Python
echo "[*] Revocando capabilities de red..."
sudo setcap -r /home/cowrie/cowrie/cowrie-env/bin/python3 2>/dev/null

# 2. Restaurar configuración de SSH Real
echo "[*] Devolviendo SSH Real al puerto 22..."
sudo sed -i 's/Port 2222/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config

# 3. Ajustar Firewall
echo "[*] Limpiando reglas de firewall..."
sudo firewall-cmd --remove-port=2222/tcp --permanent 2>/dev/null
sudo firewall-cmd --remove-port=22222/tcp --permanent 2>/dev/null
sudo firewall-cmd --add-service=ssh --permanent
sudo firewall-cmd --reload

# 4. Reactivar SELinux (Modo Enforcing)
echo "[*] Reactivando SELinux..."
sudo setenforce 1

# 5. Reiniciar servicio SSH
echo "[*] Reiniciando servicio SSH real..."
sudo systemctl restart sshd

echo -e "\n[+] SISTEMA RESTAURADO"
echo "[+] Tu SSH real ahora escucha de nuevo en el puerto 22."
