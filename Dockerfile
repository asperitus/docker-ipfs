##
FROM asperitus/rekcod:latest

ARG VERSION=v0.4.19

WORKDIR /dist/Linux
RUN wget -qO- "https://github.com/ipfs/go-ipfs/releases/download/${VERSION}/go-ipfs_${VERSION}_linux-amd64.tar.gz" | tar xz
COPY ./rc.sh .

WORKDIR /dist/Darwin
RUN wget -qO- "https://github.com/ipfs/go-ipfs/releases/download/${VERSION}/go-ipfs_${VERSION}_darwin-amd64.tar.gz" | tar xz
COPY ./rc.sh .

WORKDIR /

ENV SHUTDOWN_HOOK "\$HOME/.asperitus/ipfs/rc.sh stop"

CMD ["/bin/sh", "-ecx", "uname -a && env && export PATH=/usr/local/bin:$PATH && mkdir -p ${HOME}/.asperitus && rm -rf ${HOME}/.asperitus/ipfs && docker cp ipfs:/dist/$(uname -s) ${HOME}/.asperitus/ipfs && ${HOME}/.asperitus/ipfs/rc.sh start"]
##