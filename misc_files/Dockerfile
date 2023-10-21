FROM ruby:2.7

# RUN apt-get update -qq && apt-get install 

# # установка локали, чтобы испльзовать русский в консоли внутри контейнера
# RUN echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen && \
#   locale-gen ru_RU.UTF-8 && \
#   /usr/sbin/update-locale LANG=ru_RU.UTF-8
# ENV LC_ALL ru_RU.UTF-8

WORKDIR /app/buying

ENV PORT 3006

EXPOSE 3006

RUN gem install rails bundler
RUN gem install rails

ENTRYPOINT [ "/bin/bash" ]