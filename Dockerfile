FROM eshamster/cl-base

ENV libs 'openssl-dev'
RUN apk update \
  && apk add ${libs}

RUN ros install ccl-bin/1.11
RUN ros use ccl-bin/1.11

# Assuming whole application directory is mounted as /app
WORKDIR /app/

CMD /bin/sh
