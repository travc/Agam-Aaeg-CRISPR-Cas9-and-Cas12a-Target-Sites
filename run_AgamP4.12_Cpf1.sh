#!/bin/bash

OUTDIR='/data2/data/proj/chopchop/Cpf1_all_transcripts_run'

TRANSFN='/data2/data/proj/chopchop/data/AgamP4.12.transcript_list'
GENOME='AgamP4'
MODEL=3  # CAS9=1, CPF1=3
SCORING_METHOD='KIM_2018'

JOBS=12
CHOPCHOP_DIR='/data2/data/proj/chopchop/chopchop'



# >>> conda init >>>
__conda_setup="$(CONDA_REPORT_ERRORS=false ~/miniconda3/bin/conda shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "~/miniconda3/etc/profile.d/conda.sh" ]; then
        . "~/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="~/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup


pushd $CHOPCHOP_DIR
conda activate chopchop

#stdbuff -o0 echo "{#} {}"; \

/usr/bin/time nice -n 9 parallel \
-j $JOBS \
--joblog "$OUTDIR/run_job.log" \
-a "$TRANSFN" '\
ulimit -Sn 65535; \
'$CHOPCHOP_DIR'/chopchop.py \
 -T '$MODEL' \
 -G '$GENOME' \
 --scoringMethod '$SCORING_METHOD' \
 -t WHOLE \
 -o "tmp_{}_out" \
 --targets {} > "'$OUTDIR'/{}" ;\
rm -rf "tmp_{}_out"
'

conda deactivate
popd

