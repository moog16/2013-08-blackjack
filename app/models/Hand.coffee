class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> 
    @add(@deck.pop()).last()
    @hasBlackJack()

  stand: ->
    that = @

    if @isDealer
      that.where({revealed: false})[0].flip()
      dealer17 = ->
        if that.scores()[0] > 22 or that.scores()[1] > 22 then return
        else if findMax(that.scores()) < 17
          that.hit()
          dealer17()
      dealer17()
    findMax @.scores()

  findMax = (user) ->
    if user[0] > 22 then 0
    else if user.length is 2
      if user[1] > 22 then user[0] else user[1]
    else
      user[0]

  hasBlackJack: ->
    if findMax(@.scores()) is 21 then true else false

  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce and @models[0].get('revealed') is true and @models[1].get('revealed') then [score, score+10] else [score]

