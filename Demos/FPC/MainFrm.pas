unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TMainForm = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  BeaEngine;

{$R *.lfm}

{ TMainForm }

procedure TMainForm.Button1Click(Sender: TObject);
var
  MyDisasm: TDISASM;
  I, len: LongWord;
begin
  Memo1.Lines.Clear;
  // ======== Init the TDisasm structure (important !)
  FillChar(MyDisasm, SizeOf(TDISASM), 0);
  // ======== Init EIP
  MyDisasm.EIP := PtrUInt(@SysUtils.StrComp);
{$IFDEF CPUX64}
  MyDisasm.Archi := 64;
{$ELSE}
  MyDisasm.Archi := 0;
{$ENDIF}
  MyDisasm.Options := NoTabulation + MasmSyntax;
  // ======== Loop for Disasm
  for I := 1 to 60 do
  begin
    len := Disasm(MyDisasm);
    Memo1.Lines.Add(IntToHex(MyDisasm.EIP, 2) + ' ' + string(MyDisasm.CompleteInstr));
    MyDisasm.EIP := MyDisasm.EIP + len;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Caption := Format('%s.%s', [BeaEngineVersion, BeaEngineRevision]);
{$IFDEF CPUX64}
  Caption := Caption + ' - x64';
{$ELSE}
  Caption := Caption + ' - x32';
{$ENDIF}
end;

end.
