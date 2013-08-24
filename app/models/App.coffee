#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @redeal()
    @set 'playerPot': new Chips(500)
    @set 'casinoPot': new Chips(0)

    console.log @get('playerPot')

  findWinner: ->
    player = @get('playerHand').stand()
    dealer = @get('dealerHand').stand()
    if @get('playerHand').busted() then 'dealer'
    else if player is dealer then 'push'
    else if player > dealer then 'player' else 'dealer'

  redeal: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

