# Script to map FTS organization ids to HDX's. 

# Dependencies
library(RCurl)
library(rjson)

# Function to get FTS organizations
getFTSOrgs <- function() {
  url = 'http://fts.unocha.org/api/v1/organization.json'
  doc = fromJSON(getURL(url))
  
  total = length(doc)
  pb <- txtProgressBar(min = 0, max = total, style = 3, char ='.')
  for (i in 1:total) {
    setTxtProgressBar(pb, i)
    it <- data.frame(id = ifelse(is.null(doc[[i]]$id), NA, doc[[i]]$id),
                     name = ifelse(is.null(doc[[i]]$name), NA, doc[[i]]$name),
                     abbreviation = ifelse(is.null(doc[[i]]$abbreviation), NA, doc[[i]]$abbreviation),
                     type = ifelse(is.null(doc[[i]]$type), NA, doc[[i]]$type))
    
    if (i == 1) out <- it
    else out <- rbind(out, it)
  }
  
  return(out) 
}

# Storing output
fts_organizations <- getFTSOrgs()
write.csv(fts_organizations, 'data/fts_organizations.csv', row.names = F)

