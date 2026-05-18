# Grojha — Customer App

> Hyperlocal delivery from your neighborhood kirana, in 20–30 minutes.

This repository contains the **customer-facing Flutter app** for Grojha — a hyperlocal delivery platform I co-founded and built during the 2021 COVID lockdown in India. The product connected local neighborhood shops with the people on their street when going outside the door wasn't an option.

**Live on the Play Store:** [com.grojha.grojha](https://play.google.com/store/apps/details?id=com.grojha.grojha&pli=1)
**Working prototype APK:** [Google Drive](https://drive.google.com/file/d/1xfU6X8yfVHW3Pr8Fv69nNth-Tp1lE3bm/view?usp=sharing)

---

## What I built

Grojha was four products glued together by Firebase:

| Surface | What it does | Stack |
| --- | --- | --- |
| **Grojha** (this repo) | Customer app — browse nearby shops, place orders, track delivery live | Flutter + Firebase |
| **Grojha Retails** | Vendor app — accept orders, manage inventory, mark packed | Flutter + Firebase |
| **Grojha Delivery** | Runner app — pick up, navigate, mark delivered | Flutter + Firebase |
| **Grojha Admin** | Operations dashboard — onboarding, disputes, payouts | Web + Firebase |

This repo is the **customer app** — the one that shipped publicly to the Play Store and stayed there.

## Traction

In the first three months post-launch we onboarded **30+ local shops**, served **100+ active customers**, and completed **500+ deliveries**. Real-world traction in one neighborhood, run by two engineers and a small ops team during a lockdown.

---

## The stack

A small, deliberately boring stack, chosen so two engineers could ship four products and not drown in DevOps.

- **Flutter / Dart** — one codebase, three deliverables. The same Flutter project tree shipped three different package IDs via `change_app_package_name`.
- **Firebase Realtime Database** — primary store. The order lifecycle is heavily real-time (placed → accepted → packed → picked up → delivered), and Realtime DB's `onValue` listeners meant four apps stayed in lock-step without a single line of WebSocket code.
- **Firebase Auth** — phone OTP for customers and vendors, email for runners and admins.
- **Firebase Cloud Storage** — product photos.
- **Firebase Cloud Messaging (FCM)** — order updates to the customer, new-order pings to the vendor, dispatch nudges to the runner. Wired through `flutter_local_notifications` for foreground display.
- **Provider** — state management. No Bloc, no Redux — just `Provider` and `ChangeNotifier`. Every Flutter dev who touched it understood it on day one.
- **image_picker + image_cropper** — vendors uploaded clean product photos from their phone in seconds. Catalog quality drove conversion directly, so this had to be smooth.
- **pinput** — OTP entry that didn't feel like a chore.
- **firebase_dynamic_links** — deep links for shared shop/product pages.
- **in_app_update + new_version** — force-update prompts when the schema or critical UX shifted.

Full dependency graph in [`pubspec.yaml`](./pubspec.yaml).

---

## Architecture notes

A few decisions that aged well, written down here so the reasoning isn't lost:

**Realtime DB over Firestore.** Firestore had launched but Realtime DB's read pricing and `onValue` semantics were a better fit. Most reads were live order subscriptions, not ad-hoc queries. With persistence enabled (`setPersistenceEnabled(true)`) and a 100 MB cache (`setPersistenceCacheSizeBytes`), the app worked smoothly on flaky 3G connections, which mattered for the customer base we were serving.

**One project, three package IDs.** Each app shipped from the same Flutter project tree with `change_app_package_name` swapping the Android package and bundle ID at build time. We avoided maintaining three separate codebases without giving up store-listing isolation. This eventually became friction (vendor needs diverged from delivery's), but in month one it let two engineers do the work of six.

**Service locator (`get_it`) over passing dependencies through the tree.** `PushNotificationService`, `AuthenticationService`, and `DynamicLinkService` are registered in [`lib/locator.dart`](./lib/locator.dart) and pulled in wherever needed. Pragmatic for an app this size.

**App-version gate on boot.** [`lib/main.dart`](./lib/main.dart) reads `grojhaAppVersion` from Realtime DB before rendering the home screen and forces a Play Store update if the installed version is below the required floor. This let us ship breaking schema changes without leaving stale clients in a corrupt state.

---

## Repo layout

```
lib/
├── main.dart                # App entry, Firebase init, version gate
├── routes.dart              # Named-route table
├── theme.dart, constants.dart, size_config.dart
├── locator.dart             # get_it registrations
├── Objects/                 # Domain models — Shop, Product, Order, CartTemp, CurrentUser
├── screens/                 # 17 feature screens (home, cart, single_shop, orders, otp, …)
├── business_logic/          # Order flow, cart, FCM, cancel/accept/refresh
├── services/                # Auth, push notifications, dynamic links
├── components/              # Reusable widgets (buttons, loaders, nav bar, cached image)
├── global_variables/        # In-memory product/shop caches
└── helper/                  # Keyboard utilities
```

---

## Running locally

```bash
flutter pub get
flutter run
```

The build expects a Firebase project — drop your own `google-services.json` into `android/app/` and `GoogleService-Info.plist` into `ios/Runner/` to point it at your own backend. The production Firebase project is not included.

Tested against the Flutter SDK range declared in `pubspec.yaml` (`>=2.7.0 <3.0.0`).

---

## What I learned

- **Hyperlocal businesses run on trust, not technology.** The app was a coordination layer; the actual product was the vendor relationship our ops team had built shop-by-shop. The tech got out of their way.
- **Firebase's free tier is genuinely production-grade for a startup this size.** We didn't pay a hosting bill until we'd shipped real revenue.
- **Three apps from one codebase is a force multiplier early, friction later.** Worth the trade in month one. Worth splitting by month twelve.
- **Knowing when to stop matters.** Lockdowns lifted, behavior shifted back, and scaling further would have needed the kind of capital and operational depth a side-startup couldn't bring. Walking away with a working product, paying customers, and a clear story was its own kind of win.

---

## Screenshots

### Grojha — Customer App
![Grojha customer screen](https://play-lh.googleusercontent.com/LU65mxM3Qo1GBIFj4uFDTIfYIXE3yewxeNNjOCWQwblu7aXNaLrN75hVj_dUsLEKu6s=w1052-h592)
![Grojha customer screen](https://play-lh.googleusercontent.com/7zE8nnvqvyZxXmSiSU5EQynGjFYfaWPo3COG2LwpN6o4gYEMBZaqi7ovzIpccjDim3U=w1052-h592)
![Grojha customer screen](https://play-lh.googleusercontent.com/lozWmh0BMSaDzr9u-DfckHwVv8gC4IWLHoQYOaWL76dBG2CiqwSnhLU_BtAYtoWCc2Q=w1052-h592)
![Grojha customer screen](https://play-lh.googleusercontent.com/uk561KDZX-y9Dj4JsMvqhoKGw9w8xR_bR4JB1FagONU_lczRTVTpzWKM8Vpr3sk4qw=w1052-h592)
![Grojha customer screen](https://play-lh.googleusercontent.com/m0zDHQyRJ7s4bSzevKfCxiC32gKnjGFuR0UcTvO3-gJB2X7Ht4Ut2-NlVadM7pSjJhQy=w1052-h592)
![Grojha customer screen](https://play-lh.googleusercontent.com/VCMldSl2c7jwRcK8G2qlHKACdjdQ6ZKdqB27tcAjV4HddtFm023VLUTo2uo_KI4AmhA=w1052-h592)
![Grojha customer screen](https://play-lh.googleusercontent.com/JeP4gDJW7iNOnKWzKm8nByK-jv-pS_SLum1x-Srww4ganBgdyaYDnv-apgIDdGuKcH4m=w1052-h592)

### Grojha Retails — Vendor App
[Play Store →](https://play.google.com/store/apps/details?id=com.grojha.grojha_retails&hl=en_IN&gl=US)

![Grojha Retails screen](https://play-lh.googleusercontent.com/alFQsQUw4ViH4fejbHOSDbIgyQh16_e9Kiz2e8g296oKFI2J6KIdHNV1Fi-rpA4qXT8=w1052-h592)
![Grojha Retails screen](https://play-lh.googleusercontent.com/Mxo5vsEtZ_EZE9CLsKWwBuEopW0EyBrKv6NRgG-8t8V4StsXB9TXq79jFlhHuaPqrVY=w1052-h592)
![Grojha Retails screen](https://play-lh.googleusercontent.com/lbTB8Ej1gdJdyYjNANbltpYtz16jiMXmsevvS6enscIxEtBLn-MPryE9NSYkAxkDGvg=w1052-h592)
![Grojha Retails screen](https://play-lh.googleusercontent.com/KR0fOF05CMwR5hH7QMRg4sPL0ZKanG4PJG7HRkWxSlfUlnr_JiYHBGN3nWagg8Pfgw=w1052-h592)
![Grojha Retails screen](https://play-lh.googleusercontent.com/ArlyXAplV9d0cnz6Rt6qnd2Uq5cqgSBdv0dZuhFXLOZ4x5r765J9o6cKr_ChJi9PGuY=w1052-h592)

---

## Period

January 2021 – July 2021 · Mobile / Startup · Co-founder & sole engineer
