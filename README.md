# Fatality Analysis Reporting System (FARS)

Danny Park   
GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007   

[![Build Status](https://travis-ci.org/dannyjwpark/FARS.svg?branch=master)](https://app.travis-ci.com/dannyjwpark/SoccerHeatTracker.svg?branch=main)


## Package Description

`FARS` package reads and plots Fatality Analysis Reporting System (FARS) data 
from the [National Highway Traffic Safety Administration](https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars).

[FARS](https://en.wikipedia.org/wiki/Fatality_Analysis_Reporting_System) is a nationwide census, providing the American public yearly data, regarding fatal injuries suffered in motor vehicle traffic crashes.


## Load Packages

```{r}
library(fars)
library(maps)
```


## Included data

Data files included within the package are:

```{r}
list.files(system.file("extdata", package = "fars"))
```


## Package Functions

### Function `make_filename`

This function returns file name and path to the data files:

```{r}
yr <- 2015
make_filename(yr)
```

### Function `fars_read_years`

Ancillary function used by `fars_summarize_years`

```{r}
fars_read_years(2013)
```

## Data Source

Data originated from: US National Highway Traffic Safety
Administration's [Fatality Analysis Reporting
System](https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars),


## Reference Links:
* [Writing an R package from scratch](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/)    
* [Github: roxygen2](https://github.com/klutometis/roxygen#roxygen2)   
* [Common `roxygen2` tags](https://bookdown.org/rdpeng/RProgDA/documentation.html#common-roxygen2-tags)
* [Text formatting reference sheet](https://cran.r-project.org/web/packages/roxygen2/vignettes/formatting.html)
* [Writing R Extensions](https://cran.r-project.org/doc/manuals/R-exts.html#Creating-R-packages)
* [Travis: Building R packages](https://docs.travis-ci.com/user/languages/r/)
* [Vignettes: long-form documentation](http://r-pkgs.had.co.nz/vignettes.html)
* [Package Development with devtools Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/devtools-cheatsheet.pdf)
* [Customizing Package Build Options](https://support.rstudio.com/hc/en-us/articles/200486518-Customizing-Package-Build-Options)
* [Testing packages](http://r-pkgs.had.co.nz/tests.html)
