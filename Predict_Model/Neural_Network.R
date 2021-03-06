rm(list=ls())

setwd("/Users/cpprhtn/Desktop/git_local/Obesity_prediction_project")
memory.size(22000)
library(MASS)
library(nnet)

read.csv("EDA/종속변수생성/b_10.csv",header = T,fileEncoding = "CP949") -> b_10
read.csv("EDA/종속변수생성/b_11.csv",header = T,fileEncoding = "CP949") -> b_11
read.csv("EDA/종속변수생성/b_12.csv",header = T,fileEncoding = "CP949") -> b_12
read.csv("EDA/종속변수생성/b_13.csv",header = T,fileEncoding = "CP949") -> b_13
read.csv("EDA/종속변수생성/b_14.csv",header = T,fileEncoding = "CP949") -> b_14
read.csv("EDA/종속변수생성/b_15.csv",header = T,fileEncoding = "CP949") -> b_15
read.csv("EDA/종속변수생성/b_16.csv",header = T,fileEncoding = "CP949") -> b_16
read.csv("EDA/종속변수생성/b_17.csv",header = T,fileEncoding = "CP949") -> b_17

busan = rbind(b_10,b_11,b_12,b_13,b_14,b_15,b_16,b_17)


read.csv("Predict_Model/input_columns.csv",header = T, sep = ',') -> input
read.csv("Predict_Model/output_multinomial.csv",header = T,sep=',') -> output
read.csv("Predict_Model/pre_output_nultinumial_random.csv",header = T,sep=',') -> pre_output
input_value = c(colnames(input))
output_value = c(colnames(output))
form = as.formula(paste(paste(output_value, collapse = '+'),'~',paste(input_value, collapse = '+')))
form
pre_value = c(colnames(pre_output))

tr.nnet = nnet(form, data = busan, size = 7)
p = predict(tr.nnet, busan, type = 'raw')
dimnames(p) = list(NULL,c(pre_output))
pred_obs = cbind(busan, p)
summary(p)

mean(pred_obs)

