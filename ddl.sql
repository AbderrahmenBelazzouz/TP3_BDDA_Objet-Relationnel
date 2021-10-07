create or replace type  td3_AdresseTy as object
	  (numero int, rue varchar(20), ville varchar(20)); 
/
create type  td3_EnseignantTy as object 
	(ide int, nom varchar(20), prenom varchar(20),
		genre char(1), adresse td3_AdresseTy);
/
create type td3_CoursTy as object 
(nsalle int, jour varchar(10), hdebut date, hfin date);
/
create type td3_CoursListeTy as Table of td3_CoursTy;
/
create type td3_ModuleTy as object(nom varchar(20),
     code varchar(10), Cours td3_CoursListeTy,
       responsable ref td3_EnseignantTy);
/
create table td3_EnseignantTable of td3_enseignantTy
	 (ide primary key, check(genre in ('f','h')));
/
create table td3_ModuleTable of td3_ModuleTy
	(code primary key) nested table cours store as coursOfmodule;


------------------insertion-------------------------------

insert into td3_EnseignantTable values (1,'ali','said', 'h',
            td3_AdresseTy(12,'attrt','sba'));

insert into td3_EnseignantTable values(2, 'azziz','rafika','f',
            td3_AdresseTy(2,'maconie','sba'));


insert into  td3_moduleTable select  'BDDs avancées','uef_5.1', 
   td3_CoursListeTy(
 	td3_Coursty(5,'dimanche',to_date('08:00','hh24:mi'),to_date('10:00','hh24:mi')),
    td3_Coursty(3,'mercredi',to_date('10:00','hh24:mi'),to_date('12:00','hh24:mi'))),

      ref(e)  from  td3_EnseignantTable e 
           where e.nom= 'ali' and e.prenom='said'; 	       	              



           insert into
            Table(select m.cours from td3_moduleTable m where m.nom='IA') 
              values (2, 'jeudi', to_date('10:00','hh24:mi'),to_date('11:00','hh24:mi'));


 update td3_EnseignantTable e 
 	  set e.adresse.rue='gmabita' where ide=1;


select e.nom, e.prenom from td3_EnseignantTable e where
     e.adresse.ville='sba';

select m.code, m.nom from td3_moduleTable m 
   where m.code not in(
   select m2.code from td3_moduleTable m2, table(m2.cours) c
      	                    where c.jour <>'lundi');      