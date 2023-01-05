import csv

with open("crew_cast.csv", "r") as f, open("actors.csv", "w", newline="") as actors, open("cast.csv", "w", newline="") as cast:
    csv_reader = csv.reader(f)
    next(csv_reader)
    csv_writer = csv.writer(actors)
    writer_cast = csv.writer(cast)
    csv_writer.writerow(["actor_id", "name", "original_name", "gender", "popularity"])
    writer_cast.writerow(["tmdb_movie_id", "actor_id"])
    ids = set()
    for row in csv_reader:
        if int(row[3]) not in ids and row[2] == "Actor" :
            ids.add(int(row[3]))
            csv_writer.writerow(row[3:])
        writer_cast.writerow([row[1], row[3]])
 
            
