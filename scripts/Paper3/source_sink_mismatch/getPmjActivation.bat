@REM @ECHO OFF
call conda activate simOmPP

@REM  ENDO ------------

python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio01/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio01/myresults.vtk ^
--pmjRatio          0.1 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx


python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio05/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio05/myresults.vtk ^
--pmjRatio          0.5 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx

python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio10/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio10/myresults.vtk ^
--pmjRatio          1.0 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx

python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio15/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio15/myresults.vtk ^
--pmjRatio          1.5 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx

python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio20/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_gaur_pmjratio20/myresults.vtk ^
--pmjRatio          2.0 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx


@REM INTRA ------------------------

python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio01/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio01/myresults.vtk ^
--pmjRatio          0.1 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx


python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio03/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio03/myresults.vtk ^
--pmjRatio          0.3 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx


python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio05/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio05/myresults.vtk ^
--pmjRatio          0.5 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx


python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio06/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio06/myresults.vtk ^
--pmjRatio          0.6 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx

python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio09/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio09/myresults.vtk ^
--pmjRatio          0.9 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx

python D:/Code/simOmPP/percentagePMJactivated.py ^
--csMeshPath        D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio12/cs_myresults.vtk ^
--tissueMeshPath    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_gaur_pmjratio12/myresults.vtk ^
--pmjRatio          1.2 ^
--activationDelay   1.5 ^
--resExcel          D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_pmj_activation_new.xlsx
