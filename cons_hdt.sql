set serverout on size 999999
set lines 150
declare
	cursor c1 is
	select DISTINCT a.nomearquivo
		  ,a.cod
	  from tb_edi_arqretro r
		  ,tediarquivos a
	 where r.va_nomearquivo = a.nomearquivo
	   and r.nr_tipodoc = 211
	   and r.ch_processado is not null;

v_out 		varchar2(1000);
vhead			number;
vlote			number;
vdeta			number;
vtrai			number;
varquivos	number;

begin
	for x in c1 loop
		
		varquivos := nvl(varquivos,0) + 1;

		SELECT COUNT(*) into vhead from TEDI_HEADER_DEB_CONTA_FINANC WHERE CODARQUIVO = x.cod;
		SELECT COUNT(*) into vlote from TEDI_H_LOT_DEB_CON_ITAU_FINANC WHERE CODARQUIVO = x.cod;
		SELECT COUNT(*) into vdeta from TEDI_DEBITO_CONTA_FINANC WHERE CODARQUIVO = x.cod;
		SELECT COUNT(*) into vtrai from TEDI_TRAILER_DEB_CONTA_FINANC WHERE CODARQUIVO = x.cod;

		v_out := 'Arquivo : '||x.nomearquivo||chr(10)||
					'Total header  : '||vhead||chr(10)||
		         'Total lote    : '||vlote||chr(10)||
		         'Total detalhes: '||vdeta||chr(10)||
		         'Total trailer : '||vtrai||chr(10)||
		         rpad('=',30,'.')||'=';

		DBMS_OUTPUT.PUT_LINE(v_out);
		
		v_out := null;
		vhead	:= null;
		vlote	:= null;
		vdeta	:= null;
		vtrai	:= null;

   end loop;
	DBMS_OUTPUT.PUT_LINE('Arquivos processados: '||varquivos);
end;
/