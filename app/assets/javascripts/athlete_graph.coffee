window.draw_graph = ->
  ctx = document.getElementById("athleteChart").getContext('2d')
  data = {
    labels: gon.dates
    datasets: [{
      label: '記録',
      data: gon.results,
      backgroundColor: 'rgba(75, 192, 192, 0.2)',
      borderColor: 'rgba(75, 192, 192, 1)',
      pointBorderColor: gon.colors,
      borderWidth: 2
    }]
  }
  options = {
    showAllTooltips: true,
    tooltips: {
      mode: 'nearest',
      callbacks: {
        title: (tooltipItem, data) ->
          return [tooltipItem[0].xLabel, gon.tournaments[tooltipItem[0].index]]
        label: (tooltipItem, data) ->
          return gon.winds[tooltipItem.index] + tooltipItem.yLabel
      }
    },
    scales: {
      yAxes: [{
        ticks:{
          min: gon.min
          max: gon.max
        }
      }],
      xAxes: [{
        type: 'time'
      }]
    },
    elements: {
      line: {
        tension: 0
      }
    }
  }
  myChart = new Chart(ctx, {
    type: 'line',
    data: data,
    options: options
  })
