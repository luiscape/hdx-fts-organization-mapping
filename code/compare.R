# Compare


makeComparisons <- function() {
  # loading local data
  fts = read.csv('data/fts_organizations.csv')
  hdx = read.csv('data/hdx_org_list.csv')
  
  # Perform some cleaning of the display names: 
  # - get rid of parenthesis accronyms. 
  
  total = nrow(hdx)
  cat('-------------------------------- \n')
  cat('Making comparisons: ... \n')
  pb <- txtProgressBar(min = 0, max = total, style = 3, char ='.')
  for(i in 1:total) {
    setTxtProgressBar(pb, i)
    
    # Calculating how many fit the text search
    # perfectly. This returns how many of those
    # matches were found.
    fts_n_perfect = length(grep(hdx$display_name[i], fts$abbreviation, fixed = T, ignore.case = T)) + 
                    length(grep(hdx$display_name[i], fts$name, fixed = T, ignore.case = T))
    
    collectFTSid <- function(df, j = i, b = hdx) {
      if (df == 1 | df == 2) {
        fts_id = ifelse(
            is.null(fts[grep(b$display_name[j], fts$name),]$id), 
            NA,
            fts[grep(b$display_name[j], fts$name),]$id
          )
        if (is.na(fts_id)) fts_id = fts[grep(b$display_name[j], fts$abbreviation),]$id
      }
      else fts_id = NA
      
      return(fts_id)
    }
  
    
    # Defining the schema for the final data.frame.
    it <- data.frame(hdx_id = hdx$name[i],
                     hdx_name = hdx$display_name[i],
                     fts_id = collectFTSid(fts_n_perfect),  # collecting the FTS id
                     fts_n_perfect = fts_n_perfect,
                     fts_n_fuzzy = length(agrep(hdx$display_name[i], fts$name)) + 
                                   length(agrep(hdx$display_name[i], fts$abbreviation))
                     )
    
    
    # Iterating over the data.frames
    if (i == 1) out <- it
    else out <- rbind(out, it)
    
  }
  
  message = paste()
  cat(message)
  
  cat('\nDone.\n')
  cat('-------------------------------- \n')
  
  return(out)
}

x <- makeComparisons()
write.csv(x, 'data/correct_codes.csv', row.names = F)
