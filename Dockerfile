FROM alpine:3.3
ADD https://github.com/direnv/direnv/releases/download/v2.6.0/direnv.linux-amd64 /usr/bin/direnv
RUN apk -U add \
    bash tmux vim findutils grep less man bc \
    openssh sudo git git-doc git-bash-completion py-virtualenv postgresql-dev gcc python-dev musl-dev linux-headers libffi-dev \
    && \
    chmod +x /usr/bin/direnv && \
    pip install --upgrade pip || true && \
    rm -r /var/cache/apk/*
CMD ssh-keygen -A && exec /usr/sbin/sshd -D
