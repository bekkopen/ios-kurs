#!/bin/bash
cd backend
mvn package && java -cp "target/classes:target/dependency/*" no.bekk.ioskurs.Main
