FROM cassandra:latest

COPY entrypoint.sh /entrypoint.sh
COPY init.cql /docker-entrypoint-initdb.d/init.cql
ENTRYPOINT ["/entrypoint.sh"]
CMD ["cassandra", "-f"]