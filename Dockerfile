from centos:7
RUN yum install -y  openssl expect
RUN mkdir -p /opt/PCA
ADD bin /opt/PCA/bin
ADD private_ca /opt/PCA/bin
RUN chmod -R +x /opt/PCA/bin
VOLUME /etc/pki/CA
EXPOSE 8080
ENTRYPOINT /opt/PCA/bin/private_ca
