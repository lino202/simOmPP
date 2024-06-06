@REM @ECHO OFF
call conda activate simOmPP

@REM SAMPLE 2 -----------------------------------------------------------------
python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_endo_tentusscher/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_endo_tentusscher/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_endo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_fromdwi_cs_endo_tentusscher/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_fromdwi_cs_endo_tentusscher/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_endo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_tentusscher/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_tentusscher/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_subendo_intramyo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_endo_ohara/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_endo_ohara/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_endo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_endo_gaur/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_endo_gaur/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_endo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_subendo_intramyo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur_transminus15/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur_transminus15/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_subendo_intramyo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur_transplus15/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/sample2/results_fib_standard_cs_intra_gaur_transplus15/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample2/stim/cs/cs_subendo_intramyo.inp ^
--timeStart   2000 ^
--timeEnd     2600 ^
--soluName    cs_solution ^
--nDigits     5 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       500 ^
--resExcel    D:/Paper3/Simulations/invivo/he/results_vol_cs.xlsx
