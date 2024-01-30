@REM @ECHO OFF
call conda activate simOmPP

@REM This example is really noisy and the VD seems VI and viceversa

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               12 ^
--roisName                  anterior_view_specific_12 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 20 ^
--blockUp                   80 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                300 ^
--endFrame                  3450 ^
--oneCycleSamples           498 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 4


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               14 ^
--roisName                  anterior_view_specific_12 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 10 ^
--blockUp                   70 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                950 ^
--endFrame                  1875 ^
--oneCycleSamples           254 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               15 ^
--roisName                  anterior_view_specific_12 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 80 ^
--blockUp                   140 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                450 ^
--endFrame                  3575 ^
--oneCycleSamples           492 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               17 ^
--roisName                  anterior_view_specific_12 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 18 ^
--blockUp                   70 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1250 ^
--endFrame                  9400 ^
--oneCycleSamples           491 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               18 ^
--roisName                  anterior_view_specific_12 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   43 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1850 ^
--endFrame                  3050 ^
--oneCycleSamples           246 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 4


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               35 ^
--roisName                  posterior_view_specific_38 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 18 ^
--blockUp                   0 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                100 ^
--endFrame                  5750 ^
--oneCycleSamples           496 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               37 ^
--roisName                  posterior_view_specific_38 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1300 ^
--endFrame                  6675 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               38 ^
--roisName                  posterior_view_specific_38 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 9 ^
--blockUp                   0 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                250 ^
--endFrame                  6800 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200929_Brave_pig4 ^
--videoNumber               39 ^
--roisName                  posterior_view_specific_38 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 9 ^
--blockUp                   0 ^
--pixRes                    0.1057 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1500 ^
--endFrame                  6650 ^
--oneCycleSamples           492 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4