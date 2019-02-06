FROM eshamster/cl-base

ENV libs 'openssl-dev'
RUN apk update \
  && apk add ${libs}

# Assuming whole application directory is mounted as /app
WORKDIR /app/

CMD /bin/sh
