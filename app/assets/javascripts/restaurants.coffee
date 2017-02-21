# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @FollowSystem
  unfollowIt: (restaurantNumber) ->
    newURL = "restaurants/#{restaurantNumber}/follow"
    thisId = "follow-#{restaurantNumber}" 
    document.getElementById(thisId).href = newURL
    newClick = "followIt(#{restaurantNumber})"
    document.getElementById(thisId).onclick = newClick

  followIt: (restaurantNumber) ->
    newURL = "restaurants/#{restaurantNumber}/unfollow"
    thisId = "unfollow-#{restaurantNumber}"
    document.getElementById(thisId).href = newURL
    newClick = "unfollowIt(#{restaurantNumber})"
    document.getElementById(thisId).onclick = newClick


@follow_system = new FollowSystem()