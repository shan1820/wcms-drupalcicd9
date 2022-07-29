FROM wodby/drupal-php:7.4-dev-4.34.3
USER root
RUN set -ex; \
    apk add --update --no-cache \
    alpine-sdk \
    autoconf \
    automake \
    bash-completion \
    file \
    gcc \
    gifsicle \
    git-bash-completion \
    jpeg \
    libtool \
    make \
    musl-dev \
    nasm \
    npm \
    openjdk8 \
    optipng \
    pkgconf \
    python2 \
    tiff \
    tzdata \
    zlib \
    zlib-dev;

COPY ./pdftk* /usr/local/bin/
RUN chmod 775 /usr/local/bin/pdftk*

USER wodby

RUN sudo npm install -g gulp
RUN source /etc/profile.d/bash_completion.sh
RUN echo -e "\n[[ -f ~/uw.bashrc ]] && source ~/uw.bashrc\n" >> /home/wodby/.bashrc
RUN echo -e "\n[[ -f /etc/profile.d/bash_completion.sh ]] && source /etc/profile.d/bash_completion.sh\n" >> /home/wodby/.bashrc
RUN sudo cp /usr/share/zoneinfo/America/Toronto /etc/localtime
RUN sudo sh -c "echo \"America/Toronto\" >> /etc/timezone"
RUN composer self-update
RUN composer global require twig/twig:1.42.5
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
