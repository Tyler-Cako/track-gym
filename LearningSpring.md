# Learning Spring

## Table of Contents

- [Roadmap](#roadmap)
- [Spring Boot Concepts](#spring-boot-concepts)
  - [Project structure](#project-structure)
  - [Controller vs service vs repository](#controller-vs-service-vs-repository)
  - [What is `@Transactional`?](#what-is-transactional)
  - [What is `readOnly = true`?](#what-is-readonly-true)
  - [DTO vs view objects in the model](#dto-vs-view-objects-in-the-model)
  - [Why separate input DTO from output/view object?](#why-separate-input-dto-from-outputview-object)
  - [Naming DTOs and view objects](#naming-dtos-and-view-objects)
  - [Where to put converter/mapper classes](#where-to-put-convertermapper-classes)
  - [Should view models be all strings, or can Thymeleaf handle numbers?](#should-view-models-be-all-strings-or-can-thymeleaf-handle-numbers)
  - [Can view models depend on other view models?](#can-view-models-depend-on-other-view-models)
  - [Thymeleaf fragments for view models](#thymeleaf-fragments-for-view-models)
- [Kotlin](#kotlin)
  - [Extension functions](#extension-functions)

# Roadmap

## 1. Foundations
- JVM, Kotlin basics (classes, data classes, nullability, collections, lambdas, scope functions)
- Gradle/Maven build lifecycle, dependencies, plugins
- HTTP basics: methods, status codes, headers, cookies, redirects, form encoding
- HTML, CSS, a bit of JS; the request/response cycle
- 12-factor config, environment variables

## 2. Spring Core
- Inversion of Control, Dependency Injection, beans
- Stereotypes: `@Component`, `@Service`, `@Repository`, `@Controller`
- Constructor injection; bean scopes (singleton default)
- `@Configuration` + `@Bean`, `@ComponentScan`
- `@Value`, `@ConfigurationProperties`, `application.yml` profiles
- AOP basics (what `@Transactional` is built on)
- Bean lifecycle, `@PostConstruct`, `ApplicationRunner`

## 3. Spring Boot
- Auto-configuration, starters, dependency management
- `SpringApplication`, embedded server (Tomcat), main class
- DevTools (hot reload), actuator endpoints
- Profiles (`dev`, `prod`), externalized config, secrets
- `CommandLineRunner` / `ApplicationRunner`
- Logging (SLF4J/Logback), log levels, structured logs

## 4. Spring MVC (web layer)
- `@Controller` vs `@RestController`
- `@GetMapping`/`@PostMapping`/etc., path variables, query params
- `@RequestParam`, `@PathVariable`, `@RequestBody`, `@ModelAttribute`
- `Model`, view resolution, view names
- Form binding, `@InitBinder`, type conversion/formatters
- Redirects (`redirect:`), flash attributes (`RedirectAttributes`)
- `@ControllerAdvice`, `@ExceptionHandler`, error pages
- `HandlerInterceptor`, filters, CORS, static resources
- Content negotiation, `MediaType`
- Session vs request scope, cookies
- `DispatcherServlet` request flow (know the mental model)

## 5. Thymeleaf
- Template syntax: `${}`, `*{}`, `@{}`, `#{}`, `~{}`
- Th attributes: `th:text`, `th:each`, `th:if`, `th:unless`, `th:href`, `th:action`, `th:value`, `th:field`, `th:object`
- Fragments: `th:fragment`, `th:replace`, `th:insert`
- Layouts: Thymeleaf Layout Dialect (`layout:decorate`)
- Forms + `th:object`/`th:field` + `th:errors`
- Expression utilities (`#strings`, `#numbers`, `#dates`, `#lists`)
- Internationalization (messages, `LocaleResolver`)
- Template caching (off in dev, on in prod)

## 6. HTMX (on top of MVC)
- `hx-get`/`hx-post`/`hx-put`/`hx-delete`, `hx-target`, `hx-swap`
- `hx-trigger` (events, delays, polling), `hx-vals`, `hx-include`
- Returning HTML fragments from controllers; fragment-scoped rendering
- Out-of-band swaps (`hx-swap-oob`)
- Headers: `HX-Request`, `HX-Trigger`, `HX-Redirect`, `HX-Refresh`
- Partial validation/error rendering, progressive enhancement
- Indicators, disabled states, CSRF with HTMX

## 7. Persistence
- JDBC basics, `JdbcTemplate`, `RowMapper`, `NamedParameterJdbcTemplate`
- Spring Data JDBC (aggregates, repositories, `@Query`)
- Or JPA/Hibernate alternative: entities, `@Id`, relationships, `EntityManager`
- Transactions: `@Transactional`, propagation, isolation, `readOnly`
- Connection pooling (HikariCP), datasource config
- Schema management: `schema.sql`/`data.sql`, Flyway/Liquibase migrations
- Pagination, sorting, projections, N+1 awareness
- H2 for dev, Postgres/MySQL for prod
- SQL itself: joins, indexes, constraints, transactions

## 8. Validation & error handling
- Bean Validation (`@NotNull`, `@Size`, `@Email`, `@Valid`, `@Validated`)
- Custom validators, validation groups
- Binding result handling in forms
- Consistent error responses/fragments
- `ProblemDetail` (RFC 7807) if you add APIs

## 9. Security
- Spring Security filter chain basics
- Authentication vs authorization, sessions, form login
- Password hashing (`BCryptPasswordEncoder`)
- CSRF protection (and HTMX integration)
- Method security (`@PreAuthorize`), roles/authorities
- OAuth2/OIDC (optional), remember-me, logout
- Security headers, HTTPS, secrets management

## 10. Testing
- JUnit 5, Kotlin test, assertions
- `@SpringBootTest`, slices (`@WebMvcTest`, `@DataJdbcTest`)
- `MockMvc` / `WebTestClient` for controllers
- `@MockitoBean`/mocks for isolating services
- Testcontainers for real DB integration tests
- Reference DB / `@Sql` setup
- Test pyramid: unit -> slice -> integration -> E2E (Playwright/Selenium)

## 11. Cross-cutting / quality
- Layering: controller -> service -> repository; DTOs vs entities vs view models
- Exception handling strategy
- Mapping (manual or MapStruct)
- Caching (`@Cacheable`), if needed
- Async (`@Async`, `@Scheduled`), events (`ApplicationEventPublisher`)
- API docs if JSON endpoints (springdoc/OpenAPI)
- Static analysis: ktlint/detekt, compiler warnings
- Logging, tracing (Micrometer/OpenTelemetry)

## 12. Operations & delivery
- Packaging: fat jar, `spring-boot-maven-plugin`/Gradle `bootJar`
- Docker multi-stage build, container config
- CI/CD (GitHub Actions), automated tests, versioning
- Environments, config per profile, secrets
- Actuator health/metrics, basic monitoring
- Database migrations in deploy pipeline
- Reverse proxy/TLS (Nginx/Caddy), static asset caching
- Backups, graceful shutdown, JVM tuning (later)

## 13. Frontend build
- Tailwind (or plain CSS) build step, watch mode
- Vendoring HTMX or using a CDN
- Cache-busting static assets, CSP considerations

## Suggested learning order
1. HTTP + Kotlin basics
2. Spring Core/DI
3. Spring Boot app skeleton
4. MVC controllers + forms
5. Thymeleaf templates/fragments/layouts
6. JDBC/repository + transactions
7. Validation + error handling
8. HTMX fragment endpoints
9. Security + auth
10. Testing slices
11. Packaging/Docker/CI
12. Observability/caching/async as needed

---


# Spring Boot Concepts

## Project structure

A clean, conventional layout for a Kotlin Spring Boot MVC + Thymeleaf + HTMX app:

```
src/main/kotlin/com/example/myapp/
├── MyAppApplication.kt
├── config/
│   ├── WebConfig.kt
│   └── SecurityConfig.kt
├── advice/
│   └── GlobalExceptionHandler.kt
├── controller/
│   ├── HomeController.kt
│   ├── ProductController.kt          # full-page views
│   └── htmx/
│       └── ProductHtmxController.kt  # fragment-only endpoints
├── service/
│   ├── ProductService.kt
│   └── ProductServiceImpl.kt
├── repository/
│   ├── ProductRepository.kt
│   └── ProductRepositoryImpl.kt
├── model/
│   ├── entity/                       # persistence entities
│   │   └── Product.kt
│   ├── dto/                          # form / request objects
│   │   └── ProductForm.kt
│   └── view/                         # view models for templates
│       └── ProductSummary.kt
└── exception/
    └── NotFoundException.kt
```

```
src/main/resources/
├── application.yml
├── db/
│   ├── schema.sql
│   └── data.sql
├── static/
│   ├── css/app.css
│   ├── js/htmx.min.js
│   └── img/
└── templates/
    ├── layouts/
    │   └── default.html              # Thymeleaf layout decorator
    ├── fragments/
    │   ├── navbar.html
    │   └── product-card.html
    ├── home.html
    └── product/
        ├── index.html                # full page
        ├── form.html
        └── list.html                 # HTMX partial (fragment)
```

```
src/test/kotlin/com/example/myapp/
├── MyAppApplicationTests.kt
├── controller/
│   └── ProductControllerTest.kt      # MockMvc / WebTestClient
├── service/
│   └── ProductServiceTest.kt
└── repository/
    └── ProductRepositoryTest.kt
```

Rules of thumb:
- Full pages vs fragments: `controller` returns complete views; `controller/htmx` returns fragments like `"product/list :: rows"`.
- Entities never reach templates: map to `model/view` objects in the service/controller.
- Services own transactions/business logic; repositories are thin.
- One fragment file can serve both page and partial (`th:fragment`), but shared chunks live in `fragments/`.
- Tests mirror main packages.

---

## Controller vs service vs repository

The rule: controller handles HTTP, service handles business rules/transactions, repository handles SQL. Each layer only talks to the one below it.

### Controller: HTTP concerns only
- Map URLs, verbs, params, form binding
- Choose which view/fragment to render
- Validate input format (with `@Valid`, usually via a DTO)
- Put things in the model / redirect after POST
- Nothing about SQL, transactions, or business rules

```kotlin
@Controller
class ProductController(private val productService: ProductService) {

    @GetMapping("/products")
    fun list(model: Model): String {
        model.addAttribute("products", productService.findAll())
        return "product/index"
    }

    @PostMapping("/products")
    fun create(@Valid form: ProductForm, model: Model): String {
        productService.create(form)
        return "redirect:/products"
    }
}
```

### Service: business rules + transaction boundary
- Orchestrate one or more repository calls
- Enforce rules ("name must be unique", "can't delete last product")
- Map entity <-> view model / DTO
- Own `@Transactional`
- Throw business exceptions (`NotFoundException`, `ConflictException`)
- No `HttpServletRequest`, `Model`, or view names

```kotlin
@Service
class ProductService(private val repository: ProductRepository) {

    @Transactional(readOnly = true)
    fun findAll(): List<ProductSummary> =
        repository.findAll().map { ProductSummary(it.id, it.name) }

    @Transactional
    fun create(form: ProductForm) {
        if (repository.existsByName(form.name)) throw ConflictException("Name taken")
        repository.save(Product(form.name))
    }
}
```

### Repository: persistence only
- CRUD queries, row mapping
- No business decisions, no view models
- Return entities (or null/empty results)

```kotlin
@Repository
class ProductRepositoryImpl(private val jdbc: JdbcTemplate) : ProductRepository {
    override fun findAll(): List<Product> =
        jdbc.query("SELECT id, name FROM product") { rs, _ ->
            Product(rs.getLong("id"), rs.getString("name"))
        }

    override fun existsByName(name: String): Boolean = ...
}
```

### Controller/service/repository decision guide

| Question | Layer |
|---|---|
| What URL / which template? | Controller |
| Is this request valid shape? | Controller (DTO validation) |
| "Can a user have two products with the same name?" | Service |
| Needs multiple repo calls in one transaction? | Service |
| SQL, joins, row mapping | Repository |
| Convert entity -> template model | Service (or a mapper) |
| Render an HTMX fragment vs full page | Controller |

Thin controller, meaningful service, dumb repository. If a controller method contains an `if` about business state, it belongs in the service.

---

## What is `@Transactional`?

`@Transactional` tells Spring to wrap a method in a database transaction: begin before the method, commit if it returns normally, roll back if it throws (by default, unchecked exceptions only).

```kotlin
@Service
class OrderService(private val orders: OrderRepository, private val stock: StockRepository) {

    @Transactional
    fun placeOrder(cmd: PlaceOrderCommand): Long {
        val order = orders.save(Order(...))
        stock.decrement(cmd.productId, cmd.quantity) // if this throws...
        return order.id                              // ...the insert above is rolled back
    }
}
```

Without it, each repository call commits on its own, so a failure halfway leaves partial data.

Key points:
- Atomicity: all statements succeed or none do.
- The boundary belongs in the service, not the controller or repository, because a business operation often spans multiple repository calls.
- `readOnly = true` for query methods.
- Rollback rules: rolls back on `RuntimeException`/`Error`; checked exceptions (rare in Kotlin) do not. Use `@Transactional(rollbackFor = [Exception::class])` if needed.
- Spring AOP proxy gotchas:
  - Only works on public methods called from outside the bean (self-invocation bypasses the proxy).
  - Needs `@EnableTransactionManagement` (auto-configured by Spring Boot with a `DataSource` + `spring-boot-starter-jdbc`/`data-jpa`).
- Propagation (default `REQUIRED`): joins an existing transaction if one is active, otherwise starts a new one. `REQUIRES_NEW` suspends and starts independent.
- Isolation (default DB-level, usually `READ_COMMITTED`): controls what concurrent transactions see.
- Has no effect on external calls: HTTP, emails, messages won't roll back. Do those after commit.

For a Thymeleaf/HTMX MVC app: put `@Transactional` on service methods that write, `readOnly = true` on pure queries, and keep controllers transaction-free.

---

## What is `readOnly = true`?

`@Transactional(readOnly = true)` marks a transaction as read-only. It's a hint/optimization flag, not a hard guarantee that nothing can be written.

```kotlin
@Transactional(readOnly = true)
fun findAll(): List<ProductSummary> = repository.findAll().map { it.toSummary() }
```

What it actually does:
- Spring: sets the JDBC `Connection` to read-only for the duration.
- Hibernate/JPA: sets the session flush mode to `MANUAL`, skipping dirty-checking and auto-flushing.
- Database: may route to a read replica or use a lighter/snapshot transaction (provider-dependent); many DBs treat it as advisory only.

Why use it:
- Signals intent: this method is a pure query.
- Slight performance win by skipping dirty checking/flushes.
- Enables read-replica routing if configured.
- Pairs well with query-only service methods.

Caveats:
- Not enforced: mutations inside a read-only transaction generally won't flush, so writes can be silently dropped rather than throwing.
- Only meaningful for ORMs that honor it (Hibernate does). With plain `JdbcTemplate` it mostly just sets the connection flag.
- Don't put it on methods that write.

Rule: read-only flag on query methods, normal `@Transactional` on anything that mutates.

---

## DTO vs view objects in the model

They serve different directions of data flow. Keeping them separate avoids leaking persistence shapes into templates and vice versa.

### Entity (persistence)
Mirrors the DB / domain. Never pass to templates.

```kotlin
data class Product(
    val id: Long,
    val name: String,
    val priceCents: Int,
    val createdAt: Instant,
    val deleted: Boolean,
)
```

### DTO (request/input)
Represents what the client sends in: form submissions, command payloads. Usually validated with Bean Validation.

```kotlin
data class ProductForm(
    @field:NotBlank val name: String = "",
    @field:Min(0) val priceCents: Int = 0,
)

data class UpdateProductCommand(val id: Long, val name: String)
```

- Tied to `@ModelAttribute`/`@RequestBody` and `th:object`.
- Use `= ""`/defaults for empty form binding in Kotlin.
- May include fields only for input (confirmPassword, csrf, checkbox flags).

### View object (output / view model)
Represents exactly what a template displays: precomputed, formatted, denormalized for rendering. Built by the service (or a mapper), never persisted.

```kotlin
data class ProductRow(
    val id: Long,
    val displayName: String,
    val price: String,
    val isLowStock: Boolean,
)

data class ProductPage(
    val rows: List<ProductRow>,
    val totalCount: Int,
    val canEdit: Boolean,
)
```

- Often combines multiple entities (joins) or adds computed/UI flags.
- Formatted values (dates, money, labels) so templates stay dumb.
- Different templates -> different view objects, even for the same entity.

### Why split them

| Concern | Entity | DTO | View |
|---|---|---|---|
| Direction | DB | in (request) | out (response) |
| Validation | DB constraints | Bean Validation | none |
| Formatting | raw | raw | formatted |
| Coupling | schema | HTTP/client | template/UI |
| Safe to expose | no | no | yes |

Benefits: templates don't break when the schema changes; requests can't accidentally set server-controlled fields (mass assignment); sensitive columns never render; UI shape can differ per page without polluting the entity.

Practical rules:
- `model/entity`: persistence; maps from rows/ORM.
- `model/dto`: controller inputs; `@Valid` here.
- `model/view`: controller outputs to `Model`/fragments; built in service.
- Small apps can collapse DTO+view into one file, but don't reuse the entity for both directions.
- Mapping is manual (`toRow()`, `toEntity()`) or via MapStruct.
- Tiny CRUD may skip view objects; the moment you format/compute/join, introduce one.

---

## Why separate input DTO from output/view object?

Because they're shaped by different forces and different consumers, and a single class can't satisfy both without compromises.

Input is about trust and partial data:
- A form only sends a subset of fields.
- Fields may be optional, blank, unparseable, or malicious.
- You need defaults for Kotlin binding, validation, checkbox semantics, and transient fields like `confirmPassword`.
- The client must not be able to set `id`, `createdAt`, `role`, `deleted`, or other server-controlled fields.

Output is about presentation and truth:
- It needs computed values (`isLowStock`), formatted values (`"$19.99"`, `"Oct 25"`), labels, joined data, permission flags, counts.
- It should contain only what the template renders.
- It often combines several entities.

If you force one class, you get a union of both: writable fields you must ignore on input, required fields that are empty on input, and validation that fires on output. That's how edit forms wipe fields or crash on null.

Different reasons to change:
- Add a DB column -> entity + maybe view change.
- Redesign the form -> input DTO changes.
- Redesign the page -> view object changes.

### Why is the DTO "just for input"?
That's a naming convention, not a law. "DTO" is broad. In a layered MVC app you typically have:
- Request DTO: client -> server (input), often `model/dto`.
- Response/view DTO: server -> client (output), often `model/view`.

The output object is also a DTO; naming it `view` just makes its purpose obvious. If you later add a JSON API, add `api/response` DTOs alongside.

| Input | Output |
|---|---|
| Untrusted, validate | Trusted, already validated |
| Partial / optional | Complete for that view |
| Raw values | Formatted values |
| Only mutable fields | Whatever the page needs |
| May have transient form fields | May have computed/joined fields |

### Why not expose persistence shapes to templates?
- Security / over-exposure: entities carry `passwordHash`, `deleted`, `internalNotes`, `costPrice`, `version`, foreign keys. A view object is an allowlist.
- Mass assignment / over-posting: binding an entity lets crafted requests set `id`, `role`, `deleted`, `isAdmin`.
- Schema coupling: column renames/normalization ripple into every template (and HTMX fragment/error page). View objects absorb that.
- Lazy loading / N+1 / serialization traps (JPA): rendering entities outside a transaction triggers lazy loads or throws `LazyInitializationException`; view objects are built inside the transaction where fetching is controlled.
- Domain invariants: entities may be valid for persistence but wrong for display (soft-deleted rows, partially constructed aggregates).
- Formatting belongs at the edge of the domain: `BigDecimal(1999)` vs `"$19.99"` vs locale formatting. Precomputing keeps templates dumb and consistent.
- Multiple presentation needs: the same entity appears as list row, detail page, dropdown, HTMX row, mobile layout.
- Testability: test mappers and controllers without a DB; rename columns without touching templates.

Pragmatic counterpoint:
- Tiny CRUD, single consumer, no sensitive fields -> passing entities is fine.
- Any formatting, computed flags, joins, permissions, or sensitive columns -> introduce a view object.
- Any write endpoint -> always bind a request DTO, never the entity.
- Start simple; extract view objects when templates need formatting, security checks, or joins.

Principle: each boundary gets an object shaped for that boundary. The entity is an implementation detail of the storage boundary, not a universal data bag.

---

## Naming DTOs and view objects

Name by role/purpose, not by generic "View". The type's name should tell you which boundary and which screen it serves.

### Convention: `<Entity><Purpose>`

| Boundary | Suffix | Example | Used for |
|---|---|---|---|
| Input (form) | `Form` | `WorkoutForm` | create/edit form binding |
| Input (command) | `Command` | `CreateWorkoutCommand`, `UpdateWorkoutCommand` | service input |
| Output (list) | `Summary` / `Row` / `ListItem` | `WorkoutSummary`, `WorkoutRow` | table row, HTMX list |
| Output (detail) | `Detail` / `DetailView` | `WorkoutDetail` | single-record page |
| Output (card/tile) | `Card` | `WorkoutCard` | dashboard tile |
| Output (page) | `Page` | `WorkoutPage` | view + paging/header data |
| Output (dropdown/option) | `Option` | `WorkoutOption(id, label)` | `<select>` |
| Generic output | `Response` / `ViewModel` | `WorkoutResponse` | only if truly generic |

Pick one output convention per project. `Summary` for list, `Detail` for detail is clearest for a typical MVC/Thymeleaf app.

### Workout domain example

```
model/entity/Workout.kt                      data class Workout(id, userId, splitId, date, notes, ...)

model/dto/WorkoutForm.kt                     @NotBlank name, date, notes            (input)
model/dto/CreateWorkoutCommand.kt            validated, service-facing             (input)

model/view/WorkoutSummary.kt                 id, title, dateLabel, exerciseCount    (list/HTMX)
model/view/WorkoutDetail.kt                  id, title, dateLabel, sets: List<...> (detail page)
model/view/WorkoutRow.kt                     id, title, duration, canEdit          (HTMX partial)
model/view/WorkoutPage.kt                    workouts: List<WorkoutSummary>, page, total
```

```kotlin
// input -> service
fun create(form: WorkoutForm): Long =
    workoutService.create(form.toCommand())

// service -> view
fun detail(id: Long): WorkoutDetail = ...
```

### Mapping names
- `Workout.toSummary()`, `Workout.toDetail()`: extension functions, or
- `WorkoutMapper.toSummary(entity)`, `WorkoutMapper.toDetail(entity)`, or
- `WorkoutForm.toCommand()`, `CreateWorkoutCommand.toEntity()`.

Keep mappers in `mapper/WorkoutMapper.kt` or as extensions near the view object. One direction each: `toSummary`, `toDetail`, `toForm`, `toCommand`. Never name a mapper just `toDto`.

### Rules of thumb
- No `DTO` suffix. `WorkoutDto` says nothing.
- No `View` suffix unless it's the only one. `WorkoutSummary` beats `WorkoutView`.
- Verb-ish suffixes for input (`Form`, `Command`, `Request`); noun-ish for output (`Summary`, `Detail`, `Row`, `Card`, `Page`, `Option`).
- Name both sides the same base (`Workout*`) so grep finds the whole cluster.
- One view per distinct rendering, even if they overlap.
- Don't create a generic view "just in case"; extract when a template needs specific fields/formatting.

For a workout app, start with `WorkoutForm`, `WorkoutSummary`, `WorkoutDetail`.

---

## Where to put converter/mapper classes

There are two different things called "converter"; keep them in different places.

### 1. Domain mappers (entity <-> DTO/view)
Put them in a dedicated top-level package:

```
com/example/myapp/
├── mapper/
│   ├── WorkoutMapper.kt
│   └── ExerciseMapper.kt
```

Or as extension functions next to the target type:

```kotlin
// model/view/WorkoutSummary.kt
fun Workout.toSummary(): WorkoutSummary =
    WorkoutSummary(id = id, title = title, dateLabel = date.format(...))
```

Choose:
- Extension functions: best for small/medium apps, no extra class, colocated with the view type.
- `mapper/` object/class: when many types, shared across controllers, or unit-tested in isolation.
- MapStruct: interfaces in `mapper/`, generated impls in `build/generated`. Needs kapt or KSP with Kotlin; manual mappers are usually simpler for small apps.

Don't scatter `toX()` functions across controllers/services; pick one home.

### 2. Spring `Converter` / `Formatter` (web type conversion)
For converting request parameters / form values to types (e.g. `String -> WorkoutId`, custom date formats). These belong to the web layer:

```
com/example/myapp/
├── web/
│   └── converter/
│       ├── WorkoutIdConverter.kt
│       └── LocalDateFormatter.kt
├── config/
│   └── WebConfig.kt          # registers them
```

```kotlin
@Component
class WorkoutIdConverter : Converter<String, WorkoutId> {
    override fun convert(source: String) = WorkoutId(source.toLong())
}

@Configuration
class WebConfig(private val workoutIdConverter: WorkoutIdConverter) : WebMvcConfigurer {
    override fun addFormatters(registry: FormatterRegistry) {
        registry.addConverter(workoutIdConverter)
    }
}
```

### 3. Thymeleaf / JSON serialization converters
- Custom Thymeleaf dialect or `IExpressionObjectFactory` -> `config/thymeleaf/`.
- Jackson `JsonSerializer`/`JsonDeserializer` (if adding JSON endpoints) -> `web/json/` or `config/jackson/`.

### Converter placement decision guide

| Kind | Package |
|---|---|
| Entity <-> view/DTO mapping | `mapper/` or extension in `model/view` |
| MapStruct interfaces | `mapper/` (impls generated) |
| `String -> domain type` for forms | `web/converter/`, registered in `config/WebConfig` |
| Custom date/number formatting | `web/converter/` or `config/` |
| Jackson serializers | `web/json/` or `config/jackson/` |
| Thymeleaf dialect | `config/thymeleaf/` |

---

## Should view models be all strings, or can Thymeleaf handle numbers?

Thymeleaf handles numbers, dates, booleans, enums, and collections natively. You do not need to make everything strings. Over-stringifying hurts.

### Keep native types by default

```kotlin
data class WorkoutSummary(
    val id: Long,
    val title: String,
    val date: LocalDate,
    val weightKg: BigDecimal,
    val sets: Int,
    val completed: Boolean,
    val status: WorkoutStatus,
)
```

```html
<span th:text="${workout.title}"></span>
<span th:text="${workout.sets}"></span>
<span th:text="${#numbers.formatDecimal(workout.weightKg, 1, 1)}"></span>
<span th:text="${#temporals.format(workout.date, 'MMM d, yyyy')}"></span>
<span th:if="${workout.completed}">Done</span>
<tr th:classappend="${workout.sets > 5} ? 'heavy' : ''">
<input type="number" th:field="*{weightKg}">
<input type="date"   th:field="*{date}">
```

### When to precompute a string
When the display value is genuinely derived or locale-specific, and keep the raw value alongside if anything else needs it:

```kotlin
data class WorkoutSummary(
    val id: Long,
    val title: String,
    val weightKg: BigDecimal,
    val weightLabel: String,   // formatted for this locale
    val date: LocalDate,
    val dateLabel: String,     // compact list display
    val canEdit: Boolean,
)
```

Reasons:
- Consistent formatting across templates.
- Locale/i18n decided in Kotlin, not the template.
- Computed/joined values.
- Permission flags that need security logic.
- Testability: assert on `weightLabel` without rendering HTML.

### Why not all strings
- `th:field` needs the correct type for round-tripping forms; a string date breaks binding.
- You lose comparisons/arithmetic.
- Sorting strings sorts lexically (`"10" < "9"`).
- Booleans become ambiguous (`"false"` is truthy).
- More conversion code and null/blank bugs.
- Charts/JSON/HTMX later want the raw number.

### Rule of thumb
- Raw type for logic, binding, comparison, sorting.
- Formatted string only for display, as an extra field (`weightLabel`) next to the raw one (`weightKg`).
- Never turn a whole view model into strings "so the template is easier".

---

## Can view models depend on other view models?

Yes, but use composition, not inheritance. View models are data, so a parent should contain children, not extend them.

```kotlin
data class WorkoutPage(
    val workoutId: String,
    val workoutName: String,
    val exercises: List<ExerciseCard>,
)
```

Nesting can go further (`WorkoutPage` -> `ExerciseCard` -> `SetRow`); just avoid cycles.

### Map entity -> card in one place

```kotlin
data class ExerciseCard(
    val name: String,
    val oneRepMax: Float,
    val splits: List<SplitCard>,
)

data class SplitCard(
    val weight: Float,
    val reps: Int,
    val completed: Boolean,
)

fun Exercise.toCard(): ExerciseCard =
    ExerciseCard(
        name = exerciseType.name,
        oneRepMax = oneRepMax,
        splits = listOf(
            split1.toCard(isSplit1Completed, oneRepMax),
            split2.toCard(isSplit2Completed, oneRepMax),
            split3.toCard(isSplit3Completed, oneRepMax),
        ),
    )
```

```kotlin
fun loadPage(id: String): WorkoutPage {
    val workout = ...
    val exercises = exerciseRepository.findByWorkoutId(id)
    return WorkoutPage(
        workoutId = workout.id,
        workoutName = workout.name,
        exercises = exercises.map { it.toCard() },
    )
}
```

### Guidelines
- Compose, don't inherit. If two view models share fields, extract a small child view model and include it, or duplicate the few fields.
- Only include what the page renders; keep page-level fields on the page.
- One mapping direction: `Exercise.toCard()`, not back.
- Keep parent/child cohesive; the service builds cards from entities, templates never see entities.
- Reuse child views where identical; create a second view (`ExerciseRow`) when needs diverge.
- Watch for cycles: view models should be a DAG (a tree), never bidirectional.

---

## Thymeleaf fragments for view models

One view model <-> one fragment, so the fragment's parameter is just the view object.

### `templates/fragments/exercise-card.html`

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<body>
<div th:fragment="card(exercise)" class="rounded border p-3">
  <h3 th:text="${exercise.name}">Bench Press</h3>
  <p th:text="${exercise.oneRepMax}">100.0</p>
  <ul>
    <li th:each="split : ${exercise.splits}">
      <span th:text="${split.weight}">100.0</span>
      <span th:text="${split.reps}">5</span>
      <span th:if="${split.completed}">Done</span>
    </li>
  </ul>
</div>
</body>
</html>
```

Alternatively use `th:object` inside the fragment if you prefer `*{}` syntax:

```html
<div th:fragment="card(exercise)" th:object="${exercise}">
    <h3 th:text="*{name}">...</h3>
</div>
```

### Use it from the page

```html
<div th:each="ex : ${workoutPage.exercises}">
    <div th:replace="~{fragments/exercise-card :: card(${ex})}"></div>
</div>
```

- `card(exercise)` declares the parameter; `${exercise}` inside the fragment refers to it.
- `th:replace` swaps the whole host element; `th:insert` nests it inside.

### Reuse for HTMX

The same fragment serves both the full page and HTMX updates:

```kotlin
@GetMapping("/workouts/{id}/exercises/{exId}")
fun card(@PathVariable id: String, @PathVariable exId: Int, model: Model): String {
    model.addAttribute("exercise", workoutService.loadCard(id, exId))
    return "fragments/exercise-card :: card"
}
```

```html
<button hx-get="/workouts/1/exercises/5"
        hx-target="closest .exercise-card"
        hx-swap="outerHTML">Refresh</button>
```

### Fragment conventions that match view models
- File per child view: `fragments/exercise-card.html` <-> `ExerciseCard`.
- Fragment name = concept: `card`, not `fragment1`.
- Keep fragments self-contained: pass only what the card needs, not the whole page.
- Shared chrome goes in `fragments/`; layout decorators stay in `layouts/`.
- If a card needs extra flags, add them to the view model or a second fragment parameter; don't reach into the parent model.

Chain: entity -> `ExerciseCard` (mapped in service) -> fragment `card(exercise)` -> included by `WorkoutPage`'s template. One type, one fragment, reusable for full-page render and HTMX partials.

# Kotlin

## Extension functions

An extension function adds a function to an existing type without modifying or subclassing it:

```kotlin
fun Exercise.toCard(): ExerciseCard =
    ExerciseCard(
        name = exerciseType.name,        // named argument; RHS = this.exerciseType
        oneRepMax = oneRepMax,           // this.oneRepMax implicitly
        splits = listOf(
            SplitCard(oneRepMax * split1.multiplier, split1.reps, isSplit1Completed),
            SplitCard(oneRepMax * split2.multiplier, split2.reps, isSplit2Completed),
            SplitCard(oneRepMax * split3.multiplier, split3.reps, isSplit3Completed),
        ),
    )
```

- `Exercise.toCard()` is the extension function; `Exercise` is the receiver type.
- Inside the body, `this` is the receiver, so its properties (`exerciseType`, `oneRepMax`, `split1`, `isSplit1Completed`, ...) are available directly.
- `this.oneRepMax` and `oneRepMax` are equivalent; use `this` when a parameter or local would shadow it.
- Call it like a member: `exercise.toCard()`.
- It compiles to a static function with the receiver as its first parameter, so it cannot access private members and does not enable polymorphism (no overriding).
- Import it with a normal import if it lives in another package.

Named arguments (`ExerciseCard(name = ..., oneRepMax = ...)`) let you skip positional order, avoid repeating types, and make mappings self-documenting.

### Related Kotlin concepts
- **Data classes**: `data class ExerciseCard(...)` generates `equals`, `hashCode`, `toString`, `copy`, and component functions; ideal for view models and DTOs.
- **`copy`**: create a changed view model without mutating the original, e.g. `card.copy(completed = true)`.
- **Default parameters**: useful for form DTOs (`val name: String = ""`).
- **Nullability**: `String?` vs `String`; use `?.`, `?:`, `let` instead of null checks.
- **Scope functions**: `let`, `run`, `apply`, `also`, `with`; know when each returns the receiver vs the result.
- **Top-level/extension functions**: prefer colocating `toX()` mappers next to the target type.
