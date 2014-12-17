# Script to map FTS organization ids to HDX's. 

# Dependencies
library(RCurl)
library(rjson)

# Function to get FTS organizations
getHDXOrgs <- function() {
  url = 'https://data.hdx.rwlabs.org/api/action/organization_list'
  doc = fromJSON(getURL(url))
  org_list = doc$result
  
  total = length(doc$result)
  pb <- txtProgressBar(min = 0, max = total, style = 3, char ='.')
  for (i in 1:total) {
    setTxtProgressBar(pb, i)
    url = paste0('https://data.hdx.rwlabs.org/api/action/organization_show?id=', org_list[i])
    doc = fromJSON(getURL(url))
    
    # schema for data.frame
    it <- data.frame(display_name = ifelse(is.null(doc$result$display_name), NA, doc$result$display_name),
                     title = ifelse(is.null(doc$result$title), NA, doc$result$title),
                     name = ifelse(is.null(doc$result$name), NA, doc$result$name))
    
    if (i == 1) out <- it
    else out <- rbind(out, it)
  }
  
  return(out) 
}