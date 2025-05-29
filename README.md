# automatiza-criacao-sln-api
Scripts para automatizar a criação de soluções .Net

✅ Passo 1: 
Instale o Git Bash (se ainda não tiver):
https://git-scm.com/downloads

Abra o Git Bash na pasta onde o script está salvo.

Salve o script com o nome desejado, exemplo: create-hexagonal-api.sh

Dê permissão de execução (opcional no Windows, mas seguro): **__chmod +x create-hexagonal-api.sh__**

Execute o script passando o nome da solução e a versão do dotnet: **__./create-hexagonal-api.sh NomeSolucao net9.0__**

✅ Pré-requisitos

Certifique-se de que:

O .NET SDK está instalado e acessível no terminal (dotnet --version)

O terminal tem permissão para criar arquivos e pastas 

✅ Abaixo está a organização do projeto

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
</head>
<body>

<h2>📁 Estrutura do Projeto</h2>

<ul>
  <li>
    <span class="toggle folder caret">0 - Ui</span>
    <ul class="nested">
      <li>
        <span class="toggle folder caret">WebApi</span>
        <ul class="nested">
          <li class="file">WebApi.csproj</li>
          <li>
            <span class="toggle folder caret">Controllers</span>
            <ul class="nested">
              <li class="file">ExemploControllers.cs</li>
            </ul>
          </li>
          <li>
            <span class="toggle folder caret">Middlewares</span>
            <ul class="nested">
              <li class="file">ExceptionHandlingMiddleware.cs</li>
            </ul>
          </li>
          <li>
            <span class="toggle folder caret">Extensions</span>
            <ul class="nested">
              <li class="file">MiddlewareExtensions.cs</li>
            </ul>
          </li>
          <li>
            <span class="toggle folder caret">Routes</span>
            <ul class="nested">
              <li class="file">ExemploRoutes.cs</li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>

  <li>
    <span class="toggle folder caret">1 - Business</span>
    <ul class="nested">
      <li>
        <span class="toggle folder caret">0 - Application</span>
        <ul class="nested">
          <li class="file">Application.csproj</li>
          <li>
            <span class="toggle folder caret">Exemplo</span>
            <ul class="nested">
              <li class="file">ExemploApplication.cs</li>
              <li class="folder">InputModels</li>
              <li class="folder">Interfaces</li>
              <li class="folder">ViewModels</li>
              <li class="folder">UseCases</li>
              <li class="folder">Services</li>
              <li class="folder">Validators</li>
              <li class="folder">Mappers</li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <span class="toggle folder caret">1 - Domain</span>
        <ul class="nested">
          <li class="file">Domain.csproj</li>
          <li class="folder">Entities</li>
          <li class="folder">ValueObjects</li>
          <li class="folder">Exceptions</li>
          <li class="folder">Specifications</li>
          <li class="folder">Enums</li>
          <li class="folder">Repositories</li>
        </ul>
      </li>
    </ul>
  </li>

  <li>
    <span class="toggle folder caret">2 - Infrastructure</span>
    <ul class="nested">
      <li>
        <span class="toggle folder caret">0 - Data</span>
        <ul class="nested">
          <li class="file">Data.csproj</li>
          <li class="folder">Repositories</li>
          <li class="folder">Persistence</li>
          <li class="folder">ExternalServices</li>
          <li class="folder">Configurations</li>
          <li class="folder">Migrations</li>
          <li class="folder">Adapters</li>
          <li>
            <span class="toggle folder caret">Connections</span>
            <ul class="nested">
              <li class="file">ConnectionBase.cs</li>
            </ul>
          </li>
        </ul>
      </li>
      <li class="folder">1 - CrossCutting</li>
      <li>
        <span class="toggle folder caret">2 - IOC</span>
        <ul class="nested">
          <li class="file">IOC.csproj</li>
          <li class="file">DependencyResolver.cs</li>
        </ul>
      </li>
    </ul>
  </li>

  <li>
    <span class="toggle folder caret">tests</span>
    <ul class="nested">
      <li>
        <span class="toggle folder caret">Application.Tests</span>
        <ul class="nested">
          <li class="file">Application.Tests.csproj</li>
          <li class="folder">UseCases</li>
        </ul>
      </li>
    </ul>
  </li>

  <li class="file">NomeDoProjeto.sln</li>
</ul>
</body>
</html>
