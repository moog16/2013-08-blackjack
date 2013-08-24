#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  findWinner: ->
    player = @get('playerHand').stand()
    dealer = @get('dealerHand').stand()
    if player is dealer then 'push'
    else if player > dealer then 'player' else 'dealer'

  redeal: ->
    $('body').html ''
    new AppView(model: new App()).$el.appendTo 'body'


