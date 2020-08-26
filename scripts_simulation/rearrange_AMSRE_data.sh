#!bash

################# DECLARE THE PATHS #############################3
path1=/folder/original/daily/observations # folder containing files downloaded from the MEASUReS dataset (https://nsidc.org/data/nsidc-0630/versions/1)
path2=/work/mh0033/m300411/SatSim/WORK_DATA/observations
###################################################################

freq="06V"


for yy in {2003..2008}
do
echo "YEAR $yy"
#mergetime years
cdo mergetime $path1/$freq/single_files/*"$yy"*.nc $path1/$freq/AMSRE_N25km_"$freq"_E_"$yy".nc
#remap on modgrid
cdo remapbil,$path2/assim_MPI-ESM-LR.nc $path1/$freq/AMSRE_N25km_"$freq"_E_"$yy".nc $path1/$freq/AMSRE_N25km_"$freq"_E_"$yy"_modgrid.nc
done

#mergetime all
echo "merging all years together"
cdo mergetime $path1/$freq/AMSRE_N25km_"$freq"_E_"$yy"_modgrid.nc $path1/$freq/AMSRE_N25km_"$freq"_E_2003-2008_modgrid.nc
cdo selyear,2004/2008 $path1/$freq/AMSRE_N25km_"$freq"_E_2003-2008_modgrid.nc $path2/AMSRE_N25km_"$freq"_E_2004-2008_modgrid.nc
cdo sellonlatbox,0,360,45,87.2 $path2/AMSRE_N25km_"$freq"_E_2004-2008_modgrid.nc $path2/AMSRE_N25km_"$freq"_E_2004-2008_modgrid_hole.nc