--Puzzle 1 Finding Distinct Values
 
SELECT DISTINCT
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl; --Found Distinct Values

--Puzzle 2 Removing Rows with All Zeroes
SELECT * 
FROM TestMultipleZero 
WHERE not (A = 0 and B = 0 and C = 0 and D = 0); -- Removed Rows with All Zeroes

--Puzzle 3 Find those with odd ids
 SELECT id,[name]
 FROM section1 
 WHERE id%2<>0;--Found those with odd ids

--Puzzle 4 Person with the smallest id
 
SELECT TOP 1 id, [name] 
FROM section1 
ORDER BY id ASC;  --Person with the smallest id

--Puzzle 5 Person with the highest id

SELECT TOP 1 id, [name]
FROM section1
ORDER BY id DESC -- Person with the highest id

--Puzzle 6 --People whose name starts with b

SELECT * 
FROM section1 
WHERE [name] like 'b%'; ----People whose name starts with b

--Puzzle 7 Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
SELECT code 
FROM ProductCodes 
WHERE code like '%[_]%' ; --Wrote a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).