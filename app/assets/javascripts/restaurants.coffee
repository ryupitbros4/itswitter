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
  notGoodIt: (commentNumber, restaurantNumber, userNumber) ->
    commentId = commentNumber
    restaurantId = restaurantNumber
    userId = userNumber
    newURL = "/restaurants/cancel_like?comment_id=#{commentId}&amp;restaurant_id=#{restaurantId}&amp;user_id=#{userId}"
    thisId = "not-good-#{restaurantNumber}"
    newId = "good-#{restaurantNumber}"

    document.getElementById(thisId).value = "いいね!"
    document.getElementById(thisId).id = newId
    document.getElementById(newID).parentNode.setAttribute('action', newURL)

  goodIt: (commentNumber, restaurantNumber, userNumber) ->
    commentId = commentNumber
    restaurantId = restaurantNumber
    userId = userNumber
    newURL = "/restaurants/add_like_point?comment_id=#{commentId}&amp;restaurant_id=#{restaurantId}&amp;user_id=#{userId}"
    thisId = "good-#{restaurantNumber}"
    newId = "not-good-#{restaurantNumber}"

    document.getElementById(thisId).value = "いいね!取り消し"
    document.getElementById(thisId).id = newId
    document.getElementById(newID).parentNode.setAttribute('action', newURL)

@goodness_system = new GoodnessSystem()