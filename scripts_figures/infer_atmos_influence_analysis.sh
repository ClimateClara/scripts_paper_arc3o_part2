#!/bin/bash

#putting all tuning experiments together 

################# DECLARE THE PATHS #######################################
path1=/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/20190125-1448/mergetime
path2=/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_SICCI2_50km_mergetime
########################################################################

# prepare a mask to mask out all regions below 99% of sea-ice concentration to avoid the effect of open ocean surface
cdo gtc,0.99 -selvar,seaice $path2/assim_SICCI2_50km_echam6_200301-200812_selcode_Arctic.nc $path1/mask_99percent_seaice_2003-2008.nc

# infer the effect of the atmosphere on the ice brightness temperature
cdo sub -selvar,TBV $path1/TBtot_assim_2003-2008_7.nc  -selvar,TBV $path1/TB_assim_2003-2008_7.nc $path1/TBVtot-TBV_assim_2003-2008_7.nc

# mask out regions of sea-ice concentration lower than 99 percent
cdo ifthen $path1/mask_99percent_seaice_2003-2008.nc $path1/TBVtot-TBV_assim_2003-2008_7.nc $path1/TBVtot-TBV_assim_2003-2008_7_only99.nc

# monthly mean over all years
cdo ymonmean $path1/TBVtot-TBV_assim_2003-2008_7_only99.nc $path1/TBVtot-TBV_assim_2003-2008_7_only99_ymonmean.nc
# field mean over this monthly mean
cdo fldmean $path1/TBVtot-TBV_assim_2003-2008_7_only99_ymonmean.nc $path1/TBVtot-TBV_assim_2003-2008_7_only99_ymonmean_fldmean.nc
# monthly standard deviation over all years
cdo ymonstd $path1/TBVtot-TBV_assim_2003-2008_7_only99.nc $path1/TBVtot-TBV_assim_2003-2008_7_only99_ymonstd.nc
# field standard deviation over this monthly mean
cdo fldstd $path1/TBVtot-TBV_assim_2003-2008_7_only99_ymonstd.nc $path1/TBVtot-TBV_assim_2003-2008_7_only99_ymonstd_fldstd.nc


###this is just applying the same method to H polarization, however the result has not been evaluated!
# cdo sub -selvar,TBH $path1/TBtot_assim_2003-2008_7.nc -selvar,TBH $path1/TB_assim_2003-2008_7.nc  $path1/TBHtot-TBH_assim_2003-2008_7.nc
# cdo ifthen $path1/mask_99percent_seaice_2003-2008.nc $path1/TBHtot-TBH_assim_2003-2008_7.nc $path1/TBHtot-TBH_assim_2003-2008_7_only99.nc
# cdo ymonmean $path1/TBHtot-TBH_assim_2003-2008_7_only99.nc $path1/TBHtot-TBH_assim_2003-2008_7_only99_ymonmean.nc
# cdo fldmean $path1/TBHtot-TBH_assim_2003-2008_7_only99_ymonmean.nc $path1/TBHtot-TBH_assim_2003-2008_7_only99_ymonmean_fldmean.nc
# cdo ymonstd $path1/TBHtot-TBH_assim_2003-2008_7_only99.nc $path1/TBHtot-TBH_assim_2003-2008_7_only99_ymonstd.nc
# cdo fldstd $path1/TBHtot-TBH_assim_2003-2008_7_only99_ymonstd.nc $path1/TBHtot-TBH_assim_2003-2008_7_only99_ymonstd_fldstd.nc
