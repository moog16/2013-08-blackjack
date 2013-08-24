class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-hand-button">New Hand</button>
    <div class="player-hand-container-status"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container-status"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": 'hit'
    "click .stand-button": 'findWinner'
    "click .new-hand-button": -> 
      @model.redeal()
      @render()

  initialize: -> 
    @render()
    if @model.get('playerHand').hasBlackJack() then @findWinner()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  findWinner: ->
    loser = winner = @model.findWinner()
    winnerText = 'Winner'
    loserText = 'Loser'
    if winner is 'push'
      winnerText = loserText = 'Push'
      loser = 'dealer'
      winner = 'player'

    loser = if winner is 'player' then 'dealer' else 'player'
    @$('.' + winner + '-hand-container-status').append '<span class="winnerText">' + winnerText + '</span>'
    @$('.' + loser + '-hand-container-status').append '<span class="loserText">' + loserText + '</span>'

  hit: ->
    hasBlackJack = @model.get('playerHand').hit()
    playerBusted = @model.get('playerHand').busted()
    if hasBlackJack or playerBusted
      @findWinner()
