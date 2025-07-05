#!/bin/sh

mvn io.confluent:kafka-schema-registry-maven-plugin:derive-schema

echo ""
echo "Inferred Schema(s):"
jq . avro/schema.avsc
