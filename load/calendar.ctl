options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
infile '../data/calendar.txt' "str '\r\n'"
insert into table calendar
fields terminated by ',' optionally enclosed by '"'
(
   service_id,
   monday    ,
   tuesday   ,
   wednesday ,
   thursday  ,
   friday    ,
   saturday  ,
   sunday    ,
   start_date     date "yyyymmdd",
   end_date       date "yyyymmdd"
)
