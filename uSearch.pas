unit uSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TfmSearch = class(TForm)
    lvResult: TListView;
    edQuery: TEdit;
    laResult: TLabel;
    laQuery: TLabel;
    btGo: TButton;
    procedure btGoClick(Sender: TObject);
  private
  public
  end;

var
  fmSearch: TfmSearch;

implementation

uses
  uMain, uStruct;

{$R *.dfm}

procedure TfmSearch.btGoClick(Sender: TObject);
var
  TempIndex: TIndex;
  Computer: TComputer;
  s: String;
begin
  lvResult.Clear;

  s:=edQuery.Text;

  Seek(IndexFile, 0);

  while not EOF(IndexFile) do
    begin
      Read(IndexFile, TempIndex);

      if Pos(s, TempIndex.CPU) <> 0 then
        begin
          Seek(ComputerFile, TempIndex.Idx);
          Read(ComputerFile, Computer);

          with lvResult.Items.Add, Computer do
            begin
              Caption:=CPU;
              SubItems.Add(IntToStr(RAMTotalSpace));
              SubItems.Add(IntToStr(HDDTotalSpace));
              SubItems.Add(OS);
              SubItems.Add(IntToStr(Cost));
            end;
        end;
    end;
end;

end.
