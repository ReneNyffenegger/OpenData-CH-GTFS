begin
--
-- Prevent ORA-01940: cannot drop a user that is currently connected
--     ( See https://renenyffenegger.ch/notes/development/databases/Oracle/errors/ORA-01940_cannot-drop-a-user-that-is-currently-connected )
--
   for r in (
      select
        'alter system kill session ''' || sid || ',' || serial# || ''' force'  stmt
      from
         gv$session
      where
         username ='GTFS_ZURICH') loop

         execute immediate r.stmt;
    end loop;
end;
/

drop user if exists gtfs_ch cascade;

create user gtfs_ch identified by gtfs_ch
   default   tablespace users
   temporary tablespace temp
   quota unlimited on users;


grant
   create session,
   create table,
   create view
to
   gtfs_ch;

exit

