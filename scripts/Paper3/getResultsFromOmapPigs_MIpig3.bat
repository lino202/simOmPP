@REM @ECHO OFF
call conda activate simOmPP

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               13 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                600 ^
--endFrame                  6475 ^
--oneCycleSamples           500 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  RS ^
--faceView                  AV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               15 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                5350 ^
--endFrame                  7775 ^
--oneCycleSamples           369 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 2

REM Here the Stim was 700 ms in AD but the ventricles were depolarizing at 1000ms period
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               17 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                600 ^
--endFrame                  7450 ^
--oneCycleSamples           500 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  AD ^
--faceView                  AV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               21 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                450 ^
--endFrame                  7700 ^
--oneCycleSamples           370 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               22 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                650 ^
--endFrame                  7850 ^
--oneCycleSamples           370 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  AD ^
--faceView                  PV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               23 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                450 ^
--endFrame                  7775 ^
--oneCycleSamples           370 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               27 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                3150 ^
--endFrame                  7850 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 2



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               29 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                400 ^
--endFrame                  7725 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  AD ^
--faceView                  PV ^
--pigNumber                 2



REM Here the Stim was in RS and ventricles go to 500ms period and the AD was previously stim at that pace
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               30 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                3350 ^
--endFrame                  7850 ^
--oneCycleSamples           251 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  RS ^
--faceView                  PV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               31 ^
--infarction                ^
--roisName                  anterior_view_masks_specific_31 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                3100 ^
--endFrame                  6100 ^
--oneCycleSamples           470 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  RS ^
--faceView                  AV ^
--pigNumber                 2



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               33 ^
--infarction                ^
--roisName                  anterior_view_masks_specific_31 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                600 ^
--endFrame                  7925 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 2



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               34 ^
--infarction                ^
--roisName                  anterior_view_masks_specific_31 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                550 ^
--endFrame                  7925 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  AD ^
--faceView                  AV ^
--pigNumber                 2



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               35 ^
--infarction                ^
--roisName                  anterior_view_masks_specific_31 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                500 ^
--endFrame                  7550 ^
--oneCycleSamples           264 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 2



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               36 ^
--infarction                ^
--roisName                  anterior_view_masks_specific_31 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                800 ^
--endFrame                  7350 ^
--oneCycleSamples           529 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               37 ^
--infarction                ^
--roisName                  anterior_view_masks_specific_31 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                500 ^
--endFrame                  6050 ^
--oneCycleSamples           530 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  AD ^
--faceView                  AV ^
--pigNumber                 2



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               40 ^
--infarction                ^
--roisName                  posterior_view_masks_specific_40 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                450 ^
--endFrame                  7550 ^
--oneCycleSamples           528 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 2



@REM The 43 and 44 samples are VD according to comments
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               43 ^
--infarction                ^
--roisName                  posterior_view_masks_specific_40 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                3800 ^
--endFrame                  7750 ^
--oneCycleSamples           529 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 2


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20211112_PigInfarcted3 ^
--videoNumber               44 ^
--infarction                ^
--roisName                  posterior_view_masks_specific_40 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.0729 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                500 ^
--endFrame                  7600 ^
--oneCycleSamples           528 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 2




