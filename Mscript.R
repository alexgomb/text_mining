#install.packages("pdftools")
library(pdftools) #read the pdf documents
#install.packages("tidytext")
library(tidytext) #put text in tidytext format
#install.packages("wordcloud")
library(wordcloud) #function to create a wordcloud
library(tidyverse) #includes ggplot2 and dplyr
library(tm)

#load the text
text <- pdf_text("./sampledoc.pdf")
#create a data frame structure
text_df <- data.frame(line = 1:length(text), text = text)
#tokenize the words and remove the stop words (is, was, more, but,..)
text_tok <- text_df %>% unnest_tokens(word, text) %>% anti_join(stop_words) %>% removeNumbers(TRUE)
#plot the word count
text_tok %>% count(word, sort = TRUE) %>% 
  filter( n > 30) %>% #filter
  ggplot(aes(word, n)) + geom_col() + xlab("Most common words") + ylab("Number of rep") + coord_flip() #plot the bar chart

#word cloud
text_tok %>% 
  anti_join(stop_words) %>% #remove stop words
  count(word) %>%
  with(wordcloud(word, n, max.words = 15))

