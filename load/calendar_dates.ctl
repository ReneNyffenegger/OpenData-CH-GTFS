options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
infile '../data/calendar_dates.txt' "str '\r\n'"
insert into table calendar_dates
fields terminated by ',' optionally enclosed by '"'
(
   service_id,
   date_          date "yyyymmdd",
   exception_type
)
