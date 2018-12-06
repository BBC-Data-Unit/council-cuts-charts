#Given a column name, and the names of 2 data frames, generate a SQL query that will generate 
#a table showing change from one data frame to another
givemesqlquery.fromto <- function(colwewant,fromdata,todata){
  #Generate the query by using paste to insert that column in the appropriate places
  querywewant <- paste("SELECT ro1011.`E-code`, ro1011.`Local authority`, ro1011.",", ro1011."," AS figs1011, ro1718."," as figs1718, ro1718."," - ro1011."," AS change, (ro1718."," - ro1011.",")/ro1011."," AS percchange from ro1011 LEFT JOIN ro1718 ON ro1011.`E-code` = ro1718.`E-code` WHERE ro1011.`Class` != 'O' AND ro1011.`Class` != 'SD' AND ro1011.`E-code` != 'NA' ORDER BY percchange ASC","",sep=colwewant)
  #The paste function inserts that string at the end too but we need to remove that
  #Now 'clean up' the query by reducing it to the characters up to the point where the unneeded text appears
  querywewant <- substr(querywewant,1,nchar(querywewant) - nchar(colwewant))
  #replace the specific datasets with those passed to the function
  querywewant <- gsub("ro1011",fromdata,querywewant)
  querywewant <- gsub("ro1718",todata,querywewant)
  querywewant <- gsub("figs1011",fromdata,querywewant)
  querywewant <- gsub("figs1718",todata,querywewant)
  #Uncomment for debugging
  #print(querywewant)
  #Run that query and store results
  resultsofquery <- sqldf(querywewant)
  return(resultsofquery)
}