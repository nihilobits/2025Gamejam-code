### Solo Project: Full-Cycle Development
This collection of scripts demonstrates the implementation of core interactive mechanics for a 48-hour Game Jam project. The focus was on delivering a functional Minimum Viable Product (MVP) with high player engagement through environmental storytelling and interactive systems.


This game was developed entirely by me as a **Solo Developer** and my work encompassed:
- **System Programming:** Implementing all core game loops and interactive systems.
- **3D Modeling & Asset Creation:** Designing and modeling all in-game objects (except the burger and cat model).
- **Level Design:** Planning and building the entire map layout to ensure proper pacing and player flow.
- **Game Design:** Concept development, mechanic design, and making the game playable and enjoyable.

#### Featured Mechanics & Technical Implementation:
- **State-Based Interaction (Doors & Hatches):**
  - Implemented a robust door system using TweenService with a debounce mechanism to prevent animation glitches.
  - Includes automated closing logic (task.delay) to maintain game flow and atmosphere.
- **Logic-Driven Inspection (Burger Minigame):**
  - A randomized spawning system that clones and validates different "burger" models.
  - Implements a custom game loop managing win/loss conditions based on player decisions.
- **Environment & Feedback Systems:**
  - A raycast system that provides visual feedback when players look at interactive objects.
  - Global event tracking to trigger the final win-state and cinematic sequences.
- **Complex World Events (Nuke Sequence):**
  - Manages multi-part animations, sound synchronization, and procedural rocket movement via CFrames and Tweening.
  - Implements a custom "Reset" event handler to ensure game replayability without reloading the server.
 
While these scripts were written under extreme time pressure, they highlight my ability to translate complex game design ideas into functional code rapidly. This is not one of the scripts that represent my architectural skills, they do represent the ability to deliver the Most Viable Product within extreme time windows :) Please do keep in mind I had 48 hours to do everything alone, which impacted the quality of the code greatly. When you do have so little time, the focus is on delivering rather than polishing. I have decided to leave it unmodified after the gamejam to show that I am capable of making something that works under pressure.
