color = (context) ->
  index = context.dataIndex
  value = context.dataset.data[index]
  return value == Nan ? 'red' : 'blue'

label_to_date = ->
  labels = []
  for label in gon.label
    labels.push(new Date(label))
  return labels


window.draw_graph = ->
  ctx = document.getElementById("athleteChart").getContext('2d')
  data = {
    labels: gon.dates
    datasets: [{
      label: '記録',
      data: gon.results,
      backgroundColor: 'rgba(75, 192, 192, 0.2)',
      borderColor: 'rgba(75, 192, 192, 1)',
      borderWidth: 2
    }]
  }
  options = {
    tooltips: {
      mode: 'nearest'
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
