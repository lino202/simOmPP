@REM @ECHO OFF
call conda activate simOmPP

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               11 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                600 ^
--endFrame                  6750 ^
--oneCycleSamples           494 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 4

python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               13 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
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
--faceView                  AV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               17 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                1200 ^
--endFrame                  7250 ^
--oneCycleSamples           345 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 4



@REM See this first for block down some AT values, 
@REM we can use 48 in blockdown but it deletes so much from the LV 
@REM so we leave it on 0
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               18 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                75 ^
--endFrame                  4750 ^
--oneCycleSamples           346 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 4



@REM Check APD has wave are decended so might be difficult to find the 90%repo - FINE
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               19 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                400 ^
--endFrame                  7200 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 4




@REM Block Up the red zone CHeck! - FINE
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               24 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                352 ^
--endFrame                  6900 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 4


python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               24 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                352 ^
--endFrame                  6900 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  AV ^
--pigNumber                 4


@REM Check this also as the APD is really strange (M like signals)
@REM Also cut the extremes from AT - FINE
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               25 ^
--infarction                ^
--roisName                  anterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                400 ^
--endFrame                  7300 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  AV ^
--pigNumber                 4


@REM Posterior: the view seems to point to much to the RV, so pay attention the roi selected.
@REM CUT the posterior RV only the LV is seen from distance so it has a lot of noisy
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               26 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                200 ^
--endFrame                  6850 ^
--oneCycleSamples           493 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4



@REM Delete the extremes in AT
python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               27 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                50 ^
--endFrame                  7150 ^
--oneCycleSamples           493 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  1000 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               31 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                250 ^
--endFrame                  7050 ^
--oneCycleSamples           346 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               31 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                250 ^
--endFrame                  7050 ^
--oneCycleSamples           346 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               33 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                350 ^
--endFrame                  6800 ^
--oneCycleSamples           345 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  700 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               35 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                250 ^
--endFrame                  5875 ^
--oneCycleSamples           246 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VI ^
--faceView                  PV ^
--pigNumber                 4



python D:/Simulations/simOmPP/getResultsFromOmapResults.py ^
--folderPath                D:/Data/OM_PigHeart/MI/20220223_PigInfarcted6 ^
--videoNumber               36 ^
--infarction                ^
--roisName                  posterior_view_masks ^
--shouldNotHaveAllPoints    ^
--cleanProcess              2 ^
--blockDown                 0 ^
--blockUp                   0 ^
--pixRes                    0.08851 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--startFrame                50 ^
--endFrame                  2950 ^
--oneCycleSamples           247 ^
--apdtype                   90 ^
--fps                       500 ^
--reverse                   ^
--stimFreq                  500 ^
--stimType                  VD ^
--faceView                  PV ^
--pigNumber                 4