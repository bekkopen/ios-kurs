#!/bin/bash
cd server
mvn package && java -cp "target/classes:target/dependency/*" no.bekk.ioskurs.Main
