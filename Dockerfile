FROM registry.fedoraproject.org/fedora:31
RUN dnf -y update --refresh
RUN dnf -y install ansible openssh-server
COPY etc/ansible/* /etc/ansible/
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
EXPOSE 22
CMD ["/entrypoint.sh"]
