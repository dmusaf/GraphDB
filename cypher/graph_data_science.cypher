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