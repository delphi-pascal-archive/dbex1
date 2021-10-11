unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ShellAPI;

type
  TfmAbout = class(TForm)
    imgMain: TImage;
    imgFlag: TImage;
    laMadeInRussia: TLabel;
    laProgramName: TLabel;
    laCopyright: TLabel;
    laWebSiteAddress: TLabel;
    laTeacher: TLabel;
    laName1: TLabel;
    laDeveloper: TLabel;
    laName2: TLabel;
    btOk: TButton;
    procedure laWebSiteAddressMouseEnter(Sender: TObject);
    procedure laWebSiteAddressMouseLeave(Sender: TObject);
    procedure laWebSiteAddressClick(Sender: TObject);
  private
  public
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.dfm}

procedure TfmAbout.laWebSiteAddressMouseEnter(Sender: TObject);
begin
  laWebSiteAddress.Font.Color:=clRed;
end;

procedure TfmAbout.laWebSiteAddressMouseLeave(Sender: TObject);
begin
  laWebSiteAddress.Font.Color:=clBlue;
end;

procedure TfmAbout.laWebSiteAddressClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, PChar('open'), PChar('http://www.superutils.com'), nil, nil, SW_NORMAL);
end;

end.
