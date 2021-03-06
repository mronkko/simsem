library(simsem)
library(semTools)
library(OpenMx)

############################ Fitting growthCurveFit

data(myLongitudinalData)

growthCurveModel <- mxModel("Linear Growth Curve Model Matrix Specification", 
    mxData(
    	observed=myLongitudinalData, 
        type="raw"
    ),
    mxMatrix(
        type="Full",
        nrow=7, 
        ncol=7,
        free=F,
        values=c(0,0,0,0,0,1,0,
                 0,0,0,0,0,1,1,
                 0,0,0,0,0,1,2,
                 0,0,0,0,0,1,3,
                 0,0,0,0,0,1,4,
                 0,0,0,0,0,0,0,
                 0,0,0,0,0,0,0),
        byrow=TRUE,
        name="A"
    ),
    mxMatrix(
        type="Symm",
        nrow=7,
        ncol=7,
        free=c(T, F, F, F, F, F, F,
               F, T, F, F, F, F, F,
               F, F, T, F, F, F, F,
               F, F, F, T, F, F, F,
               F, F, F, F, T, F, F,
               F, F, F, F, F, T, T,
               F, F, F, F, F, T, T),
        values=c(0,0,0,0,0,  0,  0,
                 0,0,0,0,0,  0,  0,
                 0,0,0,0,0,  0,  0,
                 0,0,0,0,0,  0,  0,
                 0,0,0,0,0,  0,  0,
                 0,0,0,0,0,  1,0.5,
                 0,0,0,0,0,0.5,  1),
        labels=c("residual", NA, NA, NA, NA, NA, NA,
                 NA, "residual", NA, NA, NA, NA, NA,
                 NA, NA, "residual", NA, NA, NA, NA,
                 NA, NA, NA, "residual", NA, NA, NA,
                 NA, NA, NA, NA, "residual", NA, NA,
                 NA, NA, NA, NA, NA, "vari", "cov",
                 NA, NA, NA, NA, NA, "cov", "vars"),
        byrow= TRUE,
        name="S"
    ),
    mxMatrix(
        type="Full",
        nrow=5,
        ncol=7,
        free=F,
        values=c(1,0,0,0,0,0,0,
                 0,1,0,0,0,0,0,
                 0,0,1,0,0,0,0,
                 0,0,0,1,0,0,0,
                 0,0,0,0,1,0,0),
        byrow=T,
        name="F"
    ),
    mxMatrix(
    	type="Full",
    	nrow=1, 
    	ncol=7,
        values=c(0,0,0,0,0,1,1),
        free=c(F,F,F,F,F,T,T),
        labels=c(NA,NA,NA,NA,NA,"meani","means"),
        name="M"
    ),
    mxRAMObjective("A","S","F","M",
		dimnames = c(names(myLongitudinalData), "intercept", "slope"))
)
   
growthCurveFit <- mxRun(growthCurveModel, suppressWarnings=TRUE)
fitMeasuresMx(growthCurveFit)
growthCurveFitSim <- sim(10, growthCurveFit, n = 200)
summary(growthCurveFitSim)
