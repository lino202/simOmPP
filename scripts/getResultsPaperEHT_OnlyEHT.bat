@REM @ECHO OFF
call conda activate simOmPP

python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Quad3d/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Quad3d/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Quad3d/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Rect3d/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Rect3d/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Rect3d/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_120/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_120/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_120/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_100/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_100/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_100/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_80/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_80/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_80/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_60/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_60/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Hex3d_60/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx



python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Aux3d_Ver/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Aux3d_Ver/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Aux3d_Ver/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx


python D:/Simulations/simOmPP/getResults.py ^
--resPath    D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Aux3d_Hor/results ^
--myResPath  D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Aux3d_Hor/myResults/4paperEHTCV.vtk ^
--meshPath   D:/Simulations/electra_sims/Biovad/Paper/0.6mm2/Aux3d_Hor/mesh.inp ^
--timeStart  4000 ^
--timeEnd    5000 ^
--nDigits    4 ^
--maxMem     4 ^
--dt         1 ^
--soluName   solution ^
--stimLabel  set1 ^
--spaceUnit  mm ^
--maxDist    0.21 ^
--maxCV      300 ^
--resExcel   D:/Simulations/electra_sims/Biovad/Paper/resultsOnlyEHT.xlsx