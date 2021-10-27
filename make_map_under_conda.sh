#! /bin/bash

bindir=`dirname $0`
. ${bindir}/try_conda_rpm_env_snippet.sh
. ${bindir}/try_conda_rpm_conda_snippet.sh

conda activate $CONDA_TOP

${bindir}/simple_map_trick.py
