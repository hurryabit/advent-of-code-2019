rows% = 6
cols% = 25
size% = rows% * cols%

CLS
PRINT "Decoding..."

OPEN "INPUT.TXT" FOR INPUT AS #1
INPUT #1, alllayers$
CLOSE #1
numlayers% = LEN(alllayers$) / size%

DIM image$(size%)
FOR j% = 1 TO size%
  image$(j%) = " "
NEXT

FOR i% = 1 TO numlayers%
  layer$ = MID$(alllayers$, size% * (i% - 1) + 1, size%)
  FOR j% = 1 TO size%
    IF image$(j%) = " " THEN
      pixel$ = " "
      SELECT CASE MID$(layer$, j%, 1)
        CASE "0": pixel$ = "."
        CASE "1": pixel$ = "#"
      END SELECT
      image$(j%) = pixel$
    END IF
  NEXT j%
NEXT i%

FOR r% = 1 TO rows%
  row$ = ""
  FOR c% = 1 TO cols%
    row$ = row$ + image$(cols% * (r% - 1) + c%)
  NEXT c%
  PRINT row$
NEXT r%

