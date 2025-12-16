# qofi

This project is a Quickshell-based app launcher inspired by the likes of wofi and rofi.

### Project background

This project will focus first on my Hyprland setup. The app should work in most tiling WMs and DEs, though.

I'm building this for a few reasons:

- I want to learn Quickshell/QML/Qt
  - There are other [widget systems](https://wiki.hypr.land/Useful-Utilities/Status-Bars/#widget-systems)
    that work with Hyprland, but Quickshell ticks more of my boxes. Intuitive/modern language for writing the config,
    contained runtime, and a UI toolkit I've had better experiences with (Qt was easier than GTK in Python for me.)
- I'm not a big fan of the customization/styling methodologies for most of the [app launchers linked in the Hyprland wiki](https://wiki.hypr.land/Useful-Utilities/App-Launchers/)
  - CSS, Lisp, and proprietary configs hurt to use!
- I have some ideas for how to make app launchers (and widgets in general!) nicer to use and I
  think QML/QtQuick provide primitives which make this easy to build.

Goals and _maybe-goals_

- [ ] List view on Desktop entries
  - [ ] Visible metadata elements can be selected/unselected
  - [ ] Click to launch, other actions drop down on right-click, including "copy launch command", e.g.
- [ ] Grid view on Desktop entries
  - [ ] Icon-only mode
  - [ ] Click to "expand entry" which shows actions and metadata in popup/popover view
- [ ] Theme/style presets
  - [ ] e.g., "super compact", "spacious", "icons on the right"
  - [ ] Expose colors, size presets, et al. for customization
- [ ] Intuitive UI/UX
  - [ ] Shortcuts for major actions: cycle view, set theme, etc.
  - [ ] Modes, settings, hover-actions, etc should be visible to user.
  - [ ] _Clickables for major actions_
- [ ] _Graph view on Desktop entries_
  - _What relationships would determine the edges of the graph?_
  - _Expand on interact like Grid view?_
- [ ] Views are embeddable.
  - Another Quickshell program (e.g., a start menu like on Windows, but without
    ads which grind the system to a halt) could embed the view within.
- [ ] _dmenu-like input mode_
  - _Ideally, we can replace the Desktop entries with arbitrary inputs like dmenu mode in rofi/wofi._

Non-goals

- Feature parity with any existing system.
- Intentional compatibility with all WMs and DEs. It should work in Hyprland and will likely work in any Wayland WM.
