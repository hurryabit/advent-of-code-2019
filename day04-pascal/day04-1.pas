(* day04-1.pas *)
VAR
  Low: Int32;
  High: Int32;
  Current: Int32;
  I: Int32;
  S: String;
  Count: Int32;
  NonDescending: Boolean;
  Double: Boolean;
BEGIN
  Low := 402328;
  High := 864247;
  Count := 0;
  FOR Current := Low TO High DO BEGIN
    Str(Current, S);
    NonDescending := TRUE;
    Double := FALSE;
    FOR I := 1 TO Length(S) - 1 DO BEGIN
      IF S[I] > S[I+1] THEN NonDescending := FALSE;
      IF S[I] = S[I+1] THEN Double := TRUE;
    END;
    IF NonDescending AND Double THEN Count := Count + 1;
  END;
  WriteLn(Count);
END.
