HomeController = Paloma.controller('Home')

HomeController.prototype.index = ->
  options = {
    min: new Date(this.params['date']['min'])
    max: new Date(this.params['date']['max'])
  }

  default_options = {
    min: new Date(this.params['default']['min'])
    max: new Date(this.params['default']['max'])
  }
  console.log options
  $("#slider").dateRangeSlider bounds: options, defaultValues: default_options
  $("#slider").bind "valuesChanged", (e, data) ->
    refreshData()
  $('#selects input').on 'click', (e) ->
    if !$('#selects input:checked').length
      e.preventDefault()
      return
    refreshData()

  refreshData = ->
    stores = []
    $('#selects input:checked').each ->
      stores.push $(this).val()
    dates = $("#slider").dateRangeSlider("values")
    $.cookie 'date_min', dates.min
    $.cookie 'date_max', dates.max
    $.cookie 'stores', stores

    console.log '----------------'
    console.log stores
    console.log dates
    console.log '----------------'

    renderCharts()

  renderCharts = ->
    new Chartkick.PieChart("chart-1", "/part_answers", {})
    new Chartkick.LineChart("chart-2", "/dynamic",
      min: 5
      max: 10
    )
    new Chartkick.ColumnChart("chart-3", "/part", {})

