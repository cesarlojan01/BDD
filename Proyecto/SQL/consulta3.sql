use ganado;
SELECT DISTINCT a.raza FROM ANIMAL a WHERE a.raza NOT IN (SELECT b.raza FROM ANIMAL b WHERE b.estado = 'VENDIDO');