#!/bin/bash

DOMAIN="domain.pddl"
PROBLEM_DIR="./problem"        # folder containing problem files
OUTPUT_DIR="./outputs"          # where output txt files will be saved

mkdir -p "$OUTPUT_DIR"

for problem in "$PROBLEM_DIR"/*.pddl; do
    filename=$(basename -- "$problem")
    name="${filename%.pddl}"

    echo "Running POPF for $filename..."

       ros2 run popf popf "$DOMAIN" "$problem" \
        > "$OUTPUT_DIR/${name}_output.txt" 2>&1

done

echo "All problems processed."
