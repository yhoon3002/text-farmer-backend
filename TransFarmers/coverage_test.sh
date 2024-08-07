#!/bin/bash

TEST_DIRS=$(find . -path ./.venv -prune -o -type d -name 'tests' -print)

source .venv/bin/activate

coverage erase

for TEST_DIR in $TEST_DIRS; do
    APP_NAME=$(basename $(dirname $TEST_DIR))

    TEST_FILES=$(find $TEST_DIR -type f -name 'test*.py')
    if [ -z "$TEST_FILES" ]; then
        echo "No test files found in $TEST_DIR. Skipping..."
        continue
    fi

    echo "Running tests for $APP_NAME with coverage..."
    coverage run --source='.' manage.py test ${APP_NAME}.tests
done

coverage combine

coverage report
coverage html
coverage xml
