suppressMessages(suppressWarnings(library(roquefort)))


richModelsDir <- "4_RunRichnessModels/"
abundModelsDir <- "5_RunAbundanceModels/"

outDir <- "6_PlotModels/"

richModels <- readRDS(paste0(richModelsDir,"ModelsByRarityCategory.rds"))
abundModels <- readRDS(paste0(abundModelsDir,"ModelsByRarityCategory.rds"))

ylims <- c(-120,80)

png(filename = paste0(outDir,"ResultsFigure.png"),
    width = 17.0,height = 19.5,units = "cm",res = 300)

layout.mat <- matrix(data = c(1,2,3,4,5,6,7,8,9,10,11,12),nrow = 4,ncol = 3,byrow = FALSE)
layout(mat = layout.mat,widths = c(4,6.5,6.5),heights = rep(4.875,4))

par(mar=c(0,0,0,0))
plot.new()

par("cex" = 1)
text(x = 0.5,y = 0.7,
     labels = "Rare \u00d7 3\n(n = 1):",
     cex=0.8,font=2)

legend(x = 0.5,y = 0.65,legend = c(
  "R\u2193A\u2193H\u2193"),
  pch = 18,ncol=1,
  xjust=0.5,yjust=1,
  cex=0.8,bty="n")

plot.new()

par("cex" = 1)
text(x = 0.5,y = 0.7,
     labels = "Rare \u00d7 2\n(n = 3):",
     cex=0.8,font=2)

legend(x = 0.5,y = 0.65,legend = c(
  "R\u2193A\u2193H\u2191",
  "R\u2193A\u2191H\u2193",
  "R\u2191A\u2193H\u2193"),
  pch = c(16,17,15),ncol=1,
  xjust=0.5,yjust=1,
  cex=0.8,bty="n")

plot.new()

par("cex" = 1)
text(x = 0.5,y = 0.7,
     labels = "Rare \u00d7 1\n(n = 3):",
     cex=0.8,font=2)

legend(x = 0.5,y = 0.65,legend = c(
  "R\u2193A\u2191H\u2191",
  "R\u2191A\u2193H\u2191",
  "R\u2191A\u2191H\u2193"),
  pch = c(1,2,0),ncol=1,
  xjust=0.5,yjust=1,
  cex=0.8,bty="n")

plot.new()

par("cex" = 1)
text(x = 0.5,y = 0.7,
     labels = "Common \u00d7 3\n(n = 1):",
     cex=0.8,font=2)

legend(x = 0.5,y = 0.65,legend = c(
  "R\u2191A\u2191H\u2191"),
  pch = 5,ncol=1,
  xjust=0.5,yjust=1,
  cex=0.8,bty="n")

par("cex" = 0.66)

PlotErrBar(model = richModels['1 1 1'][[1]]$model,data = richModels['1 1 1'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 18,ylim = ylims,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(a)",side = 3,adj = -0.26,font=3,line=-1.4)
mtext(text = "Species richness",side = 3,
      adj = 0.5,line = -1.2,cex=0.8,font=2)

PlotErrBar(model = richModels['1 1 2'][[1]]$model,data = richModels['1 1 2'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 16,ylim = ylims,offset = -0.3,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = richModels['1 2 1'][[1]]$model,data = richModels['1 2 1'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 17,ylim = ylims,offset = 0,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = richModels['2 1 1'][[1]]$model,data = richModels['2 1 1'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 15,ylim = ylims,offset = 0.3,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(b)",side = 3,adj = -0.26,font=3,line=-1.4)

PlotErrBar(model = richModels['1 2 2'][[1]]$model,data = richModels['1 2 2'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 1,ylim = ylims,offset = -0.3,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = richModels['2 1 2'][[1]]$model,data = richModels['2 1 2'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 2,ylim = ylims,offset = 0,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = richModels['2 2 1'][[1]]$model,data = richModels['2 2 1'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 0,ylim = ylims,offset = 0.3,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(c)",side = 3,adj = -0.26,font=3,line=-1.4)

PlotErrBar(model = richModels['2 2 2'][[1]]$model,data = richModels['2 2 2'][[1]]$data,
           responseVar = "Richness",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 5,ylim = ylims,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(d)",side = 3,adj = -0.26,font=3,line=-1.4)

PlotErrBar(model = abundModels['1 1 1'][[1]]$model,data = abundModels['1 1 1'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 18,ylim = ylims,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(e)",side = 3,adj = -0.26,font=3,line=-1.4)
mtext(text = "Total abundance",side = 3,
      adj = 0.5,line = -1.2,cex=0.8,font=2)

PlotErrBar(model = abundModels['1 1 2'][[1]]$model,data = abundModels['1 1 2'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 16,ylim = ylims,offset = -0.3,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = abundModels['1 2 1'][[1]]$model,data = abundModels['1 2 1'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 17,ylim = ylims,offset = 0,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = abundModels['2 1 1'][[1]]$model,data = abundModels['2 1 1'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 15,ylim = ylims,offset = 0.3,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(f)",side = 3,adj = -0.26,font=3,line=-1.4)

PlotErrBar(model = abundModels['1 2 2'][[1]]$model,data = abundModels['1 2 2'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 1,ylim = ylims,offset = -0.3,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = abundModels['2 1 2'][[1]]$model,data = abundModels['2 1 2'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 2,ylim = ylims,offset = 0,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

PlotErrBar(model = abundModels['2 2 1'][[1]]$model,data = abundModels['2 2 1'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 0,ylim = ylims,offset = 0.3,add = TRUE,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(g)",side = 3,adj = -0.26,font=3,line=-1.4)

PlotErrBar(model = abundModels['2 2 2'][[1]]$model,data = abundModels['2 2 2'][[1]]$data,
           responseVar = "Abundance",logLink = "e",catEffects = "LandUse",
           forPaper = TRUE,pt.pch = 5,ylim = ylims,xtext.srt = 45,
           params = list(tck=-0.01,mgp=c(1.2,0.2,0)))

mtext(text = "(h)",side = 3,adj = -0.26,font=3,line=-1.4)

invisible(dev.off())