#!/bin/bash

./env.sh

JVM_OPTS="-Dcom.sun.management.jmxremote.port=7199"
JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=true"
JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl=false"
JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=$SERVER_HOSTNAME"

TARGET="target/usergrid-standalone-0.0.28-SNAPSHOT.jar"
TARGET_TEST="target/usergrid-standalone-0.0.28-SNAPSHOT-tests.jar"

CMD="java -jar $JVM_OPTS"

case $1 in

    run)
        echo "Run standalone"
        nohup $CMD $TARGET &
        ;;
    run-db)
        echo "Running standalone with embedded cassandra"
        nohup $CMD $TARGET -db &
        ;;
    run-init)
        echo "Run standalone and initialize embedded cassandra"
        nohup $CMD $TARGET -db -init &
        ;;
    test)
        echo "Test standalone"
        nohup $CMD $TARGET_TEST &
        ;;
    test-db)
        echo "Test standalone with embedded cassandra"
        nohup $CMD $TARGET_TEST -db &
        ;;
    test-init)
        echo "Test standalone and initialize embedded cassandra"
        nohup $CMD $TARGET_TEST -db &
        ;;
    *)
        echo "Usage: $0 {run|run-db|run-init|test|test-db|test-init}" >&2
        exit 1
        ;;
esac
