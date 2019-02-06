FROM amazonlinux

ENV libs 'automake make gcc curl curl-devel bzip2 tar gzip'
RUN yum update -y \
  && yum upgrade -y \
  && yum install -y ${libs}

ENV roswell_archive_url 'https://github.com/roswell/roswell/archive/release.tar.gz'
RUN echo 'install roswell' \
  && curl -SL ${roswell_archive_url} \
  | tar -xzC /tmp/ \
  && cd /tmp/roswell-release \
  && sh bootstrap \
  && ./configure \
  && make \
  && make install \
  && rm -rf /tmp/roswell-release

# locale setting
#RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN ros setup
ENV PATH /root/.roswell/bin:/usr/local/bin:$PATH

# Assuming whole application directory is mounted as /app
WORKDIR /app/

CMD /bin/sh
