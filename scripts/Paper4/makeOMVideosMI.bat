@ECHO OFF
call conda activate simOmPP


@REM Power point like fps 30 otherwise the video is delay or freezes on power point


@REM SAMPLE 8 -----------------------------------------------------------------
@REM echo Sample8 ------------------------------------------

@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/37/FileTag037_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/37/roi.txt ^
@REM --threshold           0.96 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/37 ^
@REM --fps                 30

@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/39/FileTag039_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/39/roi.txt ^
@REM --threshold           0.93 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/39 ^
@REM --fps                 30

@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/40/FileTag040_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/40/roi.txt ^
@REM --threshold           0.85 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211111_PigInfarcted2/40 ^
@REM --fps                 30


@REM SAMPLE 9 -----------------------------------------------------------------
@REM echo Sample9 ------------------------------------------


@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/50/FileTag050_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/50/roi.txt ^
@REM --threshold           0.9 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/50 ^
@REM --fps                 30

@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/52/FileTag052_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/52/roi.txt ^
@REM --threshold           0.93 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/52 ^
@REM --fps                 30


@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/53/FileTag053_video_filtered.mat ^   This roi is lacking we should re do it, if we wanna see it
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/53/roi.txt ^
@REM --threshold           0.85 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211112_PigInfarcted3/53 ^
@REM --fps                 30




@REM SAMPLE 10-----------------------------------------------------------------
@REM echo Sample10 ------------------------------------------


@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211214_PigInfarcted5/44/FileTag044_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211214_PigInfarcted5/44/roi.txt ^
@REM --threshold           0.94 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211214_PigInfarcted5/44 ^
@REM --fps                 30

@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20211214_PigInfarcted5/47/FileTag047_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20211214_PigInfarcted5/47/roi.txt ^
@REM --threshold           0.9 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20211214_PigInfarcted5/47 ^
@REM --fps                 30




@REM @REM SAMPLE 11-----------------------------------------------------------------
@REM echo Sample11 ------------------------------------------


@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/38/FileTag038_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/38/roi.txt ^
@REM --threshold           0.5 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/38 ^
@REM --fps                 30

@REM python D:/Code/simOmPP/getOMVideos.py ^
@REM --videoPath           E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/39/FileTag039_video_filtered.mat ^
@REM --roiPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/39/roi.txt ^
@REM --threshold           0.5 ^
@REM --outPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/39 ^
@REM --fps                 30

@REM @REM python D:/Code/simOmPP/getOMVideos.py ^
@REM @REM --videoPath           E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/40/FileTag040_video_filtered.mat ^
@REM @REM --roiPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/40/roi.txt ^
@REM @REM --threshold           0.5 ^
@REM @REM --outPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/40 ^
@REM @REM --fps                 30

@REM @REM python D:/Code/simOmPP/getOMVideos.py ^
@REM @REM --videoPath           E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/41/FileTag041_video_filtered.mat ^
@REM @REM --roiPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/41/roi.txt ^
@REM @REM --threshold           0.5 ^
@REM @REM --outPath             E:/Data/OM_PigHeart/MI/20220223_PigInfarcted6/41 ^
@REM @REM --fps                 30


@REM SAMPLE 12-----------------------------------------------------------------
echo Sample12 ------------------------------------------


python D:/Code/simOmPP/getOMVideos.py ^
--videoPath           E:/Data/OM_PigHeart/MI/20220224_PigInfarcted8/39/FileTag039_video_filtered.mat ^
--roiPath             E:/Data/OM_PigHeart/MI/20220224_PigInfarcted8/39/roi.txt ^
--threshold           0.5 ^
--outPath             E:/Data/OM_PigHeart/MI/20220224_PigInfarcted8/39 ^
--fps                 30





