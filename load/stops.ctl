options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
characterset  al32utf8
infile '../data/stops.txt' "str '\r\n'"
insert into table stops
fields terminated by ',' optionally enclosed by '"'
(
   stop_id          ,
   stop_name        ,
   stop_lat         ,
   stop_lon         ,
-- stop_url         filler,
   location_type    ,
   parent_station
)
