FROM registry.fedoraproject.org/fedora:31 AS base
RUN dnf -y update --refresh
FROM base AS builder
RUN dnf -y install cargo rust git
RUN cargo install --git https://github.com/jcollie/rts.git
FROM base
COPY --from=builder /root/.cargo/bin/rts /rts
RUN dnf -y install ansible openssh-server
COPY etc/ansible/* /etc/ansible/
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
EXPOSE 22
CMD ["/rts", "/entrypoint.sh"]
