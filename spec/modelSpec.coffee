describe "Card Model", ->

  card = new Card
  
  it "should create a card with default values", ->
    expect(card.get('faceDown')).toBe(true)
  
  it "should have a 'flip' function", ->
    expect(card.flip).toBeDefined()

  it "flip should change the faceDown property of the card", ->
    beforeFlip = card.get("faceDown");
    card.flip()
    expect(card.get("faceDown")).toBe(false)
    expect(card.get("faceDown")).not.toEqual(beforeFlip)

  # Do spy for flip function