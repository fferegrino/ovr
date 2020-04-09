# http://www.aaronbell.com/how-to-create-overviewer-maps-from-minecraft-realms/
FROM python:3.8

# RUN git clone https://github.com/air/minecraft-tools.git && cd minecraft-tools

# RUN apt-get update && apt-get install -y httpie jq && \
#    apt-get install -y software-properties-common && apt-add-repository 'deb http://overviewer.org/debian ./'

RUN apt-get update && apt-get install build-essential python3-pil python3-dev python3-numpy httpie jq curl -y

ENV PIL_INCLUDE_DIR /

RUN wget https://raw.githubusercontent.com/python-pillow/Pillow/master/src/libImaging/Imaging.h && \
    wget https://raw.githubusercontent.com/python-pillow/Pillow/master/src/libImaging/ImagingUtils.h && \
    wget https://raw.githubusercontent.com/python-pillow/Pillow/master/src/libImaging/ImPlatform.h

RUN pip install -q pillow numpy networkx pytest

RUN git clone git://github.com/overviewer/Minecraft-Overviewer.git

RUN cd Minecraft-Overviewer && python3 setup.py build

WORKDIR /ovr

COPY render-config.py get-minecraft-client-jar.sh ./

RUN mkdir -p ~/.minecraft/versions/1.15.2/
RUN curl -# -f --output ~/.minecraft/versions/1.15.2/1.15.2.jar https://launcher.mojang.com/v1/objects/e3f78cd16f9eb9a52307ed96ebec64241cc5b32d/client.jar


# /Minecraft-Overviewer/overviewer.py --conf=render-config.py
# docker run --name ovr -it --rm -v $pwd/world:/tmp/world ovr bash
# docker run -it --rm -v $pwd/world:/tmp/world -v $pwd/output:/tmp/world-map ovr bash