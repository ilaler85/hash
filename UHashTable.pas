unit UHashTable;

interface
  uses
    UData,UList,Grids;

  const
    N=101;

  type
    TIndex=0..N-1;
    TCell=TList;
    TTable=array[TIndex] of TCell;
    THashTable=class
    private
      FTable:TTable;
      FCount:integer;
    protected
      Function HashFunc(Key:TKey):TIndex;
    public
      Constructor Create;
      Destructor Destroy;override;

      Procedure Clear;
      Function Add(info:TInfo):boolean;
      Function Search(Key:TKey; var info:TInfo):boolean;
      Function Delete(Key:TKey):boolean;
      Procedure Save(FileName:string);
      Function Load(FileName:string):boolean;
      Procedure Print(SG : TStringGrid);

      property Table:TTable read FTable;
      property Count:integer read FCount write FCount;
    end;

implementation

{ THashTable }

function THashTable.Add(info: TInfo): boolean;
var a:TIndex;
begin
  a:=HashFunc(Info.Key);
  Result:=FTable[a].Add(Info);
  FCount:=FCount+1;
end;

procedure THashTable.Clear;
var i:TIndex;
begin
  for i:=0 to N-1 do
    FTable[i].Clear;
  FCount:=0;
end;

constructor THashTable.Create;
var i:integer;
begin
  for i := 0 to N - 1 do
    FTable[i]:=TList.Create;
  FCount:=0;
end;

function THashTable.Delete(Key: TKey): boolean;
var a:integer;
begin
  a:=HashFunc(Key);
  Result:=FTable[a].Delete(Key);
  FCount:=FCount-1;
end;

destructor THashTable.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function THashTable.HashFunc(Key: TKey): TIndex;
begin
  Result:=HF(Key) mod N;
end;

function THashTable.Load(FileName: string): boolean;
var
  f:TFile;
  r:TInfo;
begin
  assignfile(f,FileName);
  result:=true;
  try
    reset(f);
    while (not eof(f)) and result do
      if LoadFromFile(f,r) then
        Add(r)
      else
        result:=false;
    closefile(f);
  except
    result:=false;
  end;

end;

procedure THashTable.Print(SG: TStringGrid);
var i,j:integer;
begin
  j:=0;
  for i := 0 to n - 1 do
    FTable[i].Print(SG,j);
end;

procedure THashTable.Save(FileName: string);
var
  f:TFile;
  i:integer;
begin
  assignfile(f,FileName);
  rewrite(f);
  for i:=0 to n-1 do
    FTable[i].SaveToFile(f);
  closefile(f);
end;

function THashTable.Search(Key: TKey; var info: TInfo): boolean;
var P:TPtr;
    a:integer;
begin
  a:=HashFunc(Key);
  Result:=FTable[a].FindNode(Key,P);
  if Result then
    if (P<>nil) then
      Info:=P.Next.Info
    else
      Info:=FTable[a].Head.Info;
end;


end.
