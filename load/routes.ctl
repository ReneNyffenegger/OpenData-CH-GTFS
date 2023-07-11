options (
   direct =  true,
   errors =  0,
   skip   =  1,
   silent = (header, feedback)
)
load data
infile '../data/routes.txt' "str '\r\n'"
insert into table routes
fields terminated by ',' optionally enclosed by '"'
(
   route_id,
   agency_id,
   route_short_name,
   route_long_name       ,  --  filler
   route_desc            ,
   route_type            
-- route_color           filler,
-- route_text_color      filler
)
