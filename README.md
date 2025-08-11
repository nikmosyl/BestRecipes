# BestRecipes

iOS app for browsing, searching, and managing recipes in a clear MVVM-based architecture.

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

- **Onboarding**: Welcoming flow for new users  
- **Home**: Trending recipes, categories, and preview content  
- **Search**: Dynamic search UI to find recipes  
- **Recipe Detail**: Full recipe view with ingredients and instructions  
- **Saved / See All / Discover**: Collection management  
- **(Advanced)**: Create Recipe and Profile screens

---

## Tech Stack & Architecture

- Swift 5+, Xcode 15+  
- Architecture pattern: **MVVM** using modules per feature  
- Network interaction via Spoonacular API (or any other)  
- Manual navigation flow — intentionally simple for learning clarity

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

---

## Usage
1. Complete Onboarding

2. Browse trending recipes on Home

3. Search by keyword

4. Tap into recipe detail to see ingredients and steps

5. Save favorites or explore collections

6. Advanced flows: create a recipe or view profile

---

## Contributing

Contributions and issue reports are welcome!

* Start with git checkout -b feature/YourFeatureName

* Make your changes, commit, and open a Pull Request

---

## ⚖️ License
MIT License. See LICENSE for details.
