DECLARE FUNCTION Count% (text$, char$)

size% = 25 * 6

OPEN "INPUT.TXT" FOR INPUT AS #1
INPUT #1, image$
CLOSE #1
numlayers% = LEN(image$) / size%
minlayer$ = ""
minlayercount% = size% + 1
FOR i% = 1 TO numlayers%
  layer$ = MID$(image$, size% * (i% - 1) + 1, size%)
  layercount% = Count(layer$, "0")
  IF layercount% < minlayercount% THEN
    minlayer$ = layer$
    minlayercount% = layercount%
  END IF
NEXT
PRINT Count%(minlayer$, "1") * Count%(minlayer$, "2")

FUNCTION Count% (text$, char$)
  result% = 0
  FOR i% = 1 TO LEN(text$)
    IF MID$(text$, i%, 1) = char$ THEN
      result% = result% + 1
    END IF
  NEXT
  Count% = result%
END FUNCTION

