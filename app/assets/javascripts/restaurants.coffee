# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @FollowSystem
  unfollowIt: (restaurantNumber) ->

    newURL = "/restaurants/#{restaurantNumber}/follow"
    thisId = "follow-#{restaurantNumber}"
    newId = "unfollow-#{restaurantNumber}"

    thisIdTen = "follow_ten-#{restaurantNumber}"
    newIdTen = "unfollow_ten-#{restaurantNumber}"

    if document.getElementById(thisIdTen)
      document.getElementById(thisIdTen).value = "ブクマする"
      document.getElementById(thisIdTen).id = newIdTen
      document.getElementById(newIdTen).parentNode.setAttribute('action', newURL )

    if document.getElementById(thisId)
      document.getElementById(thisId).value = "ブクマする"    
      document.getElementById(thisId).id = newId
      document.getElementById(newId).parentNode.setAttribute('action', newURL )

  followIt: (restaurantNumber) ->
    newURL = "/restaurants/#{restaurantNumber}/unfollow"
    thisId = "unfollow-#{restaurantNumber}"
    newId = "follow-#{restaurantNumber}"

    thisIdTen = "unfollow_ten-#{restaurantNumber}"
    newIdTen = "follow_ten-#{restaurantNumber}"

    if document.getElementById(thisIdTen)
      document.getElementById(thisIdTen).value = "ブクマはずす"
      document.getElementById(thisIdTen).id = newIdTen
      document.getElementById(newIdTen).parentNode.setAttribute('action', newURL)

    if document.getElementById(thisId)
      document.getElementById(thisId).value = "ブクマはずす"
      document.getElementById(thisId).id = newId
      document.getElementById(newId).parentNode.setAttribute('action', newURL)

###
  unfollowItTen: (restaurantNumber) ->

    newURL = "/restaurants/#{restaurantNumber}/follow"
    thisId = "follow_ten-#{restaurantNumber}"
    newId = "unfollow_ten-#{restaurantNumber}"

    document.getElementById(thisId).value = "ブクマする"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).parentNode.setAttribute('action', newURL )

  followItTen: (restaurantNumber) ->
    newURL = "/restaurants/#{restaurantNumber}/unfollow"
    thisId = "unfollow_ten-#{restaurantNumber}"
    newId = "follow_ten-#{restaurantNumber}"

    document.getElementById(thisId).value = "ブクマはずす"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).parentNode.setAttribute('action', newURL)
###
@follow_system = new FollowSystem()

class @GoodnessSystem
  notGoodIt: (commentNumber, restaurantNumber, userNumber) ->
    commentId = commentNumber
    restaurantId = restaurantNumber
    userId = userNumber
    newURL = "/restaurants/cancel_like?comment_id=#{commentId}&amp;restaurant_id=#{restaurantId}&amp;user_id=#{userId}"
    thisId = "not-good-#{restaurantNumber}-#{commentNumber}"
    newId = "good-#{restaurantNumber}-#{commentNumber}"

    document.getElementById(thisId).value = "いいね！取り消し"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).parentNode.setAttribute('action', newURL)

  goodIt: (commentNumber, restaurantNumber, userNumber) ->
    commentId = commentNumber
    restaurantId = restaurantNumber
    userId = userNumber
    newURL = "/restaurants/add_like_point?comment_id=#{commentId}&amp;restaurant_id=#{restaurantId}&amp;user_id=#{userId}"
    thisId = "good-#{restaurantNumber}-#{commentNumber}"
    newId = "not-good-#{restaurantNumber}-#{commentNumber}"

    document.getElementById(thisId).value = "いいね！"
    document.getElementById(thisId).id = newId
    document.getElementById(newId).parentNode.setAttribute('action', newURL)

@goodness_system = new GoodnessSystem()