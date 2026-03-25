# MyOwnFitnessAPP 💪

A comprehensive fitness tracking iOS app built with SwiftUI and SwiftData that helps you monitor your workouts, meals, and progress towards your fitness goals.

## Features

### 🏋️ Workout Tracking
- Log exercises with multiple sets
- Track weight and reps for each set
- View detailed exercise history
- Delete and manage your workout data
- Clean, intuitive interface for quick logging

### 🍽️ Meal Tracking
- Search and log meals using nutrition data
- Track calories, protein, carbs, and fat
- View total daily calorie intake
- Color-coded calorie goals (under/over 2000 calories)
- Edit meal information
- Search powered by nutrition API integration

### 📊 Progress Monitoring
- Track body weight over time
- Set and monitor desired weight goals
- Visual progress tracking
- Date-based progress logging

### 👤 Profile & Authentication
- Firebase Authentication integration
- User profile management
- Secure sign-in/sign-out

## Technical Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Data Persistence**: SwiftData
- **Authentication**: Firebase Auth
- **API Integration**: Nutrition data API for meal searching
- **Architecture**: MVVM pattern with observable view models

## Data Models

### ExerciseData
```swift
- workoutName: String
- sets: [Sets]
```

### Sets
```swift
- weight: Int
- reps: Int
- date: Date?
- setNumber: Int
```

### Meal
```swift
- name: String
- calories: Int
- protein: Int
- carbs: Int
- fat: Int
- date: Date
```

### Bodyweight
```swift
- bodyweight: Double
- desiredWeight: Double
- date: Date?
```

## App Structure

The app uses a tab-based navigation with four main sections:

1. **Workout** - Exercise logging and tracking
2. **Meals** - Nutrition and meal management
3. **Progress** - Body weight and fitness progress
4. **Profile** - User account management

## Key Views

- `MainTabView` - Main tab navigation container
- `WorkOutView` - Exercise list and management
- `ExerciseDetailView` - Detailed view of individual exercises
- `MealView` - Meal list with daily calorie totals
- `MealDataView` - Add new meals with nutrition search
- `EditMealView` - Edit existing meal information
- `FitnessProgressView` - Track body weight progress
- `ProfileView` - User profile and settings
- `LoginView` - Authentication interface

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 6.0+
- Firebase account (for authentication)
- Active internet connection (for meal search functionality)

## Setup

1. Clone the repository
2. Open `MyOwnFitnessAPP.xcodeproj` in Xcode
3. Configure Firebase:
   - Add your `GoogleService-Info.plist` to the project
   - Ensure Firebase Authentication is enabled
4. Build and run on your device or simulator

## Usage

### Adding a Workout
1. Navigate to the Workout tab
2. Tap the "+" button
3. Enter exercise name and set details
4. Save your workout

### Logging a Meal
1. Navigate to the Meals tab
2. Tap the "+" button
3. Search for a food item
4. Select meal type (Breakfast/Lunch/Dinner)
5. Review nutrition information
6. Save the meal

### Tracking Progress
1. Navigate to the Progress tab
2. Log your current body weight
3. Set your desired weight goal
4. Monitor changes over time

## Future Enhancements

- [ ] Charts and graphs for progress visualization
- [ ] Workout routines and templates
- [ ] Custom meal creation
- [ ] Macro goals customization
- [ ] Social features and sharing
- [ ] Exercise form videos
- [ ] Workout timer
- [ ] Weekly/monthly statistics

## Contributing

This is a personal fitness tracking project. Feel free to fork and customize for your own use.

## License

All rights reserved. Created by kalyan.

## Contact

For questions or feedback, please open an issue in the repository.

---

**Note**: This app is for personal fitness tracking purposes. Always consult with healthcare professionals before starting any new fitness or nutrition program.
