# Agam-Aaeg-CRISPR-Cas9-and-Cas12a-Target-Sites
CRISPR-Cas9 and Cas12a Target Site Richness Reflects Genomic Diversity in natural populations of Anopheles gambiae and Aedes aegypti mosquitoes

- `good_targets.xlsx` :
Contains all of the Cas9 and Cas12a target sites which passed the filters described in the paper.  There is a sheet for each enzyme and population combination.

- Code used for analysis and figure generation...
  - `exons_Cas9_vs_Cpf1.ipynb` : Primary processeing and filtering of chopchop results

  - `exons_Cas9_vs_Cpf1_Analysis.ipynb` : Anaysis of chopchop results and figure generation

  - `compute_GC.ipynb` : Calculates overall %GC for both the whole genome and only the CDSs based on the reference sequences

  - AAEL_CDSs.bed, AgamGF_CDSs.bed, AaegL5_chroms.bed, AgamP4_chroms.bed : Data files used when computing %GC. `*_CDSs.bed` are created by `compute_GC.ipynb`

  - `gff3togenetable.sh` : used to create a list of all transcripts from a reference annotation

  - `run_AaegL5_Cas9.sh`, `run_AaegL5_Cpf1.sh`, `run_AgamP4.12_Cas9.sh`, `run_AgamP4.12_Cpf1.sh` : Scripts running chopchop on all transcripts for each species and enzyme
 
### Preprocessing and miscellaneous

#### Trascript list generation
Lists of all transcripts for each reference were extracted with the `gff3togenetable.sh` script which utilizes the `gff3ToGenePred` tool from UCSC.  
Eg: For AaegL5...
```
gff3togenetable.sh Aedes-aegypti-LVP_AGWG_BASEFEATURES_AaegL5.1.gff3
ln -s Aedes-aegypti-LVP_AGWG_BASEFEATURES_AaegL5.1.gene_table Aaegypti_L5.gene_table
cut -f 1 Aedes-aegypti-LVP_AGWG_BASEFEATURES_AaegL5.1.gene_table > Aedes-aegypti-LVP_AGWG_BASEFEATURES_AaegL5.1.transcript_list
```

#### Running chopchop on all transcripts
chopchop was run for each species and enzyme (Cas9, Cpf1|Cas12a) using the `run_*_*.sh` scripts.
