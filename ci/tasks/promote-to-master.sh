#!/bin/bash

set -e

semver=`cat final-version-semver/number`

pwd=`pwd`

#Inputs
src_repo=${pwd}/src-develop

#Outputs
mkdir -p ${pwd}/promoted

cp -r ${src_repo} promoted/repo

now=`date`

pushd promoted/repo

  echo "Creating ignored file"
  cat > scratch/private.yml << EOF
---
time-updated: ${now}
EOF

  git add .
  git config --global user.email bosh-build@oracle.com
  git config --global user.name CI
  git commit --allow-empty -m "Promoted to master release v${semver}"

popd

echo ${semver} > promoted/version
echo "Promoted to master v${semver}" > promoted/annotation_message
