FROM hub.tess.io/lindang/dev:latest

RUN apt-get update
RUN apt install -y openssl tar wget
RUN wget https://github.com/etcd-io/etcd/releases/download/v3.3.10/etcd-v3.3.10-linux-amd64.tar.gz && \
tar -zxvf etcd-v3.3.10-linux-amd64.tar.gz && \
mv etcd-v3.3.10-linux-amd64/etcd* /bin/
VOLUME /data
EXPOSE 2379 2380
CMD ["/bin/etcd"]
