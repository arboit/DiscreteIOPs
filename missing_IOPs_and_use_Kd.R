source('~/DiscreteIOPs/compute_aTOT_discrete_GE_from_Kd.R')

missing_date_station_v2 = c(
  "20160618_StationG303", # missing from discrete DB
  "20160619_StationG310", # missing from discrete DB
  "20160620_StationG315", # missing from discrete DB
  "20160621_StationG321", # missing from discrete DB
  "20160624_StationG400", # missing from discrete DB
  "20160626_StationG406", # missing from discrete DB
  "20160629_StationG500", # missing from discrete DB
  "20160630_StationG503", # missing from discrete DB
  "20160630_StationG506", # missing from discrete DB
  "20160701_StationG510", # missing from discrete DB
  "20160702_StationG515", # missing from discrete DB
  "20160704_StationG603", # missing from discrete DB
  "20160706_StationG608", # missing from discrete DB
  "20160706_StationG612", # missing from discrete DB
  "20160707_StationG618", # missing from discrete DB
  "20160708_StationG700" #, missing from discrete DB
)

for (i in 1:length(missing_date_station_v2)){
  compute.aTOT.discrete.GE.from.Kd(missing_date_station_v2[i])
}
