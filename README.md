MyOwnFitnessAPP
A fitness app I built to track my workouts, meals, and weight goals — because I got tired of watching ads on Cronometer and didn't want to pay for a subscription. So I figured I'd build my own.
What It Does

Workout Tracking — Log exercises with multiple sets, track weight and reps, view exercise history
Meal Tracking — Search foods using the USDA FoodData Central API, log meals with full nutrition info (calories, protein, carbs, fat), see daily calorie totals
Body Weight Tracking — Log your weight over time, set a goal weight, toggle between kg and lb
Profile — Google Sign In with Firebase Auth, view your stats and goals, sign out

Tech Stack

SwiftUI — all UI built in SwiftUI with no UIKit
SwiftData — for persisting workouts, meals, and body weight entries
Firebase Auth — Google Sign In using OAuth 2.0
USDA FoodData Central API — for searching food nutrition data
MVVM Architecture — ViewModels with @Observable, feature-based folder structure

What I Learned
This was my biggest project as a self-taught iOS developer, and I picked up a lot:

SwiftData over Core Data for data persistence — learned how to set up models, relationships (ExerciseData → Sets), and @Query for fetching data
MVVM pattern — structuring code with clear separation between views, view models, and models. Organized everything into feature-based folders
API integration — started with Open Food Facts API, switched to USDA when it stopped working. Learned to decode nested JSON, use computed properties to extract specific nutrients from arrays, and handle loading/error states
Firebase Auth — the hardest part of this project. Had zero Firebase experience and spent a full day debugging an issue with the REVERSED_CLIENT_ID and Bundle ID in the GoogleService-Info.plist. Solved it by digging through Stack Overflow and actually reading what Xcode was telling me
Apple Human Interface Guidelines — used them to inform layout decisions and keep the app feeling native

Screenshots
Coming soon
Requirements

iOS 17.0+
Xcode 15.0+
Firebase account for authentication
USDA API key (free at https://fdc.nal.usda.gov/api-key-signup.html)

Setup

Clone the repo
Add your GoogleService-Info.plist for Firebase
Add your USDA API key in MealDataviewModel.swift
Build and run

What's Next

Charts for weight progress visualization
Meal type sections (Breakfast / Lunch / Dinner)
Workout templates and routines
Custom macro goals



