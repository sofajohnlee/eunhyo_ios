# Android to Flutter/iOS migration plan

Reference repository: sofajohnlee/eunhyo

| Android area | Flutter target | Status |
|---|---|---|
| MainActivity / main XML | HomeScreen | Initial implementation |
| MainEHschool | SchoolScreen | Planned |
| MainMathPlus | MathPlusScreen | Initial implementation |
| MainMathMinus / Multi / Div / Mix / Geo / Painter | Math feature screens | Planned |
| MainEng / MainEeng* | English feature screens | Planned |
| MainEkor* / MainKorean* | Korean feature screens | Planned |
| MainHanja* | Hanja feature screens | Planned |
| MainMagic / MainBgame / Mz* / MainCtest | Games | Planned |
| MainSports | SportsScreen | Initial implementation |
| MainAI | AIScreen | Planned |
| RegistryBotActivity / registry RAG tooling | RegistryBotScreen + service | Initial API integration |
| ScoreRepository | Flutter repository/service | Planned |
| SharedPreferences/env settings | SharedPreferences/config service | Planned |
| Android external storage | iOS application documents/support | Planned |

The Android MainActivity is a navigation hub for English, school, courage/movie, magic, sports, AI, games, education sites and drawing.

MainEHschool stores the selected math-number range and opens math activities.

MainMathPlus contains question generation, answer checking, scoring, speech/TTS-related code, timers and ScoreRepository integration.

MainSports uses three YouTube video IDs for jump rope, badminton and table tennis.

A feature is not considered migrated merely because its screen exists; its behavior must also be tested.
