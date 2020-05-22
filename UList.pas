unit UList;

interface

  uses
    UData, Grids;

  type
    TPtr=^TNode;
    TNode=record
            Info:TInfo;
            Next:TPtr;
          end;

    TList=class
    private
      FHead:TPtr;
    public
      Function FindNode(K:TKey; var Pred:TPtr):boolean;
      Constructor Create;
      Destructor Destroy; override;
      Function Add(Info:TInfo):boolean;
      Function Delete(K:TKey):boolean;
      Function Find(K:TKey; var Info:TInfo):boolean;
      Procedure Clear;
      Procedure Print(SG : TStringGrid; var NumRow:integer);
      Procedure SaveToFile(var f:TFile);

      property Head:TPtr read FHead;
    end;

implementation

{ TList }

function TList.Add(Info: TInfo): boolean;
var P:TPtr;
begin
  New(P);
  P.Info:=Info;
  P.Next:=FHead;
  FHead:=P;
  Result:=true;
end;

procedure TList.Clear;
var P1:TPtr;
begin
  while (FHead<>nil) do
    begin
      P1:=FHead;
      FHead:=FHead.Next;
      Dispose(P1);
    end;
end;

constructor TList.Create;
begin
  Inherited Create;
  FHead:=nil;
end;

function TList.Delete(K: TKey): boolean;
var P,PTemp:TPtr;
begin
  Result:=FindNode(K,P);
  if Result then
    if (P<>nil) then
      begin
        PTemp:=P.Next;
        P.Next:=PTemp.Next;
        Dispose(PTemp);
      end
    else
      begin
        P:=FHead;
        FHead:=FHead.Next;
        Dispose(P);
      end;
end;

destructor TList.Destroy;
begin
  Clear;
  Inherited Destroy;
end;

function TList.Find(K: TKey; var Info: TInfo): boolean;
var P:TPtr;
begin
  Result:=FindNode(K,P);
  if Result then
    if (P<>nil) then
      Info:=P.Next.Info
    else
      Info:=FHead.Info;
end;

function TList.FindNode(K: TKey; var Pred: TPtr): boolean;
var t:TPtr;
    OK:boolean;
begin
  pred:=nil;
  t:=FHead;
  OK:=false;
  while (t<>nil) and (not OK) do
    if t.Info.Key=K then
      OK:=true
    else
      begin
        pred:=t;
        t:=t.Next;
      end;
  Result:=OK;
end;

Procedure TList.Print(SG:TStringGrid; var NumRow:integer);
var Ptr:TPtr;
begin
  Ptr:=FHead;
  while Ptr<>nil do
    begin
      inc(NumRow);
      SG.Rows[NumRow]:=PrintToGrid(Ptr.Info);
      Ptr:=Ptr.Next;
    end;
end;

procedure TList.SaveToFile(var f: TFile);
var Ptr:TPtr;
begin
  Ptr:=FHead;
  while Ptr<>nil do
    begin
      write(f,Ptr.Info);
      Ptr:=Ptr.Next;
    end;
end;

end.
