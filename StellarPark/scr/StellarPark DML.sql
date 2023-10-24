INSERT INTO tab_login VALUES('daniel@gmail.com','daniel123',3102223333);
INSERT INTO tab_login VALUES('martin@gmail.com','martin456',3114445555);
INSERT INTO tab_login VALUES('ana@gmail.com','ana789',3127778888);

INSERT INTO tab_vehi VALUES('AAA111','2020','chevrolet');

INSERT INTO tab_precioxhora VALUES(1,2000,1000,500);
INSERT INTO tab_precioxhora VALUES(2,3000,1000,500);
INSERT INTO tab_precioxhora VALUES(3,4000,2000,1000);

INSERT INTO tab_mensualidad VALUES(1,130000,35000,20000);
INSERT INTO tab_mensualidad VALUES(2,150000,35000,20000);
INSERT INTO tab_mensualidad VALUES(3,180000,50000,30000);

INSERT INTO tab_clien VALUES(12345678,'Maria','perez','AAA111','daniel@gmail.com');

INSERT INTO tab_gerente VALUES(1,'Daniel','perez','daniel@gmail.com');
INSERT INTO tab_gerente VALUES(2,'Martin','perez','martin@gmail.com');
INSERT INTO tab_gerente VALUES(3,'Ana','perez','ana@gmail.com');

INSERT INTO tab_parq VALUES(8600320957,'Ruby Parking','Carrera. 25 #45-22','7AM A 8PM Lunes a Domingo',TRUE,FALSE,30,30,1,1,1);
INSERT INTO tab_parq VALUES(8201569832,'Parqueadero Sotomayor','Calle. 48 #25-30','8AM A 9PM Lunes a Domingo',TRUE,FALSE,20,20,2,2,2);
INSERT INTO tab_parq VALUES(8965398157,'Cami Park','Carrera. 26 #48-45','6AM A 7PM Lunes a Domingo',TRUE,FALSE,15,15,3,3,3);

INSERT INTO tab_reserva VALUES(1,'2023-09-07 00:00:00','2023-09-07 23:00:00',12345678,8600320957);

INSERT INTO tab_puestos VALUES(1,8600320957,TRUE);

INSERT INTO tab_coment VALUES(1,'abcde','4',12345678,8600320957);