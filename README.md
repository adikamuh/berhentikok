# BerhentiKok

BerhentiKok (Berhenti meroKOk) — a lightweight Flutter app to help users track and progress toward quitting smoking.

## Overview

BerhentiKok helps users monitor cigarette consumption, track health improvements, measure financial savings, earn achievements, and follow tips to support quitting.

## Key Features

- Track daily cigarette consumption and smoking details.
- Visualize health progress and key metrics over time.
- Calculate and display financial savings from reduced smoking.
- Achievements and milestones to motivate progress.
- Onboarding flow and tips to support behavior change.
- Persist user data locally using Hive; repositories abstract storage.

## Project Structure (high level)

- `lib/`: main application code
  - `main.dart` and `generate_routes.dart`
  - `base/`: UI constants, extensions, and shared helpers
  - `helper/`: small utilities (e.g., `count_helper.dart`)
  - `model/`: data models (achievement, health_progress, smoking_detail, user, etc.)
  - `page/`: feature pages (achievement, consumption, finance, health, home, on_boarding)
  - `repositories/`: data access and persistence layers
  - `widget/`: reusable widgets grouped by purpose

## Development

- Install dependencies:

```bash
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```
