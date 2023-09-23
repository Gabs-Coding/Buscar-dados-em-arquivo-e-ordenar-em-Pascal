program InsertionSortPascal;

uses
  SysUtils;

var
  ArquivoInfo: TSearchRec;
  CaminhoDaPasta, NomeArqSaida: string;
  ArqEntrada, ArqSaida: TextFile;
  Contador, Controle: integer;
  ArrayValoresArq: array of Integer;

begin
  WriteLn('Qual é o diretório para pesquisar os arquivos?');
  ReadLn(CaminhoDaPasta);

  {Inicializando o array pela primeira vez (arquivos de 100 valores) e a variá-
  vel de controle.}

  SetLength(ArrayValoresArq, 100);
  Controle := 0;

  {Função que abre o diretório de arquivos inserido pelo usuário, busca arquivos
  .txt dentro deles, salva os valores contidos dentro dos arquivos em um array
  dinâmico e ordena os valores do array dentro de um segundo arquivo. Note que
  essa função seguirá um padrão específico para resolver o problema de 4 arqui-
  vos com ordenação diferente. Então, este algoritmo não é robusto para ser im-
  plementado em qualquer local. Tome cuidado ao utilizá-lo, caso queira. OBS:
  não recomendo utilizar esse código, pois fiz ele para resolver um exercício
  solicitado por meu professor e, como já fora dito, ele não foi feito para ser
  robusto.}

  if FindFirst(CaminhoDaPasta + '*.txt', faAnyFile, ArquivoInfo) = 0 then
  begin
    repeat
    // O nome do arquivo está em ArquivoInfo.Name
    AssignFile(ArqEntrada, ArquivoInfo.Name);
    Reset(ArqEntrada);

    // Checando a variável de controle
    case Controle of
      4: SetLength(ArrayValoresArq, 500);
      8: SetLength(ArrayValoresArq, 1000);
      12: SetLength(ArrayValoresArq, 5000);
      16: SetLength(ArrayValoresArq, 10000);
      20: SetLength(ArrayValoresArq, 50000);
      24: SetLength(ArrayValoresArq, 50000);
      28: SetLength(ArrayValoresArq, 100000);
      32: SetLength(ArrayValoresArq, 500000);
      36: SetLength(ArrayValoresArq, 1000000);
      40: SetLength(ArrayValoresArq, 5000000);
      44: SetLength(ArrayValoresArq, 10000000);
      48: SetLength(ArrayValoresArq, 50000000);
    else ;
    end;

    // Inicializando um contador para controle dos elementos inseridos no array
    Contador := 1;
      while not EOF(ArqEntrada) do
      begin
        // Lendo o valor do arquivo e o guardando dentro de um array;
        ReadLn(ArqEntrada, ArrayValoresArq[Contador]);
        Inc(Contador);
      end;

    {A variável de controle abaixo serve para reajustar o vetor dinamicamente
    para que ele comporte a quantidade de elementos do arquivo. Caso precise
    utilizar em outro código, com outra disposição de arquivos, mude essa va-
    riável e reajustar a função SetLength() para os parâmetros desejados.}
    Inc(Controle);
    until FindNext(ArquivoInfo) <> 0;

    FindClose(ArquivoInfo);
    CloseFile(ArqEntrada)
  end
  else
    writeln('Nenhum arquivo encontrado.');
  readln;
end.
