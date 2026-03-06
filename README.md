# SCP-173 System
> Modular SCP-173 system featuring blinking, player detection, and multiplayer support.
---

## Features

**SCP-173**
- Teleporting
- Multiplayer player detection & killing
- Reaction time (allows slight errors without instant punishment)

**Client-side Systems**

- Player Blink System
- Camera Checker

---

## Showcase
# TBD

---

## Architecture

```
Workspace
 └─ SCP-173
     └─ Peanut                   │ SCP-173's mesh.
         ├─ KillSound
         └─ TeleportSound

ReplicatedStorage
 ├─ Modules
 │   ├─ Blinking                 │ Handles blinking on the client side.
 │   └─ CameraChecker            │ Detects if the player is observing SCP-173.
 └─ Remotes
     ├─ BlinkEvent
     └─ WatchedEvent

ServerScriptServie
 ├─ Main.Server.lua              │ Main server script that initializes anything server-related.
 └─ SCP173                       │ Manages all server-sided stuff, like teleporting and killing.

 StarterGui
 └─ BlinkUI                      │ Manages blink UI tweening.
     ├─ Frame                    │ A black frame, resembling the eye being fully closed.
     └─ ImageLabel               │ The vignette, resembling the eye opening/closing.

StarterPlayerScripts
 └─ Main.Client.lua              │ Controls the client-side blink and detection loop.
```

---

## Code snippets

Check out [code-snippets.lua](code-snippets.lua) for code examples.

---

## Why I Made This

This project was my second major system I made after developing the [Letter-Constrained Chat System](https://github.com/evyyyy-dev/letter-constrained-chat), and it showed a step toward more structured, modular code. Since I used to be a long-time SCP fan, I decided to recreate SCP-173 once I felt confident in my ability to handle more complex logic such as multiplayer synchronization and raycasts.

The idea was also inspired by a friend's "Weeping Angel" (which is similar to SCP-173) project, and by noticing the low-quality SCP-173 models available in the toolbox, I wanted to challenge myself to create something cleaner, better-optimized, and more maintainable.

## What I Learned

While developing this system, I learned how to implement raycasting for accurate line-of-sight detection and improved my understanding of CFranes. The project also enhanced my ability to write clean, modular code and to structure client/server logic effectively.

## What I'd Improve

I've already refactored the original design, by transitioning from a single large client and server script into a modular, scalable system. If I were to touch this project again, I would focus on gamefeel and polish rather than structure, by adding better kill effects, a directional UI indicator, or even a visual teleportation cue (like a quick ghost trail).

---

> ✅ **Status:** Complete
