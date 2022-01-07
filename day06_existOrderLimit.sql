use sys;

/*=========================== EXISTS, NOT EXIST ================================
   EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanımına benzer olarak,
    EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde 
   bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar. 
   
   EXISTS operatorü bir Boolean operatördür ve true - false değer döndürür. 
    EXISTS operatorü sıklıkla Subquery'lerde satırların doğruluğunu test etmek 
    için kullanılır.
    
    Eğer bir subquery (altsorgu) bir satırı döndürürse EXISTS operatörü de TRUE 
    değer döndürür. Aksi takdirde, FALSE değer döndürecektir.
    
    Özellikle altsorgularda hızlı kontrol işlemi gerçekleştirmek için kullanılır
==============================================================================*/
   
    CREATE TABLE mart
    (
        urun_id int,
        musteri_isim varchar(50), 
        urun_isim varchar(50)
    );
    
    CREATE TABLE nisan 
    (
        urun_id int ,
        musteri_isim varchar(50), 
        urun_isim varchar(50)
    );
    
  
    INSERT INTO mart VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart VALUES (20, 'John', 'Toyota');
    INSERT INTO mart VALUES (30, 'Amy', 'Ford');
    INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
    INSERT INTO mart VALUES (10, 'Adam', 'Honda');
    INSERT INTO mart VALUES (40, 'John', 'Hyundai');
    INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');
   
    INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
    INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
    INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
    INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
    INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');
    
    select*from mart;
    select*from nisan;
    
/* -----------------------------------------------------------------------------
  ORNEK1: MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
  URUN_ID'lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/ 
   
   -- 1.Yol 
   select urun_id,musteri_isim from mart
   where urun_id in(select urun_id from nisan where mart.urun_id=nisan.urun_id);
    
   -- 2.Yol
   select urun_id,musteri_isim from mart
   where exists(select urun_id from nisan where mart.urun_id=nisan.urun_id);
    
/* -----------------------------------------------------------------------------
  ORNEK2: Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
  NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/
    select urun_isim,musteri_isim from nisan as n
    where exists (select urun_isim from mart m where n.urun_isim=m.urun_isim);
    
 /* -----------------------------------------------------------------------------
  ORNEK3: Her iki ayda birden satılmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
  NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız. 
 -----------------------------------------------------------------------------*/
    select urun_isim,musteri_isim from nisan as n
    where not exists (select urun_isim from mart m where n.urun_isim=m.urun_isim);
    
  /*===================== IS NULL, IS NOT NULL, COALESCE ========================
    
    IS NULL, ve IS NOT NULL, BOOLEAN operatörleridir. Bir ifadenin NULL olup 
    olmadığını kontrol ederler.  
    
    COALESCE ise bir fonksiyondur ve içerisindeki parameterelerden NULL olmayan
    ilk ifadeyi döndürür. Eğer aldığı tüm ifadeler NULL ise NULL döndürürür.
    
    sutun_adi = COALESCE(ifade1, ifade2, .....ifadeN)
    
==============================================================================*/

    CREATE TABLE insanlar 
    (
        tc CHAR(9), -- Social Security Number
        isim VARCHAR(50), 
        adres VARCHAR(50) 
    );

    INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar (tc, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar (tc, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar (adres) VALUES('Sakarya');
    INSERT INTO insanlar (tc) VALUES('999111222');  
    
    select*from insanlar;
    
-- Örnek1: İnsanlar tablsounda ismi null olanları sorgulayınız.
    
    select * from insanlar
    where isim is null;
    
-- Örnek2: İnsanlar tablsounda ismi null olmayanları sorgulayınız.
    
    select * from insanlar
    where isim is not null;
    
/* ------------------------------------------------------------------------------------------
  ORNEK3: isim 'i NULL olan kişilerin isim'ine NO NAME atayınız. kisa soruda eski yolla olur
--------------------------------------------------------------------------------------------*/

update insanlar
set isim='No Name'
where isim is null;

select*from insanlar;

-- Tabloyu eski haline döndürüyoruz

update insanlar
set isim=null
where isim='No Name';

select*from insanlar;

/* ----------------------------------------------------------------------------
  ORNEK4:   isim 'i NULL olanlara 'Henuz isim girilmedi'
            adres 'i NULL olanlara 'Henuz adres girilmedi'
            tc 'si NULL olanlara ' tc yok ' atayalım.
            çoklu değişimde ve  WHERE isim IS NULL or adres is null....; 
            gibi ifade yazmamak için. coalesce=birleşmek
-----------------------------------------------------------------------------*/   

update insanlar
set isim=coalesce(isim,'Henuz isim girilmedi'),
    adres=coalesce(adres,'Henuz adres girilmedi'),
	tc=coalesce (tc,' tc yok ');

select*from insanlar;

/*================================ ORDER BY  ===================================
   ORDER BY cümleciği bir SORGU deyimi içerisinde belli bir SUTUN'a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
==============================================================================*/       
    CREATE TABLE kişiler 
    (   id int PRIMARY KEY,
        tc CHAR(9) ,
        isim VARCHAR(50), 
        soyisim VARCHAR(50), 
        maaş int,
        adres VARCHAR(50) 
    );
    
    INSERT INTO kişiler VALUES(1,123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kişiler VALUES(2,234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kişiler VALUES(3,345678901, 'Mine','Bulut',4200,'Adiyaman');
    INSERT INTO kişiler VALUES(4,256789012, 'Mahmut','Bulut',3150,'Adana');
    INSERT INTO kişiler VALUES (5,344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kişiler VALUES (6,345458901, 'Veli','Yilmaz',7000,'Istanbul');

    INSERT INTO kişiler VALUES(7,123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kişiler VALUES(8,234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kişiler VALUES(9,345678901, 'Mine','Bulut',4200,'Ankara');
    INSERT INTO kişiler VALUES(10,256789012, 'Mahmut','Bulut',3150,'Istanbul');
    INSERT INTO kişiler VALUES (11,344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kişiler VALUES (12,345458901, 'Veli','Yilmaz',7000,'Istanbul');
    
/* ----------------------------------------------------------------------------
  ORNEK1: kisiler tablosunu adres'e göre sıralayarak sorgulayınız.
 -----------------------------------------------------------------------------*/ 
    
 select *from kişiler
 order by adres;
    

    
/* ----------------------------------------------------------------------------
  ORNEK2: kisiler tablosunu maaş'a göre ters sıralayarak sorgulayınız.
 -----------------------------------------------------------------------------*/ 
    
 select*from kişiler
 order by maaş desc;
    
 
 
  /* ----------------------------------------------------------------------------
  ORNEK4: ismi Mine olanları, SSN'e göre AZALAN sırada sorgulayınız.
-----------------------------------------------------------------------------*/
    select*from kişiler
    where isim='Mine'
    order by tc desc;
    
/* ----------------------------------------------------------------------------
  ORNEK5: soyismi 'i Bulut olanları ssn sıralı olarak sorgulayınız.
-----------------------------------------------------------------------------*/   
    -- 1.Yol
    select*from kişiler
    where soyisim='Bulut'
    order by maaş;
    
    -- 2.Yol
	 select*from kişiler
     where soyisim='Bulut'
     order by 5; -- maaşın bulunduğu sütunu da yazabiliriz
    
--     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LİMİT xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 
   
-- Listeden ilk 10 veriyi getir
 
 select*from kişiler limit 10;
 
-- 10. veriden sonraki 2 veriyi al (11. ve 11. veri)
  
select*from kişiler limit 10,2;  -- aradaki virgül 10 dahil değil sonraki ikiyi dahil et demek
-- select*from kişiler where id>10 limit 2; -- diğeriyle aynı yola çıkıyor
    
/* ----------------------------------------------------------------------------
  ORNEK1: MAAŞ'ı en yüksek 3 kişinin bilgilerini listeleyen sorguyu yazınız.
-------------------------------------------------------------------------------*/   
   
   --  MySQL çözümü                                     -- Oracle çözümü                                   
   select*from kişiler                                  -- select*from kişiler
   order by maaş desc                                   --  order by maaş desc
   limit 3;                                             --  fetch next 3 rows only; */
    
/* ----------------------------------------------------------------------------
  ORNEK2: MAAŞ'a göre sıralamada 4. 5.  6. kişilerin bilgilerini listeleyen 
  sorguyu yazınız.
-----------------------------------------------------------------------------*/   
   
   select*from kişiler
   order by maaş limit 3,3;
    
   
    
    
    
    
    
    

