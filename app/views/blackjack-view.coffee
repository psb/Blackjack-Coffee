class window.BlackjackView extends Backbone.View

  events:
    "click .hit-button": "hit"
    "click .stand-button": "stand"
    "click .reset-button": "reset"

  initialize: ->
    @deck = new Deck()
    @reset()

  reset: ->
    # debugger
    $('.player-cards').html('')
    $('.dealer-cards').html('')
    @turn = "player"
    # @playerScore = 0
    # @dealerScore = 0
    @gameSetup()
    console.log "game starting"

  deal: (owner, faceDown)->
    if @deck.cardIndex == @deck.length - 1
      alert('Loading new deck')
      # @deck = new Deck()
      @deck.add(new Deck().toJSON(), {silent:true})
      @calculateScore()
    card = @deck.deal()
    card.set({"owner": owner, "faceDown": faceDown})
    cardView = new CardView( { model : card } )
    $(".#{owner}-cards").append(cardView.$el);

    @calculateScore()

  throwOut: ->
    @deck.each((card) ->
      if card.get("owner") then card.set("thrownOut", true)
    )

  gameSetup: ->
    @throwOut()

    @deal("player", false)
    @deal("dealer", false)
    @deal("player", false)
    if @playerScore != 21
      @deal("dealer", true)

  hit: ->
    @deal(@turn, false)

  flip: ->
    @deck.each((card) ->
      if card.get("faceDown") then card.flip()
    )
    @calculateScore()

  stand: ->
    @flip() 
    @turn = "dealer"
    @calculateScore()

  render: ->
    $(".dealer-score").html(@dealerScore)
    $(".player-score").html(@playerScore)

  filterAces: (cards) ->
    _.filter(cards, (card) ->
      card.get("value") == "A"
    )

  withoutAces: (cards) ->
    _.filter(cards, (card) ->
      card.get("value") != "A"
    )

  checkWin: ->
    switch @turn
      when "player"
        if @playerScore == 21
          alert "you win"
          # @reset()
          break
        if @playerScore > 21
          alert "you lose"
          # @reset()
          break
      when "dealer"
        if @dealerScore > 21
          alert "you win"
          # @reset()
          break
        if @dealerScore <= @playerScore and (@playerScore >= 17 or @dealerScore <= @playerScore)
          @deal(@turn, false)
          break
        if @dealerScore > @playerScore and @dealerScore <= 21
          alert "you lose"
          # @reset() 
          break
        if (@dealerScore == @playerScore) && (@playerScore > 0)
          alert "tie but you get money"
          # @reset()
          break
      else console.log("checking score")

  updateScore: (person) ->
    score = 0
    cards = @deck.filterCards(person)
    aces = @filterAces(cards)
    withoutAces = @withoutAces(cards)
    _.each(withoutAces, (card) =>
      if typeof card.get("value") == "string"
        score += 10
      else 
        score += card.get("value")
    )
    _.each(aces, (card)=> 
      if score + 11 > 21
        score += 1
      else 
        score += 11
    )
    score


  calculateScore: ->
    @dealerScore = @updateScore("dealer")
    @playerScore = @updateScore("player")

    @render()
    @checkWin()


