get_player_photo = function(player_name) {
  
  selected_player <- (players %>% filter(name == player_name))$player_id  
  
  paste0("https://stats.nba.com/media/players/230x185/", selected_player, ".png")
}