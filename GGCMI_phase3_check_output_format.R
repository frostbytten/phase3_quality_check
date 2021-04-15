require(ncdf4)

save2file <- TRUE
ignore <- list("years"=FALSE)

# Paths
path_Data  <- normalizePath("../data/")
#path_AgMIP.output <- "/p/projects/macmit/data/GGCMI/AgMIP.output/"
#path_AgMIP.output <- "/Volumes/Reacher/GGCMI/runs_ggcmi_3b/tests/test_shortspinup/output-2020-06-15-202043-pp"
path_Output <- file.path(path_Data, "out")
landseamask_file <- file.path(path_Data, "landseamask", "landseamask.nc")
cropcalendar_dir <- file.path(path_Data, "crop_calendar")
report_dir <- "" # Set to "" to use directory above working directory (top-level directory of outputs)
report_dir_web <- "" # Set to "" to ignore
ggcmi_function_file <- "./GGCMI_phase3_check_functions.r"
skip_directory_structure <- TRUE

# settings and definitions ####
# model.name <- "ISAM"
# crops <- c("mai","ri1","ri2","soy","swh","mil","sor","wwh")
# irrigs <- c("firr","noirr")
# rcsps <- c("picontrol","historical","ssp126","ssp585","ssp370")
# socs <- c("histsoc","2015soc")
# sens <- c("default","2015co2","1850co2")
# gcms <- c("GFDL-ESM4","IPSL-CM6A-LR","MPI-ESM1-2-HR","MRI-ESM2-0","UKESM1-0-LL")
vars <- c("yield","biom","cnyield","plantday","plantyear","harvyear","anthday","matyday","pirnreq","aet",
          "transp","runoff","tnrup","n2oemis","nleach","tcemis")
model.name <- "dssat"
crops <- c("mai")
irrigs <- c("noirr")
rcsps <- c("historical")
socs <- c("histsoc")
sens <- c("default")
gcms <- c("GFDL-ESM4")
# vars <- c("yield")

#######################
# Set up
#######################
source(ggcmi_function_file)
thisdate <- date()

# Get and change working directory,
# ensuring that the last character of path_AgMIP.output is a slash
# if (substr(path_AgMIP.output, nchar(path_AgMIP.output), nchar(path_AgMIP.output)) != "/") {
#   path_AgMIP.output <- paste0(path_AgMIP.output, "/")
# }
# working_dir <- paste0(path_AgMIP.output,model.name,"/phase3b")
                                        #
print(path_Output)
working_dir <- path_Output
if (!dir.exists(working_dir)) {
  stop(paste("working_dir does not exist:", working_dir))
}

setwd(working_dir)

# Import landseamask
landseamask <- readmask.nc(landseamask_file)

# Set up reports
reportnames <- setup_reports(report_dir, report_dir_web, save2file, thisdate, model.name)


#######################
# Test filenames
#######################
files <- dir(recursive=TRUE, include.dirs=FALSE)
do_test.filenames(files, reportnames, save2file, thisdate, model.name, ignore, skip_directory_structure)


##############################################
# Test that all expected files exist
##############################################
do_test.file_set(crops, irrigs, rcsps, socs, sens, gcms, vars, reportnames, save2file, ignore)


##############################################
# Test file contents (only netCDFs)
##############################################
files <- dir(pattern = "*.nc|*.nc4", recursive=TRUE, include.dirs=FALSE)
do_test.files(files, reportnames, landseamask, save2file, thisdate)

