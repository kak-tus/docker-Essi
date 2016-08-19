FROM debian:8

MAINTAINER Andrey Kuzmin "kak-tus@mail.ru"

COPY docker.yml /etc/essi.d/docker.yml

RUN apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
  curl git libcommon-sense-perl build-essential \
  libextutils-makemaker-cpanfile-perl dh-make-perl apt-file \

  && cd /bin \
  && curl -L https://cpanmin.us/ -o cpanm \
  && chmod +x cpanm \

  # Temporary fix, App::Environ not on cpan yet
  && cpanm Config::Processor \
  && cpanm https://github.com/iph0/App-Environ.git \

  && apt-file update \
  && cpanm https://github.com/kak-tus/Essi.git \

  && rm -rf /var/lib/apt/lists/*

EXPOSE 9007

CMD ["hypnotoad", "-f", "/usr/local/bin/essi.pl"]
