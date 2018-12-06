#Given a column name, generate a SQL query that will generate a table showing change from one dataset to another
givemesqlquery <- function(colwewant){
  #Generate the query by using paste to insert that column in the appropriate places
  querywewant <- paste("SELECT ro1011.`E-code`, ro1011.`Local authority`, ro1011.",", ro1011."," AS figs1011, ro1718."," as figs1718, ro1718."," - ro1011."," AS change1118, (ro1718."," - ro1011.",")/ro1011."," AS percchange1118 from ro1011 LEFT JOIN ro1718 ON ro1011.`E-code` = ro1718.`E-code` WHERE ro1011.`Class` != 'O' AND ro1011.`Class` != 'SD' AND ro1011.`E-code` != 'NA' ORDER BY percchange1118 ASC","",sep=colwewant)
  #The paste function inserts that string at the end too but we need to remove that
  #Now 'clean up' the query by reducing it to the characters up to the point where the unneeded text appears
  querywewant <- substr(querywewant,1,nchar(querywewant) - nchar(colwewant))
  #Run that query and store results
  resultsofquery <- sqldf(querywewant)
  return(resultsofquery)
}