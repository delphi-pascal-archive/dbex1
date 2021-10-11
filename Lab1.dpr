program Lab1;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uStruct in 'uStruct.pas',
  uAbout in 'uAbout.pas' {fmAbout},
  uAddEditEntry in 'uAddEditEntry.pas' {fmAddEditEntry},
  uIndexFile in 'uIndexFile.pas' {fmIndexFile},
  uSearch in 'uSearch.pas' {fmSearch};

{$R *.res}

begin
  Application.Title:='Лабораторная работа 1 по курсу Базы данных';
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
