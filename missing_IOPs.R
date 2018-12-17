source('~/DiscreteIOPs/compute_aTOT_discrete_GE.R')

missing_date_station = c(
#"20160609_StationG100",
"20160610_StationG102",
#"20160611_StationG104",
#"20160611_StationG106",
#"20160611_StationG107",
"20160612_StationG110",
#"20160613_StationG113",
#"20160614_StationG201",
"20160615_StationG204",
#"20160616_StationG207",
#"20160616_StationG209",
"20160617_StationG300",
##"20160618_StationG303", missing from discrete DB
#"20160618_StationG308",
#"20160618_StationG309",
##"20160619_StationG310", missing from discrete DB
#"20160619_StationG312",
##"20160620_StationG315", missing from discrete DB
#"20160620_StationG318",
##"20160621_StationG321", missing from discrete DB
#"20160621_StationG324",
##"20160624_StationG400", missing from discrete DB
#"20160625_StationG403",
##"20160626_StationG406", missing from discrete DB
"20160626_StationG409", # missing COPS -> make fake .dat file
#"20160628_StationG413",
#"20160628_StationG418",
##"20160629_StationG500", missing from discrete DB
##"20160630_StationG503", missing from discrete DB
##"20160630_StationG506", missing from discrete DB
#"20160630_StationG507",
##"20160701_StationG510", missing from discrete DB
#"20160701_StationG512",
##"20160702_StationG515", missing from discrete DB
#"20160702_StationG519",
#"20160703_StationG600",
##"20160704_StationG603", missing from discrete DB
#"20160706_StationG604.5",
#"20160704_StationG605",
##"20160706_StationG608", missing from discrete DB
##"20160706_StationG612", missing from discrete DB
#"20160705_StationG615",
##"20160707_StationG618", missing from discrete DB
##"20160708_StationG700" #, missing from discrete DB
#"20160707_StationG703",
#"20160708_StationG707",
#"20160709_StationG713",
#"20160710_StationG719"
)

# > missing_date_station
# [1] "20160610_StationG102"
# [2] "20160612_StationG110"
# [3] "20160615_StationG204"
# [4] "20160617_StationG300"
# [5] "20160618_StationG303" missing from discrete DB
# [6] "20160619_StationG310" missing from discrete DB
# [7] "20160620_StationG315" missing from discrete DB
# [8] "20160621_StationG321" missing from discrete DB
# [9] "20160624_StationG400" missing from discrete DB
# [10] "20160626_StationG406" missing from discrete DB
# [11] "20160626_StationG409" missing COPS -> make fake .dat file
# [12] "20160629_StationG500" missing from discrete DB
# [13] "20160630_StationG503" missing from discrete DB
# [14] "20160630_StationG506" missing from discrete DB
# [15] "20160701_StationG510" missing from discrete DB
# [16] "20160702_StationG515" missing from discrete DB
# [17] "20160704_StationG603" missing from discrete DB
# [18] "20160706_StationG608" missing from discrete DB
# [19] "20160706_StationG612" missing from discrete DB
# [20] "20160707_StationG618" missing from discrete DB
# [21] "20160708_StationG700" missing from discrete DB

for (i in 1:length(missing_date_station)){
  compute.aTOT.discrete.GE(missing_date_station[i])
}