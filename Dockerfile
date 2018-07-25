FROM centos:latest as cent
RUN curl --silent --location https://rpm.nodesource.com/setup_9.x | bash -

RUN yum -y install git
RUN yum -y install nodejs
RUN yum -y install epel-release
RUN yum -y install nginx
RUN yum -y install supervisor
RUN npm install pm2 -g
RUN npm install @angular/cli -g --unsafe

WORKDIR /storm
RUN git clone https://github.com/smart-storm/storm-ui.git
RUN git clone https://github.com/smart-storm/storm-api.git
RUN git clone https://github.com/smart-storm/storm-website.git

WORKDIR /storm/storm-ui
COPY environment.prod.ts /storm/storm-ui/src/environments/
RUN npm install
RUN ng build --prod

WORKDIR /storm/storm-api
COPY utils.js /storm/storm-api/
RUN npm install

COPY --from=cent /storm/storm-ui/dist/ /var/www/html/storm-ui
COPY --from=cent /storm/storm-website/ /var/www/html/storm-website
COPY storm.ui.conf /etc/nginx/conf.d/storm.ui.conf
COPY storm.web.conf /etc/nginx/conf.d/storm.web.conf

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 22 80 8080
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD supervisord.conf /etc/

WORKDIR /storm

ENTRYPOINT ["/usr/bin/supervisord", "-n"]
