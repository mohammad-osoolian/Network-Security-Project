FROM alpine:3.18
USER root
RUN echo -e "root\nroot" | passwd
RUN apk update && apk add busybox-extras busybox-openrc openssh openssh-server openrc curl
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
&&  rc-status \
&& touch /run/openrc/softlevel
RUN apk add vsftpd
RUN rc-update add vsftpd default
CMD ["/bin/sh"]
