FROM debian:stable-slim as build

RUN apt update && \
    apt install -y curl gnupg

# https://github.com/litecoin-project/litecoin/releases/tag/v0.18.1
ENV LITECOIN_VERSION=0.18.1
ENV LITECOIN_KEY=FE3348877809386C

# https://superuser.com/questions/1485213/gpg-cant-import-key-new-key-but-contains-no-user-id-skipped
RUN curl -o litecoin.tar.gz -fSL https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-$(uname -m)-linux-gnu.tar.gz && \
    curl -o litecoin.asc -fSL https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc && \
    grep $(sha256sum litecoin.tar.gz | awk '{ print $1 }') litecoin.asc && \
    gpg --batch --keyserver hkps://keyserver.ubuntu.com --recv-keys "$LITECOIN_KEY" && \
    gpg --verify litecoin.asc && \
    tar -xzf litecoin.tar.gz

FROM debian:stable-slim as runtime

COPY --from=build /litecoin-**/bin/* /usr/local/bin

ENV LITECOIN_DATA=/home/cryptopunk/.litecoin

RUN useradd -r cryptopunk && \
    mkdir -p "$LITECOIN_DATA" && \
    chown -R cryptopunk "$LITECOIN_DATA"

USER cryptopunk
VOLUME ["/home/cryptopunk/.litecoin"]
EXPOSE 9332 9333 19332 19333 19444
CMD ["litecoind"]
