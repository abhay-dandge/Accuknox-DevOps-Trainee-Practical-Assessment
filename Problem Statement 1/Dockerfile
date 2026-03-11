FROM ubuntu:22.04

RUN apt update && apt install fortune-mod cowsay netcat-openbsd -y
COPY wisecow/wisecow.sh wisecow/
RUN cp /usr/games/fortune /usr/bin/fortune && cp /usr/games/cowsay /usr/bin/cowsay
WORKDIR wisecow
CMD ./wisecow.sh
EXPOSE 4499 
