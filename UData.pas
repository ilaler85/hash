unit UData;

interface

  uses
    Grids,Classes,SysUtils;

  type
    TKey=integer;

    TInfo=record
            Key:TKey;
            FIO:string[50];
            Zarplata:integer;
          end;

    TFile=File of TInfo;

  Function IsEqualKeys(const k1,k2:Tkey):boolean;
  Function LoadFromFile(var f:TFile; var info:TInfo):boolean;
  Procedure SaveToFile(var f:TFile; const Info:Tinfo);
  Function HF(Key:TKey):integer;
  Function PrintToGrid(info:TInfo):TStrings;
  Function StringsToInfo(Str:TStrings):TInfo;
  Function IsEqualInfo(const i1,i2:TInfo):boolean;
  Procedure InitInfo(var info:TInfo);
  Function GridTitle:TStrings;

implementation

Function StringsToInfo(Str:TStrings):TInfo;
begin
  with result do
    begin
      Key:=StrToInt(Str[0]);
      FIO:=Str[1];
      Zarplata:=StrToInt(Str[2]);
    end;
end;

Procedure InitInfo(var info:TInfo);
begin
  with info do
    begin
      Key:=1;
      FIO:='';
      Zarplata:=0;
    end;
end;

Function PrintToGrid(Info:TInfo):TStrings;
begin
  result:=TStringList.Create;
  with Info do
    begin
      result.Add(IntToStr(Key));
      result.Add(FIO);
      result.Add(IntToStr(Zarplata));
    end;

end;

Function IsEqualKeys(const k1,k2:Tkey):boolean;
begin
  result:=(k1=k2);
end;

Function IsEqualInfo(const i1,i2:TInfo):boolean;
begin
  result:=IsEqualKeys(i1.Key,i2.Key) and (i1.FIO=i2.FIO) and (i1.Zarplata=i2.Zarplata);
end;

Function LoadFromFile(var f:TFile; var info:TInfo):boolean;
begin
  result:=true;
  try
    read(f,info);
  except
    result:=false;
  end;
end;

Procedure SaveToFile(var f:TFile; const Info:Tinfo);
begin
  write(f,info);
end;

Function HF(key:TKey):integer;
begin
  result:=key;
end;

Function GridTitle:TStrings;
begin
  result:=TStringList.Create;
  result.Add('Табельный номер');
  result.Add('ФИО');
  result.Add('Заработная плата');
end;

end.
