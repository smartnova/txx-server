#!/bin/bash

find ./topojson/47ι½ιεΊη -type f | while read file
do
    arr=( `echo $file | tr -s '/' ' '`)
    pref=${arr[2]}
    dir="topojson/"$pref

    basename=$(basename $file)
    if [ $basename = '.DS_Store' -o ! ${basename##*.} = 'topojson' ]; then
      continue
    fi

    name=( `echo $basename | sed -e "s/\.topojson//"`)
    echo "simplify: "$pref" - "$name

    # simplify
    $(npm bin)/toposimplify -F -o topojson/$pref/$name.simple.topojson topojson/$pref/$basename

done