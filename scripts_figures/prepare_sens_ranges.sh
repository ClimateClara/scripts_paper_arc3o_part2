#################
# PREPARE THE VARIABILITY RANGES FOR THE SENSITIVITY EXPERIMENTS IN SEC 4.3.2
# author: Clara Burgard
#################

############################
path1=/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_SICCI2_50km_mergetime
path2=/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/var_sens/SICCI2
path3=/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_SICCI2_50km
############################

for mon in {03,10}
do

for var in {seaice,siced,sni,tsi}
do

# prepare a mask for regions covered by sea ice only
for yy in {2003..2008}
do
cdo selvar,$var $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/"$var"_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc 
cdo ifthen $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/"$var"_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/"$var"_SICCI2_50km_echam6_"$yy""$mon"_siconly.nc
done

# compute ensemble standard deviation (over years 2003 to 2008)
cdo ensstd $path2/"$var"_SICCI2_50km_echam6_2003"$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_2004"$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_2005"$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_2006"$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_2007"$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_2008"$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_"$mon"_ensstd_siconly.nc
# cut out polar hole
cdo sellonlatbox,0,360,45,87.2 $path2/"$var"_SICCI2_50km_echam6_"$mon"_ensstd_siconly.nc $path2/"$var"_SICCI2_50km_echam6_"$mon"_ensstd_siconly_hole.nc

for yy in {2004..2008}
do
# add the variability range to the variable of interest
cdo add $path2/"$var"_SICCI2_50km_echam6_"$yy""$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_"$mon"_ensstd_siconly.nc  $path2/"$var"_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc
# subtract the variability range to the variable of interest
cdo sub $path2/"$var"_SICCI2_50km_echam6_"$yy""$mon"_siconly.nc $path2/"$var"_SICCI2_50km_echam6_"$mon"_ensstd_siconly.nc  $path2/"$var"_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc
done
done

# make sure that there are no unrealistic values
for yy in {2004..2008}
do
# sic has to be above 0
cdo mul $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc -gec,0 $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc
#sic has to be below 1
cdo ifthenelse -lec,1 $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc -ifthenc,1 -gtc,1 $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below1.nc
#sit has to be above 0
cdo mul $path2/siced_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc -gec,0 $path2/siced_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/siced_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc
#snd has to be above 0
cdo mul $path2/sni_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc -gec,0 $path2/sni_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/sni_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc
#tsi has to be below 273.15
cdo ifthenelse -lec,273.15 $path2/tsi_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/tsi_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc -ifthenc,273.15 -gtc,273.15 $path2/tsi_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/tsi_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below273.nc

# insert the modulated variables in the original time series
#seaice
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below1.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sicplus_siconly.nc
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sicminus_siconly.nc
#siced
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/siced_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sitplus_siconly.nc
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/siced_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sitminus_siconly.nc
#snd
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/sni_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_snowplus_siconly.nc
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/sni_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_snowminus_siconly.nc
#tsi
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/tsi_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below273.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_tempplus_siconly.nc
cdo replace $path3/assim_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/tsi_SICCI2_50km_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/assim_SICCI2_50km_echam6_"$yy""$mon"_ensstd_tempminus_siconly.nc

done


done
done

# create a mask to better discriminate regions of sea ice in Figure 5 and Figure B1
for yy in {2003..2008}
do
for mon in {03,10}
do
cdo ifthen $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_SICCI2_50km_echam6_"$yy""$mon"_siconly_testmask.nc
done
done

for mon in {03,10}
do
cdo mergetime $path2/seaice_SICCI2_50km_echam6_*"$mon"_siconly_testmask.nc $path2/seaice_SICCI2_50km_echam6_"$mon"_siconly_testmask.nc
cdo sellonlatbox,0,360,45,87.2 $path2/seaice_SICCI2_50km_echam6_"$mon"_siconly_testmask.nc $path2/seaice_SICCI2_50km_echam6_"$mon"_siconly_testmask_hole.nc
done

############
# same procedure as above for Bootstrap and NASA Team (not shown in paper)
############

#assim=Bootstrap
assim=NASATeam

############################
path1=/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_"$assim"_mergetime
path2=/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/var_sens/"$assim"
path3=/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_"$assim"
############################

for mon in {03,10}
do

for var in {seaice,siced,sni,tsi}
do

for yy in {2003..2008}
do
cdo selvar,$var $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/"$var"_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc 
cdo ifthen $path2/seaice_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/"$var"_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/"$var"_"$assim"_echam6_"$yy""$mon"_siconly.nc
done

cdo ensstd $path2/"$var"_"$assim"_echam6_2003"$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_2004"$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_2005"$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_2006"$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_2007"$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_2008"$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_"$mon"_ensstd_siconly.nc
cdo sellonlatbox,0,360,45,87.2 $path2/"$var"_"$assim"_echam6_"$mon"_ensstd_siconly.nc $path2/"$var"_"$assim"_echam6_"$mon"_ensstd_siconly_hole.nc

for yy in {2004..2008}
do
cdo add $path2/"$var"_"$assim"_echam6_"$yy""$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_"$mon"_ensstd_siconly.nc  $path2/"$var"_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc
cdo sub $path2/"$var"_"$assim"_echam6_"$yy""$mon"_siconly.nc $path2/"$var"_"$assim"_echam6_"$mon"_ensstd_siconly.nc  $path2/"$var"_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc
done
done

for yy in {2004..2008}
do
cdo mul $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc -gec,0 $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc
cdo ifthenelse -lec,1 $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc -ifthenc,1 -gtc,1 $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below1.nc
#sit has to be above 0
cdo mul $path2/siced_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc -gec,0 $path2/siced_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/siced_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc
#snd has to be above 0
cdo mul $path2/sni_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc -gec,0 $path2/sni_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/sni_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc
#tsi has to be below 273.15
cdo ifthenelse -lec,273.15 $path2/tsi_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/tsi_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc -ifthenc,273.15 -gtc,273.15 $path2/tsi_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/tsi_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below273.nc

#seaice
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below1.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_sicplus_siconly.nc
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_sicminus_siconly.nc
#siced
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/siced_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_sitplus_siconly.nc
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/siced_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_sitminus_siconly.nc
#snd
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/sni_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_snowplus_siconly.nc
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/sni_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly_above0.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_snowminus_siconly.nc
#tsi
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/tsi_"$assim"_echam6_"$yy""$mon"_ensstd_sensplus_siconly_below273.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_tempplus_siconly.nc
cdo replace $path3/assim_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/tsi_"$assim"_echam6_"$yy""$mon"_ensstd_sensminus_siconly.nc $path2/assim_"$assim"_echam6_"$yy""$mon"_ensstd_tempminus_siconly.nc

done


done
done

# create a mask to better discriminate regions of sea ice in Figure 5 and Figure B1
for yy in {2003..2008}
do
for mon in {03,10}
do
cdo ifthen $path2/seaice_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_"$assim"_echam6_"$yy""$mon"_selcode_Arctic.nc $path2/seaice_"$assim"_echam6_"$yy""$mon"_siconly_testmask.nc
done
done

for mon in {03,10}
do
cdo mergetime $path2/seaice_"$assim"_echam6_*"$mon"_siconly_testmask.nc $path2/seaice_"$assim"_echam6_"$mon"_siconly_testmask.nc
cdo sellonlatbox,0,360,45,87.2 $path2/seaice_"$assim"_echam6_"$mon"_siconly_testmask.nc $path2/seaice_"$assim"_echam6_"$mon"_siconly_testmask_hole.nc
done

########
# in folder 20200603-2009 #SICCI ensstd
# in folder 20200604-0904 #BT ensstd
# in folder 20200604-0918 #NT ensstd
for i in {sicplus,sicminus,sitplus,sitminus,tempplus,tempminus,snowplus,snowminus,reference}
do

mkdir $i
cd $i
mkdir March
mkdir October
cd ..
done

# also copy the period mask (instead of computing the masks new)
for i in {sicplus,sicminus,sitplus,sitminus,tempplus,tempminus,snowplus,snowminus,reference}
do
for mon in {March,October}
do
cp ../20200527-1546/March_only/period_masks_assim.nc ./$i/$mon #SICCI2
cp ../20200518-1655/March_only/period_masks_assim.nc ./$i/$mon #Bootstrap
cp ../20200518-1701/March_only/period_masks_assim.nc ./$i/$mon #NASATeam
done
done
