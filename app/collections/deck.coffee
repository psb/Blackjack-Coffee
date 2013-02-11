class window.Deck extends Backbone.Collection

  model : Card

  cardIndex : 0

  initialize : ->
    @cardIndex = 0
    suits = ["hearts", "spades", "diamonds", "clubs"]
    values = [2..10].concat(['J','Q','K','A'])
    for suit in suits
      for value in values
        @add(new Card({"suit" : suit, "value" : value}))
    
    @shuffle()

  shuffle : ->
    @models = _.shuffle(@models)

  deal : ->
    card = @models[@cardIndex]
    @cardIndex++
    card

  filterCards: (owner) ->
    @filter (card) => 
      card.get("owner") is owner and card.get("faceDown") is false and card.get("thrownOut") isnt true