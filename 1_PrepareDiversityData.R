suppressMessages(suppressWarnings(library(yarg)))

dataDir <- "0_data/"
outDir <- "1_PrepareDiversityData/"

cat('Loading database extracts\n')

diversity<-readRDS(paste(dataDir,"database.rds",sep=""))

cat('Selecting appropriate data\n')

diversity <- droplevels(diversity[(diversity$Phylum=="Chordata"),])
diversity <- droplevels(diversity[(diversity$Class!=""),])

cat('Correcting for sampling effort\n')
diversity <- CorrectSamplingEffort(diversity)

cat('Merging sites\n')
diversity <- MergeSites(diversity,public = TRUE,silent = TRUE)

cat('Getting species\' rarity information')

bl<-BirdlifeRangeArea(path = paste(dataDir,"bird_range_areas.txt",sep=""))
ia<-IUCNRangeArea(path = paste(dataDir,"amphibian_range_areas.csv",sep=""))
im<-IUCNRangeArea(path = paste(dataDir,"mammal_range_areas.csv",sep=""))

diversity<-AddTraits(diversity,ia,im,bl)

habitat.amphib <- IUCNHabitat2(path = paste(
  dataDir,"API_HabitatLevel2_Amphibian.csv",sep=""))
habitat.mamm <- IUCNHabitat2(path = paste(
  dataDir,"API_HabitatLevel2_Mammals.csv",sep=""))
habitat.bird <- IUCNHabitat2(path = paste(
  dataDir,"API_HabitatLevel2_Birds.csv",sep=""))

diversity <- AddTraits(diversity,habitat.amphib,habitat.mamm,habitat.bird) 

santiniDens <- SantiniVertebrateAverageDensity(
  paste0(dataDir,"AverageDensities.csv"))

diversity <- AddTraits(diversity,santiniDens)

saveRDS(object = diversity,file = paste0(outDir,"diversity.rds"))