# Codebook
---
## Variables

| Variable | Description | Values |
|---------------------|----------------------------------------------------------|--------------------------------------------------------------------------|
| *Subject_ID* | Id for each subject of the experiment | 1 to 30 |
| *Activity* | Activity performed | Walking, Walking_Upstairs, Walking_Downstairs, Sittins, Standing, Laying |
| *Signal_Domain* | Domain signals capture by devices used in the experiment | Time, Frequency |
| *Acceleration_Signal* | Acceleration motion signals | Body, Gravity |
| *Device* | Device used to capture the measurements | Accelerometer, Gyroscope |
| *Measurement* | Estimated value from captured signals | Mean, StandardDeviation |
| *Axis* | Axis where signal was captured | X,Y,Z,NA |
| *Magnitude* | Magnitude Signal | Magnitude, NA |
| *Jerk* | Jerk Signal | Jerk, NA |
| *Average_Value* | Average value of the measurements | Calculated based on the values of each variable of the original dataset |

---
## Data Info
### Summary

    > summary(dt)
	   Subject_ID     Activity         Signal_Domain      Acceleration_Signal    Device         
	 Min.   : 1.0   Length:11880       Length:11880       Length:11880        Length:11880      
	 1st Qu.: 8.0   Class :character   Class :character   Class :character    Class :character  
	 Median :15.5   Mode  :character   Mode  :character   Mode  :character    Mode  :character  
	 Mean   :15.5                                                                               
	 3rd Qu.:23.0                                                                               
	 Max.   :30.0                                                                               
	 Measurement            Axis            Magnitude             Jerk           Average_Value     
	 Length:11880       Length:11880       Length:11880       Length:11880       Min.   :-0.99767  
	 Class :character   Class :character   Class :character   Class :character   1st Qu.:-0.96205  
	 Mode  :character   Mode  :character   Mode  :character   Mode  :character   Median :-0.46989  
	                                                                             Mean   :-0.48436  
	                                                                             3rd Qu.:-0.07836  
	                                                                             Max.   : 0.97451 
### Head
	> head(dt)
	  Subject_ID Activity Signal_Domain Acceleration_Signal        Device Measurement Axis Magnitude Jerk
	1          1   LAYING          Time                Body Accelerometer        Mean    X      <NA> <NA>
	2          2   LAYING          Time                Body Accelerometer        Mean    X      <NA> <NA>
	3          3   LAYING          Time                Body Accelerometer        Mean    X      <NA> <NA>
	4          4   LAYING          Time                Body Accelerometer        Mean    X      <NA> <NA>
	5          5   LAYING          Time                Body Accelerometer        Mean    X      <NA> <NA>
	6          6   LAYING          Time                Body Accelerometer        Mean    X      <NA> <NA>
	  Average_Value
	1     0.2215982
	2     0.2813734
	3     0.2755169
	4     0.2635592
	5     0.2783343
	6     0.2486565

### Tail
	> tail(dt)
      Subject_ID         Activity Signal_Domain Acceleration_Signal    Device       Measurement Axis
	11875         25 WALKING_UPSTAIRS     Frequency                Body Gyroscope StandardDeviation <NA>
	11876         26 WALKING_UPSTAIRS     Frequency                Body Gyroscope StandardDeviation <NA>
	11877         27 WALKING_UPSTAIRS     Frequency                Body Gyroscope StandardDeviation <NA>
	11878         28 WALKING_UPSTAIRS     Frequency                Body Gyroscope StandardDeviation <NA>
	11879         29 WALKING_UPSTAIRS     Frequency                Body Gyroscope StandardDeviation <NA>
	11880         30 WALKING_UPSTAIRS     Frequency                Body Gyroscope StandardDeviation <NA>
	      Magnitude Jerk Average_Value
	11875 Magnitude Jerk    -0.8410610
	11876 Magnitude Jerk    -0.6698463
	11877 Magnitude Jerk    -0.7517143
	11878 Magnitude Jerk    -0.7048528
	11879 Magnitude Jerk    -0.7564642
	11880 Magnitude Jerk    -0.7913494