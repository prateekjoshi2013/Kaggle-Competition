train=read.csv("NYTimesBlogTrain.csv", stringsAsFactors=FALSE)
test=read.csv("NYTimesBlogTest.csv", stringsAsFactors=FALSE)
train$NewsDesk=as.factor(train$NewsDesk)
train$SectionName=as.factor(train$SectionName)
train$SubsectionName=as.factor(train$SubsectionName)

test$SubsectionName=as.factor(test$SubsectionName)

test$SectionName=as.factor(test$SectionName)

test$NewsDesk=as.factor(test$NewsDesk)
test$PubDate = strptime(test$PubDate, "%Y-%m-%d %H:%M:%S")
train$PubDate = strptime(train$PubDate, "%Y-%m-%d %H:%M:%S")
train$Weekday = train$PubDate$wday
test$Weekday = test$PubDate$wday
 

#-------------for headlines ---------------
CorpusHeadline = Corpus(VectorSource(c(train$Headline,test$Headline)))
CorpusHeadline = tm_map(CorpusHeadline, tolower)
CorpusHeadline = tm_map(CorpusHeadline, PlainTextDocument)
CorpusHeadline = tm_map(CorpusHeadline, removePunctuation)
CorpusHeadline = tm_map(CorpusHeadline, removeWords, stopwords("english"))
CorpusHeadline = tm_map(CorpusHeadline, stemDocument,"english")
dtm = DocumentTermMatrix(CorpusHeadline)
sparse = removeSparseTerms(dtm, 0.95)
colnames(sparse) = paste0("H", colnames(sparse))

HeadlineWords = as.data.frame(as.matrix(sparse))
colnames(HeadlineWords) = make.names(colnames(HeadlineWords))


HeadTrain = head(HeadlineWords, nrow(train))


HeadTest = tail(HeadlineWords, nrow(test))
#-----------for Snip-----------------------------

CorpusSnip = Corpus(VectorSource(c(train$Snippet,test$Snippet)))
CorpusSnip = tm_map(CorpusSnip, tolower)
CorpusSnip = tm_map(CorpusSnip, PlainTextDocument)
CorpusSnip = tm_map(CorpusSnip, removePunctuation)
CorpusSnip = tm_map(CorpusSnip, removeWords, stopwords("english"))
CorpusSnip = tm_map(CorpusSnip, stemDocument,"english")
dtm = DocumentTermMatrix(CorpusSnip)
sparse = removeSparseTerms(dtm, 0.95)
colnames(sparse) = paste0("S", colnames(sparse))
SnipWords = as.data.frame(as.matrix(sparse))
colnames(SnipWords) = make.names(colnames(SnipWords))


SnipTrain = head(SnipWords, nrow(train))


SnipTest = tail(SnipWords, nrow(test))



#--------------for abstract--------------------------------


CorpusAbs = Corpus(VectorSource(c(train$Abstract,test$Abstract)))
CorpusAbs = tm_map(CorpusAbs, tolower)
CorpusAbs = tm_map(CorpusAbs, PlainTextDocument)
CorpusAbs = tm_map(CorpusAbs, removePunctuation)
CorpusAbs = tm_map(CorpusAbs, removeWords, stopwords("english"))
CorpusAbs = tm_map(CorpusAbs, stemDocument,"english")
dtm = DocumentTermMatrix(CorpusAbs)
sparse = removeSparseTerms(dtm, 0.95)
colnames(sparse) = paste0("A", colnames(sparse))
AbsWords = as.data.frame(as.matrix(sparse))
colnames(AbsWords) = make.names(colnames(AbsWords))


AbsTrain = head(AbsWords, nrow(train))


AbsTest = tail(AbsWords, nrow(test))











HeadlineWordsTrain$Popular = NewsTrain$Popular

HeadlineWordsTrain$WordCount = NewsTrain$WordCount
HeadlineWordsTest$WordCount = NewsTest$WordCount


HeadlineWordsLog = glm(Popular ~ ., data=HeadlineWordsTrain, family=binomial)



PredTest = predict(HeadlineWordsLog, newdata=HeadlineWordsTest, type="response")



MySubmission = data.frame(UniqueID = NewsTest$UniqueID, Probability1 = PredTest)

write.csv(MySubmission, "SubmissionHeadlineLog.csv", row.names=FALSE)

#------------------------------------

dtmtrain=cbind(HeadTrain,SnipTrain,AbsTrain)
 dtmtest=cbind(HeadTest,SnipTest,AbsTest)
 Train=train[c("NewsDesk","SectionName","SubsectionName","WordCount","Weekday","Popular")]
 Test=test[c("NewsDesk","SectionName","SubsectionName","WordCount","Weekday")]
 Test=cbind(Test,dtmtest)
 Train=cbind(Train,dtmtrain)
SimpleMod = glm(Popular ~ ., data=Train, family=binomial)
 PredTest = predict(SimpleMod, newdata=Test, type="response")
MySubmission = data.frame(UniqueID = NewsTest$UniqueID, Probability1 = PredTest)
 write.csv(MySubmission, "SubmissionSimpleLog.csv", row.names=FALSE)

