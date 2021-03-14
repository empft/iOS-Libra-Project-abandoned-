# Documentation

---
## Fundamental Concept

### Persistence of Data
User based Persistence and Device based persistence
**User**
- Session Key in keychain
- Cache and User Configuration in Core Data
- Login State in UserDefaults

**Device**
- Wallets in keychain
- User-Wallet Link Key in keychain
- Encrypted Chat History and Key for specific user
- Device config in Core Data

### User
- Only one user can login per device
- Store *session key* in keychain, *cache and config* in core data and *login state* in userdefaults

### Cryto Key Storage aka Wallet


### How to complete a transaction





---
## Third Party Codes

### LineReader
Read and load a text file line by line, good fo reading extremely large file

```
let reader = LineReader(path: path)!

for line in reader {
    // do something with line
}

```

---
## Reusable View Components

### FlipView
Show a collection of views as pages that change with sliding animation

1. Views must implement Flippable Protocol
2. Add an environment object Flipper that conform to the protocol
3. Implement FlipView that takes a list of view casted to AnyView, e.g.
```
FlipView(
    AnyView(PageOne()),
    AnyView(PageTwo())
)
```
Features:
- Use `disableSwipeBack()` function provided by Flipper object on onAppear modifier to prevent turning to previous page

### Form
Various components that can be used to create a form

#### NextButton
A button that is aligned to the right

#### ErrorField
A TextField that can show error message under it

#### LoadableButton
A button with a rotating loading image next to it; this button is aligned to the right 

#### TimerButton
A button that show a timer next to it, button is disabled when time shown is larger than zero; this button is aligned to the right


### Loading
A rotating loading image, use with caution, it may interfere with other animation

### ActivityIndicator
A loading indicator that can be toggle, better than `Loading()`

### NavBackButton
A customisable back button in navigation bar, looks slightly different from default back button
























