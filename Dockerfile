FROM docker.io/library/alpine:latest

RUN apk --no-cache --update --upgrade add \
        bash \
        python3 \
        python3-dev \
        gfortran \
        py-pip \
        build-base \
        procps \
        git

RUN pip install --no-cache-dir numpy

ENV NOVNC_TAG="v1.4.0"
ENV WEBSOCKIFY_TAG="v0.11.0"

# Clone NoVNC and Websockify
RUN git config --global advice.detachedHead false && \
    git clone https://github.com/novnc/noVNC --branch ${NOVNC_TAG} /root/noVNC && \
    git clone https://github.com/novnc/websockify --branch ${WEBSOCKIFY_TAG} /root/noVNC/utils/websockify

COPY index.html /root/noVNC/index.html

ENV VNC_SERVER "localhost:5900"
ENV VNC_CERT_PATH "/etc/ssl/certs/app.crt"
ENV VNC_KEY_PATH "/etc/ssl/private/app.key"

LABEL se.domain.app-type="user"

ENTRYPOINT [ "bash", "-c", "/root/noVNC/utils/novnc_proxy --vnc ${VNC_SERVER} --cert ${VNC_CERT_PATH} --key ${VNC_KEY_PATH} --ssl-only" ]
