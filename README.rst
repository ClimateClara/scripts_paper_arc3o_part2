Scripts used to produce the data and figures for the ARC3O Part 2
=================================================================

What's this?
------------

These are the scripts used to prepare the data and produce figures for the paper:

Burgard, C., Notz, D., Pedersen, L. T., and Tonboe, R. T.: The Arctic Ocean Observation Operator for 6.9 GHz (ARC3O) – Part 2: Development and evaluation, The Cryosphere, 14, 2387–2407, https://doi.org/10.5194/tc-14-2387-2020, 2020.

The best understanding of these scripts is reached by combining the following description with
the content of the paper. Enjoy!

If you are interested in the ARC3O code in particular, visit `this github repository <https://www.github.com/ClimateClara/arc3o/>`_, which contains the most
up-to-date ARC3O-version.

Data
----

All following data and the corresponding documentation can be downloaded from the `DKRZ long term archive <https://cera-www.dkrz.de/WDCC/ui/cerasearch/entry?acronym=DKRZ_LTA_033_ds00006>`_.

Model data
##########

The ECHAM output needed for the brightness temperature simulation, from assimilation runs conducted by F. Bunzel for `Bunzel et al. (2016) <https://doi.org/10.1002/2015GL066928>`_ can be found in the folder *assimilation_runs.tar.gz* in the `DKRZ long term archive <https://cera-www.dkrz.de/WDCC/ui/cerasearch/entry?acronym=DKRZ_LTA_033_ds00006>`_.

Simulation data
###############

The simulated brightness temperatures were computed by applying the version of ARC3O given in the folder `arc3o <./arc3o/>`_ to the output of the three 
different MPI-ESM assimilation runs:
	* SICCI2: `run_arc3o_SICCI.ipynb <./scripts_simulation/run_arc3o_SICCI.ipynb>`_
	* Bootstrap: `run_arc3o_Bootstrap.ipynb <./scripts_simulation/run_arc3o_Bootstrap.ipynb>`_
	* NASA Team: `run_arc3o_NASATeam.ipynb <./scripts_simulation/run_arc3o_NASATeam.ipynb>`_

As the results are written out as monthly files, you can merge them using `cdo  <https://code.mpimet.mpg.de/projects/cdo/wiki/Cdo#Documentation>`_
as follows:

.. code-block:: bash
	
	mkdir mergetime
	cdo mergetime TBtot* ./mergetime/TBtot_assim_2003-2008_7.nc
	
The output data can be found in the folder *simulated_TBs.tar.gz* in the `DKRZ long term archive <https://cera-www.dkrz.de/WDCC/ui/cerasearch/entry?acronym=DKRZ_LTA_033_ds00006>`_.

Observation data
################

The AMSR-E data was downloaded from the NSIDC `website <https://nsidc.org/data/nsidc-0630/versions/1>`_ and 
merged and remapped to the MPI-ESM grid with the script `rearrange_AMSR_data.sh </scripts_simulation/rearrange_AMSR_data.sh>`_.

The Round Robin Data Package used in Sec. 3.1.4 was downloaded from https://doi.org/10.6084/m9.figshare.6626549.v6.

The sea-ice concentration products used in `Figures_6_8.ipynb.ipynb </scripts_figures/Figures_6_8.ipynb.ipynb>`_ were downloaded 
from NSIDC (ftp://sidads.colorado.edu/pub/DATASETS/NOAA/G02202_V3/north/daily/, Bootstrap and NASA Team) and
`ESA CCI project <http://dx.doi.org/10.5285/5f75fcb0c58740d99b07953797bc041e>`_. The data were merged, remapped to the
MPI-ESM grid, and the pole hole cut out using `cdo  <https://code.mpimet.mpg.de/projects/cdo/wiki/Cdo#Documentation>`_.

In both observed and modeled brightness temperatures, the polar hole was masked using `cdo  <https://code.mpimet.mpg.de/projects/cdo/wiki/Cdo#Documentation>`_
as follows:

.. code-block:: bash
	
	cdo sellonlatbox,0,360,45,87.2 infile.nc infile_hole.nc
	
The formatted observational data can be found in the folder *observations.tar.gz* in the `DKRZ long term archive <https://cera-www.dkrz.de/WDCC/ui/cerasearch/entry?acronym=DKRZ_LTA_033_ds00006>`_.


Sensitivity study (see Sec. 4.3.2 of the paper)
-----------------------------------------------

For the sensitivity study in Sec. 4.3.2., we prepare the variability ranges displayed in Figure B1 and
mentioned in Table 1 with the script `prepare_sens_ranges.sh </scripts_figures/prepare_sens_ranges.sh>`_.
The resulting modulated fields are used to run simulations with ARC3O, using the script 
`prepare_sensexp_data.py </scripts_figures/prepare_sensexp_data.py>`_. Finally, these results are 
processed to prepare the results displayed in Figure 5 and Table 1 with the script `prepare_sensexp_output_for_figure5.sh </scripts_figures/prepare_sensexp_output_for_figure5.sh>`_.


Further analysis and Figures
----------------------------

The final analysis and visualization was done using the following scripts:
	
	* Figure 2: `Figure_2.ipynb </scripts_figures/Figure_2.ipynb>`_
	* infer the atmospheric influence for the correction of the summer TB: `infer_atmospheric_influence.ipynb </scripts_figures/infer_atmospheric_influence.ipynb>`_ and `infer_atmos_influence_analysis.sh </scripts_figures/infer_atmos_influence_analysis.sh>`_
	* Figure 4 and key figure (on The Cryosphere webpage): `Figure_Key_and_4.ipynb </scripts_figures/Figure_Key_and_4.ipynb>`_ 
	* Figure 5, Table 1, and Figure B1: `Figures_B1_5_Table_1.ipynb </scripts_figures/Figures_B1_5_Table_1.ipynb>`_
	* Figures 6 and 8:  `Figures_6_8.ipynb.ipynb </scripts_figures/Figures_6_8.ipynb>`_
	* Figure 7: `Figure_7.ipynb </scripts_figures/Figure_7.ipynb>`_ 
	* Figure A1: `Figure_A1.ipynb </scripts_figures/Figure_A1.ipynb>`_ 
	* Figure 9: data prepared with `experiment_meltpondfraction0.ipynb </scripts_figures/experiment_meltpondfraction0.ipynb>`_ and `mpf0_prepare_files.sh </scripts_figures/experiment_meltpondfraction0.ipynb>`_, then plotted with `Figure_9.ipynb </scripts_figures/Figure_9.ipynb>`_

Signed: Clara Burgard, 02.09.2020