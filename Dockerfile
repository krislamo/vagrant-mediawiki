FROM mediawiki:1.35.4

ARG VER=REL1_35
ARG EXT="PluggableAuth LDAPProvider LDAPAuthentication2"
ARG URL="https://extdist.wmflabs.org/dist/extensions/"

RUN apt-get update && apt-get install -y --no-install-recommends \
        libldap2-dev \
        libldap-2.4-2 \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install ldap

RUN curl -s ${URL} | grep -io href=\".*-${VER}.*tar.gz\" | \
    awk '{print substr($1, 7, length($1)-7)}' | while read line; do \
        for item in ${EXT}; do \
            if echo "$line" | grep -qe ^$item; then \
                curl -s ${URL}$line | tar -xzC /var/www/html/extensions; \
            fi \
        done \
    done
