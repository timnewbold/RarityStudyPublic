suppressMessages(suppressWarnings(library(yarg)))

inDir <- "2_DivideDiversityDataByRarity/"
outDir <- "3_PrepareSiteData/"

diversity <- readRDS(paste0(inDir,"diversity.rds"))

diversityRC <- split(diversity,diversity$combined.quants)

diversityRC <- lapply(diversityRC,droplevels)

sitesRC <- lapply(X = diversityRC,FUN = SiteMetrics,extra.cols=c(
  "SSB","SSBS","Biome","Sampling_method",
  "Study_common_taxon","Sampling_effort",
  "Sampling_effort_unit","LandUse", "Class", 
  "Realm","combined.quants"),srEstimators=FALSE)

sitesRC <- lapply(sitesRC,function(sites){
  sites$LogAbund<-(log(sites$Total_abundance+1))
  
  sites$LandUse <- paste(sites$LandUse)
  sites$LandUse[which(sites$LandUse=="Primary vegetation")]<-"Primary vegetation"
  sites$LandUse[which(sites$LandUse=="Mature secondary vegetation")]<-"Secondary vegetation"
  sites$LandUse[which(sites$LandUse=="Intermediate secondary vegetation")]<-"Secondary vegetation"
  sites$LandUse[which(sites$LandUse=="Young secondary vegetation")]<-"Secondary vegetation"
  sites$LandUse[which(sites$LandUse=="Plantation forest")]<-"Plantation forest"
  sites$LandUse[which(sites$LandUse=="Pasture")]<-"Pasture"
  sites$LandUse[which(sites$LandUse=="Cropland")]<-"Cropland"
  sites$LandUse[which(sites$LandUse=="Urban")]<-"Urban"
  sites$LandUse<-factor(sites$LandUse, levels=c("Primary vegetation", "Secondary vegetation", "Plantation forest", "Pasture", "Cropland", "Urban"))
  sites$LandUse<-relevel(sites$LandUse,ref="Primary vegetation")
  
  sites <- droplevels(sites[sites$LandUse!="Urban",])
  
})

allSites <- do.call('rbind',sitesRC)

print(table(allSites$combined.quants,allSites$LandUse))
