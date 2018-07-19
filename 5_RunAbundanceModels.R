suppressMessages(suppressWarnings(library(StatisticalModels)))

inDir <- "3_PrepareSiteData/"
outDir <- "5_RunAbundanceModels/"

allSites <- readRDS(paste0(inDir,"CombinedSites.rds"))

allSites$habitat.quants <- factor(allSites$habitat.quants)

modelData <- allSites[,c('LogAbund','SS','SSB','SSBS',
                         'LandUse','range.quants','abund.quants',
                         'habitat.quants','combined.quants')]
modelData <- droplevels(na.omit(modelData))

cat('Null model\n')

nullModel <- GLMER(modelData = modelData,responseVar = "LogAbund",
                   fitFamily = "gaussian",fixedStruct = "1",
                   randomStruct = "(1|SS)+(1|SSB)")

cat('Land-use model\n')

luModel <- GLMER(modelData = modelData,responseVar = "LogAbund",
                 fitFamily = "gaussian",fixedStruct = "LandUse",
                 randomStruct = "(1|SS)+(1|SSB)")

cat('Additive rarity model\n')

rarityAdditiveModel <- GLMER(modelData = modelData,responseVar = "LogAbund",
                             fitFamily = "gaussian",
                             fixedStruct = "LandUse + range.quants + abund.quants + habitat.quants + LandUse:range.quants + LandUse:abund.quants + LandUse:habitat.quants",
                             randomStruct = "(1|SS)+(1|SSB)")

cat('Interactive rarity model\n')

rarityInteractModel <- GLMER(modelData = modelData,responseVar = "LogAbund",
                             fitFamily = "gaussian",
                             fixedStruct = "LandUse + combined.quants + LandUse:combined.quants",
                             randomStruct = "(1|SS)+(1|SSB)")

print(AIC(nullModel$model,luModel$model,rarityAdditiveModel$model,rarityInteractModel$model))

saveRDS(object = rarityInteractModel,file = paste0(outDir,"FullInteractionsModel.rds"))

rm(allSites,modelData,nullModel,luModel,rarityAdditiveModel,rarityInteractModel)

sitesRC <- readRDS(paste0(inDir,'SitesByRarityCategory.rds'))

cat('Running models for individual rarity categories\n')
modelsByCategory <- mapply(function(sites,label){
  
  cat(paste0(label,'\n'))
  
  modelData <- sites[,c('LogAbund','SS','SSB','SSBS','LandUse')]
  modelData <- droplevels(na.omit(modelData))
  
  nullModel <- GLMER(modelData = modelData,responseVar = "LogAbund",
                     fitFamily = "gaussian",fixedStruct = "1",
                     randomStruct = "(1|SS)+(1|SSB)")
  
  luModel <- GLMER(modelData = modelData,responseVar = "LogAbund",
                   fitFamily = "gaussian",fixedStruct = "LandUse",
                   randomStruct = "(1|SS)+(1|SSB)")
  
  av <- anova(nullModel$model,luModel$model)
  cat(paste0('Chi Sq = ',round(av$Chisq[2],2),'\n'))
  cat(paste0('DF = ',paste(av$Df,collapse = ','),'\n'))
  cat(paste0('P = ',round(av$`Pr(>Chisq)`[2],4),'\n'))
  
  png(filename = paste0(outDir,"AbundResponse_",label,".png"),
      width = 12.5,height = 8,units = "cm",res = 1200)
  
  PlotGLMERFactor(model = luModel$model,data = luModel$data,
                  responseVar = "Total abundance",logLink = "e",
                  catEffects = "LandUse",order = c(1,2,3,5,4),
                  seMultiplier = 1)
  
  invisible(dev.off())
  
  return(luModel)
  
},sitesRC,gsub(" ","_",names(sitesRC)))

saveRDS(object = modelsByCategory,file = paste0(outDir,"ModelsByRarityCategory.rds"))