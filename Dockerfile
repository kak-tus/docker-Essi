FROM debian:8

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

ENV ESSI_DEB_PATH=
ENV GOSU_VERSION=1.10

RUN apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
  curl git libcommon-sense-perl build-essential \
  libextutils-makemaker-cpanfile-perl dh-make-perl apt-file ssh-client \
  dnsutils libanyevent-perl libmodule-install-perl \
  libmodule-install-xsutil-perl libmodule-install-authortests-perl \
  libmodule-build-xsutil-perl ca-certificates wget \

  # Build fixes for some modules
  && apt-get install --no-install-recommends --no-install-suggests -y \
  libclass-xsaccessor-perl \

  && cd /bin \
  && curl -L https://cpanmin.us/ -o cpanm \
  && chmod +x cpanm \

  && cpanm Module::Install::TestTarget \

  && apt-file update \
  && cpanm https://github.com/kak-tus/Essi.git@0.15 \

  && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
  && chmod +x /usr/local/bin/gosu \

  && mkdir -p /home/www-data \
  && chown www-data:www-data /home/www-data \
  && usermod -d /home/www-data www-data \
  && gosu www-data bash -c "( echo y ; echo 'manual' ; echo o conf prerequisites_policy follow ; echo o conf commit ) | cpan" \

  && rm -rf /root/.cpanm \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 9007

ENV USER_UID=1000
ENV USER_GID=1000

COPY docker.yml /etc/essi.d/docker.yml
COPY start_essi.sh /usr/local/bin/start_essi.sh

CMD /usr/local/bin/start_essi.sh
