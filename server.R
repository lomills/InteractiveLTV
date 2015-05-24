library(shiny)
library(ggplot2)
library(plyr)
source("multiplotFunction.R")

load("data/terminations_macro.Rdata")

shinyServer(
        function(input, output) {

        output$plot <- renderPlot({
                knots <- seq(input$begLTV,input$endLTV,input$ltvBucketIncrements)
                dat$mltv_group <- cut(dat$mkt_cltv,breaks=knots)
                mltv_profile <- ddply(dat, .(mltv_group), summarise, 
                                      default_rate = 100*mean(default),
                                      prepay_rate = 100*mean(prepay))

                 num <- length(mltv_profile$mltv_group)
                 pts <- seq(1,num,floor(num/9))
                 mltv_labels <- mltv_profile$mltv_group[pts]

                 q1 <- qplot(mltv_profile$mltv_group,mltv_profile$default_rate,size=1.5,main="Default Rate by MLTV Buckets")
                 q1 <- q1 + stat_smooth(aes(group=1),method="loess",size=1.5,se=FALSE) + theme_bw() + guides(size=FALSE)
                 q1 <- q1 + scale_y_continuous(name="Default Rate (%)",limits=c(-10, 100)) + scale_x_discrete(name="MLTV Bucket",breaks=mltv_labels)
                 
                 q2 <- qplot(mltv_profile$mltv_group,mltv_profile$prepay_rate,size=1.5,main="Prepayment Rate by MLTV Buckets")
                 q2 <- q2 + stat_smooth(aes(group=1),method="loess",size=1.5,se=FALSE) + theme_bw() + guides(size=FALSE)
                 q2 <- q2 + scale_y_continuous(name="Prepayment Rate (%)",limits=c(-10, 100)) + scale_x_discrete(name="MLTV Bucket",breaks=mltv_labels)
                 
                 multiplot(q1, q2, cols=1)
                                 

                },height=600)
                        
        })
        
        
        
