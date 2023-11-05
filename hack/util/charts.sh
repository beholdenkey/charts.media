#!/bin/bash

# Directory containing your charts
CHARTS_DIR="charts"

# Loop over each chart in the directory
for CHART_DIR in "${CHARTS_DIR}"/*; do
  # Extract the chart name from the directory name
  CHART_NAME=$(basename "${CHART_DIR}")

  # Run the tasks for this chart
  task helm-lint CHART_NAME="${CHART_NAME}" CHART_DIR="${CHART_DIR}"
  task helm-install CHART_NAME="${CHART_NAME}" CHART_DIR="${CHART_DIR}"
  task helm-test CHART_NAME="${CHART_NAME}" CHART_DIR="${CHART_DIR}"
done
