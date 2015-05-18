column object_name format A30
select owner
     , object_name
     , object_type
     , to_char(last_ddl_time,'yyyy-mm-dd') as last_ddl_time
     , timestamp
  from dba_objects
 where object_name = '&objeto';
