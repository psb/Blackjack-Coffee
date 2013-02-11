class window.CardView extends Backbone.View

  template: _.template($("#card-template").html())

  initialize: ->
    @model.on("change", @render, @)

    @render()
  render: ->
    # alert()
    # console.log(@model, @template)
    # debugger
    # @model.flip()
    @$el.html( @template( {card: @model} ) )
