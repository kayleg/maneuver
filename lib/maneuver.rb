%w(maneuver node edge graph cost_algorithm 
   search_algorithm first_search a_star).each { |f| require "maneuver/#{f}" }