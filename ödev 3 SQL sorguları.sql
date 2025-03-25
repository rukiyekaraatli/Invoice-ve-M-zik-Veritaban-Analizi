
--Soru 1: Invoice Tablosu

--“USA” ülkesine ait, 2009 yılı içerisinde oluşturulmuş tüm faturaların (Invoice) toplamını
--listeleyen bir sorgu yazınız.

--Önce tablomuzu inceleyim

SELECT * FROM invoice

-- Bu sorguyu yazarken şu adımları takip edebiliriz:

--billing_country sütununa göre "USA" filtresi ekleyelim.

--Fatura tarihini (invoice_date) 2009 yılıyla sınırlayalım.

--Faturaların toplamını hesaplayıp total_bill olarak atayalım (SUM(total)).

SELECT
      SUM(total) as total_bill
FROM invoice
WHERE billing_country = 'USA'
AND EXTRACT(YEAR FROM invoice_date)= 2009;

--Soru 2: Track, PlaylistTrack ve Playlist Tablolarında JOIN

--Tüm parça (track) bilgilerini, bu parçaların ait olduğu playlisttrack ve playlist tablolarıyla birleştirerek
--(JOIN) listeleyen bir sorgu yazınız.

-- Tabloları inceleyelim.

SELECT * FROM track
SELECT * FROM playlisttrack
SELECT * FROM playlist

-- 1. Yöntem

SELECT t.*
FROM track t
INNER JOIN playlisttrack pt ON pt.track_id = t.track_id
INNER JOIN playlist p ON p.playlist_id = pt.playlist_id

--2. Yöntem

SELECT 
    t.*
FROM track t
JOIN playlisttrack pt USING (track_id)
JOIN playlist p USING (playlist_id);

--Soru 3: Track, Album ve Artist Tablolarında JOIN
--"Let There Be Rock" adlı albüme ait tüm parçaları (Track) listeleyen, sanatçı (Artist) bilgisini
--de içeren bir sorgu yazınız. Ayrıca, sonuçları parça süresi (milliseconds) büyükten küçüğe
--sıralayınız.

--Tabloları inceleyelim

SELECT * FROM album
SELECT * FROM artist
SELECT * FROM track

--Bu sorguyu yazarken tabloları şu şekilde birleştirebiliriz:

--track tablosu (t) → Şarkılar burada tutulur.

--album tablosu (a) → Albüm adları burada yer alır ve album_id üzerinden track ile ilişkilidir.

--artist tablosu (ar) → Sanatçılar burada tutulur ve artist_id üzerinden album ile ilişkilidir.

--JOIN işlemleri ile bu tabloları birbirine bağlayacağız.

--Albüm adı "Let There Be Rock" olan parçaları filtreleyeceğiz.

--Sonuçları parça süresine (milliseconds) göre büyükten küçüğe sıralayacağız.

--1.Yöntem

SELECT 
    t.track_id, 
    t.name AS track_name, 
    ar.name AS artist_name, 
    a.title AS album_name, 
    t.milliseconds
FROM track t
INNER JOIN album a ON a.album_id = t.album_id
INNER JOIN artist ar ON ar.artist_id = a.artist_id
WHERE a.title = 'Let There Be Rock'
ORDER BY t.milliseconds DESC;

--2.Yöntem

SELECT 
    t.track_id, 
    t.name AS track_name, 
    ar.name AS artist_name, 
    a.title AS album_name, 
    t.milliseconds
FROM track t
JOIN album a USING (album_id)
JOIN artist ar USING (artist_id)
WHERE a.title = 'Let There Be Rock'
ORDER BY t.milliseconds DESC;
