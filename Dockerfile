FROM debian:8

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

COPY docker.yml /etc/essi.d/docker.yml

ENV ESSI_DEB_PATH=

RUN apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
  curl git libcommon-sense-perl build-essential \
  libextutils-makemaker-cpanfile-perl dh-make-perl apt-file ssh-client \
  dnsutils libanyevent-perl libmodule-install-perl \
  libmodule-install-xsutil-perl libmodule-install-authortests-perl \
  libmodule-build-xsutil-perl \

  && cd /bin \
  && curl -L https://cpanmin.us/ -o cpanm \
  && chmod +x cpanm \

  && cpanm Module::Install::TestTarget \

  && apt-file update \
  && cpanm https://github.com/kak-tus/Essi.git@0.13 \
  && (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan \

  && rm -rf /root/.cpanm \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 9007

CMD ["hypnotoad", "-f", "/usr/local/bin/essi.pl"]
