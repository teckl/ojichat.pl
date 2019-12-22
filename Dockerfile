FROM perl

RUN cpanm Carton
RUN mkdir /app
WORKDIR /app
COPY cpanfile /app/
RUN carton install
COPY . /app

ENTRYPOINT ["carton", "exec", "./ojichat.pl" ]
