FROM	ubuntu:16.04

ENV 	DEBIAN_FRONTEND=noninteractive
RUN	apt-get update && \
	apt-get install -y \
	build-essential \
	git \
	g++ \
	libgtk-3-dev \
	gtk-doc-tools \
	gnutls-bin \
	valac \
	intltool \
	libpcre2-dev \
	libglib3.0-cil-dev \
	libgnutls28-dev \
	libgirepository1.0-dev \
	libxml2-utils \
	gperf

WORKDIR /root
RUN 	git clone --recursive https://github.com/thestinger/termite.git
RUN	git clone https://github.com/thestinger/vte-ng.git

WORKDIR /root/vte-ng
ENV 	LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
RUN	./autogen.sh && make && make install

WORKDIR /root/termite
RUN	make

VOLUME	/target
ENTRYPOINT ["cp", "termite", "termite.desktop", "termite.terminfo", "/target/"]

## to get termite, you can build and run this container:
# docker build -t termite-install .
# docker run --rm -v $(pwd):/target termite-install
