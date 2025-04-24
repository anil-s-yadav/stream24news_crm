# Stream24 News CRM

A Flutter web application for managing news channels and content. This CRM system allows you to manage live channels, handle reported and requested channels, and manage news content.

## Features

- View all channels in a grid layout
- Manage reported channels
- Handle channel requests
- News management with delete and reload functionality
- Add new channels with logo, name, URL, and language selection
- Responsive design for web platforms

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- A modern web browser (Chrome recommended)
- Firebase project (for backend - to be configured)

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd stream24news_crm
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d chrome
```

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── screens/
│   └── home_screen.dart   # Main screen with navigation
└── widgets/
    ├── sidebar.dart       # Navigation sidebar
    ├── channel_list.dart  # Channel grid display
    ├── news_list.dart     # News management
    └── add_channel_form.dart # New channel form
```

## Firebase Setup (TODO)

1. Create a new Firebase project
2. Enable Authentication
3. Set up Cloud Firestore
4. Configure Firebase in the web app

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.








# From your project root
flutter build web

# Move into the build folder
cd build/web

# Initialize git and switch to deploy branch (if not already)
git init
git remote add origin https://github.com/anil-s-yadav/stream24news_crm.git
git checkout -b deploy

# Stage and push
git add .
git commit -m "Update Flutter web app"
git push -f origin deploy

