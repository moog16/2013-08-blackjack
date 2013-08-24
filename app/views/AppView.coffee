class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-hand-button">New Hand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": 'hit'
    "click .stand-button": 'findWinner'
    "click .new-hand-button": -> @model.redeal()

  initialize: -> 
    @render()
    console.log(@model.get('playerHand').hasBlackJack())
    if @model.get('playerHand').hasBlackJack() then @findWinner()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  findWinner: ->
    winner = @model.findWinner()
    console.log(winner + ' won');

  hit: ->
    console.log('hit')
    hasBlackJack = @model.get('playerHand').hit()
    if hasBlackJack
      console.log 'blackjack'
      @findWinner()
