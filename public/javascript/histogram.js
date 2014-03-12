


  var some_data = <%= @data.to_json %>;


  nv.addGraph(function() {  
    var chart = nv.models.discreteBarChart()
        .x(function(d) { return d.label })
        .y(function(d) { return d.value })
        .staggerLabels(true)
        .tooltips(false)
        .showValues(true)
        .transitionDuration(250)
        ;

    d3.select('#chart1 svg')
        .datum(some_data)
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });


