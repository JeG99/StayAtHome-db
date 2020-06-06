-- 1. Name of Movie with daily rent greater than $15
SELECT v.title
FROM video v
WHERE v.dailyRental > 2;

-- 2. Name of clients that have movies rented and not returned
SELECT fName, lName
FROM (SELECT * FROM rentalagreement r WHERE r.dateReturn = NULL) r1 
INNER JOIN member m 
ON (r1.memberNo = m.memberNo);

-- 3. Name of the movie that has never been rented
SELECT title
FROM (
	SELECT catalogNo
	FROM (
		(SELECT v.videoNo FROM videoforrent v WHERE v.videoNo NOT IN (SELECT r.videoNo FROM rentalagreement r)
	) peliculas_no_rentadas 
	INNER JOIN videoforrent v1 
	ON (peliculas_no_rentadas.videoNo = v1.videoNo))
) never_rented
INNER JOIN video v3 
ON (never_rented.catalogNo = v3.catalogNo);

-- 4. Name of the movie and name of the director for movies rented by women
SELECT title, directorName
FROM (
	SELECT directorNo, title
	FROM (
		SELECT catalogNo
		FROM (
			SELECT videoNo
			FROM (
				SELECT m.memberNo
				FROM member m WHERE m.sex = 'F'
			) mujeres
			INNER JOIN rentalagreement r
			ON (mujeres.memberNo = r.memberNo)
		) videos_mujeres
		INNER JOIN videoforrent vfr
		ON (videos_mujeres.videoNo = vfr.videoNo)
	) vm_vfr
	INNER JOIN video v
	ON (vm_vfr.catalogNo = v.catalogNo)
) vm_vfr_v
INNER JOIN director d
ON (vm_vfr_v.directorNo = d.DirectorNo);

-- 5. Name of the clients that don ́t have movies to return
SELECT fName, lName
FROM (
	SELECT m.memberNo
	FROM member m
	WHERE m.memberNo
	NOT IN (
		SELECT ra.memberNo
		FROM rentalagreement ra
		WHERE ra.dateReturn = NULL
	)
) sin_pendientes
INNER JOIN member m
ON (sin_pendientes.memberNo = m.memberNo);

-- 6. Name of movies available for rent.
SELECT title
FROM videoforrent vfr INNER JOIN video v 
ON (vfr.catalogNo = v.catalogNo)
WHERE vfr.available = 1;

-- 7. Name of movie and name of director for movies rented for clients with last name Lopez.
SELECT v.title , d.DirectorName
FROM rentalagreement ra , member m , videoForRent vfr , video v , director d
WHERE ra.memberNo = m.memberNo 
	AND ra.videoNo = vfr.videoNo 
	AND vfr.catalogNo = v.catalogNo 
	AND v.directorNo = d.directorNo 
	AND m.lName = 'Lopez';

-- 8. First Name and last name of all male clients born before 1989
SELECT m.fName, m.lName
FROM member m
WHERE YEAR(m.DOB) < 1989 
	AND sex = 'M';
