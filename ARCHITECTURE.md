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

## 🛠 SOLID Principles Implementation

| Principle | How it is applied in this code |
| :--- | :--- |
| **S**ingle Responsibility | Each class has one job. `TaskValidator` validates, `TaskRepository` handles data, `NotificationService` notifies, and `TaskReportGenerator` manages reports. |
| **O**pen/Closed | We can add new storage (e.g., SQLite) by implementing a new `DataSource` without modifying existing BLoC or UseCase logic. |
| **L**iskov Substitution | `PriorityTask` and `RecurringTask` extend `Task`. All logic operates on `List<Task>`, allowing subtypes to replace the base class without breaking the app. |
| **I**nterface Segregation | We use focused interfaces like `ITaskRepository` and `TaskDataSource`. Classes only depend on the specific methods they need to function. |
| **D**ependency Inversion | High-level modules (BLoC, Controller) depend on abstractions (`ITaskRepository`), not concrete implementations (SharedPrefs). |

---

## Service Locator (GetIt) vs. Constructor DI

For this project, the **Service Locator** was chosen for several reasons:

1. **Decoupling from Widget Tree**: Unlike `Provider` or `InheritedWidget`, `GetIt` allows access to dependencies outside of the `BuildContext` (e.g., in background tasks or deep logic layers).
2. **Boilerplate Reduction**: Automated DI via `injectable` removes the need to manually instantiate long chains of dependencies.
3. **Environment Management**: It provides a clean way to manage "prod", "dev", and "test" environments using tags, which is essential for professional software testing.