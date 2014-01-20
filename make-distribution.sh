#!/usr/bin/env bash

FWDIR="$(cd `dirname $0`; pwd)"
DISTDIR="$FWDIR/dist"
VERION=`mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version | grep -v '\['`

echo "maven building hbase shell version "$VERION
mvn clean package

# Make directories
rm -rf "$DISTDIR"
mkdir -p "$DISTDIR"/lib

echo "built for hbase shell distribution package "

cp -r $FWDIR/conf "$DISTDIR"/
cp -r $FWDIR/bin "$DISTDIR"/
cp -r $FWDIR/lib "$DISTDIR"/
cp $FWDIR/target/cosmos-hbase-shell-*.jar "$DISTDIR"/lib/
tar -zcvf "cosmos-hbase-shell-"$VERION".tar.gz"  "$DISTDIR"/ 
