select resultList =
(
    SELECT "text()" =
        iif(id1 < id2, convert(varchar(15), id1) +
        iif(id1 < (id2 - 1), ',' + CONVERT(VARCHAR(15), id2 - 1), ''), '') +
        iif(id3 IS NULL, iif(id1 < id2, ', ', '') ,',')
    FROM
    (
        SELECT
            id1 = isnull(lag(id) OVER (ORDER BY id), 0) + 1,
            id2 = id,
            id3 = lead(id) OVER (ORDER BY id)
        FROM TestTable
    ) res
    WHERE ( id1 < id2 ) OR ( id3 IS NULL )
    FOR xml path('')

)

