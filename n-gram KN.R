library(data.table)

#in quadgram dataset, get frequency "gramfreq" of preceding trigram for each word
quadgrams2 <- merge(quadgrams,trigrams[, .(pword3 = pword2, pword2 = pword1, pword1 = word, gramfreq = N)],by=c("pword3","pword2","pword1"),sort=FALSE)
quadgrams2[,firstTerm:= N/gramfreq
           ][,lambda:= 0/gramfreq
             ][, pcontwn:=length(N),by=word
               ][, pcontwd:=length(N)
                 ][, KNscore:=(firstTerm+lambda)*(pcontwn/pcontwd)]

trigrams2 <- merge(trigrams,bigrams[, .(pword2 = pword1, pword1 = word, gramfreq = N)],by=c("pword2","pword1"),sort=FALSE)
trigrams2[,firstTerm:= pmax(N-0.75,0)/gramfreq
           ][,lambda:= 0.75/gramfreq
             ][, pcontwn:=length(N),by=word
               ][, pcontwd:=length(N)
                 ][, KNscore:=(firstTerm+lambda)*(pcontwn/pcontwd)]            

bigrams2 <- merge(bigrams,unigrams[, .(pword1, gramfreq = N)],by=c("pword1"),sort=FALSE)
bigrams2[,firstTerm:= pmax(N-0.75,0)/gramfreq
          ][,lambda:= 0.75/gramfreq
            ][, pcontwn:=length(N),by=word
              ][, pcontwd:=length(N)
                ][, KNscore:=(firstTerm+lambda)*(pcontwn/pcontwd)]

capstone_ref_new <- rbindlist(list(quadgrams2,trigrams2,bigrams2), use.names=TRUE, fill=TRUE, idcol = TRUE)

wordpredict <- function(input) {
  wordsin <- str_split(str_trim(tolower(str_replace_all(input, "[^a-zA-Z ]", "")),"both"),"[[:punct:] ]+",simplify=TRUE)
  stringlength <- length(wordsin)
  if (stringlength >=3) {
    suggestedwords1 <- capstone_ref_new[pword1==wordsin[stringlength] & pword2==wordsin[stringlength-1] & pword3==wordsin[stringlength-2],c("word","KNscore")
                                        ][order(-KNscore),]
  } else suggestedwords1 <- capstone_ref_new[0,c("word","KNscore")]
  if (nrow(suggestedwords1) <=5 | stringlength==2) {
    suggestedwords2 <- capstone_ref_new[pword1==wordsin[stringlength] & pword2==wordsin[stringlength-1] & pword3==(NA_character_),c("word","KNscore")
                                        ][order(-KNscore),][! word %in% suggestedwords1[,word],]
  } else suggestedwords2 <- capstone_ref_new[0,c("word","KNscore")]
  if ((nrow(suggestedwords1)+nrow(suggestedwords2))<=5 | stringlength==1) {
    suggestedwords3 <- capstone_ref_new[pword1==wordsin[stringlength],c("word","KNscore")
                                        ][order(-KNscore),][! word %in% suggestedwords1[,word],][! word %in% suggestedwords2[,word],]
  } else suggestedwords3 <- capstone_ref_new[0,c("word","KNscore")]
  
  suggestedwords <- rbindlist(list(suggestedwords1,suggestedwords2,suggestedwords3),use.names=TRUE, fill=TRUE)
  
  result <- dplyr::top_n(suggestedwords,5,KNscore)
  
  return(result)
}

qplot(wordpredict("this should be")$word, wordpredict("this should be")$KNscore)