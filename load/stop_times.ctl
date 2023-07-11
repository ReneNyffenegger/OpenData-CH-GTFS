options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
characterset  al32utf8
infile '../data/stop_times.txt' "str '\r\n'"
insert into table stop_times
fields terminated by ',' optionally enclosed by '"'
(
   trip_id               ,
   arrival_time          ,
   departure_time        ,
   stop_id               ,
   stop_sequence         ,
-- stop_headsign         ,
   pickup_type           ,
   drop_off_type
-- shape_dist_travelled
)
