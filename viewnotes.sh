#!/bin/bash

cat ./notes.txt | sed 's/^/ \${color #ddddff}\${voffset 5}\${alignc}\${offset -5}  \$color /g'
