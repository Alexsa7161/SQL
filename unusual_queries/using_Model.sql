/*
Для произвольной строки, состоящей из открывающих и закрывающих скобок написать запрос для вывода всех слов максимальной длины,
представляющих правильные скобочные записи. Например, для строки  (()(() ответ должен быть:
()()
(())
*/
with t as( select '(()(()' str from dual),
t1 as(
select str,level rn,substr(str,level,1) let from t
connect by level <=length(str)
),
t2 as(
select rownum rn, str, nabor from(
select distinct str, replace( Sys_Connect_By_Path(let, ' '), ' ') nabor from t1
connect by prior rn<rn)),
mod as
(select rn,num,nabor,summa from t2
model unique single reference
PARTITION by (rn)
dimension by (cast(0 as number(10)) num)
measures (str,nabor,cast(0 as number(10)) summa)
rules
iterate(1000) until (iteration_number>length(str[0]))
(
summa[0]=0,
nabor[iteration_number+1]=nabor[0],
summa[iteration_number+1]= case substr(nabor[0],iteration_number+1,1)
when '(' then summa[iteration_number]+1
when ')' then summa[iteration_number]-1
else summa[iteration_number] end
)
order by 1,2),
pravilnie_nabory as(
select nabor from mod
where num=length(nabor) and summa=0
minus
select distinct m.nabor from mod join mod m
on m.rn=mod.rn and m.summa<0)
select nabor from pravilnie_nabory
where length(nabor)=(select max(length(nabor)) from pravilnie_nabory)
Order by nabor desc;
