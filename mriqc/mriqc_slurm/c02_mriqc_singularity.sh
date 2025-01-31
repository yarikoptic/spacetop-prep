BATCH --job-name=mriqc
#SBATCH --mail-user=heejung.jung@colorado.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --qos normal
#SBATCH --output ./log/mriqc%j.out
#SBATCH --error ./log/mriqc.e%j
#SBATCH --nodes 1
#SBATCH -c 12
#SBATCH -t 20:00:00
#SBATCH --exclusive


SUBJ=${1}

IMAGE=/projects/heju9108/container/mriqc-0.14.2.sif
MAINDIR=/projects/heju9108/conformity.01
BIDSROOT=${MAINDIR}/data/fontBIDS
OUTDIR=${MAINDIR}/data/derivatives/mriqc
WORKDIR=${OUTDIR}/work/

unset PYTHONPATH; singularity run ${IMAGE} \
${BIDSROOT} ${OUTDIR} participant --participant-label ${SUBJ} \
--email heejung.jung@colorado.edu --n_procs 10  --mem_gb 8 \
--correct-slice-timing --ica -m {T1w,bold}
