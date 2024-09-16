@REM @REM @ECHO OFF
@REM call conda activate simOmPP


python D:/Code/simOmPP/getOMVideos.py ^
--videoPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR1/3/FileTag003_video_filtered.mat ^
--roiPath                  D:/Data/OM_BioVAD/Perth_24062024/total/AR1/roi_3/mask.pkl ^
--outPath                  D:/Data/OM_BioVAD/Perth_24062024/overall_results/videos/video_AR1_basal.mp4


python D:/Code/simOmPP/getOMVideos.py ^
--videoPath                D:/Data/OM_BioVAD/Perth_24062024/total/AR2/15/FileTag015_video_filtered.mat ^
--roiPath                  D:/Data/OM_BioVAD/Perth_24062024/total/AR2/roi_15/mask.pkl ^
--outPath                  D:/Data/OM_BioVAD/Perth_24062024/overall_results/videos/video_AR2_basal.mp4


python D:/Code/simOmPP/getOMVideos.py ^
--videoPath                D:/Data/OM_BioVAD/Perth_24062024/total/DF/40/FileTag040_video_filtered.mat ^
--roiPath                  D:/Data/OM_BioVAD/Perth_24062024/total/DF/roi_40/mask.pkl ^
--outPath                  D:/Data/OM_BioVAD/Perth_24062024/overall_results/videos/video_DF_basal.mp4



python D:/Code/simOmPP/getOMVideos.py ^
--videoPath                D:/Data/OM_BioVAD/Perth_24062024/total/DP2/96/FileTag096_video_filtered.mat ^
--roiPath                  D:/Data/OM_BioVAD/Perth_24062024/total/DP2/roi_96/mask.pkl ^
--outPath                  D:/Data/OM_BioVAD/Perth_24062024/overall_results/videos/video_DP2_basal.mp4



python D:/Code/simOmPP/getOMVideos.py ^
--videoPath                D:/Data/OM_BioVAD/Perth_24062024/total/S1/50/FileTag050_video_filtered.mat ^
--roiPath                  D:/Data/OM_BioVAD/Perth_24062024/total/S1/roi_50/mask.pkl ^
--outPath                  D:/Data/OM_BioVAD/Perth_24062024/overall_results/videos/video_S1_basal.mp4


python D:/Code/simOmPP/getOMVideos.py ^
--videoPath                D:/Data/OM_BioVAD/Perth_24062024/total/S2/75/FileTag075_video_filtered.mat ^
--roiPath                  D:/Data/OM_BioVAD/Perth_24062024/total/S2/roi_75/mask.pkl ^
--outPath                  D:/Data/OM_BioVAD/Perth_24062024/overall_results/videos/video_S2_basal.mp4