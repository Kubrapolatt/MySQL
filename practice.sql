use sys;

CREATE TABLE people 
(
    ssn CHAR (9),
    name VARCHAR(50),
    address VARCHAR(80)
);

INSERT INTO PEOPLE VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO PEOPLE VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO PEOPLE VALUES (345678901, 'Marry Tien', 'New Jersey');
INSERT INTO PEOPLE (ssn, address) VALUES (456789012, 'Michigan');
INSERT INTO PEOPLE (ssn, address) VALUES (567890123, 'California');
INSERT INTO PEOPLE (ssn, name) VALUES (567890123, 'California');
SELECT * FROM PEOPLE ;


-- Boş adları "ad daha sonra eklenecek" olarak değiştirin

update PEOPLE 
set name='ad daha sonra eklenecek'
where name is null;

-- Boş adresleri 'Adres daha sonra eklenecek' olarak değiştirin
update PEOPLE 
set address='Adres daha sonra eklenecek'
where address is null;

-- people tablosunda 'Daha sonra eklenecek' tüm boş değerleri değiştirin

update PEOPLE 
set name=coalesce(name,'Daha sonra eklenecek');

-- -------------------------------------------------------------------------------------------------- --


-- Create işçi tablosu alanları worker_id,work_name,work_salary şeklindedir.
-- worker_id, worker_id_pk adında primary key sahip olacak
-- İşçiler tablosuna 4 kayıt ekleyin
-- Konsoldaki tabloya bakın
CREATE TABLE worker 
(
    worker_id char(3),
    worker_name VARCHAR(50),
    worker_salary int not null,
     CONSTRAINT worker_id_pk PRIMARY KEY (worker_id)
);

INSERT INTO WORKER VALUES ('100','Ali Can', 1200);
INSERT INTO WORKER VALUES ('102','Veli Han', 2000);
INSERT INTO WORKER VALUES ('103','Ayse Kan', 7000);
INSERT INTO WORKER VALUES ('104', 'Angie Ocean', 8500);
SELECT * FROM WORKER ;

-- En yüksek maaşın %20 oranında azaltarak Veli Han'ın maaşı olarak update edin.
update WORKER 
set worker_salary=(select max(worker_salary) from(select*from WORKER)AS W)-((select max(worker_salary)from (select*from WORKER)AS V)*0.20)
where worker_name='Veli Han';


-- EN DÜŞÜK MAAŞI %30 ARTTIRIN VE ALİ CAN'IN MEVCUT MAAŞI İLE UPDATE EDİN
update WORKER 
set worker_salary=(select max(worker_salary)*1.30 from(select*from WORKER)AS M)
where worker_name='Ali Can';

-- Maaş ortalama maaştan düşükse maaşları 1000 artırın




-- Maaşın ortalama maaştan az olması durumunda maaşları ortalama maaşa eşit 


















