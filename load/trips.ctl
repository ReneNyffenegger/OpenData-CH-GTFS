options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
infile '../data/trips.txt' "str '\r\n'"
insert into table trips
fields terminated by ',' optionally enclosed by '"'
(
   route_id,
   service_id,
   trip_id,
-- shape_id           filler,
   trip_headsign,
   trip_short_name,
   direction_id,
   block_id
)
