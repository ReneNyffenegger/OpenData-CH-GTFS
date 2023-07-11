options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
characterset  al32utf8
infile '../data/transfers.txt' "str '\r\n'"
insert into table transfers
fields terminated by ',' optionally enclosed by '"'
(
   from_stop_id          ,
   to_stop_id            ,
   transfer_type         ,
   min_transfer_time
)
