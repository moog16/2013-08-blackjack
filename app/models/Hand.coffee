class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  stand: ->
    that = @
    findMax = (user) ->
      if user[0] > 22
        0
      else if user.length is 2
        if user[1] > 22 then user[0] else user[1]
      else
        user[0]

    if @isDealer
      that.where({revealed: false})[0].flip()
      dealer17 = ->
        if that.scores() < 17
          that.hit()
          dealer17()
      dealer17()

    findMax @.scores()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score+10] else [score]