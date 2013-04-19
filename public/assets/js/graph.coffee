
$ ->


  d3.xml "/data/main.gexf", "application/xml", (gexf) ->

    console.log gexf


    nodes =  d3.select(gexf).selectAll("node")[0]
    edges =  d3.select(gexf).selectAll("edge")[0]


    grp_edges = edges.map (d) ->
      source  :
        d3.select(gexf).selectAll("node").filter("[id='#{d3.select(d).attr("source")}']")[0][0]
      target:
        d3.select(gexf).selectAll("node").filter("[id='#{d3.select(d).attr("target")}']")[0][0]
      weight: 1

    svg = d3.select("#viz").append("svg")
      .attr("height", 900)

    console.log nodes

    color = d3.scale.category20()

    force = d3.layout.force()
      .size([500, 900])
      .nodes(nodes)
      .links(grp_edges)
      .charge(-200)
      .linkDistance(250)
      .linkStrength(0.1)
      .friction(0.1)
      .gravity(0.0)
      .on("tick", -> tick())
      .start()

    link = svg.selectAll("link")
      .data(grp_edges)
      .enter()
      .append("line")
      .attr("class", "link")

    node = svg.selectAll("node")
      .data(nodes)
      .enter()
      .append("circle")
      .attr("r", 5)
      .attr("class", "node")
      .call(force.drag)

    text = svg.selectAll("text")
      .data(nodes)
      .enter()
      .append("text")
      .attr("class", "text")
      .attr("text-anchor", "middle")
      .text((d) -> d.attributes.label.value)

    tick = ->

      link
        .attr("x1", (d) -> d.source.x)
        .attr("y1", (d) -> d.source.y)
        .attr("x2", (d) -> d.target.x)
        .attr("y2", (d) -> d.target.y)

      node
        .attr("cx", (d) -> d.x)
        .attr("cy", (d) -> d.y)

      text
        .attr("x", (d) -> d.x)
        .attr("y", (d) -> d.y - 10)


    ###
    dataset = [ 5, 10, 15, 20, 25 ]

    svg.selectAll("circle")
      .data(dataset)
      .enter()
      .append("circle")
      .attr("cx", (d, i) -> (i * 50) + 25)
      .attr("cy", 150)
      .attr("r", (d) -> d)
      .attr("fill", "yellow")
      .attr("stroke", "orange")
      .attr("stroke-width", (d) -> d / 2 )
    ###

    ###
    svg.append("svg:defs").selectAll("marker")
      .data(["end"])
      .enter().append("svg:marker")
      .attr("id", String)
      .attr("viewBox", "0 -5 10 10")
      .attr("refX", 15)
      .attr("refY", -1.5)
      .attr("markerWidth", 6)
      .attr("markerHeight", 6)
      .attr("orient", "auto")
      .append("svg:path")
      .attr("d", "M0,-5L10,0L0,5")

    svg.append("svg:g").selectAll("path")
      .data(force.links())
      .enter().append("svg:path")
      .attr("class", "link")
      .attr("marker-end", "url(#end)")
    ###

    return

  ###
  sigInst = sigma.init(document.getElementById('viz')).drawingProperties(
    defaultLabelColor: '#fff'
    defaultLabelSize: 14
    defaultLabelBGColor: '#fff'
    defaultLabelHoverColor: '#000'
    labelThreshold: 6
    defaultEdgeType: 'curve'
  ).graphProperties(
    minNodeSize: 0.5
    maxNodeSize: 5
    minEdgeSize: 1
    maxEdgeSize: 1
  ).mouseProperties(
    maxRatio: 32
  )

  sigInst.parseGexf('/data/main.gexf')

  sigInst.draw()

  ###


