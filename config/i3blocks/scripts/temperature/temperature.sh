#!/bin/bash

TEMP=$(sensors | grep "Package id 0" | awk '{print substr($4,2)}')

# Exibição da temperatura
echo "TEMP: $TEMP"

exit 0
