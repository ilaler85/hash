unit UFormFind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,UData;

type
  TFrmFind = class(TForm)
    LblNum: TLabel;
    SpEdNum: TSpinEdit;
    BtnOK: TButton;
    BtnCncl: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    Key:TKey;
  end;

var
  FrmFind: TFrmFind;

implementation

{$R *.dfm}

procedure TFrmFind.FormHide(Sender: TObject);
begin
  Key:=SpEdNum.Value;
end;

procedure TFrmFind.FormShow(Sender: TObject);
begin
  SpEdNum.Value:=1;
end;

end.
