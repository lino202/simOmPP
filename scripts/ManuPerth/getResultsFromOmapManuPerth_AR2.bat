@REM @REM @ECHO OFF
@REM call conda activate simOmPP

@REM @REM S is stimulated and B is basal, L is longitudinal and T is transversal, C is central


@REM @REM @REM AR2 ----------------------------------------------

python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR2 ^
--videoName                 15 ^
--fileName                  FileTag015_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_15 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 0 ^
--endTime                   8920 ^
--before                    850 ^
--after                     850 ^
--nBeats                    5 ^
--cleanProcess              0 ^
--blockDown                 0 ^
--blockUp                   0 ^
--shouldNotHaveAllPoints    ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--apdtype                   90 ^
--stimCL                    1704 ^
--stimType                  Basal ^
--sampleType                Rect ^
--sampleName                AR2


python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR2 ^
--videoName                 16 ^
--fileName                  FileTag016_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_15 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 3300 ^
--endTime                   8900 ^
--before                    850 ^
--after                     850 ^
--nBeats                    3 ^
--cleanProcess              0 ^
--blockDown                 0 ^
--blockUp                   0 ^
--shouldNotHaveAllPoints    ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--apdtype                   90 ^
--stimCL                    2000 ^
--stimType                  Long ^
--sampleType                Rect ^
--sampleName                AR2


python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR2 ^
--videoName                 17 ^
--fileName                  FileTag017_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_15 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 4500 ^
--endTime                   9900 ^
--before                    550 ^
--after                     550 ^
--nBeats                    5 ^
--cleanProcess              0 ^
--blockDown                 0 ^
--blockUp                   0 ^
--shouldNotHaveAllPoints    ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--apdtype                   90 ^
--stimCL                    1000 ^
--stimType                  Long ^
--sampleType                Rect ^
--sampleName                AR2



python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR2 ^
--videoName                 19 ^
--fileName                  FileTag019_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_19 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 10100 ^
--endTime                   13800 ^
--before                    850 ^
--after                     850 ^
--nBeats                    2 ^
--cleanProcess              0 ^
--blockDown                 0 ^
--blockUp                   0 ^
--shouldNotHaveAllPoints    ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--apdtype                   90 ^
--stimCL                    2000 ^
--stimType                  Trans ^
--sampleType                Rect ^
--sampleName                AR2


python D:/Code/simOmPP/getResultsFromOmapFiltered.py ^
--folderPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR2 ^
--videoName                 20 ^
--fileName                  FileTag020_video_filtered ^
--matVarName                wholav_images ^
--getSubRegions             ^
--subregionNames            L M S ^
--roisName                  roi_19 ^
--exposure                  10 ^
--reverse                   ^
--startTime                 4800 ^
--endTime                   10100 ^
--before                    550 ^
--after                     550 ^
--nBeats                    5 ^
--cleanProcess              0 ^
--blockDown                 0 ^
--blockUp                   0 ^
--shouldNotHaveAllPoints    ^
--pixRes                    0.0136 ^
--maxDist                   3 ^
--maxCV                     300 ^
--cvCalcMethod              vanilla ^
--scaleVectors              1. ^
--apdtype                   90 ^
--stimCL                    1000 ^
--stimType                  Trans ^
--sampleType                Rect ^
--sampleName                AR2