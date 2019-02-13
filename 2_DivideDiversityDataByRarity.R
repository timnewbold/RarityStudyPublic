
inDir <- "1_PrepareDiversityData/"
outDir <- "2_DivideDiversityDataByRarity/"

diversity <- readRDS(paste0(inDir,"diversity.rds"))

cat('Preparing data\n')

diversity$log.range <- diversity$Range_area_EOO_log10_square_km
diversity$Habitat_Specialisation<-diversity$Natural_habitat_specialization_Category
diversity$Density <- diversity$Average_local_density_log10_individuals_per_km2
diversity$LandUse <- diversity$Predominant_land_use

diversity <- droplevels(diversity[!is.na(diversity$log.range),])
diversity <- droplevels(diversity[!is.na(diversity$Habitat_Specialisation),])
diversity <- droplevels(diversity[!is.na(diversity$Density),])

diversity <- droplevels(diversity[diversity$Predominant_land_use!="Cannot decide",])
diversity <- droplevels(diversity[diversity$Predominant_land_use!="Secondary vegetation (indeterminate age)",])

cat('Splitting data into rarity categories\n')

diversitySS <- split(diversity,diversity$SS)

diversity <- do.call('rbind',lapply(diversitySS,function(x)
{
  
  if (!any(duplicated(c(min(x$log.range-1),quantile(x$log.range,probs=c(0,1/2,1.0))[2:3])))){
    x$range.quants <- cut(x = x$log.range,breaks = c(min(x$log.range-1),quantile(
      x$log.range,probs=c(0,1/2,1.0))[2:3]),labels=1:2)
    
  } else {
    x$range.quants <- NA
  }
  
  if (!any(duplicated(c(min(x$Density),quantile(x$Density,probs=c(0,1/2,1.0))[2:3])))){
    x$abund.quants <- cut(x = x$Density,breaks = c(min(x$Density),quantile(
      x$Density,probs=c(0,1/2,1.0))[2:3]),labels=1:2)
    
  } else {
    x$abund.quants <- NA
  }
  
  x$habitat.quants <- ifelse(as.logical(x$Habitat_Specialisation),1,2)
  
  x$combined.quants <- paste(x$range.quants,x$abund.quants,x$habitat.quants)
  
  x <- x[!is.na(x$range.quants),]
  x <- x[!is.na(x$abund.quants),]
  
  return(x)
  
  # xq <- split(x = x,f = x$combined.quants)
  
  # return(xq['1 1 1'][[1]])
  
}))

cat(paste0('Final dataset contains ',nrow(diversity),' records\n'))
cat(paste0('For ',length(unique(c(diversity$Taxon))),' species\n'))

species <- unique(diversity[,c('Taxon','combined.quants')])
print(table(species$combined.quants))

saveRDS(object = diversity,file = paste0(outDir,"diversity.rds"))
