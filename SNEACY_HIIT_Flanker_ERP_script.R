#Created by Katherine McDonald
#If you use my script, I kindly ask for co-authorship on your work as a
#significant contributor to your data processing pipeline

library(readxl)
library(dplyr)
library(plyr)
library(ggplot2)
library(tidyverse)
library(RColorBrewer)
library(wesanderson)
library(haven)
library(data.table)
library(janitor)
library(funModeling)
library(scales)
library(reshape)

#Import Data
SNEACY2Child_pr_Flanker_R_Congruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Rest/Pre/Export_Excel/GrandAVG/SNEACY2Child_pr_Flanker_R_Congruent.xlsm")
SNEACY2Child_pr_Flanker_R_Incongruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Rest/Pre/Export_Excel/GrandAVG/SNEACY2Child_pr_Flanker_R_Incongruent.xlsm")
SNEACY2Child_pr_Flanker_E_Congruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Exercise/Pre/Export_Excel/GrandAVG/SNEACY2Child_pr_Flanker_E_Congruent.xlsm")
SNEACY2Child_pr_Flanker_E_Incongruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Exercise/Pre/Export_Excel/GrandAVG/SNEACY2Child_pr_Flanker_E_Incongruent.xlsm")
SNEACY2Child_pr_Flanker_T_Congruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Trier/Pre/Export_Excel/GrandAVG/SNEACY2Child_pr_Flanker_T_Congruent.xlsm")
SNEACY2Child_pr_Flanker_T_Incongruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Trier/Pre/Export_Excel/GrandAVG/SNEACY2Child_pr_Flanker_T_Incongruent.xlsm")
SNEACY2Child_po_Flanker_R_Congruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Rest/Post/Export_Excel/GrandAVG/SNEACY2Child_po_Flanker_R_Congruent.xlsm")
SNEACY2Child_po_Flanker_R_Incongruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Rest/Post/Export_Excel/GrandAVG/SNEACY2Child_po_Flanker_R_Incongruent.xlsm")
SNEACY2Child_po_Flanker_E_Congruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Exercise/Post/Export_Excel/GrandAVG/SNEACY2Child_po_Flanker_E_Congruent.xlsm")
SNEACY2Child_po_Flanker_E_Incongruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Exercise/Post/Export_Excel/GrandAVG/SNEACY2Child_po_Flanker_E_Incongruent.xlsm")
SNEACY2Child_po_Flanker_T_Congruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Trier/Post/Export_Excel/GrandAVG/SNEACY2Child_po_Flanker_T_Congruent.xlsm")
SNEACY2Child_po_Flanker_T_Incongruent <- read_excel("/Volumes/Data-1/ZShared/SNEACY/3_SNEACY2_HIIT_Child/SNEACY2_HIIT_EEG/Flanker_DL_EEG/Flanker_DL_EEG_Trier/Post/Export_Excel/GrandAVG/SNEACY2Child_po_Flanker_T_Incongruent.xlsm")

#Call and name variables 
time <- (SNEACY2Child_pr_Flanker_R_Congruent$time)
FPZ_pr_R_Congruent <- (SNEACY2Child_pr_Flanker_R_Congruent$FPZ)
FZ_pr_R_Congruent <- (SNEACY2Child_pr_Flanker_R_Congruent$FZ)
FCZ_pr_R_Congruent <- (SNEACY2Child_pr_Flanker_R_Congruent$FCZ)
CZ_pr_R_Congruent <- (SNEACY2Child_pr_Flanker_R_Congruent$CZ)
CPZ_pr_R_Congruent <- (SNEACY2Child_pr_Flanker_R_Congruent$CPZ)
PZ_pr_R_Congruent <- (SNEACY2Child_pr_Flanker_R_Congruent$PZ)
POZ_pr_R_Congruent<- (SNEACY2Child_pr_Flanker_R_Congruent$POZ)
FPZ_pr_E_Congruent <- (SNEACY2Child_pr_Flanker_E_Congruent$FPZ)
FZ_pr_E_Congruent <- (SNEACY2Child_pr_Flanker_E_Congruent$FZ)
FCZ_pr_E_Congruent <- (SNEACY2Child_pr_Flanker_E_Congruent$FCZ)
CZ_pr_E_Congruent <- (SNEACY2Child_pr_Flanker_E_Congruent$CZ)
CPZ_pr_E_Congruent <- (SNEACY2Child_pr_Flanker_E_Congruent$CPZ)
PZ_pr_E_Congruent <- (SNEACY2Child_pr_Flanker_E_Congruent$PZ)
POZ_pr_E_Congruent<- (SNEACY2Child_pr_Flanker_E_Congruent$POZ)
FPZ_pr_T_Congruent <- (SNEACY2Child_pr_Flanker_T_Congruent$FPZ)
FZ_pr_T_Congruent <- (SNEACY2Child_pr_Flanker_T_Congruent$FZ)
FCZ_pr_T_Congruent <- (SNEACY2Child_pr_Flanker_T_Congruent$FCZ)
CZ_pr_T_Congruent <- (SNEACY2Child_pr_Flanker_T_Congruent$CZ)
CPZ_pr_T_Congruent <- (SNEACY2Child_pr_Flanker_T_Congruent$CPZ)
PZ_pr_T_Congruent <- (SNEACY2Child_pr_Flanker_T_Congruent$PZ)
POZ_pr_T_Congruent<- (SNEACY2Child_pr_Flanker_T_Congruent$POZ)
FPZ_pr_R_Incongruent <- (SNEACY2Child_pr_Flanker_R_Incongruent$FPZ)
FZ_pr_R_Incongruent <- (SNEACY2Child_pr_Flanker_R_Incongruent$FZ)
FCZ_pr_R_Incongruent <- (SNEACY2Child_pr_Flanker_R_Incongruent$FCZ)
CZ_pr_R_Incongruent <- (SNEACY2Child_pr_Flanker_R_Incongruent$CZ)
CPZ_pr_R_Incongruent <- (SNEACY2Child_pr_Flanker_R_Incongruent$CPZ)
PZ_pr_R_Incongruent <- (SNEACY2Child_pr_Flanker_R_Incongruent$PZ)
POZ_pr_R_Incongruent<- (SNEACY2Child_pr_Flanker_R_Incongruent$POZ)
FPZ_pr_E_Incongruent <- (SNEACY2Child_pr_Flanker_E_Incongruent$FPZ)
FZ_pr_E_Incongruent <- (SNEACY2Child_pr_Flanker_E_Incongruent$FZ)
FCZ_pr_E_Incongruent <- (SNEACY2Child_pr_Flanker_E_Incongruent$FCZ)
CZ_pr_E_Incongruent <- (SNEACY2Child_pr_Flanker_E_Incongruent$CZ)
CPZ_pr_E_Incongruent <- (SNEACY2Child_pr_Flanker_E_Incongruent$CPZ)
PZ_pr_E_Incongruent <- (SNEACY2Child_pr_Flanker_E_Incongruent$PZ)
POZ_pr_E_Incongruent<- (SNEACY2Child_pr_Flanker_E_Incongruent$POZ)
FPZ_pr_T_Incongruent <- (SNEACY2Child_pr_Flanker_T_Incongruent$FPZ)
FZ_pr_T_Incongruent <- (SNEACY2Child_pr_Flanker_T_Incongruent$FZ)
FCZ_pr_T_Incongruent <- (SNEACY2Child_pr_Flanker_T_Incongruent$FCZ)
CZ_pr_T_Incongruent <- (SNEACY2Child_pr_Flanker_T_Incongruent$CZ)
CPZ_pr_T_Incongruent <- (SNEACY2Child_pr_Flanker_T_Incongruent$CPZ)
PZ_pr_T_Incongruent <- (SNEACY2Child_pr_Flanker_T_Incongruent$PZ)
POZ_pr_T_Incongruent<- (SNEACY2Child_pr_Flanker_T_Incongruent$POZ)
FPZ_po_R_Congruent <- (SNEACY2Child_po_Flanker_R_Congruent$FPZ)
FZ_po_R_Congruent <- (SNEACY2Child_po_Flanker_R_Congruent$FZ)
FCZ_po_R_Congruent <- (SNEACY2Child_po_Flanker_R_Congruent$FCZ)
CZ_po_R_Congruent <- (SNEACY2Child_po_Flanker_R_Congruent$CZ)
CPZ_po_R_Congruent <- (SNEACY2Child_po_Flanker_R_Congruent$CPZ)
PZ_po_R_Congruent <- (SNEACY2Child_po_Flanker_R_Congruent$PZ)
POZ_po_R_Congruent<- (SNEACY2Child_po_Flanker_R_Congruent$POZ)
FPZ_po_E_Congruent <- (SNEACY2Child_po_Flanker_E_Congruent$FPZ)
FZ_po_E_Congruent <- (SNEACY2Child_po_Flanker_E_Congruent$FZ)
FCZ_po_E_Congruent <- (SNEACY2Child_po_Flanker_E_Congruent$FCZ)
CZ_po_E_Congruent <- (SNEACY2Child_po_Flanker_E_Congruent$CZ)
CPZ_po_E_Congruent <- (SNEACY2Child_po_Flanker_E_Congruent$CPZ)
PZ_po_E_Congruent <- (SNEACY2Child_po_Flanker_E_Congruent$PZ)
POZ_po_E_Congruent<- (SNEACY2Child_po_Flanker_E_Congruent$POZ)
FPZ_po_T_Congruent <- (SNEACY2Child_po_Flanker_T_Congruent$FPZ)
FZ_po_T_Congruent <- (SNEACY2Child_po_Flanker_T_Congruent$FZ)
FCZ_po_T_Congruent <- (SNEACY2Child_po_Flanker_T_Congruent$FCZ)
CZ_po_T_Congruent <- (SNEACY2Child_po_Flanker_T_Congruent$CZ)
CPZ_po_T_Congruent <- (SNEACY2Child_po_Flanker_T_Congruent$CPZ)
PZ_po_T_Congruent <- (SNEACY2Child_po_Flanker_T_Congruent$PZ)
POZ_po_T_Congruent<- (SNEACY2Child_po_Flanker_T_Congruent$POZ)
FPZ_po_R_Incongruent <- (SNEACY2Child_po_Flanker_R_Incongruent$FPZ)
FZ_po_R_Incongruent <- (SNEACY2Child_po_Flanker_R_Incongruent$FZ)
FCZ_po_R_Incongruent <- (SNEACY2Child_po_Flanker_R_Incongruent$FCZ)
CZ_po_R_Incongruent <- (SNEACY2Child_po_Flanker_R_Incongruent$CZ)
CPZ_po_R_Incongruent <- (SNEACY2Child_po_Flanker_R_Incongruent$CPZ)
PZ_po_R_Incongruent <- (SNEACY2Child_po_Flanker_R_Incongruent$PZ)
POZ_po_R_Incongruent<- (SNEACY2Child_po_Flanker_R_Incongruent$POZ)
FPZ_po_E_Incongruent <- (SNEACY2Child_po_Flanker_E_Incongruent$FPZ)
FZ_po_E_Incongruent <- (SNEACY2Child_po_Flanker_E_Incongruent$FZ)
FCZ_po_E_Incongruent <- (SNEACY2Child_po_Flanker_E_Incongruent$FCZ)
CZ_po_E_Incongruent <- (SNEACY2Child_po_Flanker_E_Incongruent$CZ)
CPZ_po_E_Incongruent <- (SNEACY2Child_po_Flanker_E_Incongruent$CPZ)
PZ_po_E_Incongruent <- (SNEACY2Child_po_Flanker_E_Incongruent$PZ)
POZ_po_E_Incongruent<- (SNEACY2Child_po_Flanker_E_Incongruent$POZ)
FPZ_po_T_Incongruent <- (SNEACY2Child_po_Flanker_T_Incongruent$FPZ)
FZ_po_T_Incongruent <- (SNEACY2Child_po_Flanker_T_Incongruent$FZ)
FCZ_po_T_Incongruent <- (SNEACY2Child_po_Flanker_T_Incongruent$FCZ)
CZ_po_T_Incongruent <- (SNEACY2Child_po_Flanker_T_Incongruent$CZ)
CPZ_po_T_Incongruent <- (SNEACY2Child_po_Flanker_T_Incongruent$CPZ)
PZ_po_T_Incongruent <- (SNEACY2Child_po_Flanker_T_Incongruent$PZ)
POZ_po_T_Incongruent<- (SNEACY2Child_po_Flanker_T_Incongruent$POZ)


#Create ERP graphs based on electrode, include intervention (3 levels), pre/post (2 levels), and congruency (2 levels)
#FPZ Data
FPZ.df <- data.frame(time, FPZ_po_E_Congruent, FPZ_po_E_Incongruent, FPZ_po_R_Congruent, FPZ_po_R_Incongruent, FPZ_po_T_Congruent, FPZ_po_T_Incongruent, 
                          FPZ_pr_E_Congruent, FPZ_pr_E_Incongruent, FPZ_pr_R_Congruent, FPZ_pr_R_Incongruent, FPZ_pr_T_Congruent, FPZ_pr_T_Incongruent)
longformat.FPZ.df <- melt(FPZ.df, id = "time", variable.name = "time")

ggplot(longformat.FPZ.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Flanker ERP at FPZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")
 

#FZ Data
FZ.df <- data.frame(time, FZ_po_E_Congruent, FZ_po_E_Incongruent, FZ_po_R_Congruent, FZ_po_R_Incongruent, FZ_po_T_Congruent, FZ_po_T_Incongruent, 
                   FZ_pr_E_Congruent, FZ_pr_E_Incongruent, FZ_pr_R_Congruent, FZ_pr_R_Incongruent, FZ_pr_T_Congruent, FZ_pr_T_Incongruent)
longformat.FZ.df <- melt(FZ.df, id = "time", variable.name = "time")

ggplot(longformat.FZ.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Flanker ERP at FZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#FCZ Data
FCZ.df <- data.frame(time, FCZ_po_E_Congruent, FCZ_po_E_Incongruent, FCZ_po_R_Congruent, FCZ_po_R_Incongruent, FCZ_po_T_Congruent, FCZ_po_T_Incongruent, 
                    FCZ_pr_E_Congruent, FCZ_pr_E_Incongruent, FCZ_pr_R_Congruent, FCZ_pr_R_Incongruent, FCZ_pr_T_Congruent, FCZ_pr_T_Incongruent)
longformat.FCZ.df <- melt(FCZ.df, id = "time", variable.name = "time")

ggplot(longformat.FCZ.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Flanker ERP at FCZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#CZ Data
CZ.df <- data.frame(time, CZ_po_E_Congruent, CZ_po_E_Incongruent, CZ_po_R_Congruent, CZ_po_R_Incongruent, CZ_po_T_Congruent, CZ_po_T_Incongruent, 
                   CZ_pr_E_Congruent, CZ_pr_E_Incongruent, CZ_pr_R_Congruent, CZ_pr_R_Incongruent, CZ_pr_T_Congruent, CZ_pr_T_Incongruent)
longformat.CZ.df <- melt(CZ.df, id = "time", variable.name = "time")

ggplot(longformat.CZ.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Flanker ERP at CZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#CPZ Data
CPZ.df <- data.frame(time, CPZ_po_E_Congruent, CPZ_po_E_Incongruent, CPZ_po_R_Congruent, CPZ_po_R_Incongruent, CPZ_po_T_Congruent, CPZ_po_T_Incongruent, 
                    CPZ_pr_E_Congruent, CPZ_pr_E_Incongruent, CPZ_pr_R_Congruent, CPZ_pr_R_Incongruent, CPZ_pr_T_Congruent, CPZ_pr_T_Incongruent)
longformat.CPZ.df <- melt(CPZ.df, id = "time", variable.name = "time")

ggplot(longformat.CPZ.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(14,-6)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Flanker ERP at CPZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#PZ Data
PZ.df <- data.frame(time, PZ_po_E_Congruent, PZ_po_E_Incongruent, PZ_po_R_Congruent, PZ_po_R_Incongruent, PZ_po_T_Congruent, PZ_po_T_Incongruent, 
                   PZ_pr_E_Congruent, PZ_pr_E_Incongruent, PZ_pr_R_Congruent, PZ_pr_R_Incongruent, PZ_pr_T_Congruent, PZ_pr_T_Incongruent)
longformat.PZ.df <- melt(PZ.df, id = "time", variable.name = "time")

ggplot(longformat.PZ.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Flanker ERP at PZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#POZ Data
POZ.df <- data.frame(time, POZ_po_E_Congruent, POZ_po_E_Incongruent, POZ_po_R_Congruent, POZ_po_R_Incongruent, POZ_po_T_Congruent, POZ_po_T_Incongruent, 
                    POZ_pr_E_Congruent, POZ_pr_E_Incongruent, POZ_pr_R_Congruent, POZ_pr_R_Incongruent, POZ_pr_T_Congruent, POZ_pr_T_Incongruent)
longformat.POZ.df <- melt(POZ.df, id = "time", variable.name = "time")

ggplot(longformat.POZ.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Flanker ERP at POZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")






#Separated by congruency
#FPZ Congruent Data
FPZ.congruent.df <- data.frame(time, FPZ_pr_E_Congruent, FPZ_po_E_Congruent, FPZ_pr_T_Congruent, FPZ_po_T_Congruent, FPZ_pr_R_Congruent, FPZ_po_R_Congruent)
longformat.FPZ.congruent.df <- melt(FPZ.congruent.df, id = "time", variable.name = "time")

ggplot(longformat.FPZ.congruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Congruent Flanker ERP at FPZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#FPZ Incongruent Data
FPZ.incongruent.df <- data.frame(time, FPZ_pr_E_Incongruent, FPZ_po_E_Incongruent, FPZ_pr_T_Incongruent, FPZ_po_T_Incongruent, FPZ_pr_R_Incongruent, FPZ_po_R_Incongruent)
longformat.FPZ.incongruent.df <- melt(FPZ.incongruent.df, id = "time", variable.name = "time")

ggplot(longformat.FPZ.incongruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Incongruent Flanker ERP at FPZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#FZ Congruent Data
FZ.congruent.df <- data.frame(time, FZ_pr_E_Congruent, FZ_po_E_Congruent, FZ_pr_T_Congruent, FZ_po_T_Congruent, FZ_pr_R_Congruent, FZ_po_R_Congruent)
longformat.FZ.congruent.df <- melt(FZ.congruent.df, id = "time", variable.name = "time")

ggplot(longformat.FZ.congruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Congruent Flanker ERP at FZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#FZ Incongruent Data
FZ.incongruent.df <- data.frame(time, FZ_pr_E_Incongruent, FZ_po_E_Incongruent, FZ_pr_T_Incongruent, FZ_po_T_Incongruent, FZ_pr_R_Incongruent, FZ_po_R_Incongruent)
longformat.FZ.incongruent.df <- melt(FZ.incongruent.df, id = "time", variable.name = "time")

ggplot(longformat.FZ.incongruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Incongruent Flanker ERP at FZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#FCZ Congruent Data
FCZ.congruent.df <- data.frame(time, FCZ_pr_E_Congruent, FCZ_po_E_Congruent, FCZ_pr_T_Congruent, FCZ_po_T_Congruent, FCZ_pr_R_Congruent, FCZ_po_R_Congruent)
longformat.FCZ.congruent.df <- melt(FCZ.congruent.df, id = "time", variable.name = "time")

ggplot(longformat.FCZ.congruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Congruent Flanker ERP at FCZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#FCZ Incongruent Data
FCZ.incongruent.df <- data.frame(time, FCZ_pr_E_Incongruent, FCZ_po_E_Incongruent, FCZ_pr_T_Incongruent, FCZ_po_T_Incongruent, FCZ_pr_R_Incongruent, FCZ_po_R_Incongruent)
longformat.FCZ.incongruent.df <- melt(FCZ.incongruent.df, id = "time", variable.name = "time")

ggplot(longformat.FCZ.incongruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Incongruent Flanker ERP at FCZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#CZ Congruent Data
CZ.congruent.df <- data.frame(time, CZ_pr_E_Congruent, CZ_po_E_Congruent, CZ_pr_T_Congruent, CZ_po_T_Congruent, CZ_pr_R_Congruent, CZ_po_R_Congruent)
longformat.CZ.congruent.df <- melt(CZ.congruent.df, id = "time", variable.name = "time")

ggplot(longformat.CZ.congruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Congruent Flanker ERP at CZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#CZ Incongruent Data
CZ.incongruent.df <- data.frame(time, CZ_pr_E_Incongruent, CZ_po_E_Incongruent, CZ_pr_T_Incongruent, CZ_po_T_Incongruent, CZ_pr_R_Incongruent, CZ_po_R_Incongruent)
longformat.CZ.incongruent.df <- melt(CZ.incongruent.df, id = "time", variable.name = "time")


ggplot(longformat.CZ.incongruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Incongruent Flanker ERP at CZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#CPZ Congruent Data
CPZ.congruent.df <- data.frame(time, CPZ_pr_E_Congruent, CPZ_po_E_Congruent, CPZ_pr_T_Congruent, CPZ_po_T_Congruent, CPZ_pr_R_Congruent, CPZ_po_R_Congruent)
longformat.CPZ.congruent.df <- melt(CPZ.congruent.df, id = "time", variable.name = "time")

ggplot(longformat.CPZ.congruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-8)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Congruent Flanker ERP at CPZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#CPZ Incongruent Data
CPZ.incongruent.df <- data.frame(time, CPZ_pr_E_Incongruent, CPZ_po_E_Incongruent, CPZ_pr_T_Incongruent, CPZ_po_T_Incongruent, CPZ_pr_R_Incongruent, CPZ_po_R_Incongruent)
longformat.CPZ.incongruent.df <- melt(CPZ.incongruent.df, id = "time", variable.name = "time")

ggplot(longformat.CPZ.incongruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(14,-8)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Incongruent Flanker ERP at CPZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")


#PZ Congruent Data
PZ.congruent.df <- data.frame(time, PZ_pr_E_Congruent, PZ_po_E_Congruent, PZ_pr_T_Congruent, PZ_po_T_Congruent, PZ_pr_R_Congruent, PZ_po_R_Congruent)
longformat.PZ.congruent.df <- melt(PZ.congruent.df, id = "time", variable.name = "time")

ggplot(longformat.PZ.congruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Congruent Flanker ERP at PZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#PZ Incongruent Data
PZ.incongruent.df <- data.frame(time, PZ_pr_E_Incongruent, PZ_po_E_Incongruent, PZ_pr_T_Incongruent, PZ_po_T_Incongruent, PZ_pr_R_Incongruent, PZ_po_R_Incongruent)
longformat.PZ.incongruent.df <- melt(PZ.incongruent.df, id = "time", variable.name = "time")

ggplot(longformat.PZ.incongruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Incongruent Flanker ERP at PZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#POZ Congruent Data
POZ.congruent.df <- data.frame(time, POZ_pr_E_Congruent, POZ_po_E_Congruent, POZ_pr_T_Congruent, POZ_po_T_Congruent, POZ_pr_R_Congruent, POZ_po_R_Congruent)
longformat.POZ.congruent.df <- melt(POZ.congruent.df, id = "time", variable.name = "time")

ggplot(longformat.POZ.congruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Congruent Flanker ERP at POZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")

#POZ Incongruent Data
POZ.incongruent.df <- data.frame(time, POZ_pr_E_Incongruent, POZ_po_E_Incongruent, POZ_pr_T_Incongruent, POZ_po_T_Incongruent, POZ_pr_R_Incongruent, POZ_po_R_Incongruent)
longformat.POZ.incongruent.df <- melt(POZ.incongruent.df, id = "time", variable.name = "time")

ggplot(longformat.POZ.incongruent.df, aes(x=time, y=value, color = variable))+
  geom_line()+
  ylim(12,-12)+
  xlim(-200, 1000)+
  xlab("Time")+
  ylab("ERP Amplitude")+
  ggtitle("Incongruent Flanker ERP at POZ Site")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_brewer(palette = "Paired")


















