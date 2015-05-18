select to_char(fim, 'dd/mm/yyyy hh24:mi:ss') as fim
     , to_char(inicio, 'dd/mm/yyyy hh24:mi:ss') as inicio
  from tb_teste_tempo;

 select trunc((fim-inicio)*24) as horas
      ,((((fim-inicio)*24)-trunc((fim-inicio)*24))*60) as minutos
  from tb_teste_tempo;

 select trunc((fim-inicio)*24) as horas
  from tb_teste_tempo;

 select trunc((fim-inicio)*1440) as minutos
  from tb_teste_tempo;

 select trunc((fim-inicio)*86400) as segundos
  from tb_teste_tempo;


