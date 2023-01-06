NB_ACTORS = 5
import csv


with open("../data/links_cast.csv", "r") as links_cast, open("../data/reduced_links_cast.csv", "w") as reduced, open ("../data/actors.csv", "r", encoding="UTF-8") as actors, open ("../data/reduced_actors.csv", "w", encoding="UTF-8") as r_actors:
    actors_per_movie = dict()
    actors_id = set()
    csv_reader = csv.reader(links_cast)
    csv_writer = csv.writer(reduced)
    next(csv_reader)
    csv_writer.writerow(["tmdb_movie_id", "actor_id"])
    for row in csv_reader:
        tmdb_movie_id = int(row[0])
        if tmdb_movie_id not in actors_per_movie.keys():
            actors_per_movie[tmdb_movie_id] = 1
        else:
            actors_per_movie[tmdb_movie_id] += 1
        
        if actors_per_movie[tmdb_movie_id] < NB_ACTORS:
            actors_id.add(int(row[1]))
            csv_writer.writerow(row)
    csv_writer = csv.writer(r_actors)
    csv_reader = csv.reader(actors)
    next(csv_reader)
    csv_writer.writerow(["actor_id","name","original_name","gender","popularity"])
    for row in csv_reader:
        if int(row[0]) in actors_id:
            csv_writer.writerow(row)





