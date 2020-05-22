unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ActnList, StdActns, ToolWin, ComCtrls, ExtCtrls,
  StdCtrls, Buttons, ImgList;

type
  TFrmMain = class(TForm)
    MainMenu: TMainMenu;
    MMFile: TMenuItem;
    MMNew: TMenuItem;
    MMOpen: TMenuItem;
    MMSave: TMenuItem;
    MMSaveAs: TMenuItem;
    MMClose: TMenuItem;
    MMExit: TMenuItem;
    MMEdit: TMenuItem;
    MMAdd: TMenuItem;
    MMEditing: TMenuItem;
    MMClear: TMenuItem;
    MMFind: TMenuItem;
    MMDelete: TMenuItem;
    StGrMain: TStringGrid;
    ActListMain: TActionList;
    ActExit: TFileExit;
    ActSave: TAction;
    ActNew: TAction;
    ActClose: TAction;
    ActAdd: TAction;
    ActEdit: TAction;
    ActClear: TAction;
    ActDelete: TAction;
    ActFind: TAction;
    TBMain: TToolBar;
    Splttr: TSplitter;
    Panel1: TPanel;
    LblSeRe: TLabel;
    StGrOut: TStringGrid;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    ActOpen: TAction;
    ActSaveAs: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    BitBtn: TBitBtn;
    ImageList: TImageList;
    procedure ActNewExecute(Sender: TObject);
    procedure ActSaveAsExecute(Sender: TObject);
    procedure ActOpenExecute(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure BitBtnClick(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ActClearExecute(Sender: TObject);
    procedure ActAddExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MainIdle (Sender : TObject; var Done : boolean);
  private
    procedure DelRow(Grid:TStringGrid; k:integer);
  public
    procedure YesSearch;
  end;

var
  FrmMain: TFrmMain;

implementation

uses UData, UHashTableGUI, UFormEdit, UFormFind, UHashTable, UList;

 var Hash:THashTableGUI;
{$R *.dfm}

procedure TFrmMain.DelRow(Grid: TStringGrid; k:integer);
var i:integer;
begin
  for i:=k to Grid.RowCount-2 do
    Grid.Rows[i]:=Grid.Rows[i+1];
  if Hash.Count>0 then
    Grid.RowCount:=Grid.RowCount-1
  else
    Grid.Rows[1].Clear;
end;

procedure TFrmMain.ActAddExecute(Sender: TObject);
begin
  with FrmEdt do
    begin
      InitInfo(Info);
      if (ShowModal=mrOK)then
        if not(Hash.Add(info))then
          MessageDlg('Добавление невозможноо!' , mtInformation , [mbOk] , 0);
    end;

end;

procedure TFrmMain.ActClearExecute(Sender: TObject);
begin
  if Assigned(Hash) then
    Hash.Clear;
end;

procedure TFrmMain.ActCloseExecute(Sender: TObject);
var ok:integer;
    kk:boolean;
begin
  kk:=true;
  if Assigned(Hash) and Hash.Modified then
    begin
      ok:=MessageDlg('Сохранить файл?'+Hash.FileName,mtConfirmation,[mbYes,mbNo,mbCancel],0);
      case ok of
        mrYes:
          begin
            ActSave.Execute;
            kk:= not Hash.Modified;
          end;
        mrNo:
          kk:=true;
        mrCancel:
          kk:=false;
      end;
    end;
  if kk then
    FreeAndNil(Hash);
end;

procedure TFrmMain.ActDeleteExecute(Sender: TObject);
var info:TInfo;
begin
  with Hash do
    begin
      info:=StringsToInfo(StGrMain.Rows[StGrMain.Row]);
      if Delete(info.Key) then
        DelRow(Grid,Grid.Row);
    end;
end;

procedure TFrmMain.ActEditExecute(Sender: TObject);
var r:TInfo;
begin
  with FrmEdt do
    begin
      info:=StringsToInfo(StGrMain.Rows[StGrMain.Row]);
      r:=info;
      if (ShowModal=mrOk) then
        if not(Hash.Delete(r.Key) and Hash.Add(Info))then
          MessageDlg('Невозможно изменить запись!' , mtInformation , [mbOk] , 0);
    end;
end;

procedure TFrmMain.ActFindExecute(Sender: TObject);
var info:TInfo;
begin
  with FrmFind do
    if ShowModal=mrOk then
      begin
        if Hash.Search(Key,info) then
          begin
             StGrOut.Rows[0]:=PrintToGrid(info);
             YesSearch;
          end
        else
        begin
          MessageDlg('Ничего не найдено' , mtInformation , [mbOk] , 0 );
        end;
      end;
end;

procedure TFrmMain.ActNewExecute(Sender: TObject);
begin
  if Hash<>nil then
    ActClose.Execute;
  if Hash=nil then
    Hash:=THashTableGUI.Create(StGrMain);
end;

procedure TFrmMain.ActOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
    begin
      if Hash<>nil then
        ActClose.Execute;
      if Hash=nil then
        begin
          Hash:=THashTableGUI.Create(StGrMain);
          Hash.Load(OpenDialog.FileName);
        end
    end;
end;

procedure TFrmMain.ActSaveExecute(Sender: TObject);
begin
  if Assigned(Hash) then
    if (Hash.FileName='') then
      ActSaveAs.Execute
    else
      Hash.Save(Hash.FileName);
end;


procedure TFrmMain.ActSaveAsExecute(Sender: TObject);
begin
  SaveDialog.FileName:=Hash.FileName;
  if SaveDialog.Execute and Assigned(Hash) then
    Hash.Save(SaveDialog.FileName);
end;

procedure TFrmMain.BitBtnClick(Sender: TObject);
begin
  Panel1.Height:=1;
  StGrOut.Rows[0].Clear;
  Splttr.Visible:=false;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Hash:=THashTableGUI.Create(StGrMain);
  StGrMain.Rows[0]:=GridTitle;
  Application.OnIdle:=MainIdle;
end;

procedure TFrmMain.YesSearch;
begin
  Splttr.Visible:=true;
  Panel1.Height:=47;
  LblSeRe.Height:=21;
end;

procedure TFrmMain.MainIdle(Sender: TObject; var Done: boolean);
begin
  ActSave.Enabled:=Hash<>nil;
  ActSaveAs.Enabled:=Hash<>nil;
  ActEdit.Enabled:=(Hash<>nil) and (Hash.Count<>0);
  ActAdd.Enabled:=Hash<>nil;
  ActClear.Enabled:=(Hash<>nil) and (Hash.Count<>0);
  ActClose.Enabled:=Hash<>nil;
  ActDelete.Enabled:=(Hash<>nil) and (Hash.Count<>0);
  ActFind.Enabled:=(Hash<>nil) and (Hash.Count<>0);
  StGrMain.Visible:=Hash<>nil;
end;

end.
