CALL gds.graph.project.cypher(
    'Movies and actor',
    'MATCH (n)
    WHERE n:Actor OR n:Movies
    RETURN id(n) AS id, labels(n) as labels',
    'MATCH (n)-[r:ACTED_IN]->(m) 
    RETURN id(n) AS source, id(m) AS target, type(r) AS type')
YIELD
    graphName AS graph, nodeQuery, nodeCount AS nodes, relationshipCount AS rels

CALL gds.pageRank.stream("moviesAndActors")
YIELD nodeId,score
RETURN gds.util.asNode(nodeId).title AS n, score
ORDER BY score DESC
LIMIT 50

// Creating KNOWS relationship (an Actor a knows an Actor b if a and b played in the same movie)
CALL gds.graph.project(
    'moviesAndActors',
    ['Movie', 'Actor'],
    {
        ACTED_IN:{
            orientation:'NATURAL'
        },
        HAS_ACTOR:{
            type:'ACTED_IN',
            orientation:'REVERSE'
        }
    })
YIELD
    graphName, nodeCount, relationshipCount


CALL gds.beta.collapsePath.mutate("moviesAndActors",{
    pathTemplates:[["ACTED_IN", "HAS_ACTOR"]],
    allowSelfLoops:false,
    mutateRelationshipType:'KNOWS'
}) YIELD relationshipsWritten