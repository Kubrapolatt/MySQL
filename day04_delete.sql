use sys;
-- ============================== DELETE ===================================  
    -- DELETE FROM tablo_adı;  Tablonun tüm içerğini siler.
    -- Bu komut bir DML komutudur. Dolayısıyla devamında WHERE gibi cümlecikler
    -- kullanılabilir.
    
    
    -- DELETE FROM tablo_adı
    -- WHERE sutun_adi = veri;
    drop table ogrenciler;
    CREATE TABLE öğrenciler
    (
        id CHAR(3),
        isim VARCHAR(50),
        veli_isim VARCHAR(50),
        yazili_notu int       
    );
  
    INSERT INTO öğrenciler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO öğrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
    INSERT INTO öğrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO öğrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
    INSERT INTO öğrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
    savepoint abc;
  
    -- savepoint sikintisi varsa -> SET autocommit=0; 
    -- ayarlar sql execution auto commit tiki kaldr
--    DELETE FROM ogrenciler;     -- Tüm verileri sil.
--    ROLLBACK TO  ABC;  -- Silinen Verileri geri getir.
--    SELECT * FROM öğrenciler;
    
/* =============================================================================
         Seçerek silmek için WHERE Anahtar kelimesi kullanılabilir. 
===============================================================================*/     
/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/ 
delete from öğrenciler
  where id='124';
  select*from öğrenciler;
    
    
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan satırını siliniz.
 -----------------------------------------------------------------------------*/   
     delete from öğrenciler
     where isim='Kemal Yasa';
      
      
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
 -----------------------------------------------------------------------------*/        
    delete from öğrenciler
     where isim ='Nesibe Yilmaz'or isim='Mustafa Bak';
     
      delete from öğrenciler
     where isim in('Nesibe Yilmaz','Mustafa Bak');
     
/* ----------------------------------------------------------------------------
  ORNEK4: İsmi Ali Can ve id'si 123 olan kaydı siliniz.
 -----------------------------------------------------------------------------*/    
       delete from öğrenciler
     where isim ='Ali Can'and id='123';
   
   select*from öğrenciler;
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan büyük olan kayıtları silelim.
 -----------------------------------------------------------------------------*/  
   delete from öğrenciler
     where id>126;
   
   select*from öğrenciler;
    
 
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 ve 126 olanları silelim.
 -----------------------------------------------------------------------------*/     
      delete from öğrenciler
     where id in(123,125,126);
    
    
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAKİ TÜM KAYITLARI SİLELİM..
 -----------------------------------------------------------------------------*/     
   delete from öğrenciler;
    
    
    
-- ******************************************************************************************    
    
      -- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz 
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir   
/* ======================== DELETE - TRUNCATE - DROP ============================   
  
  1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.
    Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML değil DDL komutudur.*/ 
         TRUNCATE TABLE öğrenciler;  -- doğru yazım
       
    
   /* 2-) DELETE komutu beraberinde WHERE cümleciği kullanılabilir. TRUNCATE ile 
    kullanılmaz.
        TRUNCATE TABLE ogrenciler
        WHERE veli_isim='Hasan';  .....yanlış yazım
        
-- TRUNCATE komutu tablo yapısını değiştirmeden, 
-- tablo içinde yer alan tüm verileri tek komutla silmenizi sağlar.
        
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylıkla geri 
    alınabilir.
    
    4-) Truncate ile silinen veriler geri alınması daha zordur. Ancak
    Transaction yöntemi ile geri alınması mümkün olabilir.
    
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da 
    siler. 
==============================================================================*/ 
    -- INSERT veri girişinden sonra SAVEPOİNT ABC; ile verileri buraya sakla
    -- (yanlışlık yapma olasılığına karşın önlem gibi, AYNI İSİMDE BAŞKA TABLO VARSA)
    -- sonra istediğini sil (ister tümü ister bir kısmı)
    -- sonra savepoint yaptığın yerden alttaki gibi rollback ile verileri geri getir
   
   
    INSERT INTO öğrenciler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO öğrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
    INSERT INTO öğrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO öğrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
    INSERT INTO öğrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
    savepoint abc;
    
    select*from öğrenciler;
   
   
   delete from öğrenciler;
    rollback to abc;
    
    
   
   
   
   
   
   