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
[![Watch showcase](https://img.youtube.com/vi/Qev-H1CNSeg/0.jpg)](https://www.youtube.com/watch?v=Qev-H1CNSeg)

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
 └─ SCP173                       │ Module that manages all server-sided stuff, like teleporting and killing.

 StarterGui
 └─ BlinkUI
     ├─ Frame                    │ A black frame, resembling the eye being fully closed.
     └─ ImageLabel               │ A vignette, resembling the eye opening/closing.

StarterPlayerScripts
 └─ Main.Client.lua              │ Controls the client-side blink and detection loop.
```

#### System flow

- Both main scripts (server and client) initialize their respective modules.

- The Blinking Module forces each player to blink by tweening `BlinkUI` 's elements approximately all 5 seconds, with a small random offset added to prevent synchronized blinking and fires the `BlinkEvent` to notify the SCP-173 module.

- The CameraChecker Module checks if the player is watching SCP-173 inside of a ±15° vision cone.

- SCP-173's Module uses a continuous server-sided loop, working like this:
  - It identifies the nearest player as the current target.
  - It iterates through all playeres, checking whether they are observing SCP-173 or not.
  - If at least one player is currently observing SCP-173, movement is stopped.
  - If SCP-173 isn't being watched, a `REACTION_TIME` delay is applied to make gameplay less strict.
  - After the delay, if SCP-173 still remains unobserved, it advances toward the target player with `moveDistance` steps at a time.
  - If the distance between SCP-173 and the player becomes small than `moveDistance`, it teleports in front of the player and kills them.
---

## Code snippets

Check out [code-snippets.lua](code-snippets.lua) for code examples.

---

## Why I Made This

This project was my second major system I made after developing the [Letter-Constrained Chat Filtering System](https://github.com/evyyyy-dev/letter-constrained-chat), and it made me improve more toward modular code. Since I used to be a long-time SCP fan, I decided to recreate SCP-173 once I felt confident in my ability to handle more complex logic such as multiplayer synchronization and raycasts.

The idea was also inspired by a friend's "Weeping Angel" project, which is similar to SCP-173, and by noticing the low-quality SCP-173 models available in the toolbox, I wanted to challenge myself to create something cleaner, better-optimized, and more maintainable.

## What I Learned

While developing this system, I learned how to implement raycasting for accurate line-of-sight detection and improved my understanding of CFranes. The project also enhanced my ability to write clean, modular code and to structure client/server logic effectively.

## What I'd Improve

I've already refactored the original design by transitioning from a single large client and server script into a modular, scalable system.

If I were to touch this project again, I would focus on gamefeel and polish rather than structure, by adding better kill effects, a directional UI indicator, or maybe even a visual teleportation cue (like a quick ghost trail).

---

> ✅ **Status:** Complete
