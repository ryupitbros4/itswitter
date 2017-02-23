# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @FollowSystem
  unfollowIt: (restaurantNumber) ->
    newURL = "/restaurants/#{restaurantNumber}/follow"
    thisId = "follow-#{restaurantNumber}" 
    document.getElementById(thisId).href = newURL
    newId = "unfollow-#{restaurantNumber}"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).innerHTML = "ブクマする"

  followIt: (restaurantNumber) ->
    newURL = "/restaurants/#{restaurantNumber}/unfollow"
    thisId = "unfollow-#{restaurantNumber}"
    document.getElementById(thisId).href = newURL
    newId = "follow-#{restaurantNumber}"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).innerHTML = "ブクマはずす"

@follow_system = new FollowSystem()

class @GoodnessSystem
  notGoodIt: (restaurantNumber) ->
  
  goodIt: (restaurantNumber) ->


@goodness_system = new GoodnessSystem()