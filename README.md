Competition Details
#-------------------------------------------------------------------
Test your analytics skills by predicting which New York Times blog articles will be the most popular


What makes online news articles popular?

Newspapers and online news aggregators like Google News need to understand which news articles will be the most popular, so that they can prioritize the order in which stories appear. In this competition, you will predict the popularity of a set of New York Times blog articles from the time period September 2014-December 2014.

The following screenshot shows an example of the New York Times technology blog "Bits" homepage:

New York Times Blog Image

Many blog articles are published each day, and the New York Times has to decide which articles should be featured. In this competition, we challenge you to develop an analytics model that will help the New York Times understand the features of a blog post that make it popular.

To download the data and learn how this competition works, please be sure to read the "Data" page, as well as the "Evaluation" page, which can both be found in the panel on the left.
#---------------------------------------------------------------
Data Files

File Name	Available Formats
NYTimesBlogTest	.csv (681.22 kb)
NYTimesBlogTrain	.csv (2.29 mb)
SampleSubmission	.csv (42.03 kb)

File Descriptions

The data provided for this competition is split into two files:

NYTimesBlogTrain.csv = the training data set. It consists of 6532 articles.
NYTimesBlogTest.csv = the testing data set. It consists of 1870 articles.  
We have also provided a sample submission file, SampleSubmission.csv. This file gives an example of the format of submission files (see the Evaluation page for more information). The data for this competition comes from the New York Times website.

Variable Descriptions

The dependent variable in this problem is the variable Popular, which labels if an article had 25 or more comments in its online comment section (equal to 1 if it did, and 0 if it did not). The dependent variable is provided in the training data set, but not the testing dataset. This is an important difference from what you are used to - you will not be able to see how well your model does on the test set until you make a submission on Kaggle.

The independent variables consist of 8 pieces of article data available at the time of publication, and a unique identifier:

NewsDesk = the New York Times desk that produced the story (Business, Culture, Foreign, etc.)
SectionName = the section the article appeared in (Opinion, Arts, Technology, etc.)
SubsectionName = the subsection the article appeared in (Education, Small Business, Room for Debate, etc.)
Headline = the title of the article
Snippet = a small portion of the article text
Abstract = a summary of the blog article, written by the New York Times
WordCount = the number of words in the article
PubDate = the publication date, in the format "Year-Month-Day Hour:Minute:Second"
UniqueID = a unique identifier for each article