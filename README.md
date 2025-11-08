Mini Social Feed

A mini social media app built with Flutter that allows users to create posts with images and captions, like posts, and generate AI-based captions. The app uses SharedPreferences for local storage and Provider for state management.

Features

User Login – Simple email login with persistence.

Create Post – Add posts with:

Caption (manual or AI-generated)

Image from gallery

Feed – View all posts with:

User avatar & username

Timestamp

Image preview

Caption

Like functionality

Comment button (UI placeholder)

Persistent Storage – Posts and login state saved locally using SharedPreferences.

AI Caption Generator – Fetches captions from an AI/quotes API for auto-generated captions.

Clean, Modular UI – Post widget split into header, image, caption, and actions for maintainability.

Screenshots

(You can add your own screenshots here)

Login Screen

Feed Screen

Create Post Screen

Tech Stack

Flutter – Frontend UI

Provider – State management

SharedPreferences – Local data storage

Image Picker – Pick images from gallery

Intl – Format timestamps

HTTP – API requests for AI captions

Installation

Clone the repo:

git clone https://github.com/yourusername/mini-social-feed.git
cd mini-social-feed


Install dependencies:

flutter pub get


Run the app:

flutter run

Project Structure
lib/
├── models/
│   └── post_model.dart
├── providers/
│   └── feed_provider.dart
├── screens/
│   ├── login_screen.dart
│   ├── feed_screen.dart
│   └── create_post_screen.dart
├── services/
│   └── ai_caption_service.dart
├── widgets/
│   └── post_widget.dart
└── main.dart


models → Data models (PostModel)

providers → State management (FeedProvider)

screens → App screens (Login, Feed, Create Post)

services → API / AI caption service

widgets → Modular widgets (PostWidget and its subcomponents)

Usage

Open the app and login with any email.

Navigate to the feed.

Tap + to create a post.

Add a caption manually or generate using AI.

Pick an image from the gallery (optional).

Post and view it in the feed.

Like posts and see like counts update.
