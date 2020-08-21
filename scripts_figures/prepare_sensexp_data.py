#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 03 10:30 2020

Script running ARC3O on the modulated variables for the sensitivity study in Sec. 4.3.2.
The experiment is run over the three datasets but only the results of SICCI2 are shown in 
the paper

@author: Clara Burgard
"""

import xarray as xr
import subprocess
from pathos.multiprocessing import ProcessingPool as Pool

import sys
sys.path.append('./arc3o')
import core_functions as arc3o

##################################################################################

outputpath0_SICCI = '/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/20200603-2009/'
outputpath0_BT = '/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/20200604-0904/'
outputpath0_NT = '/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/20200604-0918/'


inputpath_SICCI = '/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/var_sens/SICCI2/'
inputpath_SICCI_orig = '/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_SICCI2_50km/'

inputpath_BT = '/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/var_sens/Bootstrap/'
inputpath_BT_orig = '/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_Bootstrap/'

inputpath_NT = '/work/mh0033/m300411/SatSim/WORK_DATA/simulated_TBs/var_sens/NASATeam/'
inputpath_NT_orig = '/work/mh0033/m300411/SatSim/WORK_DATA/assimilation_runs/assim_NASATeam/'

#############################################################################################################				if assim == 'SICCI2':

### ARC3O computation, using pool to parallelize the computation
def f(yy):

	freq_of_int = 6.9
	for var in ['seaice','siced','sni','tsi']: # loop over variables
	
		if var=='seaice':
			var1 = 'sic'
		elif var=='siced':
			var1 = 'sit'
		elif var=='tsi':
			var1 = 'temp'
		elif var=='sni':
			var1 = 'snow'
			
		for mm in [3,10]: # loop over March and October
	
			if mm == 3:
				strmonth = 'March'
			elif mm == 10:
				strmonth = 'October'

			for assim in ['SICCI2','Bootstrap','NASATeam']: # loop over assimilation runs
				
				for plus_minus in ['plus','minus']: # loop over added variability fields and subtracted variability fields
					
					if assim=='SICCI2':
					
						outputpath = outputpath0_SICCI+var1+plus_minus+'/'+strmonth+'/'
						file_begin = 'assim_'+assim+'_50km_echam6_'
						file_end = '_ensstd_'+var1+plus_minus+'_siconly.nc'
	
						orig_data = xr.open_dataset(inputpath_SICCI+'assim_'+assim+'_50km_echam6_'+str(yy)+str(mm).zfill(2)+'_ensstd_'+var1+plus_minus+'_siconly.nc')

						arc3o.satsim_complete_1month(orig_data,freq_of_int,yy,mm,inputpath_SICCI,outputpath,file_begin,file_end,write_mask='no',write_profiles='yes',compute_memls='yes')
    
					elif assim == 'Bootstrap':
					
						outputpath = outputpath0_BT+var1+plus_minus+'/'+strmonth+'/'
						file_begin = 'assim_'+assim+'_echam6_'
						file_end = '_ensstd_'+var1+plus_minus+'_siconly.nc'
	
						orig_data = xr.open_dataset(inputpath_BT+'assim_'+assim+'_echam6_'+str(yy)+str(mm).zfill(2)+'_ensstd_'+var1+plus_minus+'_siconly.nc')

						arc3o.satsim_complete_1month(orig_data,freq_of_int,yy,mm,inputpath_BT,outputpath,file_begin,file_end,write_mask='no',write_profiles='yes',compute_memls='yes')

					elif assim == 'NASATeam':
					
						outputpath = outputpath0_NT+var1+plus_minus+'/'+strmonth+'/'
						file_begin = 'assim_'+assim+'_echam6_'
						file_end = '_ensstd_'+var1+plus_minus+'_siconly.nc'
	
						orig_data = xr.open_dataset(inputpath_NT+'assim_'+assim+'_echam6_'+str(yy)+str(mm).zfill(2)+'_ensstd_'+var1+plus_minus+'_siconly.nc')

						arc3o.satsim_complete_1month(orig_data,freq_of_int,yy,mm,inputpath_NT,outputpath,file_begin,file_end,write_mask='no',write_profiles='yes',compute_memls='yes')


p = Pool(6)
p.map(f, range(2004,2009))    


# To be sure that we are comparing apples to apples, we redo the reference experiments so that we can compare the modulated results with the same reference

def f(yy):
	inputpath_SICCI_orig = '/work/mh0033/m300411/SatSim/WORK_DATA/assim_SICCI2_50km/'
	inputpath_BT_orig = '/work/mh0033/m300411/SatSim/WORK_DATA/assim_Bootstrap/'
	inputpath_NT_orig = '/work/mh0033/m300411/SatSim/WORK_DATA/assim_NASATeam/'
	freq_of_int = 6.9
	
	assim = 'NASATeam' # or 'SICCI2' or 'Bootstrap'
	for mm in [3,10]:
	
		if mm == 3:
			strmonth = 'March'
		elif mm == 10:
			strmonth = 'October'
		
		if assim=='SICCI2':

			outputpath = outputpath0_SICCI+'reference/'+strmonth+'/'

			file_begin = 'assim_'+assim+'_50km_echam6_'
			file_end = '_selcode_Arctic.nc'
	
			orig_data = xr.open_dataset(inputpath_SICCI_orig+'assim_'+assim+'_50km_echam6_'+str(yy)+str(mm).zfill(2)+'_selcode_Arctic.nc')

			arc3o.satsim_complete_1month(orig_data,freq_of_int,yy,mm,inputpath_SICCI_orig,outputpath,file_begin,file_end,write_mask='no',write_profiles='yes',compute_memls='yes')

		elif assim=='Bootstrap':

			outputpath = outputpath0_BT+'reference/'+strmonth+'/'

			file_begin = 'assim_'+assim+'_echam6_'
			file_end = '_selcode_Arctic.nc'
	
			orig_data = xr.open_dataset(inputpath_BT_orig+'assim_'+assim+'_echam6_'+str(yy)+str(mm).zfill(2)+'_selcode_Arctic.nc')

			arc3o.satsim_complete_1month(orig_data,freq_of_int,yy,mm,inputpath_BT_orig,outputpath,file_begin,file_end,write_mask='no',write_profiles='yes',compute_memls='yes')

		elif assim=='NASATeam':

			outputpath = outputpath0_NT+'reference/'+strmonth+'/'

			file_begin = 'assim_'+assim+'_echam6_'
			file_end = '_selcode_Arctic.nc'
	
			orig_data = xr.open_dataset(inputpath_NT_orig+'assim_'+assim+'_echam6_'+str(yy)+str(mm).zfill(2)+'_selcode_Arctic.nc')

			arc3o.satsim_complete_1month(orig_data,freq_of_int,yy,mm,inputpath_NT_orig,outputpath,file_begin,file_end,write_mask='no',write_profiles='yes',compute_memls='yes')


p = Pool(6)
p.map(f, range(2004,2009))    


###### the following is an example for only running a subset of these experiments
# def f(yy):
# 	for var in ['tsi']:
# 	
# 		if var=='seaice':
# 			var1 = 'sic'
# 		elif var=='siced':
# 			var1 = 'sit'
# 		elif var=='tsi':
# 			var1 = 'temp'
# 		elif var=='sni':
# 			var1 = 'snow'
# 			
# 		for mm in [3]:
# 	
# 			if mm == 3:
# 				strmonth = 'March'
# 			elif mm == 10:
# 				strmonth = 'October'
# 
# 			for assim in ['SICCI2']:
# 				
# 				for plus_minus in ['minus']:
# 				
# 					outputpath = outputpath0+var1+plus_minus+'/'+strmonth+'/'
# 
# 					file_begin = 'assim_'+assim+'_50km_echam6_'
# 					file_end = '_ensstd_'+var1+plus_minus+'_siconly.nc'
# 	
# 					orig_data = xr.open_dataset(inputpath_SICCI+'assim_'+assim+'_50km_echam6_'+str(yy)+str(mm).zfill(2)+'_ensstd_'+var1+plus_minus+'_siconly.nc')
# 
# 					freq_of_int = 6.9
# 
# 					satsim.satsim_complete_1month(orig_data,freq_of_int,yy,mm,inputpath_SICCI,outputpath,file_begin,file_end,write_mask='no',write_profiles='no',compute_memls='no')
#     
# p = Pool(6)
# p.map(f, range(2004,2009))  

