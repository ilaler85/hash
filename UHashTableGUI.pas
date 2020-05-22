unit UHashTableGUI;

interface

  uses
    Grids,Classes,SysUtils,UHashTable,UData,UList;

  type
    THashTableGUI=class(THashTable)
    private
      FFileName:string;
      FModified:boolean;
      FGrid:TStringGrid;
    public
      Constructor Create (AGrid : TStringGrid);
      Destructor Destroy;override;
      Procedure Clear;
      function Delete(key: TKey): boolean;
      Procedure Save(FileName:string);
      Procedure Load(FileName:string);
      Function Add(info:TInfo):boolean;
      Procedure CopyToGrid;

      property FileName:string read FFileName;
      property Modified:boolean read FModified;
      property Grid:TStringGrid read FGrid;
    end;

implementation

constructor THashTableGUI.Create(AGrid : TStringGrid);
begin
  Inherited Create;
  FFileName:='';
  FModified:=false;
  FGrid:=AGrid;
  CopyToGrid;
end;

destructor THashTableGUI.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure THashTableGUI.Clear;
begin
  inherited Clear;
  FModified:=true;
  CopyToGrid;
end;

function THashTableGUI.Add(info: TInfo): boolean;
begin
  if inherited Add(info) then
    begin
      FModified:=true;
      result:=true;
      FGrid.RowCount:=Count+1;
      FGrid.Rows[Count]:=PrintToGrid(info);
    end
  else
    result:=false;
end;

function THashTableGUI.Delete(key: TKey): boolean;
begin
  if inherited Delete(key) then
    begin
      FModified:=true;
      result:=true;
    end
  else result:=false;
end;

Procedure THashTableGUI.Save(FileName: string);
begin
  inherited Save(FileName);
  FModified:=false;
  FFileName:=FileName;
end;

procedure THashTableGUI.CopyToGrid;
begin
  if Count=0 then
    begin
      FGrid.RowCount:=2;
      FGrid.Rows[1].Clear;
    end
  else
    begin
      FGrid.RowCount:=Count+1;
      inherited Print(FGrid);
    end;
end;

procedure THashTableGUI.Load(FileName: string);
begin
  if inherited Load(FileName) then
    begin
      CopyToGrid;
      FFileName:=FileName;
      FModified:=false;
    end;
end;

end.
