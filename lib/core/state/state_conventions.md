# State Conventions

- Keep UI-facing state in `ChangeNotifier` classes under `lib/core/state/`.
- Widgets should read state with `context.watch`, `Consumer`, or `Selector`.
- Widgets should mutate state by calling methods on the state class, not by
  reaching into repositories or editing fields directly.
- Repositories remain responsible for fetching data and mapping raw models.
- State objects should expose simple primitives and collections that are easy
  for screens to render.
- If a screen needs domain data, translate it into UI state before exposing it
  to widgets.
