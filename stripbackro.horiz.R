#This function takes an Excel filename and a year, 
#then returns a subset for main categories of spending
#with the year added as a prefix for the columns
stripbackro.horiz <- function(filename, year){
  #read from Excel into an object 
  roobject <- read_excel(filename, 
                         sheet = 3, 
                         skip = 6, 
                         na = "c('-','')",
                         col_types = "guess")
  #Store the first few columns separately
  roobject.las <- roobject[c(1,2,3,5)]
  #Read from Excel again to grab the codes
  roobject.otherheads <- read_excel(filename, 
                                    sheet = 3, skip = 4, n_max = 1, range = "A6:IR6")
  #Combine the codes with the relevant column headings
  colnames(roobject) <- paste(head(colnames(roobject.otherheads),length(colnames(roobject))),
                              colnames(roobject), sep=": ")
  #Add the year as a prefix
  colnames(roobject) <- paste(year, colnames(roobject), sep=": ")
  #Create a list of terms that we can use to filter
  listofterms <- "Social Care|Highway|GFRA|Public Health|Cultural|Environmental|Planning|Education|at 1 April"
  #Use grepl to filter to just those columns containing the keywords
  roobject.sub <- roobject[grepl(listofterms,
                                 colnames(roobject))]
  #Add in the LA details extracted earlier
  roobject.sub <- cbind(roobject.las,roobject.sub)
  #No need to add the year in this version
  #roobject.sub$year <- year
  #Return to whatever called this function
  return(roobject.sub)
}