FROM alpine:3.13

RUN apk add --no-cache \
	zsh curl git htop wget tmux nano ripgrep fd tree ranger ninja make cmake tar xz zip bash gawk grep mercurial autoconf patch \
	flex bison subversion texinfo \
	libexecinfo-dev \
	python3 py3-pip \
	python2 \
	build-base alpine-sdk linux-headers musl-dev coreutils

RUN cd /opt && \
	wget https://musl.cc/x86_64-linux-musl-cross.tgz && \
	wget http://musl.cc/aarch64-linux-musl-cross.tgz && \
	tar -xvzf /opt/x86_64-linux-musl-cross.tgz && \
	tar -xvzf /opt/aarch64-linux-musl-cross.tgz && \
	ln -sf /opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-g++ /bin/x86_64-linux-gnu-g++ && \
	ln -sf /opt/aarch64-linux-musl-cross/bin/aarch64-linux-musl-gcc /bin/aarch64-linux-gnu-gcc && \
	ln -sf /opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-gcc /bin/x86_64-linux-gnu-gcc && \
	ln -sf /opt/aarch64-linux-musl-cross/bin/aarch64-linux-musl-ar /bin/aarch64-linux-gnu-ar && \
	ln -sf /opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ar /bin/x86_64-linux-gnu-ar && \
	ln -sf /opt/aarch64-linux-musl-cross/bin/aarch64-linux-musl-ranlib /bin/aarch64-linux-gnu-ranlib && \
	ln -sf /opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ranlib /bin/x86_64-linux-gnu-ranlib && \
	ln -sf /opt/aarch64-linux-musl-cross/bin/aarch64-linux-musl-as /bin/aarch64-linux-gnu-as && \
	ln -sf /opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-as /bin/x86_64-linux-gnu-as


RUN git clone https://github.com/khordadi/popcorn-compiler-alpine /popcorn-compiler-alpine && \
	cd /popcorn-compiler-alpine && \
	./install_compiler.py --install-all

RUN git clone https://gitlab.com/khordadi/npb-gold /npb-gold && \
	cd /npb-gold && \
	make A && \
	cd is && \
	make 

