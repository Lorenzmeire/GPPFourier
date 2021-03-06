% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GPPFourier.R
\name{GPPFourier_t}
\alias{GPPFourier_t}
\title{Calculate GPP(t) from by complex demodulation of O2 time series}
\usage{
GPPFourier_t(x, dt = NULL, units = c("days", "hours", "mins", "secs"),
  Nfilt = NULL, nf = 1, NLowPass = NULL, fDL = NULL,
  MAcorrect = FALSE, phi = 51.176, lambda = 4.326, ...)
}
\arguments{
\item{x}{Regularly sampled O2 time series. x can be a dataframe with time (POSIXt) in first column and O2 concentrations in second column
or a vector of concentrations sampled with time step = dt}

\item{dt}{Sampling time step. Either a difftime object or a numerical value. 
When \code{dt} is given as a numerical value, the unit is assumed to be
days, unless \code{units} is provided. Can be omitted when \code{x} is a data frame, then \code{dt} is calculated from the time spacing between the first two samples.}

\item{units}{Unit of sampling time step.}

\item{Nfilt}{Moving average filter width for detrending time series. See \code{\link{GPPFourierPreprocess}}}

\item{nf}{Number of iterative applications of moving average filter, to reduce filter width}

\item{NLowPass}{Moving average filter width for low pass filtering demodulated O2 series. See \code{\link{demod}}}

\item{fDL}{Optional. Relative fraction of light hours during the day. When \code{x} is a data frame, and no value for fDL is 
provided, fDL is calculated with \code{\link{fDLfun}}}

\item{MAcorrect}{correction factor for moving average filter}

\item{phi}{Latitude}

\item{lambda}{Longitude}

\item{...}{Other parameters to be passed to GPPFourierPreprocess}
}
\value{
Data frame with time and GPPt column.
}
\description{
Calculate GPP(t) from by complex demodulation of O2 time series
}
\examples{
# Calculate GPP(t) by complex demodulation of simulated water column time series
# More examples in vignette("GPPFourier").

dt <- as.numeric(difftime(watercolumn$time[2], watercolumn$time[1] , units="days"))
Nfilt <- 1/dt
GPPt <- GPPFourier_t(watercolumn[,c("time", "O2")], 
                        dt=dt, 
                        units="days", 
                        Detrend=TRUE, 
                        filter=TRUE, 
                        Nfilt=Nfilt, 
                        NLowPass=Nfilt, 
                        fDL=NULL, 
                        circular=FALSE, 
                        sides=2, 
                        nf=1)


par(mfrow=c(2,1), cex=1.2)
plot(watercolumn[,c("time", "O2")], type="l", xlab="", ylab=expression(paste(O[2], " [", mu, "M]")))
title(main="Water column")
plot(GPPt, type="l", lwd=3, ylim=c(0,30), xlab="", ylab="GPP")
lines(watercolumn[,c("time","GPP")], col="red")
legend("topleft", 
         lty=1, 
         col=c("red", "black"), 
         legend=c( "Simulated GPP", expression(paste("Complex demodulated ", O[2], " series"))), 
         bty="n")


}
\references{
Cox et al (2017). Tune in on 11.57 muHz and listen to primary production. Biogeosciences Discussions. doi:10.5194/bg-2017-81
}
\seealso{
\code{\link{GPPFourierPreprocess}}, \code{\link{GPPFourier}}, \code{\link{WindowGPPFourier.gts}}, \code{\link{SunRiseSet}}
}
