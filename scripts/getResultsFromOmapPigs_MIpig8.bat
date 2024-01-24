@REM @ECHO OFF
call conda activate simOmPP

@REM This example is really strange also, MI in the apex cannot be seen
@REM Also the protocol seen wrongly annotated as VI seemed VDs and viceversa
@REM Moreover the isochrone that Ana has sent me seem the opposite. 
@REM La fibrilacion tambien es en el sentido opuesto a las demas
@REM Si vemos el video 6, vemos que tenemos un RS muy raro va desde el izquierdo superior al apex

@REM This seems VD, maybe blocked left CS in some regions?
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               8 ^
--infarction                ^
--roisName                  anterior_view_specific_8 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                200 ^
--endFrame                  6850 ^
--oneCycleSamples           494 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 5



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               9 ^
--infarction                ^
--roisName                  anterior_view_specific_9 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                100 ^
--endFrame                  7200 ^
--oneCycleSamples           494 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 5



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               10 ^
--infarction                ^
--roisName                  anterior_view_specific_9 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                125 ^
--endFrame                  4450 ^
--oneCycleSamples           345 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 5



@REM This seems VD, maybe blocked left CS in some regions?
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               11 ^
--infarction                ^
--roisName                  anterior_view_specific_11 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                200 ^
--endFrame                  7000 ^
--oneCycleSamples           345 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 5



@REM This seems VD, maybe blocked left CS in some regions?
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               12 ^
--infarction                ^
--roisName                  anterior_view_specific_11 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                300 ^
--endFrame                  7150 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 5


@REM This seems VI, maybe blocked CS in some regions?
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               13 ^
--infarction                ^
--roisName                  anterior_view_specific_11 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                5075 ^
--endFrame                  7250 ^
--oneCycleSamples           249 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 5


@REM @REM This seems VI, maybe blocked CS in some regions?
@REM @REM AD/Vs is supposed to be wrong so I do not use it, but it is ready
@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
@REM --videoNumber               14 ^
@REM --infarction                ^
@REM --roisName                  anterior_view_specific_11 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.090689 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                500 ^
@REM --endFrame                  6900 ^
@REM --oneCycleSamples           493 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  1000 ^
@REM --stimType                  AD ^
@REM --faceView                  AV ^
@REM --pigNumber                 5



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               21 ^
--infarction                ^
--roisName                  posterior_view_specific_21 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                400 ^
--endFrame                  7050 ^
--oneCycleSamples           493 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 5


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               22 ^
--infarction                ^
--roisName                  posterior_view_specific_21 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                200 ^
--endFrame                  6800 ^
--oneCycleSamples           494 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 5



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               23 ^
--infarction                ^
--roisName                  posterior_view_specific_21 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                200 ^
--endFrame                  7000 ^
--oneCycleSamples           345 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 5



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               24 ^
--infarction                ^
--roisName                  posterior_view_specific_21 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                100 ^
--endFrame                  7200 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 5


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               25 ^
--infarction                ^
--roisName                  posterior_view_specific_21 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                75 ^
--endFrame                  7200 ^
--oneCycleSamples           346 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 5



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220224_PigInfarcted8 ^
--videoNumber               26 ^
--infarction                ^
--roisName                  posterior_view_specific_21 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.090689 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                300 ^
--endFrame                  7150 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 5