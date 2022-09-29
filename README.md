# LAB. 5 Package

<!-- badges: start -->
[![R-CMD-check](https://github.com/arashHaratian/Advanced-R-Assignment5/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/arashHaratian/Advanced-R-Assignment5/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->


_This is the repo for 5th lab assignment for Advanced R Programming_

To install the package, use the following command in your R session:

```r
# You have to install devtools before executing the command
# install.packages("devtools")
devtools::install_github("arashHaratian/Advanced-R-Assignment5",force=TRUE, build_vignettes = TRUE)
library(lab5package)
```

To run the shiny app, use the following command:
> ***NB: PLEASE BE AWARE THAT IT MAY TAKE TIME TO QUERY THE DATA***

```r
shiny::runGitHub(repo = "Advanced-R-Assignment5",username = "arashHaratian", subdir = "R")
```

