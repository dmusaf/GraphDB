// Nodes
// (:Location)
// (:Trip)
// (:Driver)

// Columns in rides.csv :
//
// ====================================================================================
// ||  VendorID  || tpep_pickup_datetime || tpep_dropoff_datetime || passenger_count ||
// ====================================================================================
//
// =======================================================================================
// || trip_distance || RatecodeID || store_and_fwd_flag || PULocationID || DOLocationID || 
// =======================================================================================
//
// =============================================================================================
// || payment_type || extra || mta_tax || tip_amount || tolls_amount || improvement_surcharge ||
// ============================================================================================= 
//
// ===============================================================================
// || total_amount || congestion_surcharge || airport_fee || tripID || driverID ||
// ===============================================================================



// Columns in drivers.csv
// ==========================================================
// || driver_id || last_name ||	first_name || plate_number ||
// ==========================================================



// Columns in taxi_location_lookup.csv
// ===================================================
// || LocationID || Borough || Zone || service_zone ||
// ===================================================


CREATE CONSTRAINT ON (loc:Location) ASSERT loc.loc_id IS UNIQUE;
CREATE CONSTRAINT ON (trip:Trip) ASSERT trip.trip_id IS UNIQUE;
CREATE CONSTRAINT ON (driver:Driver) ASSERT driver.driver_id IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:/taxi_location_lookup.csv" as l
CREATE (loc:Location{loc_id:toInteger(l.LocationID), borough:l.Borough, zone:l.Zone, service_zone:l.service_zone});

LOAD CSV WITH HEADERS FROM "file:/drivers.csv" as l
CREATE (driver:Driver{driver_id:toInteger(l.driver_id), last_name:l.last_name, first_name:l.first_name, plate_number:l.plate_number});

:auto LOAD CSV WITH HEADERS FROM "file:/rides_test2.csv" as l
CALL{
    WITH l 
    MERGE (source:Location{loc_id:toInteger(l.PULocationID)} )
    MERGE(driver:Driver{driver_id:toInteger(l.driverID)})
    MERGE (dest:Location{loc_id:toInteger(l.DOLocationID)} )
    CREATE (trip:Trip{
                trip_id:toInteger(l.tripID), 
                trip_distance:l.trip_distance,
                vendor_id:toInteger(l.VendorID), // 1= Creative Mobile Technologies, LLC; 2= VeriFone Inc. (TPEP provider)
                tpep_pickup_date:split(l.tpep_pickup_datetime, " ")[0],
                tpep_pickup_time:split(l.tpep_pickup_datetime, " ")[1],
                tpep_dropoff_date:split(l.tpep_dropoff_datetime, " ")[0],
                tpep_dropoff_time:split(l.tpep_dropoff_datetime, " ")[1],
                passenger_count:l.passenger_count,
                ratecode_id:toInteger(l.RatecodeID), // 1=Standard rate, 2=JFK, 3=Newark, 4=Nassau or Westchester, 5=Negotiated fare, 6=Group ride
                store_and_fwd_flag:l.store_and_fwd_flag, // Y=store and forward trip, N=not a store and forward trip => not very intersting for us
                payment_type:l.payment_type, // 1=credit card, 2=cash, 0,3,4,5=other
                tip_amount:toFloat(l.tip_amount),
                total_amount:toFloat(l.total_amount)
            })
    CREATE (trip) -[:from]-> (source)
    CREATE (trip) -[:to]-> (dest)
    CREATE (driver) -[:drives]-> (trip)
} IN TRANSACTIONS