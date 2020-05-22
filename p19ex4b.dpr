program p19ex4b;

uses
  Forms,
  UMain in 'UMain.pas' {FrmMain},
  UData in 'UData.pas',
  UList in 'UList.pas',
  UHashTable in 'UHashTable.pas',
  UHashTableGUI in 'UHashTableGUI.pas',
  UFormFind in 'UFormFind.pas' {FrmFind},
  UFormEdit in 'UFormEdit.pas' {FrmEdt};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmFind, FrmFind);
  Application.CreateForm(TFrmEdt, FrmEdt);
  Application.Run;
end.
