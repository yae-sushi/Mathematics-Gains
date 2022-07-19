# Mathematics-Gains

Understanding impact of school and classroom-level factors on student performance. A demonstration of performing multi-level modeling in R, through the use of both lmer and STAN. (STAN is a higher level statistical inference language based on C++, and is used here to create a Bayesian model.)

Original .csv data file and STAN model file included with R Markdown file, as well as a knitted PDF version of the Rmd.

## Data Dictionary

1990 observations (students) of 12 variables:

- sex: gender, with 0=boy, 1=girl
- minority: binary indicator, with 0=nonminority, 1=minority
- mathkind: math score in kindergarten
- mathgain: gain in match achievement score from spring of kindergarten to spring of first grade
- ses: student socioeconomic status
- yearstea: first-grade teacher’s years of teaching experience
- mathknow: first-grade teacher’s mathematics content knowledge, based on scale of 30 items
- housepov: percentage of households in the neighborhood of the school below the poverty level
- mathprep: first-grade teacher’s mathematics preparation: number of mathematics content and methods courses
- classid: classroom ID number
- schoolid: school ID number
- childid: student ID number

## Model

Comprised of three levels: students, classrooms, and schools. 

- Level 1 - Students, denoted by i
- Level 2 - Classrooms, denoted by j
- Level 3 - Schools, denoted by k

![image](https://user-images.githubusercontent.com/64810654/179855539-9a7461cd-efcf-47bc-88d6-79775469070e.png)

- Alpha_j represents average estimated math gain effects for classroom j.
- Beta_k represents average estimated math gain effects for school k.

## Takeaways

- There are modelable, significant, varying classroom and school-level effects on students' individual math gains. We can also see how much these effects vary as a whole by examining the standard deviation of random effects.
- The main advantage of using a multi-level approach is that data can be partially pooled. It eliminates the need to create a separate model (totally unpooled) for each classroom and school, or a separate dummy variable for each in one big model (totally pooled). This is especially helpful when data is sparse for some cross sections (ie. few children in one class, few children in one school). It also makes modeling overall more concise and feature engineering less work, which is a relief when there are 312 classrooms and 107 schools.
- Although it requires some training to use, STAN is exceptionally useful if there is prior knowledge that can be put into the model (as priors, hehe) and runs relatively quickly. Four MCMC with 2000 iterations each took less than 3 minutes to perform.
