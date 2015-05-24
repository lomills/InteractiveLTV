Default and Prepayment Rates by Mark-to-Market LTV
========================================================
author: Len Mills
date: 5/24/2015

[An Interactive LTV Visualization](https://pianalytics.shinyapps.io/InteractiveLTV/)

Data Sources and Transformations
========================================================
<small>Raw data sources</small>
* <small>Mortgage loan-level data from [Freddie Mac Loan Level Dataset](http://www.freddiemac.com/news/finance/sf_loanlevel_dataset.html).  This is a sample dataset of 50K loans orginated in 1999-2013.</small>
* <small>CBSA and state level House Price indices from [FHFA HPI](http://www.fhfa.gov/DataTools/Downloads/Pages/House-Price-Index.aspx). </small>

<small>Original, combined LTV to a mark-to-market LTV</small>
* <small>Mortgage loan balance updated with scheduled amortization</small>
* <small>Property value updated with CBSA and state-level HPI since loan orgination.</small>
* <small>Mark-to-market LTV equals updated balance divided by updated house value.</small>


Summary of Dataset
========================================================
<small>The dataset contains four variables for each of the ~640 loans: </small>
* <small>two factor variables indicating whether the loan defaulted or prepaid.  Note that a loan may not have defaulted or prepaid.</small>
* <small>mark-to-market, combined loan-to-value ratio, expressed as percent and denoted as MLTV.</small>
* <small>MLTV group </small>




```r
cbind(length(dat$mkt_cltv),
  round(100*mean(dat$default),2),
  round(100*mean(dat$prepay),2),
  round(mean(dat$mkt_cltv),2))
```

```
       [,1] [,2] [,3]  [,4]
[1,] 663976 0.89 68.1 67.39
```

```r
dat$mltv_group <- cut(dat$mkt_cltv,breaks=seq(0,200,7))
```

Default/Prepay Rates by MLTV Group
========================================================

```r
mltv_profile <- ddply(dat, .(mltv_group), 
  summarise, default_rate = 100*mean(default),  prepay_rate = 
  100*mean(prepay))
```
    
An interactive version of this mark-to-market profile can be found at [An MLTV Profile Visualization](https://pianalytics.shinyapps.io/InteractiveLTV/).

***
![plot of chunk unnamed-chunk-4](interactiveLTVpresentation-figure/unnamed-chunk-4-1.png) 

Interpretation of Results
========================================================
* <small>The prepayment and default rates should be interpreted as 'lifetime rates'.  The average loan age in this sample is about 4.5 years.  Therefore, a lifetime rate of 50% rate would imply about an annualized rate of about 14.3%, and a 10% lifetime rate translates into about a 2.3% annual rate. </small>
* <small>The homeowners' willingness-to-default 
  and ability-to-prepay are apparent in these plots.  As the amount of the loan increases 
  relative to the value of the house (i.e. the LTV rises), the willingness of the homeowners  to default on their mortgages increases.  The default rate starts at virtually zero, but when
the house becomes 'under-water' with a LTV > 100, the default rate begins to ascend. Similarly, the homeowners ability to prepay is intially flat, but begins to descend as a LTVs rise above 100. </small>
