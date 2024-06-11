@REM @ECHO OFF
call conda activate simOmPP


@REM SOURCE_SINK_MISMATCH--------------------------------------------------

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio01/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio05/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio10/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio15/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx


python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio20/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx





python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio01/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio03/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio06/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio09/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx

python D:/Simulations/simOmPP/getResultsToExcel.py ^
--meshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio12/myresults.vtk ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_source_sink_mismatch.xlsx



