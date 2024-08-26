@REM @ECHO OFF
call conda activate simOmPP

@REM S is stimulated and B is basal, L is longitudinal and T is transversal, C is central

@REM S2 ----------------------------------------------

python D:/Code/simOmPP/getResultsFromOmapResultsPerth.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/S2 ^
--videoNumber               75 ^
--getSubRegions             ^
--roisName                  roi_75 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                -1000000 ^
--endFrame                  -1000000 ^
--oneCycleSamples           -1000000 ^
--apdtype                   90 ^
--fps                       100 ^
--reverse                   ^
--stimFreq                  2013 ^
--stimType                  B ^
--faceView                  B ^
--pigNumber                 S2



python D:/Code/simOmPP/getResultsFromOmapResultsPerth.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/S2 ^
--videoNumber               76 ^
--getSubRegions             ^
--roisName                  roi_76 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                -1000000 ^
--endFrame                  -1000000 ^
--oneCycleSamples           -1000000 ^
--apdtype                   90 ^
--fps                       100 ^
--reverse                   ^
--stimFreq                  2000 ^
--stimType                  S ^
--faceView                  L ^
--pigNumber                 S2



python D:/Code/simOmPP/getResultsFromOmapResultsPerth.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/S2 ^
--videoNumber               77 ^
--getSubRegions             ^
--roisName                  roi_76 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                -1000000 ^
--endFrame                  -1000000 ^
--oneCycleSamples           -1000000 ^
--apdtype                   90 ^
--fps                       100 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  S ^
--faceView                  L ^
--pigNumber                 S2



python D:/Code/simOmPP/getResultsFromOmapResultsPerth.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/S2 ^
--videoNumber               79 ^
--getSubRegions             ^
--roisName                  roi_79 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                -1000000 ^
--endFrame                  -1000000 ^
--oneCycleSamples           -1000000 ^
--apdtype                   90 ^
--fps                       100 ^
--reverse                   ^
--stimFreq                  2000 ^
--stimType                  S ^
--faceView                  T ^
--pigNumber                 S2



python D:/Code/simOmPP/getResultsFromOmapResultsPerth.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/S2 ^
--videoNumber               80 ^
--getSubRegions             ^
--roisName                  roi_79 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                -1000000 ^
--endFrame                  -1000000 ^
--oneCycleSamples           -1000000 ^
--apdtype                   90 ^
--fps                       100 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  S ^
--faceView                  T ^
--pigNumber                 S2
