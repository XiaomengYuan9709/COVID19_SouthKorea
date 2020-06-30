# COVID19_SouthKorea

# Project Goals
Since the begining of COVID-19 outbreak in Jan, 2020, South Korea have put huge effort in containing the spread of the disease by deploying fast PCR testing and case tracing technology. Those public health policys have helped tremendously in reducing the daily new cases to a relatively low and stable level by mid April without having any lockdown enforced. 
The goal of this project is to identify the roles of spatio-temporal effects, and the effects of public health policies on the epidemic of COVID-19 in South Korea across different provinces and cities. The plan of the project includes phase 0 to 3 as illustrated below. 

## Phase 0 Data Collection
Extracting testing data and aggregated case counts from KCDC website. Now I have collected the data from Jan.30 to April.20.

## Phase 1 Data Visualization
Using sp and surveillance packages to construct a webpage to present the changes in reported COVID-19 cases across provinces and cities. Key public health policy changes will also be noted on the plots. The goal is to identify any unsual pattern associated with potential spatial, temporal, policy and other variables of interest so a hypothesis can be formed before entering the analysis stage. 

## Phase 2 Spatio-temopral analysis
Using hhh4 model to analyze aggregated counts data from Korea CDC daily reports of new cases of COVID-19. In this stage I will test and estimate the effects of spatial, temporal or policy variables. Different models (other than hhh4) might also be used depending on the need of the project. 

## Phase 3 Prediction 
With the model we built in phase2 we might also predict the future trend of the epidemic and get insight on the potential outcomes from different policy scenarios. 


# Data Resources
KOSIS http://kosis.kr/eng/

KCDC  https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030


# Method Resources
Applied Spatial Data Analysis with R https://ebookcentral.proquest.com/lib/ufl/reader.action?docID=1317550

SpatialPolygonsDataFrame https://rdrr.io/cran/sp/man/SpatialPolygonsDataFrame-class.html

Applied Spatial Data Analysis with R https://ebookcentral.proquest.com/lib/ufl/detail.action?docID=1317550
