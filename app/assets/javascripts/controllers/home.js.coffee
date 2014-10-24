HomeController = Paloma.controller('Home')

HomeController.prototype.index = ->
  options = {
    min: new Date(this.params['date']['min'])
    max: new Date(this.params['date']['max'])
  }
  console.log options
  $("#slider").dateRangeSlider bounds: options, defaultValues: options
  $("#slider").bind "valuesChanged", (e, data) ->
    console.log "Will be executed"