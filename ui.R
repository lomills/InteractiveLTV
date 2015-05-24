shinyUI(navbarPage("PI Analytics",
   tabPanel("Plot",      

        titlePanel(
                "Prepayment and Default Rates by Mark-to-Market LTV (MLTV)"
                ),
        
        sidebarPanel(
                sliderInput('ltvBucketIncrements', h4('LTV Increments'), min=2, max=12, value=7, step=1),
                h6("Enter the increment between buckets"),
                br(),
     
                numericInput("begLTV", label = h4("Beginning LTV"), value = 0,min = 0,max = 240,step = 10),
                h6("Enter the beginning MLTV value for the plot"),
                br(),
                
                numericInput("endLTV", label = h4("Ending LTV"), value = 220,min=10,max=250,step=10),
                h6("Enter the ending MLTV value for plot"),
                br(),
                
                submitButton("Update Calculations and Plots"),
                h6("Update after changing entries"),
                br(),
                
                HTML('<a href="http://www.pianalytics.net/#!samples/c67q">PI Analytics</a></p>'), 
                img(src = "pilogo.png",height=60,width=108)
                
                ),
        
        mainPanel(
               plotOutput('plot')
)
),
 
       tabPanel("Discussion",
                
titlePanel("Prepayment and Default Rates by Mark-to-Market LTV (MLTV)", windowTitle="PI Analytics: Interactive LTV"),

strong("Data and Calculations:"), br(),              
                                
HTML('A full description of the loan level data can be found at <a href="http://www.freddiemac.com/news/finance/sf_loanlevel_dataset.html">Freddie Mac Loan Level Dataset</a></p>'),

p("The loans were originated during 1999-2013 with each year containing a sample of 
50 thousand loans.  We use the Freddie Sample loan files as of 2014:Q3.  
After excluding some loans with missing data, there were approximately 664 thousand loans in the dataset. 
Defaults are defined as REO disposition, zero-balance code 9, or Foreclosure Alternatives, zero-balance code 3.  
Prepayments are loans with zero-balance code 1."),
                
p("The original combined loan-to-value (LTV) is updated to a mark-to-market LTV with two updating functions.
First, the loan balance is amortized according to the standard mortgage amortization.  Here, we assumed
that the any second loan balance amortizes at the along the same schedule as the first loan.
Second, the updated the implied house value at loan orgination by the FHFA CBSA- and state-level, purchase-only, house-price-indices (HPI).  
If the loan record had a CBSA code, the CBSA HPI was used to update the house value.  If the CBSA code was not provided 
in the data, the state HPI was used fo update the house value."),

HTML('A full description of the CBSA and state level HPIs at <a href="http://www.fhfa.gov/DataTools/Downloads/Pages/House-Price-Index.aspx">FHFA House Price Indices</a></p>'),

p("Ater the mark-to-market LTVs are calculated for each loan, the loans are bucketed into groups 
defined by the user-inputted LTV increments.  For example, an LTV increment of 5 groups are loans into 
ranges of LTVs from (0,5], (5,10], (10,15],...  The beginning and ending LTVs in the plots 
are also controlled by user-input.  The accompanying default rate, # of defaulted loans / # loans, 
is computed for each LTV bucket and is expressed as a percent.   The same calculation is used 
to compute the prepayment rate.  A smooth curve is fit by the 'loess' function is shown (in blue) through the bucket-level rates."),

strong("Interpretation of Prepayment and Default Rates:"),
p("The prepayment and default rates should be interpreted as 'lifetime rates'.  The average loan age in this sample is about 4.5 years.  Therefore, 
a lifetime rate of 50% rate would imply about an annualized rate of about 14.3%, and a 
10% lifetime rate translates into about a 2.3% annual rate.  The homeowners' willingness-to-default 
  and ability-to-prepay are apparent in these plots.  As the amount of the loan increases 
  relative to the value of the house (i.e. the LTV rises), the willingness of the homeowners
  to default on their mortgages increases.  The default rate starts at virtually zero, but when
the house becomes 'under-water' with a LTV > 100, the default rate begins to ascend.  
  Similarly, the homeowners ability to prepay is intially flat, but begins to descend 
  as a LTVs rise above 100."),

HTML('<a href="http://www.pianalytics.net/#!samples/c67q">PI Analytics</a></p>'),
img(src = "pilogo.png",height=60,width=108)

)
)
)