unit uIndexFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TfmIndexFile = class(TForm)
    lvMain: TListView;
    btHide: TButton;
    procedure btHideClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  fmIndexFile: TfmIndexFile;

implementation

uses
  uMain;

{$R *.dfm}

procedure TfmIndexFile.btHideClick(Sender: TObject);
begin
  Close;
end;

procedure TfmIndexFile.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmMain.actIndexFile.Checked:=false;
end;

end.
