@REM @ECHO OFF
call conda activate simOmPP

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               11 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                500 ^
--endFrame                  3250 ^
--oneCycleSamples           500 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               14 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1378 ^
--endFrame                  6044 ^
--oneCycleSamples           500 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 1



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               15 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1140 ^
--endFrame                  6729 ^
--oneCycleSamples           370 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               21 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                490 ^
--endFrame                  7886 ^
--oneCycleSamples           370 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               22 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                597 ^
--endFrame                  7204 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               24 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                2063 ^
--endFrame                  7617 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 1

REM Posterior Views

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               26 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                525 ^
--endFrame                  7911 ^
--oneCycleSamples           500 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               28 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                2704 ^
--endFrame                  7881 ^
--oneCycleSamples           500 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               29 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                667 ^
--endFrame                  7684 ^
--oneCycleSamples           370 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               31 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                693 ^
--endFrame                  7748 ^
--oneCycleSamples           370 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               32 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                612 ^
--endFrame                  7757 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 1


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211111_PigInfarcted2 ^
--videoNumber               34 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.081 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                535 ^
--endFrame                  7918 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 1
