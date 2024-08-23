@REM @ECHO OFF
call conda activate simOmPP

@REM ENDO -----------------------------------------------------------------
python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio01/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio01/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_endo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio05/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio05/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_endo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio10/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio10/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_endo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio15/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio15/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_endo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio20/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_endo_tentusscher_pmjratio20/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_endo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx



@REM INTRA --------------------------------------------------------------------------------------------------------------

python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio01/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio01/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_subendo_intramyo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio03/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio03/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_subendo_intramyo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio05/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio05/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_subendo_intramyo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio06/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio06/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_subendo_intramyo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio09/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio09/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_subendo_intramyo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx


python D:/Code/simOmPP/getResults.py ^
--resPath     D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio12/cs ^
--myResPath   D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_fib_standard_cs_intra_tentusscher_pmjratio12/cs_myresults.vtk ^
--meshPath    D:/Paper3/Models/invivo/he/sample1/stim/cs/base/cs_subendo_intramyo.inp ^
--timeStart   0 ^
--timeEnd     250 ^
--soluName    cs_solution ^
--nDigits     4 ^
--apd         90 ^
--dt          0.25 ^
--spaceUnit   mm ^
--maxMem      40 ^
--nCores      1 ^
--maxDist     0.48 ^
--maxCV       600 ^
--resExcel    D:/Paper3/Simulations/invivo/he/source_sink_mismatch/results_vol_cs.xlsx

