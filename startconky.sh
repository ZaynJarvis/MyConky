#!/bin/bash

conky -c ~/.Conky/rings & # the main conky with rings
conky -c ~/.Conky/cpu &
conky -c ~/.Conky/mem &
# conky -c ~/.Conky/notes &
