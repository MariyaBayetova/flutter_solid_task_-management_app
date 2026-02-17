# Architecture Documentation

This document describes the architectural patterns, dependency flow, and design decisions used in the Task Manager application.

## Dependency Flow
The application follows the **Clean Architecture** data flow pattern (Direction of Dependencies: Outside -> In).

1.  **UI Layer**: User interacts with the UI. A Flutter Widget calls an event in the `TaskBloc`.
2.  **Presentation Layer (BLoC)**: The `TaskBloc` receives the event and triggers a specific `UseCase`.
3.  **Domain Layer (Use Cases)**: The `UseCase` contains business logic and requests data from the `ITaskRepository` (Interface).
4.  **Data Layer (Repository Implementation)**: `TaskRepositoryImpl` (the concrete implementation) fetches or saves data.
5.  **Infrastructure Layer (Data Source)**: The Repository communicates with the active `TaskDataSource` (e.g., `SharedPrefTaskDataSource` for production or `MockTaskDataSource` for development).

---

## Dependency Injection Logic

We utilize a **Service Locator** pattern powered by `GetIt` and `Injectable`.

### Dependency Graph
* **TaskBloc** (Factory) -> depends on -> **UseCases**
* **UseCases** (Factory) -> depends on -> **ITaskRepository** (Interface)
* **ITaskRepository** (LazySingleton) -> implemented by -> **TaskRepositoryImpl**
* **TaskRepositoryImpl** -> depends on -> **TaskDataSource** (Interface)
* **TaskDataSource** (LazySingleton) -> implemented by -> **SharedPrefTaskDataSource**
* **SharedPrefTaskDataSource** -> depends on -> **SharedPreferences** (External Module)

---

## SOLID Principles Implementation

| Principle | How it is applied in this code |
| :--- | :--- |
| **S**ingle Responsibility | Every class has one job. `TaskValidator` only validates, `TaskRepository` data operations, `NotificationService` only notifies, `TaskReportGenerator` generating reports. |
| **O**pen/Closed | We can swap storage (e.g., move from SharedPrefs to SQLite) by adding a new `DataSource` without touching the BLoC code. |
| **L**iskov Substitution | 
`PriorityTask` and `RecurringTask` both extend the base `Task` class.
All business logic (UseCases, Repositories) and State Management (BLoC) operate on the base `Task` type (e.g., `List<Task>`). The `ITaskRepository` can be replaced by any of its implementations without breaking the `TaskBloc`. |
| **I**nterface Segregation |
`Readable` has read operations,
`Writable` has write operations,
`Deletable` has delete operations.
 We use specific interfaces (`ITaskRepository`, `TaskDataSource`) so classes only know about methods they actually use. |
| **D**ependency Inversion | 
`TaskRepository` depends on `ITaskDataSource` interface
`TaskController` depends on `ITaskRepository` interface.
The `TaskBloc` does not "know" about `SharedPref`. It depends on `UseCase` and `Repository` abstractions. |

---

## Service Locator (GetIt) vs. Constructor DI

For this project, the **Service Locator** was chosen for several reasons:

1. **Decoupling from Widget Tree**: Unlike `Provider` or `InheritedWidget`, `GetIt` allows access to dependencies outside of the `BuildContext` (e.g., in background tasks or deep logic layers).
2. **Boilerplate Reduction**: Automated DI via `injectable` removes the need to manually instantiate long chains of dependencies.
3. **Environment Management**: It provides a clean way to manage "prod", "dev", and "test" environments using tags, which is essential for professional software testing.