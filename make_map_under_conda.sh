#! /bin/bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/conda/etc/profile.d/conda.sh" ]; then
        . "$HOME/conda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# FIXME: I should put much of this under BUILDROOT or /opt or
# something, not my home dir.  for now I coordinate it with the test
# that I'm doing in install_conda_stuff.sh, which uses home dir for
# conda and /tmp/try_conda_rpm for installed packages

conda activate /tmp/try_conda_rpm

./simple_map_trick.py
