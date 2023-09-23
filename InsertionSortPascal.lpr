program InsertionSortPascal;

uses
  SysUtils;

var
  ArquivoInfo: TSearchRec;
  CaminhoDaPasta: string;
  Arquivo: TextFile;
  Valor: integer;

begin
  WriteLn('Qual é o diretório para pesquisar os arquivos?');
  ReadLn(CaminhoDaPasta);

  //
  if FindFirst(CaminhoDaPasta + '*.txt', faAnyFile, ArquivoInfo) = 0 then
  begin
    repeat
      // O nome do arquivo está em ArquivoInfo.Name
    AssignFile(Arquivo, ArquivoInfo.Name);
    Reset(Arquivo);
      while not EOF(Arquivo) do
      begin
        // Lendo o valor do arquivo
        ReadLn(Arquivo, Valor);
        // Método de ordenação do arquivo.
      end;

    until FindNext(ArquivoInfo) <> 0;

    FindClose(ArquivoInfo);
  end
  else
    writeln('Nenhum arquivo encontrado.');
  readln;
end.
