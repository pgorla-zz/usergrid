#!/bin/bash

./env.sh

JVM_OPTS="-Dcom.sun.management.jmxremote.port=7199"
JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=true"
JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl=false"
JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=$SERVER_HOSTNAME"

case $1 in

    run)
        echo "Running usergrid standalone alone"
        nohup java -jar $JVM_OPTS target/usergrid-standalone-0.0.28-SNAPSHOT.jar &
        ;;
    run-db)
        echo "Running usergrid standalone with embedded cassandra"
        nohup java -jar $JVM_OPTS target/usergrid-standalone-0.0.28-SNAPSHOT.jar -db &
        ;;
    test)
        echo "Running usergrid standalone alone with test"
        nohup java -jar $JVM_OPTS target/usergrid-standalone-0.0.28-SNAPSHOT-tests.jar &
        ;;
    test-db)
        echo "Running usergrid standalone alone with test and embedded cassandra"
        nohup java -jar $JVM_OPTS target/usergrid-standalone-0.0.28-SNAPSHOT-tests.jar -db &
        ;;
    *)
        echo "Usage: $0 {run|test|run-db|test-db}" >&2
        exit 1
        ;;
esac
