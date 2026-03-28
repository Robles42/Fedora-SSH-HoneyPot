from scapy.all import sniff, IP, TCP, UDP, ICMP

def packet_callback(packet):
    if packet.haslayer(IP):
        ip_src = packet[IP].src
        ip_dst = packet[IP].dst
        protocol = packet[IP].proto
        
        # Determinar el nombre del protocolo
        proto_name = "OTRO"
        if protocol == 6: proto_name = "TCP"
        elif protocol == 17: proto_name = "UDP"
        elif protocol == 1: proto_name = "ICMP"

        print(f"[+] {proto_name} | Origen: {ip_src} -> Destino: {ip_dst}")

        # Si es TCP, ver los puertos (útil para el HoneyPot)
        if packet.haslayer(TCP):
            print(f"    Port: {packet[TCP].sport} -> {packet[TCP].dport}")

print("[*] Nexora Sniffer Iniciado...")
print("[*] Filtrando tráfico IP... (Presiona Ctrl+C para detener)")

# Filtro: Solo paquetes IP. Interfaz: wlo1 (tu Wi-Fi según tu ip addr)
sniff(filter="ip", prn=packet_callback, iface="wlo1", store=0)
