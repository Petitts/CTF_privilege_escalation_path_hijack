FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instalacja ssh + kompilator tymczasowo
RUN apt update && \
    apt install -y openssh-server gcc binutils && \
    rm -rf /var/lib/apt/lists/*

# Tworzenie użytkownika
RUN useradd -m -s /bin/bash ctf && \
    echo "ctf:qwerty123" | chpasswd

# Tworzenie flagi
RUN echo "FLAG{9f33de7c1af7186de4d38ad55a1642069ce067b0}" > /root/flag.txt && \
    chmod 600 /root/flag.txt

# Kompilacja podatnej binarki
COPY backup.c /tmp/backup.c
RUN gcc /tmp/backup.c -o /usr/local/bin/backup && \
    chown root:root /usr/local/bin/backup && \
    chmod 4755 /usr/local/bin/backup && \
    rm /tmp/backup.c

# Usunięcie gcc (żeby uczestnik nie kompilował exploitów)
RUN apt purge -y gcc && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Konfiguracja SSH
RUN mkdir /var/run/sshd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config && \
    echo "AllowUsers ctf" >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]