# Coursera_Data_Science_Capstone
 
This Shiny application returns a set of likely next words when words or phrases are entered into the input box. 
Alter the text in the *Input text:* box and the app employs the wordpredict function to extract a list of likely words, and their likelhood scores from a reference table. In addition a pair of `renderPlot` expression are automatically re-evaluated when the inputbox is updated, causing new word suggestions to be generated and both a pointplot and wordcloud to be rendered.