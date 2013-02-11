describe "Card View", ->

  blackJackView = new BlackjackView()

  it "should make a deck collection of 52 models on initialize", ->
    expect(blackJackView.deck.models.length).toBe(52)
  
  it "should fire methods on click events", ->
    spyOn(blackJackView, 'deal')
    blackJackView.$el.append("<div class='hit-button'></div>")
    blackJackView.$('.hit-button').trigger("click")
    expect(blackJackView.deal.callCount).toBe(1)

  it "should deal at least three cards on initialize", ->
    dealerHand = blackJackView.deck.filterCards("dealer")
    playerHand = blackJackView.deck.filterCards("player")
    spyOn(blackJackView,'checkWin')
    expect(dealerHand.length).toNotEqual(0)
    expect(playerHand.length).toEqual(2)

  it "should change the turn property of the view after calling stand", ->
    expect(blackJackView.turn).toEqual("player")
    spyOn(blackJackView,'checkWin')
    blackJackView.stand()
    expect(blackJackView.turn).toEqual("dealer")

  it "should increase the size of the deck when it reaches the end of the current deck", ->
    deckLength = blackJackView.deck.length
    blackJackView.deck.cardIndex = 51
    blackJackView.deal()
    expect(blackJackView.deck.length).toEqual(104)
    expect(blackJackView.deck.length).toNotEqual(deckLength)