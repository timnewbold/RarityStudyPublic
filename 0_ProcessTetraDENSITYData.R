
dataDir <- "0_data/"
outDir <- "0_ProcessTetraDENSITYData/"

tetraDens <- read.csv(paste0(dataDir,"TetraDENSITY.csv"))
tetraDensOrig <- read.csv(paste0(dataDir,"AverageDensities.csv"))

tetraDens$Species <- paste(tetraDens$Genus,tetraDens$Species)

avDens <- tapply(X = tetraDens$Density,
                 INDEX = tetraDens$Species,
                 FUN = function(x){
                   return(10^mean(log10(x)))})

avDensOrig <- tetraDensOrig$Density_km2[match(
  names(avDens),tetraDensOrig$Species)]

print(cor.test(avDens,avDensOrig))

classes <- tapply(X = paste(tetraDens$Class),
                  INDEX = tetraDens$Species,
                  FUN = unique)
orders <- tapply(X = paste(tetraDens$Order),
                  INDEX = tetraDens$Species,
                  FUN = unique)
families <- tapply(X = paste(tetraDens$Family),
                  INDEX = tetraDens$Species,
                  FUN = unique)

avDensDF <- data.frame(Class=classes,
                       Order=orders,
                       Family=families,
                       Species=names(avDens),
                       Density_km2=avDens)

write.csv(x = avDensDF,file = paste0(
  outDir,"TetraDensitySpeciesAverages.csv"),
  row.names = FALSE)
