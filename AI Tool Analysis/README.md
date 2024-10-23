# AI Tool Analysis

## Overview
This data analysis aims plans to provide answers and insights to assist a company in deciding whether entering 
utilizing this technology is worth the risk or not by finding different patterns within AI products and tools.

# WiDS Datathon++ 2024 University Challenge

## Team Members
- Tiffany Le
- Ryan Shihabi
<br></br>


## Introduction
Our model aims to solve two questions: 
1) Can technology commodity prices be correlated to the recent mentions of AI?
2) What types of ML tools are being developed?
The data was retrieved via transcript collection, keyword extraction, and Kaggle ([Artificial Intelligence Tools 2023](https://www.kaggle.com/datasets/muhammadtalhaawan/ai-5000-tools-2023)). Tiffany's analysis focused on the different types of ML tools that are being developed and their pricing cost and frequency. The goal of this analysis is to inform companies that are considering investing or entering the AI market.

## Methods
#### Data Preparation
Preparation began with dropping all missing values from the predictors we included in our model (minus charge amount). We decided not to fill these in, as there wouldn’t be a significant loss in data. To further this analysis, we performed feature engineering by extracting the charge frequency and amount. We assumed that the product was free for all of the missing values in the charge amount variable.

#### Clustering Model: Truncated SVD & K-Means
One-hot encoding of the categorical predictors performed preprocessing.
We constructed a PCA model using Truncated SVD, selecting relevant parameters to optimize performance, and then put it into a pipeline with the preprocessing. Following this, we built a K-Means model using 5 PCs. The cluster's performance was evaluated using a Silhouette Score.

#### Predictive Model: Random Forest Regressor
We built a Random Forest Regressor Model with Random Search CV to predict the amount that a company should charge given their characteristics.

## Results
Our K-Means model performed well and clustered with a 0.713. We were able to notice that there were about 7 prominent clusters or types of AI tools found in the industry. Our Random Forest Regressor Model, over all, performed relatively poorly with an average of ~15,000 MSE. That said, the Random Forest Classifier Model performed much better. It performed with a performance metric average of about 0.85 or 85%. 

## Discussion
We learned the importance of data preparation and model selection from performing these analyses. Data cleaning (handling missing values/outliers and text clean-up), feature engineering, and model selection are all important elements for generating accurate predictions. Beyond these general topics, we found ways to improve our model uniquely, such as imputing values given data from an individual’s region or model configuration using parameters.
<br></br>


## Acknowledgements
We would like to acknowledge Ben Labaschin for his valuable guidance throughout this challenge. 


