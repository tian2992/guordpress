FROM hhvm/hhvm-proxygen:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y curl unzip wget

ENV DOCUMENT_ROOT /var/www/public

# Install the app
RUN wget -O wordpress.tar.gz https://wordpress.org/latest.tar.gz
RUN tar -xzvf /wordpress.tar.gz --strip-components=1 --directory ${DOCUMENT_ROOT}

# SQLite sauce
RUN wget -O sqlite-plugin.zip https://downloads.wordpress.org/plugin/sqlite-integration.1.8.1.zip
RUN unzip sqlite-plugin.zip -d ${DOCUMENT_ROOT}/wp-content/plugins/
RUN cp ${DOCUMENT_ROOT}/wp-content/plugins/sqlite-integration/db.php ${DOCUMENT_ROOT}/wp-content

# FIXME: hide db
# Gotta secure /wp-content/database/.ht.sqlite

RUN cp ${DOCUMENT_ROOT}/wp-config-sample.php ${DOCUMENT_ROOT}/wp-config.php
RUN echo "define('FS_METHOD', 'direct');" >> ${DOCUMENT_ROOT}/wp-config.php


# Cleanup
RUN rm sqlite-plugin.zip
RUN rm wordpress.tar.gz

# RUN chown -R www-data.www-data ${DOCUMENT_ROOT}

EXPOSE 80

VOLUME ${DOCUMENT_ROOT}
