# NAME:     GraysonChen/eic_lisa_circleci
FROM ubuntu:14.04
MAINTAINER Grayson Chen <cgg5207@sina.com>

RUN apt-get update && apt-get install -y wget

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN wget --quiet https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key add ACCC4CF8.asc
RUN apt-get update

RUN apt-get install -y pandoc postgresql-10-pgtap
RUN echo "local  all all   trust" | sudo tee /etc/postgresql/10/main/pg_hba.conf
RUN echo "host all all 127.0.0.1/32 trust" | sudo tee --append /etc/postgresql/10/main/pg_hba.conf
RUN service postgresql start 10

# install ruby dependencies
RUN apt-get install -y curl openssh-server git-core openssh-client build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config

# RVM
RUN apt-get install -y gnupg2
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile
CMD ["/bin/bash", "-l"]
