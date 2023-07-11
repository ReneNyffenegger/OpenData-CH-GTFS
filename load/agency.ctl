options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
characterset  al32utf8
infile '../data/agency.txt' "str '\r\n'"
insert into table agency
fields terminated by ',' optionally enclosed by '"'
(
   agency_id      ,
   agency_name    
-- agency_url     ,
-- agency_timezone,
-- agency_lang    ,
-- agency_phone
)
