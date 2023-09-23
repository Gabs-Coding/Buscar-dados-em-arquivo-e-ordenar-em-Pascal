program InsertionSortPascal;

uses
  SysUtils, DateUtils;

procedure CalcularTempo(TempoInicio, TempoFim: TDateTime; NomeArquivo: string);

var
  ArquivoLog: TextFile;
  Duracao: Int64;
  DiretorioLog, NomeArquivoLog: string;
begin
  // Calcular a diferença em milissegundos
  Duracao := MilliSecondsBetween(TempoFim, TempoInicio);

  // Criando o caminho do diretório.
  DiretorioLog := '.\logs_dos_arquivos\';

  // Criando o diretório.
  if not DirectoryExists(DiretorioLog) then
    ForceDirectories(DiretorioLog);

  // Abrir o arquivo de log em modo de acréscimo
  NomeArquivoLog:= DiretorioLog + 'logs.txt';
  AssignFile(ArquivoLog, NomeArquivoLog);

      // Verificar se o arquivo existe
  if FileExists(NomeArquivoLog) then
    Append(ArquivoLog) // Abrir o arquivo em modo de acréscimo
  else
    ReWrite(ArquivoLog); // Criar um novo arquivo

  // Escrever o registro no arquivo
  writeln(ArquivoLog, 'Nome do arquivo: ' + NomeArquivo);
  writeln(ArquivoLog, 'Horário de início: ', FormatDateTime('dd/mm/yyyy hh:nn:ss', TempoInicio));
  writeln(ArquivoLog, 'Horário de término: ', FormatDateTime('dd/mm/yyyy hh:nn:ss', TempoFim));
  writeln(ArquivoLog, 'Tempo de execução: ', Duracao, ' milissegundos');
  writeln(ArquivoLog, '---'); // Separador entre registros

  // Fechar o arquivo de log
  CloseFile(ArquivoLog);
end;

procedure OrdenarVetor(ArrayValores: Array of Integer;
  NomeArquivoEntrada: String);

var
  ArquivoSaida: TextFile;
  CaminhoPasta, NomeArquivoSaida: String;

begin
  // Criando o caminho de onde os arquivos ordenados ficarão.
  CaminhoPasta := '.\arquivos_ordenados\';

  // Criando o diretório para os arquivos ficarem.
  if not DirectoryExists(CaminhoPasta) then
    ForceDirectories(CaminhoPasta);

  // Criando o nome do arquivo a ser criado.
  NomeArquivoSaida := CaminhoPasta + '_' + NomeArquivoEntrada;


end;


var
  ArquivoInfo: TSearchRec;
  CaminhoDaPasta, NomeArqSaida: string;
  ArqEntrada: TextFile;
  Contador, Controle: integer;
  ArrayValores: array of Integer;
  TempoInicio, TempoFim: TDateTime;

begin
  WriteLn('Qual é o diretório para pesquisar os arquivos?');
  ReadLn(CaminhoDaPasta);

  {Inicializando o array pela primeira vez (arquivos de 100 valores) e a variá-
  vel de controle.}

  SetLength(ArrayValores, 100);
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
      4: SetLength(ArrayValores, 500);
      8: SetLength(ArrayValores, 1000);
      12: SetLength(ArrayValores, 5000);
      16: SetLength(ArrayValores, 10000);
      20: SetLength(ArrayValores, 50000);
      24: SetLength(ArrayValores, 50000);
      28: SetLength(ArrayValores, 100000);
      32: SetLength(ArrayValores, 500000);
      36: SetLength(ArrayValores, 1000000);
      40: SetLength(ArrayValores, 5000000);
      44: SetLength(ArrayValores, 10000000);
      48: SetLength(ArrayValores, 50000000);
    else ;
    end;

    // Inicializando um contador para controle dos elementos inseridos no array
    Contador := 1;
      while not EOF(ArqEntrada) do
      begin
        // Lendo o valor do arquivo e o guardando dentro de um array;
        ReadLn(ArqEntrada, ArrayValores[Contador]);
        Inc(Contador);
      end;

    {A variável de controle abaixo serve para reajustar o vetor dinamicamente
    para que ele comporte a quantidade de elementos do arquivo. Caso precise
    utilizar em outro código, com outra disposição de arquivos, mude essa va-
    riável e reajustar a função SetLength() para os parâmetros desejados.}
    Inc(Controle);
    CloseFile(ArqEntrada);

    {Chamando a função de obter o tempo atual para calcular a duração da ordena-
    ção}
    TempoInicio := Now;

    // Chamando o procedimento de ordenação do array.
    OrdenarVetor(ArrayValores, ArquivoInfo.Name);

    TempoFim := Now;
    SetLength(ArrayValores, 0);
    CalcularTempo(TempoFim, TempoFim, ArquivoInfo.Name)

    until FindNext(ArquivoInfo) <> 0;

    FindClose(ArquivoInfo);

  end
  else
    writeln('Nenhum arquivo encontrado.');
  readln;
end.
