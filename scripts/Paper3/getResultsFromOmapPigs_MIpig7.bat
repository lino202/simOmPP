@REM @ECHO OFF
call conda activate simOmPP



@REM This example is really strange,
@REM OMs were mostly unfeasible and a fatal fibrillation stopped the experiment
@REM Also there's no signed of infarction in the apex!! Use just if needed 
@REM For now I am not going to included!!
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted7 ^
--videoNumber               8 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.09215 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                175 ^
--endFrame                  7200 ^
--oneCycleSamples           392 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  RS ^
--faceView                  AV ^
--pigNumber                 not_assigned_yet



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted7 ^
--videoNumber               13 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.09215 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                300 ^
--endFrame                  7100 ^
--oneCycleSamples           345 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 not_assigned_yet



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted7 ^
--videoNumber               15 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.09215 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                400 ^
--endFrame                  7050 ^
--oneCycleSamples           246 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 not_assigned_yet



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted7 ^
--videoNumber               16 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.09215 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                600 ^
--endFrame                  7200 ^
--oneCycleSamples           246 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 not_assigned_yet




python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted7 ^
--videoNumber               19 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.09215 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                50 ^
--endFrame                  7100 ^
--oneCycleSamples           398 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  AD ^
--faceView                  AV ^
--pigNumber                 not_assigned_yet


