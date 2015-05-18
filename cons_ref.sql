set serverout on size 999999
set verify off

PROMPT "**************************************************"
ACCEPT nome_tabela char PROMPT "DIGITE O NOME DA TABELA: "
	
declare
cursor master is
select *
  from all_constraints
 where table_name = '&nome_tabela'
   and constraint_type = 'P';

cursor detail(pConstraintMaster VARCHAR2) is
select *
  from all_constraints
 where r_constraint_name = pConstraintMaster;

begin
	for m in master loop
		for d in detail(m.constraint_name) loop
			dbms_output.put_line(d.table_name||' - '||d.constraint_name||' - '||d.constraint_type);
		end loop;
	end loop;
end;
/
set verify on
