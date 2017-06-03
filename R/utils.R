.take_poll <- function(n, plot = TRUE, return_values = FALSE, blue_prob = 0.529, jitter_factor = 1, cex=1.2, ...){
  bead_color <- sample(c("Blue","Red"), n, prob=c(blue_prob, 1-blue_prob), replace = TRUE)
  if(plot){
    cols <- ifelse(bead_color=="Blue", "#0072B2", "#D55E00")
    x <- jitter(ifelse(bead_color=="Blue", 1, 2), factor = jitter_factor)
    y <- stats::rnorm(n)
    plot(x,y, pch=21, bg=cols, xlim=c(0.5,2.5), xlab="", ylab="", xaxt="n", yaxt="n", cex = cex, bty = "n", ...)
    graphics::axis(side=3, at=c(1,2), labels = c("Blue", "Red"), tick=FALSE)
    }
  if(return_values) return(bead_color) 
}
