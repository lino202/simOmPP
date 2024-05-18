@REM @ECHO OFF
call conda activate simOmPP

@REM This example is really noisy and we selected mainly the AV and left ventricle rois

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               15 ^
--roisName                  anterior_view_specific_15 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   46 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1250 ^
--endFrame                  6350 ^
--oneCycleSamples           481 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  RS ^
--faceView                  AV ^
--pigNumber                 6



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               16 ^
--roisName                  anterior_view_specific_15 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 8 ^
--blockUp                   0 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                350 ^
--endFrame                  7550 ^
--oneCycleSamples           460 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  RS ^
--faceView                  AV ^
--pigNumber                 6



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               17 ^
--roisName                  posterior_view_specific_17 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                200 ^
--endFrame                  7700 ^
--oneCycleSamples           454 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  RS ^
--faceView                  PV ^
--pigNumber                 6



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               18 ^
--roisName                  posterior_view_specific_17 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                2900 ^
--endFrame                  6800 ^
--oneCycleSamples           451 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  RS ^
--faceView                  PV ^
--pigNumber                 6



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               24 ^
--roisName                  anterior_view_specific_24 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                7775 ^
--endFrame                  10200 ^
--oneCycleSamples           438 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  AD ^
--faceView                  AV ^
--pigNumber                 6


@REM It is 1000 ms stim but it goes at 700 ms
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               36 ^
--roisName                  posterior_view_specific_36 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 10 ^
--blockUp                   0 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                2700 ^
--endFrame                  7550 ^
--oneCycleSamples           386 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  AD ^
--faceView                  PV ^
--pigNumber                 6



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               53 ^
--roisName                  posterior_view_specific_53 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                150 ^
--endFrame                  4150 ^
--oneCycleSamples           348 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  AD ^
--faceView                  PV ^
--pigNumber                 6




python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               54 ^
--roisName                  posterior_view_specific_53 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 26 ^
--blockUp                   80 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                300 ^
--endFrame                  1475 ^
--oneCycleSamples           331 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 6


@REM @REM So noisy
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
@REM --videoNumber               45 ^
@REM --roisName                  anterior_view_specific_45 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.1015 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                2150 ^
@REM --endFrame                  4750 ^
@REM --oneCycleSamples           346 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  AD ^
@REM --faceView                  AV ^
@REM --pigNumber                 6


@REM @REM So noisy
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
@REM --videoNumber               46 ^
@REM --roisName                  anterior_view_specific_45 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.1015 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                2250 ^
@REM --endFrame                  4200 ^
@REM --oneCycleSamples           390 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  VD ^
@REM --faceView                  AV ^
@REM --pigNumber                 6


@REM @REM So noisy
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
@REM --videoNumber               47 ^
@REM --roisName                  anterior_view_specific_45 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.1015 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                1000 ^
@REM --endFrame                  2550 ^
@REM --oneCycleSamples           334 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  VI ^
@REM --faceView                  AV ^
@REM --pigNumber                 6


@REM @REM So noisy
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
@REM --videoNumber               49 ^
@REM --roisName                  anterior_view_specific_45 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.1015 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                600 ^
@REM --endFrame                  3600 ^
@REM --oneCycleSamples           344 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  AD ^
@REM --faceView                  AV ^
@REM --pigNumber                 6


@REM @REM So noisy
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
@REM --videoNumber               50 ^
@REM --roisName                  anterior_view_specific_45 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.1015 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                1350 ^
@REM --endFrame                  4650 ^
@REM --oneCycleSamples           349 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  VD ^
@REM --faceView                  AV ^
@REM --pigNumber                 6

@REM @REM So noisy
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
@REM --videoNumber               51 ^
@REM --roisName                  anterior_view_specific_45 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.1015 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                2200 ^
@REM --endFrame                  3100 ^
@REM --oneCycleSamples           359 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  VI ^
@REM --faceView                  AV ^
@REM --pigNumber                 6



