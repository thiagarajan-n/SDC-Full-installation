FROM centos:6


ARG FULLTARBALL_URL=http://archives.streamsets.com/datacollector/3.6.0/tarball/streamsets-datacollector-all-3.6.0.tgz

RUN mkdir /opt/local


RUN chgrp -R 0 /tmp && \
    chmod -R g=u /tmp

RUN curl -o /tmp/sdc.tgz -L ${FULLTARBALL_URL}

RUN tar xzf /tmp/sdc.tgz --strip-components 1 -C /opt/local/

COPY run_config.sh /tmp/
# COPY streamsets-datacollector-core-3.5.2.tgz *.tgz /tmp/
# RUN /tmp/run_config.sh

# ARG SDC_USER=sdc

RUN chmod g=u /etc/passwd
ENTRYPOINT [ "uid_entrypoint" ]
# USER ${SDC_USER}

RUN cp initd/_sdcinitd_prototype  /etc/init.d/sdc

# custom one
# chown sdc:sdc /etc/init.d/sdc
RUN chgrp -R 0 /etc/init.d/sdc && \
    chmod -R g=u /etc/init.d/sdc

RUN chmod 755 /etc/init.d/sdc

RUN mkdir /etc/sdc && \
    cp -R etc/* /etc/sdc

RUN chgrp -R 0 /etc/sdc && \
    chmod -R g=u /etc/sdc

RUN chmod go-rwx /etc/sdc/form-realm.properties

RUN mkdir /var/log/sdc && \
    chgrp -R 0 /var/log/sdc && \
    chmod -R g=u /var/log/sdc

RUN mkdir /var/lib/sdc && \
    chgrp -R 0 /var/lib/sdc && \
    chmod -R g=u /var/lib/sdc

RUN mkdir /var/lib/sdc-resources && \
    chgrp -R 0 /var/lib/sdc-resources && \
    chmod -R g=u /var/lib/sdc-resources

RUN service sdc start

RUN chkconfig --add sdc

