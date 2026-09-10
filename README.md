# SeniorCare Watch — Version 0.1

This is a simulator-first SwiftUI prototype of an elderly-care Apple Watch app. It uses sample values only. It is not medical software, does not diagnose conditions, does not contact emergency services, and does not provide medically validated fall detection.

## Run it on a Mac

1. Install current **Xcode** from the Mac App Store.
2. In Terminal, install XcodeGen: `brew install xcodegen`.
3. Change into this `SeniorCare` folder and run: `xcodegen generate`.
4. Open the generated `SeniorCare.xcodeproj` in Xcode.
5. Select a watchOS Simulator and click the Run triangle.

You should see a high-contrast SeniorCare home screen with large Care, Activities, and SOS choices. The screens use sample data so they work in the simulator.

## Current limitations

HealthKit, notifications, Watch Connectivity, microphone/speech, haptics, location, real reminders, AI services, fall sensing, companion iPhone app, backend, and nurse dashboard are intentionally later milestones. These need permissions, secure server design, and often a physical Apple Watch. Blood oxygen, wrist temperature, respiratory data, and related HealthKit types also depend on specific watch hardware, region, OS, and user settings.
