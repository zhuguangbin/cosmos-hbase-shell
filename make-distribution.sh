#!/usr/bin/env bash

if [ $# != 1 ]; then
   echo "Usage: sh make-distribution.sh <env>"
   exit 1
fi

ENV=$1
VERSION=`mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version | grep -v '\['`
FWDIR="$(cd `dirname $0`; pwd)"
DISTDIR="$FWDIR/dist/cosmos-hbase-shell-"$VERSION"-"$ENV

echo "maven building hbase shell version "$VERSION
mvn clean package -Denv=$ENV

# Make directories
rm -rf "$DISTDIR"
mkdir -p "$DISTDIR"/lib

echo "built for hbase shell distribution package "

cp -r $FWDIR/conf "$DISTDIR"/
cp -r $FWDIR/bin "$DISTDIR"/
cp -r $FWDIR/lib "$DISTDIR"/
cp $FWDIR/target/cosmos-hbase-shell-*.jar "$DISTDIR"/lib/

cd $FWDIR/dist/
tar -zcvf "cosmos-hbase-shell-"$VERSION"-"$ENV".tar.gz"  "cosmos-hbase-shell-"$VERSION"-"$ENV 
