set serverout on size 999999
set verify off
set define on

PROMPT "************* CONSULTA PK ********************"
ACCEPT nome_tabela char PROMPT "DIGITE O NOME DA TABELA: "
	
select CASE co.CONSTRAINT_TYPE
          WHEN 'P' THEN 1
          WHEN 'F' THEN 2
          WHEN 'U' THEN 3
          WHEN 'C' THEN 4
          ELSE 9 END as ordem
     , co.TABLE_NAME
     , co.CONSTRAINT_NAME
     , CASE co.CONSTRAINT_TYPE
          WHEN 'P' THEN 'PRIMARY-KEY'
          WHEN 'F' THEN 'FOREIGN-KEY'
          WHEN 'U' THEN 'UNIQUE-KEY'
          WHEN 'C' THEN 'CHECK'
          ELSE 'OTHERS' END as constraint_type
     , cc.column_name
  from all_constraints co
      ,all_cons_columns cc
 where co.constraint_name = cc.constraint_name
   and co.table_name = upper('&nome_tabela')
 order by 1;
   --and constraint_type = 'P';

set verify on
