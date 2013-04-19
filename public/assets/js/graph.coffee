
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

    console.log grp_edges

    force = d3.layout.force()
      .charge(-120)
      .linkDistance(30)
      .size([500, 300])

    force
      .nodes(nodes)
      .links(grp_edges)
      .start()

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


