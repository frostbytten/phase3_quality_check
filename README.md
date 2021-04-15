# GGCMI Phase 3 Validation Tool

## Prerequisites
The following packages (and subsequent libraries) are required to run this R script.

* ncdf4
  (requires netcdf C libraries installed on the system)

## Configuration
The following variables need to be specified in the `GGCMI_phase3_check_output_format.R` script:

* **ggcmi_function_file** the full path to the `GGCMI_phase3_check_functions.r` script
* **path_Data**  directory containing NetCDF files to test
* **path_Output** directory to place the output of this tool into (reporting)
* **landseamask_file** LandSea Mask NetCDF file
* **cropcalendar_dir** Directory containing the cropcalendar NetCDF files
* **skip_directory_structure** skip validating the directory structure of the data (`TRUE` or `FALSE`)
* **vars** vector of variables to validate (use GGCMI codes)
* **model.name** string to validate the model name
* **crops** vector of crops to validate (use GGCMI codes)
* **irrigs** vector of irrigations to validate (noirrig, irrig)
* **rcsps** vector of RCPs to validate (use GGCMI codes)
* **socs** vector of socio-economic scenarios to validate (use GGCMI codes)
* **sens** vector of CO2 scenarios to validate (use GGCMI codes)
* **gcms** vector of GCMs to validate (use GGCMI codes)

## Execution
This tool can be executed from the command-line:

```
Rscript GGCMI_phase3_check_output_format.R
```
