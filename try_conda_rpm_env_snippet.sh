# common environment settings for scripts that participate in running
# python programs under conda control
export PROJECT_NAME=try_conda_rpm
export OPT_AREA=/opt/$PROJECT_NAME
export CONDA_TOP=${OPT_AREA}/conda_base
export PATH=${CONDA_TOP}/bin:$PATH
