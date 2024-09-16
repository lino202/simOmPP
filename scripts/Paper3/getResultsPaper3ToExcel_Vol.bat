@REM @ECHO OFF
call conda activate simOmPP

@REM SAMPLE 1 -----------------------------------------------------------------
python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/sample1/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/cs_myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/sample1/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/cs_myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx



@REM SAMPLE 2------------------------------------------------
python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/cs_myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/sample2/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/cs_myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx

@REM SAMPLE 3------------------------------------------------
python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/sample3/results_fib_standard_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/cs_myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx

python D:/Code/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/sample3/results_fib_fromdwi_cs_intra_gaur_rv_septum_lv_down_CL1000_meijbord/cs_myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx

