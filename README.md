# Avro Schema Inference Demo
This project demonstrates how to automatically infer an Avro schema from example JSON messages using the Confluent Schema Registry Maven Plugin.

For more details: https://docs.confluent.io/platform/current/schema-registry/develop/maven-plugin.html#schema-registry-derive-schema

## 🔧 What It Does
Using the `schema-registry:derive-schema` goal, this Maven setup:
 - Reads JSON messages from `messages/message.txt` (one JSON object per line)
   - You can use your own payload file, just to make sure to adjust the `pom.xml` accordingly (`<messagePath>messages/messages.txt</messagePath>`)
 - Infers the corresponding Avro schema
   - It also works with `json` and `protobuf` as the schema type, update the `pom.xml` as needed (`<schemaType>avro</schemaType>`)
 - Writes the result to `avro/schema.avsc`
   - Feel free to choose your own output location, update the `pom.xml` as required (`<outputPath>avro/schema.avsc</outputPath>`)

## 📁 Project Structure
```sh
schema-inference/
├── pom.xml
├── messages/
│   └── message.txt     # Newline-delimited JSON objects
└── avro/
    └── schema.avsc     # Generated Avro schema
```

## ▶️ How to Run
Make sure Maven is installed, then run:
```sh
./infer-schema.sh
```

Example:
The input JSON messages are ( as per `messages/messages.txt` -- again, one per line):
```sh
{"name": "Jasper Lin", "age": 34, "email": "jasper.lin@example.com", "isActive": true, "address": {"street": "456 Market Street", "city": "San Francisco", "state": "CA", "postalCode": "94105"}, "roles": ["admin", "editor"], "metadata": {"createdAt": "2023-09-15T14:23:00Z", "tags": ["premium", "beta-tester"], "loginCount": 42}, "preferences": {"newsletter": false, "notifications": {"email": true, "sms": false, "push": true}}}
{"name": "Foo", "Age": {"int": 12}}
{"name": "Bar", "Age": {"string": "12"}}
{"sport": "Football"}
```

```sh
WARNING: A terminally deprecated method in sun.misc.Unsafe has been called
WARNING: sun.misc.Unsafe::staticFieldBase has been called by com.google.inject.internal.aop.HiddenClassDefiner (file:/opt/homebrew/Cellar/maven/3.9.10/libexec/lib/guice-5.1.0-classes.jar)
WARNING: Please consider reporting this to the maintainers of class com.google.inject.internal.aop.HiddenClassDefiner
WARNING: sun.misc.Unsafe::staticFieldBase will be removed in a future release
[INFO] Scanning for projects...
[INFO] 
[INFO] --------------------< com.example:schema-inference >--------------------
[INFO] Building Avro Infer Demo 1.0-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- schema-registry:8.0.0:derive-schema (default-cli) @ schema-inference ---
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.531 s
[INFO] Finished at: 2025-07-05T12:49:30+01:00
[INFO] ------------------------------------------------------------------------

Inferred Schema(s):
{
  "schemas": [
    {
      "schema": {
        "type": "record",
        "name": "Schema",
        "fields": [
          {
            "name": "address",
            "type": {
              "type": "record",
              "name": "address",
              "fields": [
                {
                  "name": "city",
                  "type": "string"
                },
                {
                  "name": "postalCode",
                  "type": "string"
                },
                {
                  "name": "state",
                  "type": "string"
                },
                {
                  "name": "street",
                  "type": "string"
                }
              ]
            }
          },
          {
            "name": "age",
            "type": "int"
          },
          {
            "name": "email",
            "type": "string"
          },
          {
            "name": "isActive",
            "type": "boolean"
          },
          {
            "name": "metadata",
            "type": {
              "type": "record",
              "name": "metadata",
              "fields": [
                {
                  "name": "createdAt",
                  "type": "string"
                },
                {
                  "name": "loginCount",
                  "type": "int"
                },
                {
                  "name": "tags",
                  "type": {
                    "type": "array",
                    "items": "string"
                  }
                }
              ]
            }
          },
          {
            "name": "name",
            "type": "string"
          },
          {
            "name": "preferences",
            "type": {
              "type": "record",
              "name": "preferences",
              "fields": [
                {
                  "name": "newsletter",
                  "type": "boolean"
                },
                {
                  "name": "notifications",
                  "type": {
                    "type": "record",
                    "name": "notifications",
                    "fields": [
                      {
                        "name": "email",
                        "type": "boolean"
                      },
                      {
                        "name": "push",
                        "type": "boolean"
                      },
                      {
                        "name": "sms",
                        "type": "boolean"
                      }
                    ]
                  }
                }
              ]
            }
          },
          {
            "name": "roles",
            "type": {
              "type": "array",
              "items": "string"
            }
          }
        ]
      },
      "messagesMatched": [
        0
      ]
    },
    {
      "schema": {
        "type": "record",
        "name": "Schema",
        "fields": [
          {
            "name": "Age",
            "type": [
              "int",
              "string"
            ]
          },
          {
            "name": "name",
            "type": "string"
          }
        ]
      },
      "messagesMatched": [
        1,
        2
      ]
    },
    {
      "schema": {
        "type": "record",
        "name": "Schema",
        "fields": [
          {
            "name": "sport",
            "type": "string"
          }
        ]
      },
      "messagesMatched": [
        3
      ]
    }
  ]
}
```

The inferred schema will be saved to `avro/schema.avsc`.

## 🔗 Requirements
 - Java 17+
 - Maven
 - Internet access to download Confluent dependencies
