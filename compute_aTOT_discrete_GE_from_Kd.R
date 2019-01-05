# takes Rd and R from COPS data and produce a(lambda) as Equation 8 (or rather, 8')
# of Morel & Marioneta 2001 "Bio-optical properties of oceanic waters: A reappraisal"
# a = Kd 0.90[1+2.25R]^-1 [1-R]
#
# Use COPS data, ex:
# library(Cops) 
# cops=read.COPS(file=paste(path,"L2/",date_station,"/COPS/COPS_IML4_150710_1348_C_data_004.csv", sep = ""), 2)

compute.aTOT.discrete.GE.from.Kd <- function (date_station) {
  
  print(paste("discrete IOPs (from Kd) for",date_station))

  station.nb=substring(date_station,18,23) # two extra spaces for case "G604.5"
  path = "/Data/Insitu/GreenEdge/2016/"
  
  #Load wavelenghts from COPS
  load(file="/Data/Insitu/GreenEdge/2016/L2/20160616_StationG207/COPS/BIN/20160616_COPS_CAST_001_160616_143228_URC.tsv.RData") 
  lambda = cops$LuZ.waves
  
  #Use processed COPS data, saved 
  files.dat=read.csv(file=paste(path,"L2/",date_station,"/COPS/remove.cops.dat", sep = ""), sep = ";", header = FALSE)
  index_good_casts = which(files.dat$V2==1)
  if (length(index_good_casts) != 1) {
    print(paste("CAUTION, the number of non-removed files for",date_station,"is",length(index_good_casts)))
    one_good_cast = index_good_casts[1] # but an average should be taken instead...? (REVIEW THIS)
    print(paste("Taking the first valid cast, number =",one_good_cast))
  } else {
    one_good_cast = index_good_casts
  }
  kept_cast = files.dat$V1[one_good_cast]
  
  #In the .RData of cops, Kd is named K0.EdZ.fitted (1m) [ref. Kd.png]
  #                        R  is named R.0p
  #another option: paste(path,"L2/",date_station,"/COPS/ASC/",kept_cast,".asc",sep = "")
  load(paste(path,"L2/",date_station,"/COPS/BIN/",kept_cast,".RData",sep = ""))
  
  R_lambda = cops$R.0p
  Kd_lambda = cops$K0.EdZ.fitted[75,] #TAKE DEPHTS 0.75 TO 2.1 m ?? rownames(cops$K0.EdZ.fitted)[152]=="2.1"
  
  #a = Kd 0.90[1+2.25R]^-1 [1-R]
  a.tot = Kd_lambda*0.9*(1-R_lambda)/(1+2.25*R_lambda)
  
  # Plot and save results
  if (station.nb != "409") {
  png(filename = paste(path,"L2/",date_station,"/COPS/absorption.cops.png", sep=""))
  plot(lambda, a.tot, 
       xlab = "Wavelenght", ylab="Absorption", pch=19,
       ylim=c(0, max(a.tot)))
  
  #lines(lambda, a.p.station, col=2, lwd=3)
  #source('./spectral.aw.R', echo=TRUE)
  #lines(300:800, spectral.aw(300:800), col=4, lwd=4)
  #xlines(lambda, a.g.station, col=3, lwd=3)
  dev.off() }
  
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
