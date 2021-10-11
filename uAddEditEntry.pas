unit uAddEditEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TfmAddEditEntry = class(TForm)
    laCPU: TLabel;
    edCPU: TEdit;
    laRAMSpace: TLabel;
    sedRAMSpace: TSpinEdit;
    sedHDDSpace: TSpinEdit;
    laHDDSpace: TLabel;
    laOS: TLabel;
    edOS: TEdit;
    laCost: TLabel;
    sedCost: TSpinEdit;
    btOk: TButton;
    btCancel: TButton;
  private
  public
  end;

var
  fmAddEditEntry: TfmAddEditEntry;

implementation

{$R *.dfm}

end.
