# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @FollowSystem
  unfollowIt: (restaurantNumber) ->
    newURL = "/restaurants/#{restaurantNumber}/follow"
    thisId = "follow-#{restaurantNumber}" 
    document.getElementById(thisId).value = "ブクマする"
    newId = "unfollow-#{restaurantNumber}"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).parentNode.setAttribute('action', newURL )

  followIt: (restaurantNumber) ->
    newURL = "/restaurants/#{restaurantNumber}/unfollow"
    thisId = "unfollow-#{restaurantNumber}"
    document.getElementById(thisId).value = "ブクマはずす"
    newId = "follow-#{restaurantNumber}"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).parentNode.setAttribute('action', newURL)

@follow_system = new FollowSystem()

class @GoodnessSystem
  notGoodIt: (restaurantNumber) ->
    
  goodIt: (restaurantNumber) ->


@goodness_system = new GoodnessSystem()