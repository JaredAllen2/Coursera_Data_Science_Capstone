
wordpredictn1 <- function(word_1) {
  bigrams[word1==word_1][order(-N)]
}

wordpredictn2 <- function(word_1,word_2) {
  trigrams[word1==word_1 & word2==word_2][order(word1,-N)]
}

wordpredictn3 <- function(word_1,word_2,word_3) {
  quadgrams[word1==word_1 & word2==word_2 & word3==word_3][order(word1,word2,-N)]
}

wordpredictv1 <- function(input) {
  wordsin <- str_split(input,"[[:punct:] ]+",simplify=TRUE)  
  stringlength <- length(wordsin)
  if (stringlength >=3) {
    suggestedwords <- wordpredictn3(wordsin[stringlength-2],wordsin[stringlength-1],wordsin[stringlength])
  } else if (stringlength == 2) {
    suggestedwords <- wordpredictn2(wordsin[stringlength-1],wordsin[stringlength])
  } else if (stringlength == 1) {
    suggestedwords <- wordpredictn1(wordsin[stringlength])
  }
  suggestedwords
}

wordpredictv2 <- function(input) {
  wordsin <- str_split(tolower(input),"[[:punct:] ]+",simplify=TRUE)
  stringlength <- length(wordsin)
  suggestedwords <- capstone_ref4[pword1==wordsin[stringlength]&pword2==wordsin[stringlength-1]&pword3==wordsin[stringlength-2],c("word","gramscore")]
  result <- dplyr::top_n(suggestedwords,5,gramscore)
  return(result)
}