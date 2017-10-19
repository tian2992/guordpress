FROM hhvm/hhvm-proxygen:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y curl unzip wget

ENV VOLUME_ROOT /var/www
ENV DOCUMENT_ROOT $VOLUME_ROOT/public

# Install the app
RUN wget -O wordpress.tar.gz https://wordpress.org/latest.tar.gz && tar -xzvf /wordpress.tar.gz --strip-components=1 --directory ${DOCUMENT_ROOT} && rm wordpress.tar.gz

# SQLite sauce
RUN wget -O sqlite-plugin.zip https://downloads.wordpress.org/plugin/sqlite-integration.1.8.1.zip && unzip sqlite-plugin.zip -d ${DOCUMENT_ROOT}/wp-content/plugins/ && cp ${DOCUMENT_ROOT}/wp-content/plugins/sqlite-integration/db.php ${DOCUMENT_ROOT}/wp-content && rm sqlite-plugin.zip

RUN cp ${DOCUMENT_ROOT}/wp-config-sample.php ${DOCUMENT_ROOT}/wp-config.php
RUN echo "define('FS_METHOD', 'direct');" >> ${DOCUMENT_ROOT}/wp-config.php
# DB goes here, so it is safer than at /public/.
RUN echo "define('DB_DIR', '${VOLUME_ROOT}/');" >> ${DOCUMENT_ROOT}/wp-config.php
RUN echo "define('DB_FILE', 'db.sqlit3');" >> ${DOCUMENT_ROOT}/wp-config.php

EXPOSE 80

VOLUME ${VOLUME_ROOT}
