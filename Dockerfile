FROM bwstitt/alpine:3.6

ENTRYPOINT ["/bin/registrator"]

RUN docker-install ca-certificates

COPY . /go/src/github.com/gliderlabs/registrator

RUN docker-install -t build-deps build-base go git \
    && cd /go/src/github.com/gliderlabs/registrator \
    && export GOPATH=/go \
    && git config --global http.https://gopkg.in.followRedirects true \
    && go get \
    && go build -ldflags "-X main.Version=$(cat VERSION)" -o /bin/registrator \
    && rm -rf /go \
    && apk del --purge build-deps
