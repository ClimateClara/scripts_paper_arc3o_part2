DATA ARC3O PAPER 2
==================

MAIN DATA
---------

All data used for the paper can be found on the DKRZ archive in /hpss/arch/mh0033/m300411/ARC3O_part2_data/

	* *assimilation_runs* contains: the MPI-ESM output needed for the analysis, inferred from the data mentioned below.
	* *observations* contains: Observed brightness temperatures downloaded from https://nsidc.org/data/nsidc-0630/versions/1 and formatted using `rearrange_AMSR_data.sh </scripts_simulation/rearrange_AMSR_data.sh>`_, retrieved sea-ice concentrations, and data from the Round Robin Data Package.
	* *simulated_TBs* contains: Results from the scripts in *scripts_figures* and *scripts_simulation*


The original files from the assimilation runs can be found on the DKRZ archive:

SICCI2
######

| SICCI2 50km filtered assimilation run
| MPI-ESM-LR v1.1.00p1
| Years: 2002-2008
| Sea ice: ESA-CCI-2 50km filtered data (concentration)
| Ocean: ORA-S4 (3D temperature, 3D salinity)
| Atmosphere: ERA-Interim (surface pressure, 3D vorticity, 3D divergence, 3D temperature)
| Path: /hpss/arch/mh0033/m300096/sicci2_50km/

Bootstrap
#########

| Bootstrap assimilation run
| MPI-ESM-LR v1.0.02p2
| Years: 2002-2008
| Sea ice: NSIDC/Bootstrap (concentration)
| Ocean: ORA-S4 (3D temperature, 3D salinity)
| Atmosphere: ERA-Interim (surface pressure, 3D vorticity, 3D divergence, 3D temperature)
| Path: /hpss/arch/mh0033/m300411/fbassimsicci_r1i1p1-LR_nsidc-bt


NASATeam
########

| NASA-Team assimilation run
| MPI-ESM-LR v1.0.02p2
| Years: 1979-2012
| Sea ice: NSIDC/NASA-Team (concentration)
| Ocean: ORA-S4 (3D temperature, 3D salinity)
| Atmosphere: ERA-Interim (surface pressure, 3D vorticity, 3D divergence, 3D temperature)
| Path: /hpss/arch/mh0033/m300096/fbassimsicci_r1i1p1-LR_nsidc-nt_out/ and /hpss/arch/mh0033/m300096/fbassimsicci_r1i1p1-LR_nsidc-nt_restart/

      

