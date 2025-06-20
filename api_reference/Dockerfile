FROM node:20.19.0-bookworm-slim AS node
FROM ruby:3.4.2-slim-bookworm

WORKDIR /app/api_reference

RUN  \
  --mount=type=cache,target=/var/cache/apt,sharing=locked \
        du -sh /var/cache/apt \
      && rm /etc/apt/apt.conf.d/docker-clean \
      && apt-get update -qq \
      && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
            build-essential \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
      && truncate -s 0 /var/log/*log

COPY ./Gemfile ./Gemfile.lock ./

# nodejsインストール
## nodeのイメージから必要なファイルをコピー
COPY --from=node /usr/local/include/ /usr/local/include/
COPY --from=node /usr/local/lib/ /usr/local/lib/
COPY --from=node /usr/local/bin/ /usr/local/bin/
## reset symlinks
RUN corepack disable && corepack enable

ENV BUNDLE_PATH /usr/local/bundle
RUN \
  --mount=type=cache,id=sms1-api_reference,target=/usr/local/bundle \
        du -sh /usr/local/bundle \
  && bundle install --jobs=2 || true \
  && cp -r /usr/local/bundle /usr/local/bundle.cache
RUN \
  rm -rf /usr/local/bundle \
  && cp -r /usr/local/bundle.cache /usr/local/bundle \
  && rm -rf /usr/local/bundle.cache

COPY . /app/api_reference
