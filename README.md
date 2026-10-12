# Sameeksha's Flutter Web Portfolio

A responsive student e-portfolio built with Flutter Web. Includes a demo login, overview dashboard, academics, certifications/skills, activities, achievement carousel, and logout.

## Run locally

1. Install Flutter and make sure `flutter doctor` works.
2. Open this folder in VS Code or Android Studio.
3. In the terminal:

```bash
flutter pub get
flutter run -d chrome
```

The login is a front-end demo only: enter any non-empty roll number and password. It does not authenticate users or store credentials.

## Build for web

```bash
flutter build web
```

## Deploy to GitHub Pages

Create a GitHub repository, for example `sameeksha-portfolio`, and push this project. Then build with the repository base path:

```bash
flutter build web --base-href "/sameeksha-portfolio/"
```

Publish the contents of `build/web` using GitHub Pages (or automate deployment with GitHub Actions). For a root domain/custom domain, the base href may be `/`.

## Personalize

- Edit content and styles in `lib/main.dart`.
- Replace the `SB` avatar with your photo using an image asset and `CircleAvatar(backgroundImage: AssetImage(...))`.
- Add real certificate URLs and project repository links before publishing.
- Do not use a real password with this demo login; add a backend/authentication provider if real authentication is required.
