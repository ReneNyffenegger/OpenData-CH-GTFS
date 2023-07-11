-- purge recyclebin;

begin

   for r in (
      select
         index_name
      from
         user_indexes
      where
         status = 'UNUSABLE'
   ) loop

      execute immediate 'alter index ' || r.index_name || ' rebuild';

   end loop;

   for r in (
       select

          table_name      tab_nam,
          constraint_name con_nam
       from
          user_constraints
       where
          status = 'DISABLED'
    ) loop

       execute immediate 'alter table ' || r.tab_nam || ' modify constraint ' || r.con_nam || ' enable validate';

    end loop;
end;
/

exit
