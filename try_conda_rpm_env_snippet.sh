# common environment settings for scripts that participate in running
# python programs under conda control
export PROJECT_NAME=try_conda_rpm
export OPT_AREA=/opt/$PROJECT_NAME
export CONDA_BASE=${OPT_AREA}/conda_base
export CONDA_DEPLOY=${OPT_AREA}/conda_deploy
export PATH=${CONDA_BASE}/bin:$PATH
export PATH=${CONDA_DEPLOY}/bin:$PATH
