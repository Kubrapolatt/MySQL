use sys;

/*============================== JOIN İSLEMLERİ ===============================
    
    Set Operatorleri (Union,Union All, {oracle->Intersect,Minus}) farklı tablolardaki sutunlari 
    birlestirmek kullanilir.
    
    Join islemleri ise farklı Tablolari birlestirmek icin kullanilir. Diger 
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo 
    olusturmak icin kullanilabilir.
    
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
    icin JOIN islemleri kullanilabilir.
    
    mySQL'de 3 Cesit Join islemi kullanilabilmektedir.
    
    1) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    2) LEFT JOIN:  Ilk tabloda (Sol) olan sonuclari gosterir
    3) RIGHT JOIN: Sadece Ikinci tabloda (sağ) olan tum sonuclari gosterir
       full JOIN=(left join + union + right join) Tablodaki tum sonuclari gosterir
==============================================================================*/   
    CREATE TABLE şirketler 
    (
        şirket_id int, 
        şirket_isim VARCHAR(20)
    );
    
    INSERT INTO şirketler VALUES(100, 'Toyota');
    INSERT INTO şirketler VALUES(101, 'Honda');
    INSERT INTO şirketler VALUES(102, 'Ford');
    INSERT INTO şirketler VALUES(103, 'Hyundai');
    
    CREATE TABLE siparişler
    (
        sipariş_id int,
        şirket_id int, 
        sipariş_tarihi DATE
    );
    
    INSERT INTO siparişler VALUES(11, 101, '2020-04-17');
    INSERT INTO siparişler VALUES(22, 102, '2020-04-18');
    INSERT INTO siparişler VALUES(33, 103, '2020-04-19');
    INSERT INTO siparişler VALUES(44, 104, '2020-04-20');
    INSERT INTO siparişler VALUES(55, 105, '2020-04-21');
    
    select*from şirketler;
    select*from siparişler;
    
 /*=============================== INNER JOIN  ==================================
    
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
================================================================================  
    
  
/* -----------------------------------------------------------------------------
  ORNEK1: Iki Tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve 
  siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/     

    
	SELECT s.şirket_isim, sp.sipariş_id, sp.sipariş_tarihi, sp.şirket_id
    FROM siparişler sp  -- tablo önceliği farketmez
    INNER JOIN şirketler s 
    on s.şirket_id = sp.şirket_id; -- where yerine on yazilacak
    
    -- INNER JOIN ile sadece iki tabloki ortak olan satirlar secilir.
    -- Diger bir ifadeyle iki tablodaki ortak olan sirket_id degerleri icin 
    -- ilgili sutunlar listenir.
    
    -- INNER anahtar kelimesi opsiyoneldir.
    
   /*=============================== LEFT JOIN  ==================================
    
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/  
            
/* -----------------------------------------------------------------------------
  ORNEK2: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/    
  
  select şir.şirket_isim,sip.sipariş_id,sip.sipariş_tarihi,şir.şirket_id
  from şirketler şir
  left join siparişler sip
  on şir.şirket_id=sip.şirket_id;
    
   -- Left Join'de ilk tablodaki tum satirlar gosterilir.
    -- Ilk tablodaki satirlara 2.tablodan kosula uyan ortak satirlar 
	-- gosterilir, ancak ortak olmayan kisimlar bos kalir
          
/*=============================== RIGHT JOIN  ==================================
    
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/   
      
/* -----------------------------------------------------------------------------
  ORNEK3: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile 
  bunlara karşılık gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/  
    
   select şir.şirket_isim,sip.sipariş_id,sip.sipariş_tarihi
   from şirketler as şir
   right join siparişler as sip
   on şir.şirket_id=sip.şirket_id;
    
   -- Right Join'de 2. tablodaki tum satirlar gosterilir.
    -- 2 tablodaki satirlara 1.tablodan kosula uyan ortak satirlar gosterilir
    -- ancak ortak olmayan kisimlar bos kalirir.
    
    
    /*=============================== full JOIN  ==================================
    full JOIN: (left join + union all + right join)
   full  JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari 
    getirmek icin kullanilir. 
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    left JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
    union all
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    right JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
==============================================================================*/   
   
/* -----------------------------------------------------------------------------
  ORNEK4: sirketler ve siparisler adındaki tablolarda yer alan sirket_isim, 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/  
    
    select şir.şirket_isim,sip.sipariş_id,sip.sipariş_tarihi
    from şirketler as şir
    left join siparişler as sip
	on şir.şirket_id=sip.şirket_id
    union 
	select şir.şirket_isim,sip.sipariş_id,sip.sipariş_tarihi
    from şirketler as şir
    right join siparişler as sip
	on şir.şirket_id=sip.şirket_id;
    
   /* ******************************************************************************************* */ 
    	CREATE TABLE bolumler (
      bolum_id   int PRIMARY KEY,
      bolum_isim VARCHAR(14),
      konum      VARCHAR(13)
    );
    
    INSERT INTO bolumler VALUES (10,'MUHASEBE','IST');
    INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
    INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
    INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
    INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');

    CREATE TABLE personel (
      personel_id   int PRIMARY KEY,
      personel_isim VARCHAR(10),
      meslek        VARCHAR(9),
      mudur_id      int,
      maas          int,
      bolum_id      int
    );
    
   SELECT * FROM bolumler;
  
    INSERT INTO personel VALUES (7369,'AHMET','KATIP',1111,800,20);
    INSERT INTO personel VALUES (7499,'BAHATTIN','SATISE',1222,1600,30);
    INSERT INTO personel VALUES (7521,'NESE','SATISE',1222,1250,30);
    INSERT INTO personel VALUES (1111,'MUZAFFER','MUDUR',7839,2975,20);
    INSERT INTO personel VALUES (7654,'MUHAMMET','SATISE',1222,1250,30);
    INSERT INTO personel VALUES (1222,'EMINE','MUDUR',7839,2850,30);
    INSERT INTO personel VALUES (1333,'HARUN','MUDUR',7839, 2450,10);
    INSERT INTO personel VALUES (7788,'MESUT','ANALIST',1111,3000,20);
    INSERT INTO personel VALUES (7839,'SEHER','BASKAN',NULL,5000,10);
    INSERT INTO personel VALUES (7844,'DUYGU','SATISE',1222,1500,30);
    INSERT INTO personel VALUES (7876,'ALI','KATIP',1111,1100,20);
    INSERT INTO personel VALUES (7900,'MERVE','KATIP',1222,950,30);
    INSERT INTO personel VALUES (7902,'NAZLI','ANALIST',1111,3000,20);
    INSERT INTO personel VALUES (7934,'EBRU','KATIP',1333,1300,10);
    INSERT INTO personel VALUES (7956,'SIBEL','MIMAR',1333,3300,60);
    INSERT INTO personel VALUES (7933,'ZEKI','MUHENDIS',1333,4300,60);

    SELECT * FROM personel;
    
    
/* -----------------------------------------------------------------------------
  ORNEK1: SATIS ve MUHASEBE bolumlerinde calisan personelin isimlerini ve 
  bolumlerini, once bolum sonra isim sıralı olarak listeleyiniz
------------------------------------------------------------------------------*/ 
select p.personel_isim,b.bolum_isim
from bolumler b
join personel p
on p.bolum_id=b.bolum_id
where bolum_isim in('satis','Muhasebe')
order by b.bolum_isim,p.personel_isim;

-- bağlama işi join'lerde on keyword'ü ile yapılır

/* -----------------------------------------------------------------------------
  ORNEK2: SATIS,ISLETME ve DEPO bolumlerinde calisan personelin isimlerini,  
  bolumlerini  isim sıralı olarak listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/  
select b.bolum_isim,p.personel_isim

