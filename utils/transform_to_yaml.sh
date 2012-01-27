#!/bin/bash

sed -e 's/ \{1,\}$//g' -e  's/ \{1,\}/ /g' -e 's/^\([^ ]\{1,\}\) \{1,\}\(.\{1,\}\)$/\1: "\2"/g'  -e 's/===*/--- !ruby\/object:SGE::QAcct::Job/g'
