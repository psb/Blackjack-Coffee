describe "Card View", ->

  cardmodel = new Card({suit:"hearts", value:"5"})
  card = new CardView({model: cardmodel})
  console.log(card.$el)
  # $("body").append(card.$el)
  # console.log(card)
  
  it "should render a card when initialized", ->
    expect(card.$el.find(".card").length).toBe(1)
  
  it "should be unknown when face down", ->
    expect(card.$el.text().trim()).toBe('???')

  it "should not be unknown when face up", ->
    cardmodel.flip()
    expect(card.$el.text().trim()).not.toBe('???')

  it "should render face up correctly", ->
    expect(card.$el.text()).toContain('hearts')
    expect(card.$el.text()).toContain('5')
    cardmodel.set("suit", "jasmine")
    expect(card.$el.text()).toContain('jasmine')

