#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  stand: ->
    that = @
    dealer = 0
    findMax = (user) ->
      if user[0] > 22
        0
      else if user.length is 2
        if user[1] > 22 then user[0] else user[1]
      else
        user[0]

    dealer17 = ->
      dealer = findMax that.get('dealerHand').scores()
      if dealer < 17
        that.get('dealerHand').hit()
        dealer17()

    @get('dealerHand').models[0].set 'revealed', true
    player = findMax @get('playerHand').scores()    
    dealer17()

    if player > dealer
      'player'
    else if player is dealer
      'push'
    else
      'dealer'

