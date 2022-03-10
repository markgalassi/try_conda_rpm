#! /bin/bash

bindir=`dirname $0`
. ${bindir}/try_conda_rpm_env_snippet.sh

curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > Miniconda_$$.sh
/bin/ls -l Miniconda_$$.sh
# /bin/ls -lRa $CONDA_BASE
#/bin/rm -rf $CONDA_BASE
mkdir -p $CONDA_BASE
echo "bash Miniconda_$$.sh -b -p ${DESTDIR}${CONDA_BASE}"
bash Miniconda_$$.sh -b -u -p ${DESTDIR}${CONDA_BASE}

# FIXME: I got this tip from
# https://stackoverflow.com/questions/56871882/condavalueerror-the-target-prefix-is-the-base-prefix-aborting
# to get around the error "CondaValueError: The target prefix is the
# base prefix. Aborting."
conda config --set auto_activate_base false

. ${bindir}/try_conda_rpm_conda_snippet.sh

conda create -y python=3 --prefix ${DESTDIR}$CONDA_DEPLOY
conda activate ${DESTDIR}$CONDA_DEPLOY
# install the packages we need (numpy, cartopy) with the "nomkl"
# option to bypass the very disk-intensive Intel BLAS system.
echo "conda install -y nomkl numpy cartopy --prefix ${DESTDIR}$CONDA_DEPLOY"
# conda install -y nomkl numpy cartopy --prefix ${DESTDIR}$CONDA_DEPLOY
conda install -y nomkl numpy --prefix ${DESTDIR}$CONDA_DEPLOY
# now install conda-pack
conda install -y conda-pack --prefix ${DESTDIR}$CONDA_DEPLOY
echo "conda pack -n ${DESTDIR}$CONDA_BASE -o conda_base.tar.gz"
conda pack -n ${DESTDIR}$CONDA_BASE -o conda_base.tar.gz
conda pack -n ${DESTDIR}$CONDA_DEPLOY -o conda_deploy.tar.gz
