@REM @ECHO OFF
call conda activate simOmPP


python D:/Code/simOmPP/getResultsFromOmapResults_Review.py ^
--folderPath                G:/Data/OM_PigHeart/Control/20201006_Brave_pig6 ^
--videoNumber               15_revision ^
--roisName                  anterior_view_specific_15 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   46 ^
--pixRes                    0.1015 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1 ^
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



python D:/Code/simOmPP/getResultsFromOmapResults_Review.py ^
--folderPath                G:/Data/OM_PigHeart/MI/20211214_PigInfarcted5 ^
--videoNumber               11_revision ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.086 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                500 ^
--endFrame                  4000 ^
--oneCycleSamples           989 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  2000 ^
--stimType                  RS ^
--faceView                  AV ^
--pigNumber                 3


