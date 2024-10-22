# Grocery Store Discount Detection
## Overview
Companies have no way of verifying if their discounts are in circulation. Providing discounts at unscheduled times can cause revenue loss for companies. 
Our proposed solution is to create an object detection model capable of locating product discounts and a mobile app to communicate the model's findings 
with the product's company. We are the first open-source dataset and model for grocery store discounts allowing for a new understanding of how object detection models interpret the world.

View our published poster [here](https://blogs.chapman.edu/gci/2023/05/09/an-application-for-detecting-grocery-store-discounts/)

## Team Members
* Matthew Favela
* Tiffany Le
* Hunter Peasley
* Caden Goodwin
* Ethan Santana
* Ryan Shihabi

## Introduction
Object detection is a method of computer vision used to identify objects in an image or video. An object detection model can be taught to identify certain objects given labeled data. 
Drawing a bounded box around the objects you want to identify is a method of labeling. No model publicly exists for detecting grocery store discounts, giving us no basis for testing the performance of the model. 
Given enough data, an object detection model will be able to identify classifications of a grocery store discount.

## Methods

* Build an open-source image dataset from scratch
    * Capture video footage of grocery stores with a mobile device
    * Label the discounts found in the captured footage
* Train and evaluate the model
* Repeat above steps to improve accuracy of model
* Create a web server to host the model on the internet
* Create an app that allows users to upload images to the model web server

## Conclusion
* An model capable of detecting grocery store discounts with a 95% precision and recall
* The first open-source dataset for grocery store discounts
* New benchmark data to test object detection models

## Acknowledgments
* Zahra Askarzadeh
* Dr. Michael J. Campbell
* Dr. Salman Jahani
