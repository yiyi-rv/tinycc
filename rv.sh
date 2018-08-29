#!/bin/bash
set -x

json_out=`pwd`/errors.json
report_out=`pwd`/report
rm -rf $json_out
rm -rf $report_out

./configure --cc=kcc --extra-cflags="-fissue-report=$json_out" --extra-ldflags="-fissue-report=$json_out"
make
make test

touch $json_out && rv-html-report $json_out -o $report_out
rv-upload-report $report_out
