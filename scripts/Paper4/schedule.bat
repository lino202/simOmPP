
schtasks /create /sc once /tn "MyTask" /tr "C:\Users\usuario\miniconda3\Scripts\conda run -n simOmPP cmd /k \"D:\Code\simOmPP\scripts\Paper4\makeVideosWithParaview_S2_295.bat\"" /st 23:35