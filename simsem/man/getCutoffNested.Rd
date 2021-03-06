\name{getCutoffNested}
\alias{getCutoffNested}
\title{
	Find fit indices cutoff for nested model comparison given a priori alpha level
}
\description{
	Extract fit indices information from the simulation of parent and nested models and getCutoff of fit indices given a priori alpha level
}
\usage{
getCutoffNested(nested, parent, alpha = 0.05, usedFit = NULL, nVal = NULL, 
	pmMCARval = NULL, pmMARval = NULL, df = 0)
}
\arguments{
  \item{nested}{
	\code{\linkS4class{SimResult}} that saves the analysis results of nested model from multiple replications
}
  \item{parent}{
	\code{\linkS4class{SimResult}} that saves the analysis results of parent model from multiple replications
}
  \item{alpha}{
	A priori alpha level
}
  \item{usedFit}{
	Vector of names of fit indices that researchers wish to getCutoffs from. The default is to getCutoffs of all fit indices.
}
  \item{nVal}{
	The sample size value that researchers wish to find the fit indices cutoffs from.
}
  \item{pmMCARval}{
	The percent missing completely at random value that researchers wish to find the fit indices cutoffs from.
}
  \item{pmMARval}{
	The percent missing at random value that researchers wish to find the fit indices cutoffs from.
}
  \item{df}{
	The degree of freedom used in spline method in predicting the fit indices by the predictors. If \code{df} is 0, the spline method will not be applied.
}
}
\value{
	One-tailed cutoffs of several fit indices with a priori alpha level 
}
\author{
    Sunthud Pornprasertmanit (Texas Tech University; \email{sunthud.pornprasertmanit@ttu.edu})
}
\seealso{
	\code{\linkS4class{SimResult}} for a detail of simResult
	\code{\link{getCutoff}} for a detail of finding cutoffs for absolute fit
}
\examples{
\dontrun{
# Nested Model
loading.null <- matrix(0, 6, 1)
loading.null[1:6, 1] <- NA
LY.NULL <- bind(loading.null, 0.7)
RPS.NULL <- binds(diag(1))

error.cor.mis <- matrix("rnorm(1, 0, 0.1)", 6, 6)
diag(error.cor.mis) <- 1
RTE <- binds(diag(6), misspec=error.cor.mis)
CFA.Model.NULL <- model(LY = LY.NULL, RPS = RPS.NULL, RTE = RTE, modelType="CFA")

# Parent Model
loading.alt <- matrix(0, 6, 2)
loading.alt[1:3, 1] <- NA
loading.alt[4:6, 2] <- NA
LY.ALT <- bind(loading.alt, 0.7)
latent.cor.alt <- matrix(NA, 2, 2)
diag(latent.cor.alt) <- 1
RPS.ALT <- binds(latent.cor.alt, "runif(1, 0.7, 0.9)")
CFA.Model.ALT <- model(LY = LY.ALT, RPS = RPS.ALT, RTE = RTE, modelType="CFA")

# The actual number of replications should be greater than 10.
Output.NULL.NULL <- sim(10, n=500, model=CFA.Model.NULL, generate=CFA.Model.NULL)
Output.NULL.ALT <- sim(10, n=500, model=CFA.Model.ALT, generate=CFA.Model.NULL)

# Find the fix index cutoff from the sampling distribution of the difference
# in fit index of nested models where the alpha is 0.05.
getCutoffNested(Output.NULL.NULL, Output.NULL.ALT, alpha=0.05)
}
}
