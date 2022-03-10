# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${DESTDIR}$CONDA_BASE/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${DESTDIR}$CONDA_BASE/etc/profile.d/conda.sh" ]; then
        . "${DESTDIR}$CONDA_BASE/etc/profile.d/conda.sh"
    else
        export PATH="${DESTDIR}$CONDA_BASE/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
