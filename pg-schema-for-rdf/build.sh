#!/bin/bash

input_data_file="in-example-schema.ttl"

output_profile_file="out-profile.ttl"
output_debug_file="out-debug.ttl"

# -------------------------------------

# validate input file
riot --validate $input_data_file

if [ ! $? -eq 0 ]; then
    echo "Validation failed with errors"
    exit 1
fi

# transform input to profile using eye reasoner
eye --nope --quiet m2m/to-profile.n3 --turtle $input_data_file --query m2m/filter-profile.n3 > $output_profile_file

if [ ! $? -eq 0 ]; then
    echo "Transformation to profile failed with errors"
    exit 1
fi

# transform input to debug using eye reasoner

# eye --nope --quiet --pass          m2m/to-profile.n3 --turtle $input_data_file > $output_debug_file
eye --nope --quiet --pass-only-new m2m/to-profile.n3 --turtle $input_data_file > $output_debug_file

if [ ! $? -eq 0 ]; then
    echo "Transformation to debug failed with errors"
    exit 1
fi

echo "Profile:  $output_profile_file"
echo "Debug:    $output_debug_file"