-- FIND THE BOOKS THAT WHERE PUBLISHED IN NEW YORK

SELECT 
  * -- Selects all columns from the BOOK table
FROM  
  BOOK -- Specifies the BOOK table as the source
WHERE PUBLISHER_CODE IN  -- Filters books whose publisher code matches any in the subquery
(SELECT PUBLISHER_CODE FROM PUBLISHER WHERE
CITY = 'NEW YORK' ) -- Subquery: selects publisher codes where the city is 'NEW YORK'



SELECT
  * -- Selects all columns from the BOOK table
FROM 
  BOOK -- Specifies the BOOK table as the source
WHERE
  EXISTS ( -- Checks if the subquery returns any rows for each book
    SELECT * FROM PUBLISHER WHERE PUBLISHER.PUBLISHER_CODE = BOOK.PUBLISHER_CODE AND CITY = 'NEW YORK'
    -- Subquery: checks if there is a publisher with the same code as the book and city is 'NEW YORK'
  )


SELECT
  TITLE -- Selects only the TITLE column from the BOOK table
FROM
  BOOK -- Specifies the BOOK table as the source
WHERE
  BOOK_CODE IN ( -- Filters books whose code matches any in the subquery
      SELECT
        BOOK_CODE -- Selects book codes from the WROTE table
      FROM 
        WROTE -- Specifies the WROTE table as the source
      WHERE
        AUTHOR_NUM IN ( -- Filters for author numbers matching the subquery
          SELECT
            AUTHOR_NUM FROM AUTHOR
            WHERE AUTHOR_LAST = 'ROWLING'
            AND AUTHOR_FIRST = 'J.K.'
            -- Subquery: selects author numbers for 'J.K. ROWLING'
        )
  )



SELECT TITLE FROM BOOK WHERE BOOK_CODE IN (
    SELECT BOOK_CODE FROM INVENTORY WHERE ON_HAND >= 2
    -- Subquery: selects book codes from INVENTORY where at least 2 copies are on hand
)


SELECT
  AUTHOR_LAST, AUTHOR_FIRST -- Selects last and first names of authors
FROM
  AUTHOR -- Specifies the AUTHOR table as the source
WHERE
  AUTHOR_NUM IN  ( -- Filters authors whose number matches any in the subquery
    SELECT
      AUTHOR_NUM -- Selects author numbers from the WROTE table
    FROM
      WROTE -- Specifies the WROTE table as the source
    WHERE
      BOOK_CODE IN
      (
        SELECT BOOK_CODE FROM INVENTORY WHERE ON_HAND > 3
        -- Subquery: selects book codes from INVENTORY where more than 3 copies are on hand
      )
  )