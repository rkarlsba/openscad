#!/bin/bash
# vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

for f in *x6.scad
do
    nn=$( echo $f | sed 's/x6\./x9./' )
    cat $f | sed 's/height = \[6, 0\]/height = [9, 0]/' > $nn
done
