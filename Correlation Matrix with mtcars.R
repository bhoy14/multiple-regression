#creating a correlation matrix from this website: http://www.sthda.com/english/wiki/correlation-matrix-a-quick-start-guide-to-analyze-format-and-visualize-a-correlation-matrix-using-r-software

#load from built-in R dataset mtcars
data("mtcars")
my_data <- mtcars[ , c(1,3,4,5,6,7)]

#compute correlation matrix, round to 2 decimal places
res <- cor(my_data)
round(res, 2)

#note: if missing values, use this code: cor(my_data, use = "complete.obs")

#compute the correlation matrix with significance levels

#to do this, we need the rcorr() function in the Hmisc package
#recall, the p-values are the significance values of the correlations. 
#A p-value is a measure of the probability that an observed difference could have occurred just by random chance.
#The lower the p-value, the greater the statistical significance of the observed difference.

library("Hmisc") 
res2 <- rcorr(as.matrix(my_data))
res2

#visualizing the correlation matrix in a correlogram
#we need the function corrplot() from the corrplot package

library("corrplot")

corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)

#Positive correlations are displayed in blue and negative correlations in red color. 
#Color intensity and the size of the circle are proportional to the correlation coefficients. 
#In the right side of the correlogram, the legend color shows the correlation coefficients and the corresponding colors.

#correlogram combined with significance test
#correlations below a certain threshold are left blank

corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.01, insig = "blank")

#switching to the "ellipse" method of correlogram
corrplot(res2$r, type="upper", order="hclust", method = "ellipse",
        p.mat = res2$P, sig.level = 0.01, insig = "blank")
