# BestRecipes
<div style="width: 100%; height: 200px; overflow: hidden;">
  <img
    src="https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/images/1KipejOTs0qgfOTr1grCFg.jpeg"
    alt="Onboarding Preview"
    style="width: 100%; height: auto; object-fit: cover; object-position: center;"
  >
**iOS app for discovering and managing recipes with SwiftUI + MVVM**
</div>

--- 

**BestRecipes** is a SwiftUI-based iOS application that helps users discover, search, and manage cooking recipes. Users can explore trending recipes by categories and cuisines, search for specific meals, view detailed recipe information (ingredients, cooking instructions), save favorites, and even add their own recipes. Built with modular MVVM architecture for maintainability and scalability.

## Table of Contents

- [Description](#description)  
- [Features](#features)  
- [Tech Stack & Architecture](#tech-stack--architecture)  
- [Getting Started](#getting-started)  
  - [Prerequisites](#prerequisites)  
  - [Installation & Setup](#installation--setup)  
- [Usage](#usage)  
- [Roadmap](#roadmap)  
- [Contributing](#contributing)  
- [License](#license)  
- [Contact](#contact)

---

## Description

**BestRecipes** lets users explore trending recipes, search for meals, view full recipe details (ingredients, instructions), and even add new ones. Built with modular MVVM for clarity and testability.

---

## Features

### Core Features
- **Onboarding**: Welcome guide for new users
- **Home**: Popular recipes by categories, search via SearchBar
- **TabBar**: Navigation (Home, Favorites, + placeholders for others)
- **Search**: Recipe search by keywords
- **Recipe Details**: Complete recipe information (ingredients, instructions)
- **Favorites**: Save recipes to favorites (in-memory until app closes)
- **Categories**: Recipe collection by dish categories
- **Cuisines**: Recipe collection by world cuisines

### Advanced Features
- **Create Recipe**: Add custom recipes (with persistent storage)
- **Profile**: User profile with avatar change capability
- **Ingredients Checklist**: Checkboxes to mark available ingredients


---

## Tech Stack & Architecture

- **Language**: Swift 5+
- **UI Framework**: SwiftUI
- **Minimum iOS**: iOS 15.0+ (TBD)
- **Architecture**: MVVM with modular structure
- **Networking**: URLSession + Spoonacular API
- **Data Storage**: UserDefaults (basic version), Core Data (advanced)
- **Navigation**: Manual navigation flow (to be developed during implementation)

---

## Getting Started

### Prerequisites

- macOS with Xcode 15+  
- Swift 5+  
- [Spoonacular API token](https://spoonacular.com/food-api) (or another recipe API)

### Installation & Setup

1. Clone the repository:
Clone the repository via SSH:

```bash
cd ~/Projects
git clone git@github.com:nikmosyl/BestRecipes.git
cd BestRecipes
```

2. Configure API keys
**Config.plist** in your app target’s resources:

```bash
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>SPOONACULAR_API_KEY</key>
    <string>YOUR_TOKEN_HERE</string>
  </dict>
</plist>
```

3. Open BestRecipes.xcodeproj in Xcode
---

## Usage
1. Complete Onboarding

2. Browse trending recipes on Home

3. Search by keyword

4. Tap into recipe detail to see ingredients and steps

5. Save favorites or explore collections

6. Advanced flows: create a recipe or view profile

---

## Roadmap

Current progress and tasks are tracked on [GitHub Projects Board](https://github.com/users/nikmosyl/projects/3)

### Week 1
- [ ] Basic navigation and TabBar
- [ ] Onboarding screen
- [ ] Home screen with categories
- [ ] Spoonacular API integration

### Week 2
- [ ] Recipe Details screen
- [ ] Search functionality
- [ ] Favorites (in-memory)
- [ ] Categories & Cuisines collections

### Advanced (if time permits)
- [ ] Create Recipe
- [ ] Profile screen
- [ ] Persistent storage

---

## Contributing

We're working as a team! Guidelines:

1. Pick tasks from [Project Board](https://github.com/users/nikmosyl/projects/3)
2. Create feature branch: `git checkout -b feature/module-name`
3. Work in modules under `Modules/` folder
4. Examples: `Modules/Test` (MVVM example), `Modules/NetworkTest` (API example)
5. Write descriptive commits in English
6. Submit Pull Request when task is complete

**Team sync-ups**: Sunday - general sync and weekly planning
---

## ⚖️ License
MIT License. See LICENSE for details.
