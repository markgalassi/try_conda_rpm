#! /bin/bash

bindir=`dirname $0`
. ${bindir}/try_conda_rpm_env_snippet.sh

curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > Miniconda_$$.sh
/bin/ls -l Miniconda_$$.sh
/bin/ls -lRa $CONDA_TOP
/bin/rm -rf $CONDA_TOP
mkdir -p $CONDA_TOP
echo "bash Miniconda_$$.sh -b -p $CONDA_TOP"
bash Miniconda_$$.sh -b -u -p $CONDA_TOP

# FIXME: I got this tip from
# https://stackoverflow.com/questions/56871882/condavalueerror-the-target-prefix-is-the-base-prefix-aborting
# to get around the error "CondaValueError: The target prefix is the
# base prefix. Aborting."
conda config --set auto_activate_base false

. ${bindir}/try_conda_rpm_conda_snippet.sh

conda create -y python=3 --prefix $CONDA_TOP
conda activate $CONDA_TOP
conda install -y cartopy --prefix $CONDA_TOP
