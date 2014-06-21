library(caret)
use <- c('roll_belt','pitch_belt','yaw_belt','total_accel_belt',
         'roll_dumbbell','pitch_dumbbell','yaw_dumbbell','total_accel_dumbbell',#)#, #
         'roll_arm','pitch_arm','yaw_arm','total_accel_arm',#) 
          'roll_forearm','pitch_forearm','yaw_forearm','total_accel_forearm',#
          'user_name')
keep <- c(use,'classe')
setwd('~/School//Coursera//DataScience//PML//PracticalMachineLearning/')
training <- read.csv('pml-training.csv')
training <- training[keep]
testing <- read.csv('pml-testing.csv')
partition <- createDataPartition(y=training$classe,p=.3,list=F)
train1 <- training[partition,]
test1 <- training[-partition,]
timestamp()
modFit <- train(classe ~ roll_belt + pitch_belt + yaw_belt + total_accel_belt,# +
                  #roll_dumbbell+pitch_dumbbell+yaw_dumbbell + total_accel_dumbbell + 
                  #roll_arm + pitch_arm + yaw_arm + total_accel_arm + 
                  #roll_forearm + pitch_forearm + yaw_forearm + total_accel_forearm, 
                data=train1,method='rf')
test1$predicted <- predict(modFit,test1)
test1$correct <- test1$classe==test1$predicted
confusionMatrix(test1$predicted,test1$classe)
timestamp()