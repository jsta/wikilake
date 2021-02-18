# code to generate the milakes dataset

res <- WikipediR::page_info("en", "wikipedia",
                            page = "Category:Lakes of Michigan")

# Scrape lake names #####
res <- xml2::read_html(res$query$pages[[1]]$canonicalurl)
res <- rvest::html_nodes(res, "#mw-pages .mw-category")
res <- rvest::html_nodes(res, "li")
res <- rvest::html_nodes(res, "a")
res <- rvest::html_attr(res, "title")

# Remove junk names #####
res <- res[!(1:length(res) %in% grep("List", res))]
res <- res[!(1:length(res) %in% grep("Watershed", res))]
res <- res[!(1:length(res) %in% grep("lakes", res))]
res <- res[!(1:length(res) %in% grep("Mud Lake", res))]


# Scrape tables #####
res_raw <- lapply(res, lake_wiki)

# remove missing coordinates
res <- res_raw[unlist(lapply(res_raw, function(x) "Lat" %in% names(x)))]
res <- res[unlist(lapply(res, function(x) !is.na(x[,"Lat"])))]

# Collapse list to `data.frame` #####
res_df_names <- unique(unlist(lapply(res, names)))
res_df <- data.frame(matrix(NA, nrow = length(res),
                            ncol = length(res_df_names)))
names(res_df) <- res_df_names
for(i in seq_len(length(res))){
  print(i)
  dt_pad <- data.frame(matrix(NA, nrow = 1,
                              ncol = length(res_df_names) - ncol(res[[i]])))
  names(dt_pad) <- res_df_names[!(res_df_names %in% names(res[[i]]))]
  dt <- cbind(res[[i]], dt_pad)
  dt <- dt[,res_df_names]
  res_df[i,] <- dt
}

# Keep only common columns #####
good_cols <- data.frame(as.numeric(as.character(apply(res_df,
                                    2, function(x) sum(!is.na(x))))))
good_cols <- cbind(good_cols, names(res_df))
# good_cols[order(good_cols[,1], decreasing = TRUE),]
# hist(good_cols[,1])
good_cols <- good_cols[good_cols[,1] > 20 ,2]
good_cols <- stringi::stri_encode(
                stringi::stri_trans_general(
                    as.character(good_cols), "Latin-ASCII"), "", "UTF-8")
milakes <- res_df[,good_cols]


milakes$Name <- iconv(milakes$Name, from="UTF-8", to="ASCII")
usethis::use_data(milakes, overwrite = TRUE)
