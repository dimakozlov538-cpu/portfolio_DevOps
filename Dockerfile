FROM nginxinc/nginx-unprivileged:alpine

LABEL org.opencontainers.image.authors="Dmitry Kozlov" \
      org.opencontainers.image.description="Portfolio web application"

COPY --chown=nginx:nginx nginx.conf /etc/nginx/conf.d/default.conf
COPY --chown=nginx:nginx templates/index.html /usr/share/nginx/html/index.html
COPY --chown=nginx:nginx static /usr/share/nginx/html/static

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1

EXPOSE 8080
