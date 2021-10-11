unit uStruct;

interface

type
  TComputer = record
    CPU: String[25];
    RAMTotalSpace, HDDTotalSpace: LongWord;
    OS: String[25];
    Cost: LongWord;
  end;

  TComputerFile = file of TComputer;

  TIndex = record
    Idx: LongWord;
    CPU: String[25];
  end;

  TIndexFile = file of TIndex;

implementation

end.
