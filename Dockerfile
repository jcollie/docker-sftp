FROM registry.fedoraproject.org/fedora:33
RUN dnf -y update --refresh
RUN dnf -y install ansible openssh-server crypto-policies-scripts
RUN update-crypto-policies --set LEGACY
COPY etc/ansible/* /etc/ansible/
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
EXPOSE 22
CMD ["/entrypoint.sh"]
