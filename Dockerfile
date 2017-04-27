FROM alpine:3.5

MAINTAINER Matt Bailey <m@mdb.io>
ENV DRIVE_PATH="/data"

RUN apk -Uu add opam make build-base gcc abuild binutils bash ncurses-dev &&\
  OPAMYES=true opam init && \
  OPAMYES=true opam depext google-drive-ocamlfuse && \
  OPAMYES=true opam install google-drive-ocamlfuse && \
  mv /root/.opam/system/bin/google-drive-ocamlfuse /bin/google-drive-ocamlfuse && \
  rm -rf /root/.opam && \
  apk --purge \
    del \
    opam \
    make \
    build-base \
    gcc \
    abuild \
    binutils \
    bash \
    zlib-dev \
    libressl-dev \
    libssh2-dev \
    curl-dev \
    fuse-dev \
    gmp-dev \
    m4 \
    perl \
    ncurses-dev \
    sqlite-dev && \
  apk add libressl2.4-libtls fuse libgmpxx sqlite-libs libcurl ncurses-libs

COPY init.sh /

CMD ["/init.sh"]
