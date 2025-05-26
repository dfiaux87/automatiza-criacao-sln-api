#!/bin/bash

SOLUTION_NAME="HexagonalApi"
BASE_DIR=$(pwd)/$SOLUTION_NAME

echo "Criando diretório do projeto em: $BASE_DIR"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"


UI_DIR="$BASE_DIR/0 - Ui"
BUSINESS_DIR="$BASE_DIR/1 - Business"
INFRA_DIR="$BASE_DIR/2 - Infrastructure"
TESTS_DIR="$BASE_DIR/tests"

MODULES=("Exemplo")  # adicione mais módulos aqui: ("Exemplo" "Produto" "Cliente")

echo "Criando diretórios principais..."
mkdir -p "$UI_DIR"
mkdir -p "$BUSINESS_DIR/0 - Application"
mkdir -p "$BUSINESS_DIR/1 - Domain"
mkdir -p "$INFRA_DIR/0 - Data"
mkdir -p "$TESTS_DIR"

cd "$BASE_DIR"
dotnet new sln -n "$SOLUTION_NAME"

echo "Criando projetos..."
dotnet new webapi -n WebApi -o "$UI_DIR/WebApi"
dotnet new classlib -n Application -o "$BUSINESS_DIR/0 - Application"
dotnet new classlib -n Domain -o "$BUSINESS_DIR/1 - Domain"
dotnet new classlib -n Data -o "$INFRA_DIR/0 - Data"
dotnet new xunit -n Application.Tests -o "$TESTS_DIR/Application.Tests"

echo "Criando pastas auxiliares na API..."
mkdir -p "$UI_DIR/WebApi/Controllers"
mkdir -p "$UI_DIR/WebApi/Middlewares"
mkdir -p "$UI_DIR/WebApi/Extensions"
mkdir -p "$UI_DIR/WebApi/Routes"

cat <<EOF > "$UI_DIR/WebApi/Middlewares/ExceptionHandlingMiddleware.cs"
using System.Net;
namespace WebApi.Middlewares;

public class ExceptionHandlingMiddleware
{
    private readonly RequestDelegate _next;

    public ExceptionHandlingMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try {
            await _next(context);
        } catch {
            context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            await context.Response.WriteAsync("Erro inesperado");
        }
    }
}
EOF

cat <<EOF > "$UI_DIR/WebApi/Extensions/MiddlewareExtensions.cs"
using WebApi.Middlewares;

namespace WebApi.Extensions;

public static class MiddlewareExtensions
{
    public static IApplicationBuilder UseExceptionHandling(this IApplicationBuilder app)
    {
        return app.UseMiddleware<ExceptionHandlingMiddleware>();
    }
}
EOF

cat <<EOF > "$UI_DIR/WebApi/Routes/ExemploRoutes.cs"
namespace WebApi.Routes;

public static class ExemploRoutes
{
    public static void MapExemploEndpoints(this IEndpointRouteBuilder endpoints)
    {
        endpoints.MapGet("/exemplo", () => "Rota de exemplo");
    }
}
EOF

echo "Criando estrutura modular..."
for MODULE in "${MODULES[@]}"; do
    MODULE_DIR="$BUSINESS_DIR/0 - Application/$MODULE"
    mkdir -p "$MODULE_DIR/InputModels"
    mkdir -p "$MODULE_DIR/Interfaces"
    mkdir -p "$MODULE_DIR/ViewModels"
    mkdir -p "$MODULE_DIR/UseCases"
    mkdir -p "$MODULE_DIR/Services"
    mkdir -p "$MODULE_DIR/Validators"
    mkdir -p "$MODULE_DIR/Mappers"

    cat <<EOF > "$MODULE_DIR/${MODULE}Application.cs"
namespace Application.$MODULE;

public class ${MODULE}Application
{
    public string Executar() => "$MODULE executado com sucesso!";
}
EOF
done

echo "Criando pastas adicionais em Domain e Data..."
mkdir -p "$BUSINESS_DIR/1 - Domain/Entities"
mkdir -p "$BUSINESS_DIR/1 - Domain/ValueObjects"
mkdir -p "$BUSINESS_DIR/1 - Domain/Exceptions"
mkdir -p "$BUSINESS_DIR/1 - Domain/Specifications"
mkdir -p "$BUSINESS_DIR/1 - Domain/Enums"
mkdir -p "$BUSINESS_DIR/1 - Domain/Repositories"

mkdir -p "$INFRA_DIR/0 - Data/Repositories"
mkdir -p "$INFRA_DIR/0 - Data/Persistence"
mkdir -p "$INFRA_DIR/0 - Data/ExternalServices"
mkdir -p "$INFRA_DIR/0 - Data/Configurations"
mkdir -p "$INFRA_DIR/0 - Data/Migrations"
mkdir -p "$INFRA_DIR/0 - Data/Adapters"

mkdir -p "$TESTS_DIR/Application.Tests/UseCases"

echo " Adicionando projetos à solução..."
dotnet sln add "$UI_DIR/WebApi/WebApi.csproj"
dotnet sln add "$BUSINESS_DIR/0 - Application/Application.csproj"
dotnet sln add "$BUSINESS_DIR/1 - Domain/Domain.csproj"
dotnet sln add "$INFRA_DIR/0 - Data/Data.csproj"
dotnet sln add "$TESTS_DIR/Application.Tests/Application.Tests.csproj"

echo " Adicionando referências entre projetos..."
dotnet add "$UI_DIR/WebApi/WebApi.csproj" reference "$BUSINESS_DIR/0 - Application/Application.csproj"
dotnet add "$BUSINESS_DIR/0 - Application/Application.csproj" reference "$BUSINESS_DIR/1 - Domain/Domain.csproj"
dotnet add "$INFRA_DIR/0 - Data/Data.csproj" reference "$BUSINESS_DIR/0 - Application/Application.csproj"
dotnet add "$INFRA_DIR/0 - Data/Data.csproj" reference "$BUSINESS_DIR/1 - Domain/Domain.csproj"
dotnet add "$TESTS_DIR/Application.Tests/Application.Tests.csproj" reference "$BUSINESS_DIR/0 - Application/Application.csproj"
dotnet add "$TESTS_DIR/Application.Tests/Application.Tests.csproj" reference "$INFRA_DIR/0 - Data/Data.csproj"

echo "Estrutura completa com múltiplos módulos, camadas organizadas, e classes de exemplo criada com sucesso!"
