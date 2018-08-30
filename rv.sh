#!/bin/bash
set -x

json_out=`pwd`/errors.json
report_out=`pwd`/report
rm -rf $json_out
rm -rf $report_out

./configure --cc=kcc --extra-cflags="-fissue-report=$json_out" --extra-ldflags="-fissue-report=$json_out"
make
make test

# The errors.json has 8.6G, so we only get the first 50 entries
head -50 $json_out > tmp.json
rm $json_out
mv tmp.json $json_out

touch $json_out && rv-html-report $json_out -o $report_out
rv-upload-report $report_out
