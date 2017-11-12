FROM centos:6

RUN yum -y install epel-release && \
    yum -y clean all

RUN  yum install -y postfix dovecot httpd mod_ssl php squirrelmail

RUN useradd user
RUN PASS='password' && \
    echo -e "$PASS\n$PASS" | passwd user

COPY etc/postfix/main.cf /etc/postfix/main.cf

COPY etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf
COPY etc/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY etc/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf
COPY etc/dovecot/conf.d/10-master.conf etc/dovecot/conf.d/10-master.conf

COPY etc/httpd/conf.d/squirrelmail.conf /etc/httpd/conf.d/squirrelmail.conf

COPY etc/squirrelmail/config.php /etc/squirrelmail/config.php

EXPOSE 25 143 80 443

CMD ["/bin/bash", "-c", "service postfix start ; service dovecot start ; service httpd start ; /bin/bash"]

