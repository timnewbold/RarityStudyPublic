suppressMessages(suppressWarnings(library(yarg)))

dataDir <- "0_data"
densDir <- "0_ProcessTetraDENSITYData/"
outDir <- "1_PrepareDiversityData/"

cat('Loading database extracts\n')

diversity<-readRDS(paste(dataDir,"/database.rds",sep=""))

cat('Selecting appropriate data\n')

diversity <- droplevels(diversity[(diversity$Phylum=="Chordata"),])
diversity <- droplevels(diversity[(diversity$Class!=""),])
diversity <- droplevels(diversity[(diversity$Class %in% c("Mammalia","Aves","Amphibia")),])

cat('Correcting for sampling effort\n')
diversity <- CorrectSamplingEffort(diversity)

cat('Merging sites\n')
diversity <- MergeSites(diversity,public = TRUE,silent = TRUE)

cat('Getting species\' rarity information')

bl<-BirdlifeRangeArea(path = paste(dataDir,"/bird_range_areas.txt",sep=""))
ia<-IUCNRangeArea(path = paste(dataDir,"/amphibian_range_areas.csv",sep=""))
im<-IUCNRangeArea(path = paste(dataDir,"/mammal_range_areas.csv",sep=""))

diversity<-AddTraits(diversity,ia,im,bl)

habitat.amphib <- IUCNHabitat2(path = paste(
  dataDir,"/API_HabitatLevel2_Amphibian.csv",sep=""))
habitat.mamm <- IUCNHabitat2(path = paste(
  dataDir,"/API_HabitatLevel2_Mammals.csv",sep=""))
habitat.bird <- IUCNHabitat2(path = paste(
  dataDir,"/API_HabitatLevel2_Birds.csv",sep=""))

diversity <- AddTraits(diversity,habitat.amphib,habitat.mamm,habitat.bird) 

santiniDens <- SantiniDensity(
  paste0(densDir,"TetraDensitySpeciesAverages.csv"))

diversity <- AddTraits(diversity,santiniDens)

complete.cases <- apply(X = 
  diversity[,c('Range_area_EOO_log10_square_km',
               'Natural_habitat_specialization_Category',
               'Average_local_density_log10_individuals_per_km2')],
  MARGIN = 1,FUN = function(x) return(all(!is.na(x))))

diversity.complete <- diversity[complete.cases,]

sites <- unique(diversity.complete[,c(
  'Predominant_land_use','SSBS',
  'Longitude','Latitude')])

outline <- readOGR(dsn = dataDir,
                   layer = "outline_clip2",
                   verbose = FALSE)

png(filename = paste0(outDir,"SitesMap.png"),
    width = 12.5,height = 6.25,units = "cm",
    res = 150)

par(mar=c(0,0,0,0))
plot(outline,col="#aaaaaa",border=NA)
points(sites$Longitude,sites$Latitude,
       pch=16,col="#08306b33",cex=0.75)

invisible(dev.off())

saveRDS(object = diversity,file = paste0(outDir,"diversity.rds"))