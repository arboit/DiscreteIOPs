# compute.aTOT.for.COPS <- function(pathIOP=".", cast="down", depth.interval=c(0.75,2.1), instrument = "ASPH")
# SO TAKE DEPHTS 0.75 TO 2.1 m


source('./spectral.aw.R', echo=TRUE)

#Load wavelenghts from COPS
load(file="/Data/Insitu/GreenEdge/2016/L2/20160616_StationG207/COPS/BIN/20160616_COPS_CAST_001_160616_143228_URC.tsv.RData") 
lambda = cops$LuZ.waves
lambda[19] = 800 #875 missing from the DB

#Load and get Ap at COPS wavelengths
dat = read.csv("GE-Amundsen-particulate_absorption_120517.csv", header = TRUE)
nb_rows = length(dat$X340)
a.p <- matrix(,nb_rows,19)

a.p[,1]=as.numeric(dat$X340)
a.p[,2]=as.numeric(dat$X412)
a.p[,3]=as.numeric(dat$X443)
a.p[,4]=as.numeric(dat$X465)
a.p[,5]=as.numeric(dat$X490)
a.p[,6]=as.numeric(dat$X510)
a.p[,7]=as.numeric(dat$X532)
a.p[,8]=as.numeric(dat$X555)
a.p[,9]=as.numeric(dat$X560)
a.p[,10]=as.numeric(dat$X589)
a.p[,11]=as.numeric(dat$X625)
a.p[,12]=as.numeric(dat$X665)
a.p[,13]=as.numeric(dat$X670)
a.p[,14]=as.numeric(dat$X683)
a.p[,15]=as.numeric(dat$X694)
a.p[,16]=as.numeric(dat$X710)
a.p[,17]=as.numeric(dat$X765)
a.p[,18]=as.numeric(dat$X780)
#a.p[,19]=as.numeric(dat$X875) #missing from the DB
a.p[,19]=as.numeric(dat$X800)

#Load and get Ag at COPS wavelengths
dat = read.csv("cdom_amundsen_2016.csv", header = TRUE)
nb_rows = length(dat$X340)
a.g <- matrix(,nb_rows,19)



# get Pure water absorption at COPS wavelengths
library(Riops)
a.w = spectral.aw(lambda)


