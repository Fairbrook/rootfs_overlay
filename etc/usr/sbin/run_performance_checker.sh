#!/bin/bash

echo "Searching from $1"

script=$(find $1 -name "performance_checker*" | head -n 1)

echo "Found $script"

if [ -x $script ]; then
    echo "Executing $script"
    $script
fi
