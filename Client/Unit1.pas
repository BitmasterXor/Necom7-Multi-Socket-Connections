unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ncSources;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ncClientSource1: TncClientSource;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure ncClientSource1Connected(Sender: TObject; aLine: TncLine);
    function ncClientSource1HandleCommand(Sender: TObject; aLine: TncLine;
      aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean;
      const aSenderComponent, aReceiverComponent: string): TBytes;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  // try to set nickname and make a connection to the remote server...
  try
  self.ncClientSource1.Host:='localhost';
  self.ncClientSource1.Port:=3434;
  self.ncClientSource1.Active:=true;
  except
    On E: exception do
    begin

    end;

  end;
end;

procedure TForm1.ncClientSource1Connected(Sender: TObject; aLine: TncLine);
begin
//send over nickname info and connected command...
self.ncClientSource1.ExecCommand(0,bytesof('NewCon|' + self.Edit1.Text),false);
end;

function TForm1.ncClientSource1HandleCommand(Sender: TObject;
  aLine: TncLine; aCmd: Integer; const aData: TBytes;
  aRequiresResult: Boolean; const aSenderComponent,
  aReceiverComponent: string): TBytes;
begin
self.Caption:= stringof(aData);
end;

end.
