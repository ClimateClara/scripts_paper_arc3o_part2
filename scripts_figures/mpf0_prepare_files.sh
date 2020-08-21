# To be applied in the relevant folders in the middle of 'experiment_meltpondfraction0.ipynb':

# SICCI: 20190209-1546
for yy in {2004..2008}
do
for mm in {07,08,09}
do 
cdo selmon,$mm -selyear,$yy assim_SICCI2_50km_echam6_200211-200812_selcode_Arctic_mpf0.nc assim_SICCI2_50km_echam6_"$yy""$mm"_selcode_Arctic_mpf0.nc
done
done

cdo selyear,2004/2008 assim_SICCI2_50km_echam6_200211-200812_selcode_Arctic_mpf0.nc assim_SICCI2_50km_echam6_200401-200812_selcode_Arctic_mpf0.nc
cdo dayavg assim_SICCI2_50km_echam6_200401-200812_selcode_Arctic_mpf0.nc assim_SICCI2_50km_echam6_200401-200812_selcode_Arctic_mpf0_dayavg.nc
cdo sellonlatbox,0,360,45,87.2 assim_SICCI2_50km_echam6_200401-200812_selcode_Arctic_mpf0_dayavg.nc assim_SICCI2_50km_echam6_200401-200812_selcode_Arctic_mpf0_dayavg_hole.nc

#Bootstrap: 20190209-1549
for yy in {2004..2008}
do
for mm in {07,08,09}
do 
cdo selmon,$mm -selyear,$yy assim_Bootstrap_echam6_200211-200812_selcode_Arctic_mpf0.nc assim_Bootstrap_echam6_"$yy""$mm"_selcode_Arctic_mpf0.nc
done
done

cdo selyear,2004/2008 assim_Bootstrap_echam6_200211-200812_selcode_Arctic_mpf0.nc assim_Bootstrap_echam6_200401-200812_selcode_Arctic_mpf0.nc
cdo dayavg assim_Bootstrap_echam6_200401-200812_selcode_Arctic_mpf0.nc assim_Bootstrap_echam6_200401-200812_selcode_Arctic_mpf0_dayavg.nc
cdo sellonlatbox,0,360,45,87.2 assim_Bootstrap_echam6_200401-200812_selcode_Arctic_mpf0_dayavg.nc assim_Bootstrap_echam6_200401-200812_selcode_Arctic_mpf0_dayavg_hole.nc

#NASA Team: 20190209-1552
for yy in {2004..2008}
do
for mm in {07,08,09}
do 
cdo selmon,$mm -selyear,$yy assim_NASATeam_echam6_200211-200812_selcode_Arctic_mpf0.nc assim_NASATeam_echam6_"$yy""$mm"_selcode_Arctic_mpf0.nc
done
done

cdo selyear,2004/2008 assim_NASATeam_echam6_200211-200812_selcode_Arctic_mpf0.nc assim_NASATeam_echam6_200401-200812_selcode_Arctic_mpf0.nc
cdo dayavg assim_NASATeam_echam6_200401-200812_selcode_Arctic_mpf0.nc assim_NASATeam_echam6_200401-200812_selcode_Arctic_mpf0_dayavg.nc
cdo sellonlatbox,0,360,45,87.2 assim_NASATeam_echam6_200401-200812_selcode_Arctic_mpf0_dayavg.nc assim_NASATeam_echam6_200401-200812_selcode_Arctic_mpf0_dayavg_hole.nc