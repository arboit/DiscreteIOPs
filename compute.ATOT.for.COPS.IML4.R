source('~/Copy/R/BiOpticaR/PureWaterIOP/spectral_aw.R', echo=TRUE)

# IML42015

compute.aTOT.for.COPS.IML4_2015 <- function (path,station_date) {
  
  #Load wavelenghts from COPS
  load(file="~/copy/data/BoueesIML/2015/L2/20150603_StationIML4/COPS/BIN/IML4_150603_1448_C_data_001.csv.RData")
  lambda = cops$LuZ.waves
  
  setwd(path)
  #Load and get Ap at COPS wavelengths
  load(paste(path,"Ap/RData/",station_date,".RData",sep=""))
  a.p.cops = spline(A$Ap$Lambda, A$Ap$Ap.RG.mean,  xout=lambda, method="natural")$y
  
  
  #Load and get Ag at COPS wavelengths
  load(paste(path,"CDOM/RData/",station_date,".RData",sep=""))
  a.g.cops = spline(Ag$Lambda, Ag$Ag.offset,  xout=lambda, method="natural")$y
  
  # get Pure water absorption at COPS wavelengths
  a.w.cops = spectral_aw(lambda)
  
  a.tot.cops = a.p.cops + a.g.cops + a.w.cops
  
  # Plot and save results
  date_station=paste(substr(station_date,6,13),"_StationIML4",sep="")
  png(filename = paste(path,"L2/",date_station,"/COPS/absorption.cops.png", sep=""))
  plot(lambda, a.tot.cops, 
       xlab = "Wavelenght", ylab="Absorption", pch=19,
       ylim=c(0, max(a.tot.cops)))
  
  lines(A$Ap$Lambda,A$Ap$Ap.Stramski.mean, col=2, lwd=3)
  lines(300:800, spectral_aw(300:800), col=4, lwd=4)
  lines(Ag$Lambda,Ag$Ag, col=3, lwd=3)
  dev.off()
  
  # write results in file absorption.cops.dat
  file=paste(path,"L2/",date_station,"/COPS/absorption.cops.dat", sep="")
  df = read.table(file,sep=";")
  nfile = length(df$V1) - 1
  a.mat = matrix(a.tot.cops, nrow=nfile, ncol=19, byrow=T)
  df.a = rbind(lambda,a.mat)
  df.final = as.data.frame(cbind(df$V1, as.data.frame(df.a)))
  
  write.table(df.final, quote=F, file, sep=";", col.names = F, row.names=F)
  
  return(a.tot.cops)
  
}
path = "~/copy/data/BoueesIML/2015/"
station_date = "IML4_20151105"
a.tot = compute.aTOT.for.COPS.IML4_2015(path,station_date)
