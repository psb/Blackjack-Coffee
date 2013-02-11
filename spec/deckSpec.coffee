describe "Deck Collection", ->

  deck = new Deck()

  beforeEach ->
    deck = new Deck()
  
  it "should create a deck of 52 cards", ->
    expect(deck.length).toEqual(52)
  
  it "should have an initial index vaue of 0", ->
    expect(deck.cardIndex).toEqual(0)
  
  it "should have a 'shuffle' function", ->
    expect(deck.shuffle).toBeDefined()  
  
  it "should have a 'deal' function", ->
    expect(deck.deal).toBeDefined()  

  it "should have a 'filter' function", ->
    expect(deck.deal).toBeDefined()

  describe "shuffle function", ->
    deck2 = new Deck()   

    it "should shuffle the order of the deck models upon instantiation", ->
      expect(JSON.stringify(deck.models)).not.toEqual(JSON.stringify(deck2.models))

  describe "deal function", ->
    pluckedAt0 = deck.models[0]
    card0 = deck.deal()
    
    it "should return the card in the deck at the given index", ->
      expect(pluckedAt0).toEqual(card0)

    it "should increase the cardIndex of the collection", ->
      deck.deal() # beforeeach is messing things up
      expect(deck.cardIndex).toEqual(1);
    # More tests

  describe "filterCards function", ->
    deck.models[5].set({"owner": "dealer", "faceDown": false})
    deck.models[23].set({"owner": "dealer", "faceDown": false})
    deck.models[49].set({"owner": "player", "faceDown": false})
    # debugger
    dealerHand = deck.filterCards("dealer")
    playerHand = deck.filterCards("player")

    it "should filter the deck according to the owner of the card", ->
      expect(dealerHand.length).toEqual(2)
      expect(playerHand.length).toEqual(1)
