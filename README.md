# Task Management App (SOLID & DI Implementation)

This project is a Task Management application built with Flutter, focusing on Clean Architecture, SOLID principles, and automated Dependency Injection.

## Architecture Diagram
The app follows a strict Layered Architecture (Presentation -> Domain <- Data).
1. **Domain Layer**: Contains Entities, Use Cases, and Repository Interfaces. This is the "heart" of the app and has zero dependencies on other layers.
2. **Data Layer**: Contains Repository implementations and Data Sources (Shared Preferences, Mock, Firebase).
3. **Presentation Layer**: UI Widgets and BLoC for state management.

```mermaid
graph TD
  subgraph Presentation
    UI[Task Pages] --> Bloc[Task BLoC]
  end

  subgraph Domain
    UC[Use Cases] --> Entities[Entities: Task, Priority, Recurring]
    Bloc --> UC
    UC --> RI[ITaskRepository Interface]
    RI --> Entities
  end

  subgraph Data
    RI_Impl[TaskRepositoryImpl] -.-> RI
    RI_Impl --> DS[TaskDataSource Interface]
    DS_Impl[SQLite/SharedPref/Mock] -.-> DS
    RI_Impl --> Entities
  end