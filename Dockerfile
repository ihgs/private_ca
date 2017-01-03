from centos:7
RUN yum install -y  openssl expect
RUN mkdir -p /opt/PCA
ADD bin /opt/PCA/bin
ADD pca-server /opt/PCA/bin
RUN chmod -R +x /opt/PCA/bin

VOLUME /etc/pki/CA
EXPOSE 8080

ENTRYPOINT /opt/PCA/bin/pca-server --host 0.0.0.0 --port 8080
