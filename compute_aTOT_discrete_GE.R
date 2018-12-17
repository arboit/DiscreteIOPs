# compute.aTOT.for.COPS <- function(pathIOP=".", cast="down", depth.interval=c(0.75,2.1), instrument = "ASPH")
# SO TAKE DEPHTS 0.75 TO 2.1 m
# -> just take the minimum depth

compute_aTOT_discrete_GE <- function (station_date) {
  
  #date_station = "20160612_StationG110" # for testing

  station.nb=substring(date_station,18,23) # two extra spaces for case "G604.5"
  path = "/Data/Insitu/GreenEdge/2016/"
  
  source('./spectral.aw.R', echo=TRUE)
  
  #Load wavelenghts from COPS
  load(file="/Data/Insitu/GreenEdge/2016/L2/20160616_StationG207/COPS/BIN/20160616_COPS_CAST_001_160616_143228_URC.tsv.RData") 
  lambda = cops$LuZ.waves
  lambda[19] = 800 #875 missing from the DB
  
  #Load and get Ap at COPS wavelengths
  dat_a.p = read.csv("GE-Amundsen-particulate_absorption_120517.csv", header = TRUE)
  nb_rows = length(dat_a.p$X340)
  a.p <- matrix(,nb_rows,19)
  
  a.p[,1]=as.numeric(dat_a.p$X340)
  a.p[,2]=as.numeric(dat_a.p$X412)
  a.p[,3]=as.numeric(dat_a.p$X443)
  a.p[,4]=as.numeric(dat_a.p$X465)
  a.p[,5]=as.numeric(dat_a.p$X490)
  a.p[,6]=as.numeric(dat_a.p$X510)
  a.p[,7]=as.numeric(dat_a.p$X532)
  a.p[,8]=as.numeric(dat_a.p$X555)
  a.p[,9]=as.numeric(dat_a.p$X560)
  a.p[,10]=as.numeric(dat_a.p$X589)
  a.p[,11]=as.numeric(dat_a.p$X625)
  a.p[,12]=as.numeric(dat_a.p$X665)
  a.p[,13]=as.numeric(dat_a.p$X670)
  a.p[,14]=as.numeric(dat_a.p$X683)
  a.p[,15]=as.numeric(dat_a.p$X694)
  a.p[,16]=as.numeric(dat_a.p$X710)
  a.p[,17]=as.numeric(dat_a.p$X765)
  a.p[,18]=as.numeric(dat_a.p$X780)
  #a.p[,19]=as.numeric(dat_a.p$X875) #missing from the DB
  a.p[,19]=as.numeric(dat_a.p$X800)
  
  station.indices_a.p = which(dat_a.p$Station==paste("G",station.nb, sep = ""))
  min_depth.index_a.p = station.indices_a.p[which(dat_a.p$Depth..m.[station.indices_a.p]==min(dat_a.p$Depth..m.[station.indices_a.p]))]
  a.p.station = a.p[min_depth.index_a.p,]
  
  #Load and get Ag at COPS wavelengths
  dat_a.g = read.csv("cdom_amundsen_2016.csv", header = TRUE)
  
  station.indices_a.g = which(dat_a.g$station==paste("stnG",station.nb, sep = ""))
  depths_num = as.numeric(substring(dat_a.g$depth[station.indices_a.g],1,3))
  min_depth.index_a.g = station.indices_a.g[which(depths_num==min(depths_num))]
  
  a.g.station <- matrix(data=0,19) 
  for (i in 1:16){ #the 3 last wavelengths are not in this data
    a.g.station[i]=dat_a.g$absorption[min_depth.index_a.g[which(dat_a.g$wavelength[min_depth.index_a.g]==lambda[i])]]
  }
  
  # get Pure water absorption at COPS wavelengths
  library(Riops)
  a.w = spectral.aw(lambda)
  
  a.tot = a.p.station+a.g.station+a.w
  
  
  # Plot and save results
  date_station=paste(substr(station_date,6,13),"_StationIML4",sep="")
  png(filename = paste(path,"L2/",date_station,"/COPS/absorption.cops.png", sep=""))
  plot(lambda, a.tot, 
       xlab = "Wavelenght", ylab="Absorption", pch=19,
       ylim=c(0, max(a.tot)))
  
  lines(lambda, a.p.station, col=2, lwd=3)
  lines(300:800, spectral.aw(300:800), col=4, lwd=4)
  lines(lambda, a.g.station, col=3, lwd=3)
  dev.off()
  
  # write results in file absorption.cops.dat
  file=paste(path,"L2/",date_station,"/COPS/absorption.cops.dat", sep="")
  df = read.table(file,sep=";")
  nfile = length(df$V1) - 1
  a.mat = matrix(a.tot, nrow=nfile, ncol=19, byrow=T)
  df.a = rbind(lambda,a.mat)
  df.final = as.data.frame(cbind(df$V1, as.data.frame(df.a)))
  
  write.table(df.final, quote=F, file, sep=";", col.names = F, row.names=F)
  
  return(a.tot)

}
