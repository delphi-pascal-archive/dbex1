unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls, ToolWin, ActnList, uStruct;

type
  TfmMain = class(TForm)
    mmMain: TMainMenu;
    miFile: TMenuItem;
    miExit: TMenuItem;
    cbrMain: TCoolBar;
    tbMain: TToolBar;
    ilMain: TImageList;
    alMain: TActionList;
    miEdit: TMenuItem;
    actAddNewEntry: TAction;
    miAddNewEntry: TMenuItem;
    tbtAddNewEntry: TToolButton;
    stbMain: TStatusBar;
    tbtEditEntry: TToolButton;
    tbtDeleteEntry: TToolButton;
    tbtCreate: TToolButton;
    tbtOpen: TToolButton;
    tbtSeparator1: TToolButton;
    lvMain: TListView;
    tbtSeparator2: TToolButton;
    tbtSearch: TToolButton;
    miHelp: TMenuItem;
    miAbout: TMenuItem;
    odMain: TOpenDialog;
    actIndexFile: TAction;
    tbtIndexFile: TToolButton;
    miView: TMenuItem;
    miIndexFile: TMenuItem;
    actEditEntry: TAction;
    miEditEntry: TMenuItem;
    actDeleteEntry: TAction;
    miDeleteEntry: TMenuItem;
    actCreate: TAction;
    miSeparator1: TMenuItem;
    miCreate: TMenuItem;
    actOpen: TAction;
    miOpen: TMenuItem;
    actSearch: TAction;
    miSeparator2: TMenuItem;
    miSearch: TMenuItem;
    procedure miExitClick(Sender: TObject);
    procedure actAddNewEntryExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actIndexFileExecute(Sender: TObject);
    procedure lvMainSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure actEditEntryExecute(Sender: TObject);
    procedure actDeleteEntryExecute(Sender: TObject);
    procedure lvMainDblClick(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
  private
  public
  end;

var
  fmMain: TfmMain;

  ComputerFile: TComputerFile;

  IndexFile: TIndexFile;

implementation

uses
  uAbout, uAddEditEntry, uIndexFile, uSearch;

{$R *.dfm}

procedure TfmMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure AddComputerRecToList(Computer: TComputer);
begin
  with fmMain.lvMain.Items.Add, Computer do
    begin
      Caption:=CPU;
      SubItems.Add(IntToStr(RAMTotalSpace));
      SubItems.Add(IntToStr(HDDTotalSpace));
      SubItems.Add(OS);
      SubItems.Add(IntToStr(Cost));
    end;
end;

procedure AddIndexRecToList(IndexRec: TIndex);
begin
  with fmIndexFile.lvMain.Items.Add, IndexRec do
    begin
      Caption:=CPU;
      SubItems.Add(IntToStr(Idx));
    end;
end;

procedure TfmMain.actAddNewEntryExecute(Sender: TObject);
var
  Computer: TComputer;
  Index, TempIndex: TIndex;
begin
  fmAddEditEntry:=TfmAddEditEntry.Create(Self);
  try
    fmAddEditEntry.Caption:='Добавить новую запись';
    fmAddEditEntry.ShowModal;

    if fmAddEditEntry.ModalResult=mrOk then
      begin
        Computer.CPU:=fmAddEditEntry.edCPU.Text;
        Computer.RAMTotalSpace:=fmAddEditEntry.sedRAMSpace.Value;
        Computer.HDDTotalSpace:=fmAddEditEntry.sedHDDSpace.Value;
        Computer.OS:=fmAddEditEntry.edOS.Text;
        Computer.Cost:=fmAddEditEntry.sedCost.Value;

        Seek(ComputerFile, FileSize(ComputerFile));
        Write(ComputerFile, Computer);

        AddComputerRecToList(Computer);

        Index.CPU:=Computer.CPU;
        Index.Idx:=lvMain.Items.Count-1;

        Seek(IndexFile, 0);

        if not EOF(IndexFile) then
          begin
            Seek(IndexFile, FileSize(IndexFile));

            repeat
              Seek(IndexFile, FilePos(IndexFile)-1);
              Read(IndexFile, TempIndex);
              if TempIndex.CPU > Index.CPU then
                begin
                  Write(IndexFile, TempIndex);
                  Seek(IndexFile, FilePos(IndexFile)-2);
                end;
            until
              (FilePos(IndexFile)=0) or (TempIndex.CPU <= Index.CPU);
          end;

        Write(IndexFile, Index);

        with fmIndexFile.lvMain.Items.Insert(FilePos(IndexFile)-1) do
          begin
            Caption:=Computer.CPU;
            SubItems.Add(IntToStr(lvMain.Items.Count-1));
          end;
      end;
  finally
    fmAddEditEntry.Free;
  end;
end;

procedure Sort(var A: array of TIndex);

  procedure QuickSort(var A: array of TIndex; iLo, iHi: Integer);
  var
    Lo, Hi: Integer;
    Mid, T: TIndex;
  begin
    Lo:=iLo;
    Hi:=iHi;
    Mid:=A[(Lo + Hi) div 2];
    repeat
      while A[Lo].CPU < Mid.CPU do
        Inc(Lo);
      while A[Hi].CPU > Mid.CPU do
        Dec(Hi);

      if Lo <= Hi then
        begin
          T:=A[Lo];
          A[Lo]:=A[Hi];
          A[Hi]:=T;
          Inc(Lo);
          Dec(Hi);
        end;
    until
      Lo > Hi;

    if Hi > iLo then
      QuickSort(A, iLo, Hi);
    if Lo < iHi then
      QuickSort(A, Lo, iHi);
  end;

begin
  QuickSort(A, Low(A), High(A));
end;

procedure CreateIndexFile(const sFileName: String);
var
  Computer: TComputer;
  Index: TIndex;
  IndexArr: array of TIndex;
  N, i: Integer;
begin
  N:=FileSize(ComputerFile);

  AssignFile(IndexFile, sFileName);
  Rewrite(IndexFile);

  if N=0 then
    Exit;

  SetLength(IndexArr, N);
  try
    Seek(ComputerFile, 0);

    for i:=0 to N-1 do
      begin
        Read(ComputerFile, Computer);

        Index.CPU:=Computer.CPU;
        Index.Idx:=i;
        IndexArr[i]:=Index;
      end;

    Sort(IndexArr);

    for i:=0 to N-1 do
      begin
        Index:=IndexArr[i];

        Write(IndexFile, Index);
        AddIndexRecToList(Index);
      end;
  finally
    IndexArr:=nil;
  end;
end;

procedure OpenIndexFile(const sFileName: String);
var
  Index: TIndex;
begin
  AssignFile(IndexFile, sFileName);
  Reset(IndexFile);

  while not EOF(IndexFile) do
    begin
      Read(IndexFile, Index);

      AddIndexRecToList(Index);
    end;
end;

procedure CheckIndexFile(const sFileName: String);
begin
  if FileExists(sFileName) then
    OpenIndexFile(sFileName)
  else
    CreateIndexFile(sFileName);
end;

procedure OpenDBFile(const sFileName: String);
var
  Computer: TComputer;
begin
  AssignFile(ComputerFile, sFileName);
  Reset(ComputerFile);

  while not EOF(ComputerFile) do
    begin
      Read(ComputerFile, Computer);

      AddComputerRecToList(Computer);
    end;

  CheckIndexFile(ChangeFileExt(sFileName, '.idx'));
end;

procedure CreateDBFile(const sFileName: String);
begin
  AssignFile(ComputerFile, sFileName);
  Rewrite(ComputerFile);

  CreateIndexFile(ChangeFileExt(sFileName, '.idx'));
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  fmIndexFile:=TfmIndexFile.Create(Self);

  if FileExists('data.db') then
    OpenDBFile('data.db')
  else
    CreateDBFile('data.db');
end;

procedure TfmMain.miAboutClick(Sender: TObject);
begin
  fmAbout:=TfmAbout.Create(Self);
  try
    fmAbout.ShowModal;
  finally
    fmAbout.Free;
  end;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  CloseFile(ComputerFile);
  CloseFile(IndexFile);

  fmIndexFile.Free;
end;

procedure TfmMain.actIndexFileExecute(Sender: TObject);
begin
  fmIndexFile.Visible:=actIndexFile.Checked;
end;

procedure TfmMain.lvMainSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  actEditEntry.Enabled:=lvMain.SelCount <> 0;
  actDeleteEntry.Enabled:=lvMain.SelCount <> 0;
end;

procedure TfmMain.actEditEntryExecute(Sender: TObject);
var
  s: String;
  Idx: Integer;
  Computer: TComputer;
  Index, TempIndex: TIndex;
  OldFPos, NewFPos: Integer;
begin
  fmAddEditEntry:=TfmAddEditEntry.Create(Self);
  try
    fmAddEditEntry.Caption:='Редактировать запись';

    s:=lvMain.Selected.Caption;
    fmAddEditEntry.edCPU.Text:=s;
    fmAddEditEntry.edOS.Text:=lvMain.Selected.SubItems[2];
    fmAddEditEntry.sedRAMSpace.Value:=StrToInt(lvMain.Selected.SubItems[0]);
    fmAddEditEntry.sedHDDSpace.Value:=StrToInt(lvMain.Selected.SubItems[1]);
    fmAddEditEntry.sedCost.Value:=StrToInt(lvMain.Selected.SubItems[3]);

    fmAddEditEntry.ShowModal;

    if fmAddEditEntry.ModalResult=mrOk then
      begin
        Computer.CPU:=fmAddEditEntry.edCPU.Text;
        Computer.RAMTotalSpace:=fmAddEditEntry.sedRAMSpace.Value;
        Computer.HDDTotalSpace:=fmAddEditEntry.sedHDDSpace.Value;
        Computer.OS:=fmAddEditEntry.edOS.Text;
        Computer.Cost:=fmAddEditEntry.sedCost.Value;

        Idx:=lvMain.Selected.Index;
        Seek(ComputerFile, Idx);
        Write(ComputerFile, Computer);

        with lvMain.Selected, Computer do
          begin
            Caption:=CPU;
            SubItems[0]:=IntToStr(RAMTotalSpace);
            SubItems[1]:=IntToStr(HDDTotalSpace);
            SubItems[2]:=OS;
            SubItems[3]:=IntToStr(Cost);
          end;

        if Computer.CPU = s then
          Exit;

        Seek(IndexFile, 0);
        repeat
          Read(IndexFile, Index);
        until
          Index.Idx = Idx;

        OldFPos:=FilePos(IndexFile)-1;

        Index.CPU:=Computer.CPU;

        if Index.CPU < s then
          begin
            if OldFPos > 0 then
              begin
                repeat
                  Seek(IndexFile, FilePos(IndexFile)-2);
                  Read(IndexFile, TempIndex);

                  if TempIndex.CPU > Index.CPU then
                    begin
                      Write(IndexFile, TempIndex);
                      Seek(IndexFile, FilePos(IndexFile)-1);
                    end;
                until
                  (FilePos(IndexFile) = 1) or (TempIndex.CPU <= Index.CPU);

                if TempIndex.CPU > Index.CPU then
                  Seek(IndexFile, FilePos(IndexFile)-1);

                Write(IndexFile, Index);
              end;
          end
        else
          begin
            if OldFPos < FileSize(IndexFile) - 1 then
              begin
                repeat
                  Read(IndexFile, TempIndex);

                  if TempIndex.CPU < Index.CPU then
                    begin
                      Seek(IndexFile, FilePos(IndexFile)-2);
                      Write(IndexFile, TempIndex);
                      Seek(IndexFile, FilePos(IndexFile)+1);
                    end;
                until
                  (EOF(IndexFile)) or (TempIndex.CPU >= Index.CPU);

                if TempIndex.CPU < Index.CPU then
                  Seek(IndexFile, FilePos(IndexFile)-1)
                else
                  Seek(IndexFile, FilePos(IndexFile)-2);

                Write(IndexFile, Index);
              end;
          end;

        NewFPos:=FilePos(IndexFile)-1;

        fmIndexFile.lvMain.Items.Delete(OldFPos);
        with fmIndexFile.lvMain.Items.Insert(NewFPos), Computer do
          begin
            Caption:=CPU;
            SubItems.Add(IntToStr(Idx));
          end;
      end;
  finally
    fmAddEditEntry.Free;
  end;
end;

procedure TfmMain.actDeleteEntryExecute(Sender: TObject);
var
  Idx, Idx2: Integer;
  TempComputer: TComputer;
  TempIndex, TempIndex2: TIndex;
  iPos, iPos2: Integer;
  liTemp: TListItem;
begin
  Idx:=lvMain.Selected.Index;

  Idx2:=FileSize(ComputerFile)-1;
  Seek(ComputerFile, Idx2);
  Read(ComputerFile, TempComputer);

  Seek(ComputerFile, Idx2);
  Truncate(ComputerFile);

  if Idx2 <> Idx then
    begin
      Seek(ComputerFile, Idx);
      Write(ComputerFile, TempComputer);
    end;

  Seek(IndexFile, 0);
  while not EOF(IndexFile) do
    begin
      Read(IndexFile, TempIndex);

      if Idx2 <> Idx then
        if TempIndex.Idx=Idx2 then
          begin
            TempIndex.Idx:=Idx;
            Seek(IndexFile, FilePos(IndexFile)-1);
            iPos:=FilePos(IndexFile);
            Write(IndexFile, TempIndex);
          end;

      if TempIndex.Idx=Idx then
        begin
          iPos2:=FilePos(IndexFile)-1;

          while not EOF(IndexFile) do
            begin
              Read(IndexFile, TempIndex2);

              if Idx2 <> Idx then
                if TempIndex2.Idx=Idx2 then
                  begin
                    iPos:=FilePos(IndexFile)-2;
                    TempIndex2.Idx:=Idx;
                  end;

              Seek(IndexFile, FilePos(IndexFile)-2);
              Write(IndexFile, TempIndex2);
              Seek(IndexFile, FilePos(IndexFile)+1);
            end;

          Seek(IndexFile, FilePos(IndexFile)-1);
          Truncate(IndexFile);

          Break;
        end;
    end;

  if Idx2 <> Idx then
    begin
      liTemp:=TListItem.Create(lvMain.Items);
      liTemp.Assign(lvMain.Items[lvMain.Items.Count-1]);
      lvMain.Items[lvMain.Items.Count-1].Delete;
      lvMain.Items[Idx].Assign(liTemp);
      liTemp.Free;
    end
  else
    lvMain.Items[lvMain.Items.Count-1].Delete;

  fmIndexFile.lvMain.Items[iPos2].Delete;
  if Idx2 <> Idx then
    fmIndexFile.lvMain.Items[iPos].SubItems[0]:=IntToStr(Idx);
end;

procedure TfmMain.lvMainDblClick(Sender: TObject);
begin
  if TListView(Sender).Selected <> nil then
    actEditEntry.Execute;
end;

procedure TfmMain.actCreateExecute(Sender: TObject);
begin
  Seek(ComputerFile, 0);
  Seek(IndexFile, 0);

  Truncate(ComputerFile);
  Truncate(IndexFile);
  
  lvMain.Clear;
  fmIndexFile.lvMain.Clear;
end;

procedure TfmMain.actOpenExecute(Sender: TObject);
begin
  if odMain.Execute then
    begin
      lvMain.Clear;
      fmIndexFile.lvMain.Clear;

      CloseFile(ComputerFile);
      CloseFile(IndexFile);

      OpenDBFile(odMain.FileName);
    end;
end;

procedure TfmMain.actSearchExecute(Sender: TObject);
begin
  fmSearch:=TfmSearch.Create(Self);
  try
    fmSearch.ShowModal;
  finally
    fmSearch.Free;
  end;
end;

end.
