# Workspace Instructions

You are an expert AI programming assistant.
Follow these guidelines when generating code or answering questions.

## C# & .NET Standards
- **Target Framework:** .NET 10 or later
- **Language Version:** C# 14 / Latest Preview
- **Style:** Prefer clear, minimal, production-ready code. Avoid unnecessary abstractions and extra layers.
- **Dependencies:** Do not introduce new NuGet packages or frameworks unless explicitly requested.

### Constructors & DI
- **Primary Constructors:** Prefer primary constructors for DI-friendly services and simple classes.
  - Use regular constructors only when required (inheritance/base chaining, multiple constructors, attributes/serialization, tooling constraints).
  - *Bad:* `public class Service { private readonly IHttp _http; public Service(IHttp http) { _http = http; } }`
  - *Good:* `public class Service(IHttp http)`

### Namespaces
- **File-scoped namespaces only:** `namespace My.Namespace;`

### Nullability
- **Nullable is disabled:** Do **not** use `string?`, `#nullable enable`, or nullable annotations.
- Avoid null-forgiving `!` unless absolutely necessary.
- **CRITICAL:** When creating new projects (especially class libraries), the `dotnet new classlib` template includes `<Nullable>enable</Nullable>` by default in .NET 6+. **Immediately remove this line** from the .csproj file after project creation.
- Always verify new projects have nullable **disabled** before adding code.

### Property Initializers
- **Do NOT use `= string.Empty` or similar default initializers** on properties.
- *Bad:* `public string Name { get; set; } = string.Empty;`
- *Good:* `public string Name { get; set; }`
- *Bad:* `public ICollection<Item> Items { get; set; } = new List<Item>();`
- *Good:* `public ICollection<Item> Items { get; set; }`

### Braces
- **Always use curly braces `{}`** for all conditionals (`if/else/foreach/while`), even single-line bodies.

## Code Analysis & Simplification
- **RCS1021 (Expression Body):** Prefer expression-bodied members for simple, single-expression methods/properties.
- **RCS1037 (Whitespace):** No trailing whitespace on any line.
- **RCS1261 (Async Disposal):** Use async disposal when it exists and performs I/O (streams, network, file). `MemoryStream` is fine synchronously.
- **Async Naming:** Do not suffix our methods with `Async` (e.g., use `GetUser()` not `GetUserAsync()`), even if they return `Task`/`Task<T>`. **Exception:** keep `*Async` when required by an interface/override/framework contract (e.g., `GetAuthenticationStateAsync`, `DisposeAsync`, Blazor lifecycle overrides).
- **IDE0037 (Member Simplification):** Use implicit member names: `new { Prop }`
- **IDE0270 (Null Checks):** Prefer null-coalescing throw: `var x = y ?? throw new Exception();`
- **IDE0305 (Collections):** Use collection expressions where appropriate: `List<int> x = [1, 2];`, `return [.. items];`
  - **Exception:** Avoid collection expressions inside expression trees (e.g., EF Core LINQ queries). Use `.ToList()` / explicit construction instead.

## Blazor & Frontend
- **Dependency Injection:** Use `@inject` in `.razor` files. Use primary constructors in `.razor.cs` / services where appropriate.

## Data Layer & EF Core
- **No Migrations:** Do not create or use EF Core migrations. Database schema is managed separately.
- **No Seed Data:** Do not include seed data in `OnModelCreating` or anywhere in the data layer.
- **No Design Package:** Do not add `Microsoft.EntityFrameworkCore.Design` package.
- **Entity Classes:** Simple POCOs without property initializers. Navigation properties should not be initialized.
- **Service Layer:** Create a service layer (e.g., `HomeOpsService`) between EF Core DbContext and API endpoints.
  - Service methods should be async and return entities directly.
  - Endpoints map entities to shared DTOs when returning to clients.

## Testing & Validation
- Ensure code compiles with the project’s analyzers and strict checks.
- Prefer `var` when the type is obvious.
