# https://github.com/litecoin-project/litecoin/releases/tag/v0.18.1

FROM ubuntu:hirsute as build

ENV VERSION=0.18.1
ENV GPG_KEY=FE3348877809386C
ENV BASE_URL=https://download.litecoin.org/litecoin-${VERSION}/linux

RUN apt update && \
    apt install -y curl gnupg

RUN curl -fSL ${BASE_URL}/litecoin-${VERSION}-$(uname -m)-linux-gnu.tar.gz -o litecoin.tar.gz && \
    curl -fSL ${BASE_URL}/litecoin-${VERSION}-linux-signatures.asc -o litecoin.asc && \
    grep $(sha256sum litecoin.tar.gz | awk '{ print $1 }') litecoin.asc && \
    gpg --batch --keyserver hkps://keyserver.ubuntu.com --recv-keys "$GPG_KEY" && \
    gpg --verify litecoin.asc && \
    tar -xzf litecoin.tar.gz

FROM ubuntu:hirsute as runtime

COPY --from=build /litecoin-**/bin/* /usr/local/bin

ENV DATA=/home/cryptopunk/.litecoin
RUN useradd -r cryptopunk && \
    mkdir -p "$DATA" && \
    chown -R cryptopunk "$DATA"

USER cryptopunk
WORKDIR /home/cryptopunk
VOLUME ["/home/cryptopunk/.litecoin"]
EXPOSE 9332 9333 19332 19333 19444
CMD ["litecoind"]
