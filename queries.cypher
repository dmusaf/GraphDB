// 1. Find the locations that are never the pickup location of a trip
MATCH (l1:Location) WHERE NOT EXISTS((l1)--(:Trip)--(:Location)) 
return l1;

// 2. Get the number of distinct dropoff_locations for each pickup location
MATCH (l1:Location) OPTIONAL MATCH (l1)<-[:from]-(t:Trip)-[:to]->(l2:Location) 
return l1, count(DISTINCT l2) as nb_dp_locations 
order by nb_dp_locations desc

// 3. Show the locations in Manhattan that were part of at least 100 trips.
match (pickup:Location{borough:"Manhattan"})--(:Trip)
with pickup, count(*) as nb_trips
where nb_trips > 100
return pickup, nb_trips

// 4. For each location, calculate the number of time that location was the pickup location and the number of time that location was the dropoff location.
match (l:Location)<-[r]-(:Trip)
with *, type(r) as type
return l, type, count(*) as nb
order by l.loc_id


