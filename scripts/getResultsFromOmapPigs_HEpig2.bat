@REM @ECHO OFF
call conda activate simOmPP

@REM This example is really noisy and we selected mainly the AV and left ventricle rois

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
--videoNumber               21 ^
--roisName                  anterior_view_specific_21 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 17 ^
--blockUp                   0 ^
--pixRes                    0.09 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                200 ^
--endFrame                  3700 ^
--oneCycleSamples           332 ^
--apdtype                   90 ^
--fps                       333.33 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  AD ^
--faceView                  AV ^
--pigNumber                 1


@REM Here we used LVRV roi
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
--videoNumber               24 ^
--roisName                  anterior_view_specific_24 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 14 ^
--blockUp                   0 ^
--pixRes                    0.09 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                33 ^
--endFrame                  3866 ^
--oneCycleSamples           331 ^
--apdtype                   90 ^
--fps                       333.33 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 1



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
--videoNumber               28 ^
--roisName                  anterior_view_specific_24 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 5 ^
--blockUp                   58 ^
--pixRes                    0.09 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                533 ^
--endFrame                  2133 ^
--oneCycleSamples           234 ^
--apdtype                   90 ^
--fps                       333.33 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 1



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
--videoNumber               31 ^
--roisName                  posterior_view_specific_31 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 5 ^
--blockUp                   100 ^
--pixRes                    0.09 ^
--maxDist                   6 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                33 ^
--endFrame                  2733 ^
--oneCycleSamples           235 ^
--apdtype                   90 ^
--fps                       333.33 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 1

@REM @REM NOT USE
@REM @REM @REM Really check this results as they were noisy
@REM @REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM @REM --folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
@REM @REM --videoNumber               34 ^
@REM @REM --roisName                  posterior_view_specific_31 ^
@REM @REM --shouldNotHaveAllPoints    ^
@REM @REM --cleanProcess              2 ^
@REM @REM --blockDown                 0 ^
@REM @REM --blockUp                   0 ^
@REM @REM --pixRes                    0.09 ^
@REM @REM --maxDist                   3 ^
@REM @REM --maxCV                     300 ^
@REM @REM --cvCalcMethod              vanilla ^
@REM @REM --scaleVectors              1. ^
@REM @REM --startFrame                233 ^
@REM @REM --endFrame                  1366 ^
@REM @REM --oneCycleSamples           159 ^
@REM @REM --apdtype                   90 ^
@REM @REM --fps                       333.33 ^
@REM @REM --reverse                   ^
@REM @REM --stimFreq                  500 ^
@REM @REM --stimType                  AD ^
@REM @REM --faceView                  PV ^
@REM @REM --pigNumber                 1


@REM Really check this results as they were noisy
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
--videoNumber               39 ^
--roisName                  anterior_view_specific_24 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 10 ^
--blockUp                   45 ^
--pixRes                    0.09 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                833 ^
--endFrame                  2150 ^
--oneCycleSamples           169 ^
--apdtype                   90 ^
--fps                       333.33 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 1

@REM this not work 
@REM @REM Really check this results as they were noisy
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
@REM --videoNumber               40 ^
@REM --roisName                  anterior_view_specific_24 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.09 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                1533 ^
@REM --endFrame                  3166 ^
@REM --oneCycleSamples           169 ^
@REM --apdtype                   90 ^
@REM --fps                       333.33 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  VI ^
@REM --faceView                  AV ^
@REM --pigNumber                 1



@REM this not work 
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200915_Brave_pig2 ^
@REM --videoNumber               42 ^
@REM --roisName                  anterior_view_specific_24 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.09 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                867 ^
@REM --endFrame                  2133 ^
@REM --oneCycleSamples           524 ^
@REM --apdtype                   90 ^
@REM --fps                       333.33 ^
@REM --reverse                   ^
@REM --stimFreq                  1500 ^
@REM --stimType                  RS ^
@REM --faceView                  AV ^
@REM --pigNumber                 1