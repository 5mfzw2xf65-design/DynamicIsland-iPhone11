# Dynamic Island — iPhone 11

A SwiftUI in-app Dynamic Island-style simulator for iPhone 11.

## What it does
- Animated compact and expanded island
- Demo music controls and progress
- Battery / charging demo
- Timer demo
- Notification preview demo
- Premium dark interface with red accents

## Important iPhone 11 limitation
iPhone 11 has no physical Dynamic Island. This app simulates the look and interactions **inside the app only**. A normal App Store app cannot draw a permanent overlay over other apps or replace iOS system notifications. This project does not require jailbreak.

## Build
GitHub Actions runs on macOS, generates the Xcode project with XcodeGen, and builds an unsigned app artifact.

An unsigned IPA is not installable as-is. Installing on a physical iPhone requires signing with an Apple development certificate and provisioning profile.
