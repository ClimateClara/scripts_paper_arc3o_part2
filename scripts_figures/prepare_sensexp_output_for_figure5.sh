#!bash

############################
path1=/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_SICCI2_50km_mergetime
#path2=/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/20200603-2009 #SICCI2 
#path2=/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/20200604-0904 #Bootstrap 
path2=/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/20200604-0918 #NASATeam 
############################

mon=March # or October
mm=03 # or 10

for i in {sicplus,sicminus,sitplus,sitminus,tempplus,tempminus,snowplus,snowminus,reference}
do

# make order in arc3o output
mkdir $path2/$i/$mon/mergetime
cdo mergetime $path2/$i/$mon/TBtot* $path2/$i/$mon/mergetime/TBtot_assim_2004-2008_"$mm"_7.nc

done

for i in {sicplus,sicminus,sitplus,sitminus,tempplus,tempminus,snowplus,snowminus}
do

# difference between sensitivity experiment and reference
cdo sub $path2/$i/$mon/mergetime/TBtot_assim_2004-2008_"$mm"_7.nc $path2/reference/$mon/mergetime/TBtot_assim_2004-2008_"$mm"_7.nc $path2/$i/$mon/mergetime/TBtotdiff_assim_2004-2008_"$mm"_7.nc
#cut out polar hole
cdo sellonlatbox,0,360,45,87.2 $path2/$i/$mon/mergetime/TBtotdiff_assim_2004-2008_"$mm"_7.nc $path2/$i/$mon/mergetime/TBtotdiff_assim_2004-2008_"$mm"_7_hole.nc

done