
create type cont_type as enum ('physique','morale') ;

create table modele(
	nom VARCHAR(100),
	version VARCHAR(100),
	PRIMARY KEY (nom,version)
);



create table skin (
	nom_skin VARCHAR(100),
	nom VARCHAR(100),
	version VARCHAR(100),
	PRIMARY KEY (nom,version)
);


create table extension (
	nom_skin VARCHAR(100),
	PRIMARY KEY (nom,version)
);



create table asso_modele_skin( nom_skin VARCHAR(100), version VARCHAR(100), nom_modele VARCHAR(100), PRIMARY KEY (nom_skin,version,nom_modele), FOREIGN KEY (nom_skin) REFERENCES skin(nom_skin), FOREIGN KEY (nom_modele,version) REFERENCES modele(nom,version) )  ;

create table projet ( num_projet INT PRIMARY KEY, code VARCHAR(500), titre VARCHAR(300), description VARCHAR(1000), date_proj DATE, misenAvant BOOLEAN )  ;

create table lien (lien VARCHAR(200) PRIMARY KEY)  ;

create table contient ( num_proj INT, lien VARCHAR(100), mot_cle VARCHAR(100),PRIMARY KEY (num_proj,lien), FOREIGN KEY (lien) REFERENCES lien(lien), FOREIGN KEY (num_proj) REFERENCES projet(num_projet) )   ;

create table asso_proj ( proj1 INT, proj2 INT, PRIMARY KEY (proj1,proj2), FOREIGN KEY (proj1) REFERENCES projet(num_projet), FOREIGN KEY (proj2) REFERENCES projet(num_projet) )   ;

create table url ( url VARCHAR(200) PRIMARY KEY, num_proj INT, FOREIGN KEY (num_proj) REFERENCES projet(num_projet) );

create table image ( nom VARCHAR(100) PRIMARY KEY, dim_x INT, dim_y INT );

create table asso_projet_image ( nom_image VARCHAR(100), num_proj INT,PRIMARY KEY (nom_image,num_proj), FOREIGN KEY (nom_image) REFERENCES image(nom), FOREIGN KEY (num_proj) REFERENCES projet(num_projet) );

create table contact ( num_contact INT PRIMARY KEY, nom VARCHAR(100), telephone CHAR(10), email VARCHAR(50), siret VARCHAR(50), type cont_type NOT NULL);

create view vPhysique (num_contact,nom,telephone,email,siret,type) AS SELECT * FROM contact where type= 'physique';

create view vMorale (num_contact,nom,telephone,email,siret,type) AS SELECT * FROM contact where type= 'morale';

create table asso_contact_projet ( num_proj int, num_contact int, PRIMARY KEY (num_proj,num_contact), FOREIGN KEY (num_proj) REFERENCES projet(num_projet), FOREIGN KEY (num_contact) REFERENCES contact(num_contact) );

create table archive ( num_proj int, date_archivage date UNIQUE NOT NULL, PRIMARY KEY (num_proj), FOREIGN KEY (num_proj) REFERENCES projet(num_projet) );

 create view vArchive (num_proj, code, description,date, misenAvant,date_archivage) as SELECT projet.num_projet,projet.code,projet.description,projet.date_proj,projet.misenAvant,archive.date_archivage FROM projet,archive WHERE projet.num_projet=archive.num_proj;

 
 
 
INSERT INTO projet VALUES (1,'le code du projet','projet1','une description du projet','2015-12-01',true),
(2,'code du deuxieme projet','projet2','une description de ce projet','2015-11-01',false), 
(3,'le code de ce projet','projet3','une autre description pour un autre projet','2015-10-01',true),
(4,'le code pour un autre projet','projet4','la dernière description de projet','2015-09-01',false);

INSERT INTO archive VALUES (3,'2015-11-23'), 
(4,'2015-10-29') ;

INSERT INTO contact VALUES (1,'henry','0656459532','henry@truc.com','05MY25A','physique'),
(2,'arduino','0312255458','arduino@uno.it','05M1525A','morale') ;

INSERT INTO asso_contact_projet VALUES (1,2), (1,1), (3,2) ;

INSERT INTO image VALUES ('licorne', 15,35), ('chimere',23,42) ;

INSERT INTO lien VALUES ('lienverstruc'),('lienversmachin'),('lienverschouette') ;

INSERT INTO modele VALUES ('truc', 35), ('truc',20),('machin',35) ;

INSERT INTO skin VALUES ('skin1'),('skin2');

INSERT INTO asso_modele_skin VALUES ('skin1',35,'truc'),('skin2',35,'machin'),('skin1',20,'truc');

INSERT INTO asso_proj VALUES (1,2),(1,3),(4,2);

INSERT INTO asso_projet_image VALUES ('licorne',1),('chimere',3),('licorne',3);
