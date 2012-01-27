#!/bin/bash

sed -e 's/ \+/ /g' -e 's/\s\+$//g' -e 's/^\([^ ]\+\)\s\+\(.\+\)$/\1: "\2"/g'  -e 's/===*/--- !ruby\/object:SGE::QAcct::Job/g'
