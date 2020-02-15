library(jsonlite)
library(dplyr)
library(httr)
library(tidyr)

# Setup
# This is a set up for api key and base url.

base_uri <- "https://api.themoviedb.org/3"
end_point <- "/movie/550?api_key="
uri <- paste0(base_uri, end_point)
source("apikey.R")
key_param <- list("api_key" = tmdb_key)
response <- GET(uri, query = key_param)

# Part 1 
# This function will return list of currently trending actors.

get_trending_table <- function() {
  end_point <- paste0("/trending/person/week")
  uri <- paste0(base_uri, end_point)
  response <- GET(uri, query = key_param)
  body <- content(response, "text", encoding = "UTF-8")
  data <- fromJSON(body)
  trending_df <- as.data.frame(data)
  return(trending_df)
}

profile_path <- function(img_uri) {
  name <- get_trending_table$Name
  base_point <- "https://image.tmdb.org/t/p/h100"
  end_point <- paste0("```![",name ,"](",img_uri, ")")
  response <- GET(base_point, end_point, query = key_param)
  return(name)
}


# Part 2
# This function will return information about a specific actor.

get_actor_data <- function(specific_actor) {
  params_list <- list("/search/", specific_actor)
  response <- GET(base_uri, params_list ,query = key_param )
  body <- content(response, "text")
  data <- c(body$person_id, body$titles)
  return(data)
}


# Part 3
# This function will return movies that a specific actor played a role in.

analyze_actor <- function(person_id) {
  end_point_mc <- paste0("/person/", person_id ,"/movie_credits")
  end_point_m <- paste0("/discover/movie")
}



















