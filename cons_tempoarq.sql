set serverout on size 999999
declare
	vHoraOut		number;
	vMinOut		number;
	vSegOut		number;
	cursor c1 is
	select *
	  from tb_edi_arqretro
	 where nr_tipodoc    = 211
	   and ch_processado = 'S';
	--
	procedure GetTime
	(vIni in date
	,vFim in date
	,vHora out number
	,vMin out number
	,vSeg out number) as
	begin
		select trunc((vFim-vIni)*24) as horas
            ,trunc((((vFim-vIni)*24)-trunc((vFim-vIni)*24))*60) as minutos
            ,trunc(((((vFim-vIni)*24)-trunc((vFim-vIni)*24))*60)*60) as segundos
       into vHora,vMin,vSeg
       from dual;
	end;
begin
	for x in c1 loop
		getTime(vIni  => x.dt_proc_ini
		       ,vFim  => x.dt_proc_fim
		       ,vHora => vHoraOut
		       ,vMin  => vMinOut
		       ,vSeg  => vSegOut);
		--dbms_output.put_line('Arquivo: '||x.va_nomearquivo||' Hora: '||vHoraOut||' - Minutos: '||vMinOut||' - Segundos: '||vSegOut);
		dbms_output.put_line(vHoraOut||' Horas '||vMinOut||' Minutos '||vSegOut||' Segundos ');
	end loop;
	--
	select sum(dt_proc_fim - dt_proc_ini) into vTotalHoras
	  from tb_edi_arqretro
	 where nr_tipodoc    = 211
	   and ch_processado = 'S';
	
end;
/
