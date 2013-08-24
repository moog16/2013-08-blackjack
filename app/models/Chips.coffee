class window.Chips extends Backbone.Collection

  model: Chip

  initialize: (initPotSize) ->
    @set '@potSize': initPotSize


