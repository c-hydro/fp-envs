#!/bin/bash -e

#-----------------------------------------------------------------------------------------
# Script information
script_name='FP ENVIRONMENT - PYTHON3 LIBRARIES'
script_version="1.5.1"
script_date='2020/01/10'

# Define file reference path according with https link(s)
fileref_miniconda='https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh'

# Argument(s) default definition(s)
fp_folder_root_default=$HOME/fp_libs_python3
fileref_env_default='fp_env_python3'
fp_env_libs_default='virtualenv_python3'

# Get folder root path
if [ $# -eq 0 ]; then
    fp_folder_root=$fp_folder_root_default	
	fp_env_libs=$fp_env_libs_default
	fileref_env=$fileref_env_default
elif [ $# -eq 1 ]; then
	fp_folder_root=$1
	fp_env_libs=$fp_env_libs_default
	fileref_env=$fileref_env_default
elif [ $# -eq 2 ]; then
	fp_folder_root=$1
	fp_env_libs=$2
	fileref_env=$fileref_env_default
elif [ $# -eq 3 ]; then
	fp_folder_root=$1
	fp_env_libs=$2
	fileref_env=$3
fi

# Create root folder
if [ ! -d "$fp_folder_root" ]; then
	mkdir -p $fp_folder_root
fi

# Define folder path(s)
fp_folder_libs=$fp_folder_root

# Define environment filename
fp_file_env=$fp_folder_libs/$fileref_env

# multilines comment: if [ 1 -eq 0 ]; then ... fi
#-----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Info script start
echo " ==================================================================================="
echo " ==> "$script_name" (Version: "$script_version" Release_Date: "$script_date")"
echo " ==> START ..."
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Download library source codes
echo " ====> GET LIBRARY FILES ... "
wget $fileref_miniconda -O miniconda.sh
echo " ====> GET LIBRARY FILES ... DONE!"
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Install python environmente using miniconda
echo " ====> INSTALL PYTHON ENVIRONMENT ... "

if [ -d "$fp_folder_libs" ]; then 
	rm -Rf $fp_folder_libs; 
fi

bash miniconda.sh -b -p $fp_folder_libs
export PATH="$fp_folder_libs/bin:$PATH"
echo " ====> INSTALL PYTHON ENVIRONMENT ... DONE!"
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Install python libraries
echo " ====> INSTALL PYTHON LIBRARIES ... "
conda create -y -n $fp_env_libs -c conda-forge numpy scipy pandas matplotlib rasterio geopandas netCDF4 pyflakes statsmodels cython h5py jupyter pybufr-ecmwf pykdtree pygrib pyresample cartopy basemap basemap-data-hires proj4 progressbar2 xarray pygeobase dask pip rise nbconvert python=3
source activate $fp_env_libs
pip install pygeogrids
pip install h5netcdf
pip install ascat
pip install pytesmo
pip install repurpose
pip install jupyter
pip install pynetcf
pip install JPype1-py3
# conda install -y -c conda-forge rise
# conda install -y -c conda-forge nbconvert
echo " ====> INSTALL PYTHON LIBRARIES ... DONE!"
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Create environmental file
echo " ====> CREATE ENVIRONMENTAL FILE ... "

# Delete old version of environmetal file
cd $fp_folder_libs

if [ -f $fp_file_env ] ; then
    rm $fp_file_env
fi

# Export BINARY PATH(S)
echo "PATH=$fp_folder_libs/bin:"'$PATH'"" >> $fp_file_env
echo "export PATH" >> $fp_file_env

# Export VENV ACTIVATION
echo "source activate $fp_env_libs" >> $fp_file_env

echo " ====> CREATE ENVIRONMENTAL FILE ... DONE!"
# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------
# Info script end
echo " ==> "$script_name" (Version: "$script_version" Release_Date: "$script_date")"
echo " ==> ... END"
echo " ==> Bye, Bye"
echo " ==================================================================================="
# ----------------------------------------------------------------------------------------

