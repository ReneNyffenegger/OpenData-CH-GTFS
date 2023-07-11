create table agency (
   agency_id        varchar2( 20)     primary key,
   agency_name      varchar2(100)     not null 
-- agency_url       varchar2(200)     not null   -- Always http://www.sbb.ch/
-- agency_timezone  varchar2( 50)     not null,  -- Always Europe/Berlin
-- agency_lang      char    (  2)     not null,  -- Always DE
-- agency_phone     varchar2( 20)                -- Aways 0848 44 66 88
);

create table calendar (
   service_id  varchar2(9)      primary key,
   monday      char(1) /* boolean */ not null check ( monday       in ('0', '1') ),
   tuesday     char(1) /* boolean */ not null check ( tuesday      in ('0', '1') ),
   wednesday   char(1) /* boolean */ not null check ( wednesday    in ('0', '1') ),
   thursday    char(1) /* boolean */ not null check ( thursday     in ('0', '1') ),
   friday      char(1) /* boolean */ not null check ( friday       in ('0', '1') ),
   saturday    char(1) /* boolean */ not null check ( saturday     in ('0', '1') ),
   sunday      char(1) /* boolean */ not null check ( sunday       in ('0', '1') ),
   start_date  date,
   end_date    date
)
pctfree 0;

create table calendar_dates (
   service_id          references calendar,
   date_               date      not null,
   exception_type      number(1) not null,
   --
   constraint calendar_dates_exception_type check (exception_type in (1, 2)),
   constraint calendar_dates_uq             unique(service_id, date_)
)
pctfree 0;

create table routes (
   route_id           varchar2(20) primary key,
   agency_id          not null,                       -- Not used for GTFS Zurich
   route_short_name   varchar2(20) not null,          -- This value is NOT unique!
   route_long_name    varchar2(100),                  -- Empty in GTFS Zurich
-- route_type         number(1)                       -- used in GTFS ZUrich ?
   route_desc         varchar2(20), 
   route_type         varchar2(10),
-- route_color,                                       -- Extension to GTFS
-- route_text_color                                   -- Extension to GTFS
   --
   constraint routes_fk foreign key (agency_id) references agency
)
pctfree 0;

create table trips (
   trip_id           varchar2( 30) primary key,       -- Note reordering of columns in ctl file
   route_id          not null,
   service_id        not null,
-- shape_id,
   trip_headsign     varchar2(100) not null,
   trip_short_name   varchar2(100),
   direction_id      number(1)     not null   check(direction_id in (0, 1)),
   block_id          varchar2(100),
   --
   constraint trips_fk_calendar foreign key (service_id) references calendar, -- sic!
   constraint trips_fk_routes   foreign key (route_id  ) references routes
)
pctfree 0;

create table stops (
   stop_id          varchar2( 30) primary key,
   stop_name        varchar2(100) not null,
   stop_lat         number,
   stop_lon         number,
-- stop_url         varchar2(100),
   location_type    varchar2(1),
   parent_station   references stops,
   --
   constraint stops_location_type check (location_type is null or location_type = '1')
)
pctfree 0;

create table stop_times (
   trip_id                           not null,
   arrival_time          varchar2(8) not null,
   departure_time        varchar2(8) not null,
   stop_id                           not null,
   stop_sequence         number(3)   not null,
-- stop_headsign         varchar2(1),
   pickup_type           number(1)   not null,
   drop_off_type         number(1)   not null,
-- shape_dist_travelled  number(8,2) not null,
   --
-- constraint stop_times_uq unique(trip_id, stop_id)
   constraint stop_times_pickup_type   check (pickup_type in (0,1)),
   constraint stop_times_drop_off_type check (pickup_type in (0,1)),
   constraint stop_times_fk_trips      foreign key (trip_id) references trips,
   constraint stop_times_fk_stops      foreign key (stop_id) references stops
)
pctfree 0;

create table transfers (
   from_stop_id         not null references stops,
   to_stop_id           not null references stops,
   transfer_type        number(1) not null check (transfer_type = 2),
   min_transfer_time    number(4) not null
)
pctfree 0;

exit
