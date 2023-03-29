#################################################################################################
# Example code to download/import NHANES data files (SAS transport .XPT files) as a dataset     #
# For R                                                                                         #
#################################################################################################

# Include required packages
# Include Foreign Package To Read SAS Transport Files
library(foreign)
library(tidyverse)

# Create data frame from saved XPT file

# update the file path here

setwd("~/Box/MyDocs/Teaching/Spring/2021/DSCI 610/LectureMaterials/Week 4/Lecture/NHANES_17_18")

DEMO_J <- read.xport("DEMO_J.XPT")
BMX_J <- read.xport("BMX_J.XPT")
BPX_J <- read.xport("BPX_J.XPT")

# Select a subset of variables of interest from each data frame and then create an analysis dataset
# by merging them 


DEMO_J_sb <- select(DEMO_J, SEQN, RIAGENDR, RIDAGEYR, RIDRETH3, DMQMILIZ, DMDCITZN, DMDEDUC3, DMDEDUC2, DMDMARTL, DMDHHSIZ)
BMX_J_sb <- select(BMX_J, SEQN, BMXWT, BMXHEAD, BMXHT, BMXBMI, BMXLEG, BMXARML, BMXWAIST)
BPX_J_sb <- select(BPX_J, SEQN, BPAARM, BPACSZ, BPXPULS, BPXSY1, BPXDI1, BPXSY2, BPXDI2, BPXSY3, BPXDI3, BPXSY4, BPXDI4)

# Merge DEMO_J_sb and  BMX_J_sb using the key SEQN. Note left_join keeps all observations in  DEMO_J_sb

DM_BM <- left_join(DEMO_J_sb, BMX_J_sb, by = "SEQN")

# Repeat left_join to merge BPX_J_sb to the new merged dataset DM_BM by the key SEQN

DM_BM_BP <- left_join(DM_BM, BPX_J_sb, by = "SEQN")

# save DM_BM_BP as an R data frame; note the dataframe will be save in your working directory

saveRDS(DM_BM_BP, file = "DM_BM_BP.rds")

# Reading .rds file into R 
df <- readRDS("DM_BM_BP.rds")

