<div align="center">

# 🍔 BiarFood — iOS Food Delivery App

**A modern food delivery app for iPhone & iPad, built with SwiftUI**

[![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift&logoColor=white)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-blue?logo=apple&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-10.15-yellow?logo=firebase&logoColor=white)](https://firebase.google.com)
[![iOS](https://img.shields.io/badge/iOS-16%2B-lightgrey?logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![Braintree](https://img.shields.io/badge/Braintree%20SDK-6.6-009cde?logo=paypal&logoColor=white)](https://developer.paypal.com/braintree/docs)

<br/>

<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/5a858c65-08d2-48c3-bdac-9a97ab60d91d" width="180">
<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/cb99c705-702c-4957-8199-982f40922150" width="180">
<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/b595d8f1-7513-4d51-a69b-00a4151b2c18" width="180">

</div>

---

## About

**BiarFood** is a fully-featured iOS food delivery app that lets customers browse products, add them to a cart, and check out securely — via **PayPal** or **cash on delivery**. The app supports both iPhone and iPad with adaptive navigation layouts.

---

## Features

| Feature | Description |
|---|---|
| 🏠 **Home & Slider** | Auto-scrolling promotional banner that advances every 5 seconds |
| 🗂️ **Categories** | Browse products filtered by category |
| 🛒 **Shopping Cart** | Add items, adjust quantities, deposit fees & tax calculation |
| ❤️ **Favorites** | Save and quickly revisit favourite products |
| 🔍 **Search** | Full-text search across all products |
| 📦 **Checkout Flow** | 3-step checkout: Address → Delivery Time → Payment |
| 💳 **Payment** | PayPal via Braintree SDK & cash on delivery |
| 📍 **Address Autocomplete** | Google Places API for smart address input |
| 👤 **User Profile** | Account management & saved delivery addresses |
| 📧 **Order Confirmation** | Automatic confirmation email sent via Swift-SMTP |
| 📱 **iPad Support** | Dedicated sidebar navigation for iPad |
| 🌙 **Dark / Light Mode** | Full custom color theme for both appearances |

---

## Screenshots

<div align="center">

### Home & Categories

<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/fcff72e2-0580-4e71-865d-39992556946e" width="200">
<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/5de8fded-8c36-4f61-83df-29e155ab54b3" width="200">
<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/e13e6d2b-16ac-423f-a3cb-9c074cb78e94" width="200">

### Products & Cart

<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/a697331e-ffcd-444d-87dc-43e83f7b1bc7" width="200">
<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/4e225915-81f4-43af-9b5f-c3b9abbd8656" width="200">
<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/6c9bc9ba-e5db-42a7-a8ff-fa4c7cbdee79" width="200">

### Checkout & Payment

<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/089abbcc-a401-48dc-812a-fa540105b3b9" width="200">
<img src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/78b26a90-6c0f-4036-a711-73d77f91bc43" width="200">

</div>

---

## Architecture

The app follows the **MVVM pattern** (Model – View – ViewModel) with a clean layered structure:

```
BiarFoodiphone/
├── Model/              # Data models (Product, User, Invoice, Cart, ...)
├── Repository/         # Data access & Firebase queries
├── Service/            # FirebaseManager, SMTP mail, responsive helpers
├── Shared/
│   ├── Authentication/ # Sign in, sign up, forgot password
│   ├── Home/           # Home screen & promotional slider
│   ├── Products/       # Product list, detail view, tab view
│   ├── Cart/           # Shopping cart
│   ├── Order/          # Checkout flow (address, delivery time, payment)
│   ├── Favorite/       # Favourites management
│   ├── SearchView/     # Search
│   ├── Profile/        # User profile & saved addresses
│   ├── Sidebar/        # Navigation for iPhone & iPad
│   ├── Category/       # Category browsing
│   └── BottomBar/      # Tab bar (iPhone)
└── Extension/          # ColorTheme, TextField modifier, utilities
```

---

## Tech Stack & Dependencies

### Frameworks & SDKs

| Library | Version | Purpose |
|---|---|---|
| **SwiftUI** | 5.0 | Full UI framework |
| **Firebase iOS SDK** | 10.15.0 | Auth, Firestore, Storage |
| **Braintree iOS SDK** | 6.6.0 | PayPal payment processing |
| **Kingfisher** | 7.9.1 | Async image loading & caching |
| **Swift-SMTP** (Kitura) | 6.0.0 | Order confirmation emails |
| **swift-protobuf** | 1.23.0 | Protocol buffers for Firebase |

### Google APIs

| API | Purpose |
|---|---|
| **Google Places / Address Autocomplete** | Smart address input during checkout |
| **Firebase / Google App Measurement** | Analytics & performance monitoring |

### Firebase Services

- **Firebase Authentication** — Email/password sign-in & registration
- **Cloud Firestore** — Real-time database for products, users, and orders
- **Firebase Storage** — Product images & app assets

---

## Product Model

Each product carries detailed grocery-specific fields:

- Price, sale price & VAT rate
- Nutritional values (kJ, kcal, fat, carbohydrates, protein, salt)
- Nutri-Score, ingredients & allergens
- Deposit type & deposit price
- Alcohol content & minimum age (adult flag)
- Availability status & stock amount
- Refrigeration requirement (`isCold`)

---

## Checkout Flow

```
Cart → [1] Address  →  [2] Delivery Time  →  [3] Payment
            ↓                                      ↓
   Google Autocomplete               PayPal (Braintree) or
                                     Cash on Delivery
                                            ↓
                                  Email Confirmation (SMTP)
```

---

## Requirements

- Xcode 15+
- iOS 16+
- macOS Ventura or later
- Swift 5.9
- Valid `GoogleService-Info.plist` (Firebase configuration)
- Braintree merchant account for PayPal payments

---

## License

This project is created for demonstration purposes. All rights reserved.

---

<div align="center">
  Made with ❤️ using SwiftUI & Firebase
</div>
