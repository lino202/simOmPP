@REM @ECHO OFF
call conda activate simOmPP

@REM This example is really noisy and the VD seems VI and viceversa

@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               8 ^
@REM --roisName                  anterior_view_specific_8 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 34 ^
@REM --blockUp                   56 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                2400 ^
@REM --endFrame                  4650 ^
@REM --oneCycleSamples           375 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  RS ^
@REM --faceView                  AV ^
@REM --pigNumber                 3



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
--videoNumber               13 ^
--roisName                  anterior_view_specific_8 ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 125 ^
--blockUp                   170 ^
--pixRes                    0.086 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1250 ^
--endFrame                  2950 ^
--oneCycleSamples           488 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 3



@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               15 ^
@REM --roisName                  anterior_view_specific_8 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 5 ^
@REM --blockUp                   50 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                950 ^
@REM --endFrame                  4750 ^
@REM --oneCycleSamples           439 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  1000 ^
@REM --stimType                  VI ^
@REM --faceView                  AV ^
@REM --pigNumber                 3




@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               20 ^
@REM --roisName                  posterior_view_specific_20 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 42 ^
@REM --blockUp                   75 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                2350 ^
@REM --endFrame                  4550 ^
@REM --oneCycleSamples           493 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  1000 ^
@REM --stimType                  VI ^
@REM --faceView                  PV ^
@REM --pigNumber                 3


@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               23 ^
@REM --roisName                  posterior_view_specific_23 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   70 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                100 ^
@REM --endFrame                  4800 ^
@REM --oneCycleSamples           346 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  VD ^
@REM --faceView                  PV ^
@REM --pigNumber                 3



@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               24 ^
@REM --roisName                  posterior_view_specific_20 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 7 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                150 ^
@REM --endFrame                  2100 ^
@REM --oneCycleSamples           354 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  VI ^
@REM --faceView                  PV ^
@REM --pigNumber                 3




@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               26 ^
@REM --roisName                  anterior_view_specific_26 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 13 ^
@REM --blockUp                   50 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                200 ^
@REM --endFrame                  4700 ^
@REM --oneCycleSamples           348 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  AD ^
@REM --faceView                  AV ^
@REM --pigNumber                 3



@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               27 ^
@REM --roisName                  anterior_view_specific_26 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 15 ^
@REM --blockUp                   67 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                50 ^
@REM --endFrame                  2050 ^
@REM --oneCycleSamples           350 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  700 ^
@REM --stimType                  VD ^
@REM --faceView                  AV ^
@REM --pigNumber                 3



@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               31 ^
@REM --roisName                  anterior_view_specific_26 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 3 ^
@REM --blockUp                   38 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                50 ^
@REM --endFrame                  3250 ^
@REM --oneCycleSamples           251 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  AD ^
@REM --faceView                  AV ^
@REM --pigNumber                 3



@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               32 ^
@REM --roisName                  anterior_view_specific_26 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 20 ^
@REM --blockUp                   67 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                2800 ^
@REM --endFrame                  5850 ^
@REM --oneCycleSamples           543 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  1000 ^
@REM --stimType                  RS ^
@REM --faceView                  AV ^
@REM --pigNumber                 3



@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               33 ^
@REM --roisName                  anterior_view_specific_26 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 7 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                3400 ^
@REM --endFrame                  5825 ^
@REM --oneCycleSamples           249 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  VD ^
@REM --faceView                  AV ^
@REM --pigNumber                 3



@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               37 ^
@REM --roisName                  posterior_view_specific_37 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   0 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                250 ^
@REM --endFrame                  5300 ^
@REM --oneCycleSamples           526 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  1000 ^
@REM --stimType                  RS ^
@REM --faceView                  PV ^
@REM --pigNumber                 3




@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               38 ^
@REM --roisName                  posterior_view_specific_37 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   73 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                3050 ^
@REM --endFrame                  5050 ^
@REM --oneCycleSamples           248 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  VD ^
@REM --faceView                  PV ^
@REM --pigNumber                 3




@REM python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
@REM --folderPath                D:/Data/OM_PigHeart/Control/20200922_Brave_pig3 ^
@REM --videoNumber               39 ^
@REM --roisName                  posterior_view_specific_37 ^
@REM --shouldNotHaveAllPoints    ^
@REM --cleanProcess              2 ^
@REM --blockDown                 0 ^
@REM --blockUp                   50 ^
@REM --pixRes                    0.086 ^
@REM --maxDist                   3 ^
@REM --maxCV                     300 ^
@REM --cvCalcMethod              vanilla ^
@REM --scaleVectors              1. ^
@REM --startFrame                200 ^
@REM --endFrame                  5850 ^
@REM --oneCycleSamples           246 ^
@REM --apdtype                   90 ^
@REM --fps                       500 ^
@REM --reverse                   ^
@REM --stimFreq                  500 ^
@REM --stimType                  VI ^
@REM --faceView                  PV ^
@REM --pigNumber                 3