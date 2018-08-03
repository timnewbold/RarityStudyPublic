import platform
import socket

# Define the locations of programs
if 'ucbttne-PC' == socket.gethostname():
    # Tim's UCL PC
    arcpy = 'c:/python27/ArcGIS10.3/python.exe'
    python = 'c:/Python35/python.exe'
    R = 'c:/Program Files/R/R-3.3.2/bin/x64/Rscript.exe'
elif 'ucbttne-LT' == socket.gethostname():
    # Tim's UCL laptop
    arcpy = 'c:/python27/ArcGIS10.3/python.exe'
    python = 'c:/Python35/python.exe'
    R = 'c:/Program Files/R/R-3.3.2/bin/x64/Rscript.exe'
elif 'ucbttne-PC2' == socket.gethostname():
    # Tim's new UCL PC
    arcpy = 'c:/python27/ArcGIS10.3/python.exe'
    python = 'c:/Python36/python.exe'
    R = 'c:/Program Files/R/R-3.3.2/bin/x64/Rscript.exe'
elif 'ucbttne-LT2'==socket.gethostname():
    arcpy = 'C:/Python27/ArcGIS10.4/python.exe'
    python = 'C:/Python36/python.exe'
    R = 'C:/Program Files/R/R-3.3.2/bin/x64/Rscript.exe'

STAGES = [ ('1', R,         '1_PrepareDiversityData.R'),
           ('2', R,         '2_DivideDiversityDataByRarity.R'),
           ('3', R,         '3_PrepareSiteData.R'),
           ('4', R,         '4_RunRichnessModels.R'),
           ('5', R,         '5_RunAbundanceModels.R'),
           ('6', R,         '6_PlotModels.R'),
         ]
