# Setup — Canonical Guide

This document covers the complete setup of all external services required to run Glu.
Follow the sections in order — each one produces credentials required by the next.

---

## App Identifiers

| Platform | Identifier |
|---|---|
| Apple Team ID | `X3WYVFTV38` |
| iOS Bundle ID | `ventures.layline.glu` |
| Android Package | `ventures.layline.glu` |
| Supabase Project ID | `osaolsxiljjpgwloyxfe` |
| GCP Project ID | `glu-app-91c5a` |
| Firebase Project ID | `glu-app-91c5a` |
| Firebase Project Number | `756250899508` |
| Custom URL Scheme | `glu://login-callback` |
| HTTPS Deep Link (prod) | `https://myglu.health/signin-callback` |

---

# Part 0 — Store Setup

Both stores must have the app registered and in-app subscription products created
before configuring RevenueCat. RevenueCat requires the product IDs to exist in each
store before they can be attached to offerings.

## Google Play Console

### Create the app
1. Go to [play.google.com/console](https://play.google.com/console) → **Create app**
2. **App name:** `Glu`
3. **Default language:** English
4. **App or game:** App
5. **Free or paid:** Free (subscriptions are handled as in-app products)
6. Accept the declarations and save

### Create the subscription products
1. Go to the app → **Monetize → Subscriptions → Create subscription**
2. Create the **monthly** product:
   - **Product ID:** `glu_pro_monthly`
   - **Name:** `Glu Pro Monthly`
   - Add a base plan → set price and billing period (1 month)
3. Create the **annual** product:
   - **Product ID:** `glu_pro_annual`
   - **Name:** `Glu Pro Annual`
   - Add a base plan → set price and billing period (1 year)
4. Activate both products

> Subscription products require the app to have a complete store listing and be
> available in at least one country before they can be activated.

---

## App Store Connect

### Create the app
1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com) → **My Apps → +**
2. **Platform:** iOS
3. **Name:** `Glu`
4. **Primary language:** English
5. **Bundle ID:** `ventures.layline.glu`
6. **SKU:** `glu` (internal identifier, not shown to users)

### Create the subscription products
1. Go to the app → **Monetization → Subscriptions**
2. Create a **Subscription Group** named `Glu Pro`
3. Add the **monthly** subscription:
   - **Reference Name:** `Glu Pro Monthly`
   - **Product ID:** `glu_pro_monthly`
   - Set price and duration (1 month)
4. Add the **annual** subscription:
   - **Reference Name:** `Glu Pro Annual`
   - **Product ID:** `glu_pro_annual`
   - Set price and duration (1 year)
5. Submit both for review (or they will be reviewed alongside the first app submission)

### Store Setup Checklist

- [ ] Google Play: app created
- [ ] Google Play: `glu_pro_monthly` and `glu_pro_annual` subscriptions created and activated
- [ ] App Store Connect: app created with bundle ID `ventures.layline.glu`
- [ ] App Store Connect: subscription group `Glu Pro` created with monthly and annual products

---

# Part 1 — Authentication

## Auth Methods Overview

| Provider | Configured in |
|---|---|
| Google Sign-In | Firebase Auth + GCP + Supabase |
| Apple Sign-In | Apple Developer + Supabase |
| Magic Link | Supabase only |

## 1. Firebase

Firebase is the starting point — it creates the GCP project and all OAuth clients
automatically. GCP Console is only needed afterward to copy credentials and add
the Supabase redirect URI.

### 1.1 Create the Firebase project
1. Go to [console.firebase.google.com](https://console.firebase.google.com) and create a project
2. This automatically creates a linked GCP project (`glu-app-91c5a`)
3. Go to **Authentication → Get started → Sign-in method → Google → Enable → Save**
   This triggers Firebase to auto-create the Web and iOS OAuth clients in GCP —
   without this step, no OAuth 2.0 entries will appear in GCP Credentials.

### 1.2 Register the iOS app
1. **Project Settings → Add app → iOS**
2. **Bundle ID:** `ventures.layline.glu`
3. Download `GoogleService-Info.plist` and place it at `ios/Runner/GoogleService-Info.plist`
4. Firebase auto-creates an iOS OAuth client in GCP

> **SDK & initialization:** Firebase packages are already declared in `pubspec.yaml`
> (`firebase_core`, `firebase_analytics`, etc.). Initialization is already handled in
> `ios/Runner/AppDelegate.swift` via `FirebaseApp.configure()` — no additional code
> changes are needed when re-registering the app.

### 1.3 Register the Android app
1. **Project Settings → Add app → Android**
2. **Package name:** `ventures.layline.glu`
3. Add SHA fingerprints:
   - **Debug SHA-1 + SHA-256:**
     ```sh
     keytool -list -v \
       -keystore ~/.android/debug.keystore \
       -alias androiddebugkey \
       -storepass android -keypass android
     ```
   - **Release SHA-1 + SHA-256:**
     ```sh
     keytool -list -v \
       -keystore android/app/glu-release.jks \
       -alias glu
     ```
   - **Play App Signing SHA-1 + SHA-256** (from Play Console → Setup → App integrity), if using Play
4. Download `google-services.json` and place it at `android/app/google-services.json`
5. Firebase auto-creates Android OAuth clients in GCP for each registered fingerprint

> SHA-256 is required for Android App Links (HTTPS deep links). SHA-1 is required
> for Google Sign-In. Re-download `google-services.json` after any fingerprint change.

---

## 2. Google Cloud Console

Firebase has already created all OAuth clients. GCP Console is only needed to
copy credentials and configure the Supabase redirect URI.

Go to [console.cloud.google.com](https://console.cloud.google.com) → project **glu-app-91c5a** →
**APIs & Services → Credentials**.

### Web Client
1. Open **Web client (auto created by Google Service)**
2. Under **Authorized redirect URIs** add: `https://osaolsxiljjpgwloyxfe.supabase.co/auth/v1/callback`
3. Copy **Client ID** → `GOOGLE_WEB_CLIENT_ID`
4. Copy **Client Secret** → `SUPABASE_AUTH_EXTERNAL_GOOGLE_SECRET`

### iOS Client
1. Open **iOS client for ventures.layline.glu (auto created by Google Service)**
2. Copy **Client ID** → `GOOGLE_IOS_CLIENT_ID`
3. Verify the reversed form `com.googleusercontent.apps.<id>` matches the URL scheme
   in `ios/Runner/Info.plist`

### Android Clients
Auto-created by Firebase — do not modify here. Manage via Firebase (Section 1.3).

---

## 3. Apple Developer

### 3.1 App ID

Go to [developer.apple.com](https://developer.apple.com) → **Certificates, IDs & Profiles → Identifiers**.

Select the App ID `ventures.layline.glu` and ensure these capabilities are enabled:
- **Sign In with Apple** — set to "Enable as primary App ID"

> This is what the entitlement `com.apple.developer.applesignin: [Default]` in
> `ios/Glu.entitlements` maps to. It must be enabled before Xcode can sign the app.

### 3.2 Services ID (for Supabase server verification)

Even though the iOS app uses the native SDK, Supabase needs a Services ID to
verify the token on the server.

Go to **Identifiers → + → Services IDs**:
- **Description:** `Glu Auth`
- **Identifier:** `ventures.layline.glu.signin` (must be different from the App ID)
- After creating: enable **Sign In with Apple** → Configure:
  - **Primary App ID:** `ventures.layline.glu`
  - **Domains:** `osaolsxiljjpgwloyxfe.supabase.co`
  - **Return URLs:** `https://osaolsxiljjpgwloyxfe.supabase.co/auth/v1/callback`
- Copy the Services ID → `SUPABASE_AUTH_EXTERNAL_APPLE_CLIENT_ID`

### 3.3 Key

Go to **Keys → + → Sign In with Apple**:
- **Key Name:** e.g. `Glu Supabase Key`
- Associate with App ID `ventures.layline.glu`
- Download the `.p8` file — **this can only be downloaded once**
- Note the **Key ID** (10-character string shown after creation)
- Note your **Team ID** (top-right of the developer portal)

### 3.4 Generate the Apple Secret JWT

Supabase provides a browser-based key generator — no keys leave your browser:

**https://supabase.com/docs/guides/auth/social-login/auth-apple?queryGroups=platform&platform=flutter**

Scroll to the **"Generate Secret Key"** tool on that page and fill in:

| Field | Value |
|---|---|
| Team ID | `X3WYVFTV38` |
| Bundle ID | `ventures.layline.glu` |
| Key ID | 10-character ID shown after creating the key |
| .p8 File | the downloaded `AuthKey_XXXXXXXXXX.p8` file |

> Use Firefox or a Chrome-based browser — the tool does not work in Safari.

Copy the generated JWT → `SUPABASE_AUTH_EXTERNAL_APPLE_SECRET`

> The JWT expires in ~6 months. Set a calendar reminder to regenerate it before
> it expires, or Supabase will stop accepting Apple sign-ins silently.
> Keep the `.p8` file stored securely — it is required for every renewal and
> cannot be re-downloaded from Apple.

---

## 4. Resend (Email SMTP)

Supabase's default sender has poor deliverability. Configure Resend so magic link
emails come from `noreply@myglu.health`.

### 4.1 Resend setup
1. Create an account at [resend.com](https://resend.com)
2. Add and verify the domain `myglu.health` under **Domains**
   (adds DNS records — TXT for SPF, CNAME for DKIM)
3. Go to **API Keys → Create API Key** — scope it to `Sending access` only
4. Copy the API key (shown once) — used as the SMTP password in Supabase

---

## 5. Supabase

You now have all credentials needed to configure Supabase.

### 5.1 URL Configuration

Go to **Authentication → URL Configuration**:

| Field | Dev | Prod |
|---|---|---|
| Site URL | `http://localhost:4321` | `https://myglu.health` |
| Redirect URLs | `glu://login-callback*` | `glu://login-callback*`, `https://myglu.health/signin-callback` |

> Both redirect URLs must be in the allow-list for both environments.
> The `*` wildcard is required — the app appends `?state=<token>` to the URL.
> The Site URL is the fallback Supabase uses when a redirect is rejected —
> this is why you see that URL if a deep link isn't registered.

### 5.2 Email Provider (Magic Link)

Go to **Authentication → Providers → Email**:
- Enable **Email provider**
- Disable **Confirm email** (magic link flow handles this)
- Set **OTP Expiry** to your preference (default 3600s / 1 hour is fine)

### 5.3 SMTP — Resend

Go to **Project Settings → Auth → SMTP Provider** and enable custom SMTP:

| Field | Value |
|---|---|
| Host | `smtp.resend.com` |
| Port | `465` |
| Username | `resend` |
| Password | your Resend API key |
| Sender name | `Glu` |
| Sender email | `noreply@myglu.health` |

> Port 465 uses implicit SSL. If your network blocks it, use port 587 with STARTTLS.

**Verify:** trigger a magic link from the app and confirm the email arrives from
`noreply@myglu.health` and passes spam checks (check Gmail's "Show original"
for SPF/DKIM pass).

### 5.4 Google Provider

Go to **Authentication → Providers → Google**:
- Toggle **Enable Google provider**
- **Client ID (Web):** `GOOGLE_WEB_CLIENT_ID`
- **Client Secret:** `SUPABASE_AUTH_EXTERNAL_GOOGLE_SECRET`
- Toggle **Skip nonce checks** — required for the native `google_sign_in` SDK flow,
  which does not include a nonce in the ID token

> Supabase only needs the Web client ID — it verifies the ID token server-side
> using the web client secret. `GOOGLE_IOS_CLIENT_ID` is used only by the native
> SDK on the device and is not entered in Supabase.

### 5.5 Apple Provider

Go to **Authentication → Providers → Apple**:
- Toggle **Enable Apple provider**
- **Service ID:** `SUPABASE_AUTH_EXTERNAL_APPLE_CLIENT_ID`
- **Secret Key:** `SUPABASE_AUTH_EXTERNAL_APPLE_SECRET`

---

## 6. Deep Links

Deep links are how the app receives auth callbacks from the OS after an OAuth
redirect or a magic link tap.

### 6.1 Custom Scheme (`glu://`)

Works on both iOS and Android, used primarily in development.

**iOS** — already registered in `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLSchemes</key>
<array>
  <string>glu</string>
</array>
```

**Android** — already registered in `android/app/src/main/AndroidManifest.xml`:
```xml
<intent-filter>
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="glu" android:host="login-callback" />
</intent-filter>
```

### 6.2 HTTPS Universal Links / App Links (production)

Used in production so links in emails open the app directly rather than a browser.

**iOS — Associated Domains**

In `ios/Glu.entitlements`:
```xml
<key>com.apple.developer.associated-domains</key>
<array>
  <string>applinks:myglu.health</string>
</array>
```

The domain `myglu.health` must serve an Apple App Site Association file at:
```
https://myglu.health/.well-known/apple-app-site-association
```

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "X3WYVFTV38.ventures.layline.glu",
        "paths": ["/signin-callback"]
      }
    ]
  }
}
```

**Android — App Links**

Already registered in `AndroidManifest.xml`:
```xml
<intent-filter android:autoVerify="true">
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="https" android:host="myglu.health" android:path="/signin-callback" />
</intent-filter>
```

The domain must serve a Digital Asset Links file at:
```
https://myglu.health/.well-known/assetlinks.json
```

```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "ventures.layline.glu",
    "sha256_cert_fingerprints": [
      "<RELEASE_SHA256>",
      "<PLAY_APP_SIGNING_SHA256>"
    ]
  }
}]
```

> SHA-256 fingerprints can be copied directly from **Firebase Console → Project Settings →
> Your Android app → SHA certificate fingerprints** — this is the most reliable source
> since all fingerprints (debug, release, Play App Signing) are already registered there.

---

## 7. Environment Variables — Auth

| Variable | Where it comes from | Dev value | Prod value |
|---|---|---|---|
| `SUPABASE_URL` | Supabase → Project Settings → API | auto-resolved by `debug.sh` from `supabase status` | `https://osaolsxiljjpgwloyxfe.supabase.co` |
| `SUPABASE_ANON_KEY` | Supabase → Project Settings → API | auto-resolved by `debug.sh` from `supabase status` | project anon key |
| `AUTH_REDIRECT_URL` | set manually | `glu://login-callback` | `https://myglu.health/signin-callback` |
| `GOOGLE_WEB_CLIENT_ID` | GCP → OAuth 2.0 → Web client ID | web client ID | same |
| `GOOGLE_IOS_CLIENT_ID` | GCP → OAuth 2.0 → iOS client ID | iOS client ID | same |
| `SUPABASE_AUTH_EXTERNAL_GOOGLE_SECRET` | GCP → OAuth 2.0 → Web client secret | client secret | same |
| `SUPABASE_AUTH_EXTERNAL_APPLE_CLIENT_ID` | Apple Developer → Services ID + Bundle ID | `ventures.layline.glu.signin,ventures.layline.glu` | same |
| `SUPABASE_AUTH_EXTERNAL_APPLE_SECRET` | Supabase key generator tool | generated JWT | same |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase → Project Settings → API | service role key | same |
| `SUPABASE_JWT_SECRET` | Supabase → Project Settings → API | JWT secret | same |

> `SUPABASE_SERVICE_ROLE_KEY` and `SUPABASE_JWT_SECRET` are server-side only
> and are not passed to the Flutter app as dart-defines.


---

## 8. Flutter — How Each Method Works

### Google Sign-In
```
GoogleSignIn.initialize(serverClientId: GOOGLE_WEB_CLIENT_ID)
→ authenticate()
→ authorizationClient.authorizationForScopes(['email', 'profile'])
→ idToken + accessToken
→ supabase.auth.signInWithIdToken(provider: google, idToken, accessToken)
```

If `GOOGLE_WEB_CLIENT_ID` is empty at runtime, the native path is skipped and
the app falls back to browser-based OAuth, which redirects to `localhost:4321`
if the Supabase site URL is not correctly set.

### Apple Sign-In
```
SignInWithApple.getAppleIDCredential(nonce: hashedNonce)
→ identityToken
→ supabase.auth.signInWithIdToken(provider: apple, idToken, nonce: rawNonce)
```

The nonce is generated by Supabase (`generateRawNonce()`), hashed with SHA-256,
sent to Apple, then the raw version passed to Supabase for replay-attack prevention.

### Magic Link
```
supabase.auth.signInWithOtp(
  email: email,
  emailRedirectTo: 'glu://login-callback?state=...',
)
→ user taps link in email
→ OS opens app via deep link
→ app reads URL via deepLinkProvider
→ supabase handles session from URL
```

---

## 9. Auth Checklists

### Development

- [ ] Firebase: iOS and Android apps registered, `GoogleService-Info.plist` and `google-services.json` downloaded
- [ ] Firebase: debug SHA-1 + SHA-256 added to Android app
- [ ] GCP: Supabase redirect URI added to Web client; `GOOGLE_WEB_CLIENT_ID` + secret + `GOOGLE_IOS_CLIENT_ID` copied
- [ ] Apple: App ID has Sign In with Apple enabled
- [ ] Apple: Services ID `ventures.layline.glu.signin` created with Supabase callback URL
- [ ] Apple: Key created, JWT generated via Supabase tool, `SUPABASE_AUTH_EXTERNAL_APPLE_SECRET` set
- [ ] Resend: domain `myglu.health` verified (SPF + DKIM DNS records added)
- [ ] Supabase: Site URL set to `http://localhost:4321`
- [ ] Supabase: `glu://login-callback*` in Redirect URLs
- [ ] Supabase: Email, Google (skip nonce), Apple providers enabled
- [ ] Supabase: SMTP configured with Resend
- [ ] `supabase/.env` filled with OAuth secrets for local auth to work

### Production

Everything in the Development checklist, plus:

- [ ] Firebase: release SHA-1 + SHA-256 added to Android app, `google-services.json` re-downloaded
- [ ] Firebase: Play App Signing SHA-1 + SHA-256 added (if using Play), `google-services.json` re-downloaded
- [ ] Supabase: Site URL set to `https://myglu.health`
- [ ] Supabase: `https://myglu.health/signin-callback` added to Redirect URLs
- [ ] `myglu.health/.well-known/apple-app-site-association` deployed
- [ ] `myglu.health/.well-known/assetlinks.json` deployed with release + Play SHA-256
- [ ] `AUTH_REDIRECT_URL=https://myglu.health/signin-callback` in `supabase/.env.production`
- [ ] Apple JWT calendar reminder set for renewal (~6 months from generation date)

---

## 10. Auth Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Google sign-in redirects to `localhost:4321` | `GOOGLE_WEB_CLIENT_ID` empty at runtime → falls back to web OAuth → Supabase site URL is localhost | Ensure dart-define includes `GOOGLE_WEB_CLIENT_ID`; set Supabase Site URL to production domain |
| Google sign-in fails with `DEVELOPER_ERROR` on Android | SHA fingerprint not registered in Firebase | Add release SHA to Firebase; re-download `google-services.json` |
| Apple sign-in works in dev but fails in prod | `aps-environment` was `development` in entitlements | Ensure `ios/Glu.entitlements` has `aps-environment = production` |
| Apple sign-in fails silently | Apple JWT secret expired | Regenerate JWT via Supabase tool; update `SUPABASE_AUTH_EXTERNAL_APPLE_SECRET` |
| Magic link opens browser instead of app | `glu://login-callback*` not in Supabase redirect allow-list, or AASA/assetlinks not deployed | Add `glu://login-callback*` to Supabase Redirect URLs; verify well-known files are served |
| Magic link works on iOS but not Android | Play App Signing SHA not in `assetlinks.json` | Add Play App Signing SHA-256 to `assetlinks.json` and Firebase |
| `GoogleSignIn.initialize` throws on iOS | `GOOGLE_IOS_CLIENT_ID` empty or reversed URL scheme mismatch | Verify `GOOGLE_IOS_CLIENT_ID` is set and its reversed form matches `Info.plist` URL scheme |

---

# Part 2 — In-App Purchases (RevenueCat)

## 11. RevenueCat

RevenueCat manages subscriptions for both iOS (App Store) and Android (Google Play).
The app uses `REVENUECAT_IOS_KEY` and `REVENUECAT_ANDROID_KEY` as platform-specific
public SDK keys.

### 11.1 Create the RevenueCat project
1. Go to [app.revenuecat.com](https://app.revenuecat.com) and create a project named `Glu`

### 11.2 Connect the iOS app (App Store)
1. **Project Settings → Apps → + New app → App Store**
2. **App name:** `Glu`
3. **Bundle ID:** `ventures.layline.glu`
4. **App Store Connect API key:** generate one in App Store Connect →
   **Users and Access → Integrations → App Store Connect API → Generate API Key**
   - Role: **Admin**
   - Download the `.p8` key file and note the Key ID and Issuer ID
5. Enter the Key ID, Issuer ID, and upload the `.p8` in RevenueCat
6. Copy the **Public SDK key** → `REVENUECAT_IOS_KEY`

### 11.3 Connect the Android app (Google Play)

> Full instructions: **https://www.revenuecat.com/docs/service-credentials/creating-play-service-credentials**

Use the automated script approach — it handles API enablement, service account creation, role assignment, and key generation in one step.

1. **Project Settings → Apps → + New app → Google Play**
2. **App name:** `Glu`
3. **Package name:** `ventures.layline.glu`
4. Generate the service account credentials via Cloud Shell:
   - Open [Google Cloud Shell Editor](https://shell.cloud.google.com) and select project `glu-app-91c5a`
   - **Before running the script**, temporarily disable the org policy that blocks key creation:
     ```sh
     gcloud org-policies reset constraints/iam.disableServiceAccountKeyCreation --project=glu-app-91c5a
     ```
   - Create a new file named `credentials.sh` in your home directory
   - Copy the script content from the RevenueCat docs link above
   - Set the project ID at the top of the script:
     ```sh
     PROJECT_ID=glu-app-91c5a
     ```
   - Run the script:
     ```sh
     bash credentials.sh
     ```
   - The script enables required APIs (Android Publisher, Play Developer Reporting, Pub/Sub),
     creates a service account named `revenuecat-service-account`, assigns roles
     (Pub/Sub Editor, Monitoring Viewer), and outputs `revenuecat-key.json`
   - **After the script completes**, upgrade the Pub/Sub role from Editor to Admin
     (the script assigns Editor, but Admin is required):
     ```sh
     gcloud projects remove-iam-policy-binding glu-app-91c5a \
       --member="serviceAccount:revenuecat-service-account@glu-app-91c5a.iam.gserviceaccount.com" \
       --role="roles/pubsub.editor"

     gcloud projects add-iam-policy-binding glu-app-91c5a \
       --member="serviceAccount:revenuecat-service-account@glu-app-91c5a.iam.gserviceaccount.com" \
       --role="roles/pubsub.admin"
     ```
   - Then re-enable the org policy:
     ```sh
     gcloud org-policies delete constraints/iam.disableServiceAccountKeyCreation --project=glu-app-91c5a
     ```
5. Download `revenuecat-key.json` from the Cloud Shell VS Code editor:
   - In the Cloud Shell Editor, right-click `revenuecat-key.json` in the file explorer → **Download**
6. In Google Play Console → **Developer account → Linked services**:
   - Link to GCP project `glu-app-91c5a` (required for API-level access)
   - Find `revenuecat-service-account@glu-app-91c5a.iam.gserviceaccount.com` in the service accounts list
   - Click **Grant access** → set permissions: `View app info` and `Financial data`

   > This step is distinct from "Users and permissions" — API access must be granted
   > here for the Android Publisher API (`inappproducts`) to work with RevenueCat.
7. Upload `revenuecat-key.json` to RevenueCat → Project Settings → Google Play App Settings → Service Account Key
8. Copy the **Public SDK key** → `REVENUECAT_ANDROID_KEY`

> The service account can take **up to 36 hours** after creation before the Google Play API
> accepts it. Two shortcuts to force validation without waiting:
> 1. Re-upload `revenuecat-key.json` in RevenueCat and revalidate
> 2. Edit any subscription metadata in Google Play (e.g. description), save, then revalidate in RevenueCat

### 11.4 Configure entitlements and offerings
1. **Entitlements → + New** — create entitlement `pro`
2. Open the `pro` entitlement → **Attach** → select the existing products
   (`glu_pro_monthly` and `glu_pro_annual`) from both App Store and Google Play
3. **Offerings → + New** — create a `default` offering and attach the products

### 11.5 Environment Variables — RevenueCat

| Variable | Where it comes from |
|---|---|
| `REVENUECAT_IOS_KEY` | RevenueCat → iOS app → Public SDK key |
| `REVENUECAT_ANDROID_KEY` | RevenueCat → Android app → Public SDK key |

Add both to `supabase/.env.production`. For local development, purchases can be
tested using RevenueCat's sandbox environment — no separate key needed.

### 11.6 RevenueCat Checklist

- [ ] RevenueCat project created
- [ ] iOS app connected with App Store Connect API key
- [ ] Android app connected with GCP service account (`revenuecat-service-account`, Pub/Sub Admin)
- [ ] Google Play API access linked to GCP project with correct permissions
- [ ] `pro` entitlement created and products attached
- [ ] `default` offering configured
- [ ] `REVENUECAT_IOS_KEY` and `REVENUECAT_ANDROID_KEY` set in `supabase/.env.production`

---

# Part 3 — Push Notifications (FCM)

FCM is used to deliver push notifications on both iOS and Android. Firebase handles
delivery on Android natively. iOS requires an APNs key uploaded to Firebase so FCM
can forward notifications through Apple's infrastructure.

> **App dependency:** `firebase_messaging` must be added to `pubspec.yaml` before
> push notifications can be received.

## 12. iOS — APNs Key

### 12.1 Create the APNs key in Apple Developer
1. Go to [developer.apple.com](https://developer.apple.com) → **Certificates, IDs & Profiles → Keys → +**
2. **Key Name:** `Glu FCM`
3. Enable **Apple Push Notifications service (APNs)**
4. **Environment:** select **Sandbox & Production**
5. Click **Continue → Register**
6. Download the `.p8` key file — **this can only be downloaded once**
7. Note the **Key ID** (10-character string)
8. Note your **Team ID:** `X3WYVFTV38`

### 12.2 Upload the APNs key to Firebase
1. Firebase Console → project `glu-app-91c5a` → **Project Settings → Cloud Messaging**
2. Under **Apple app configuration** → find `ventures.layline.glu`
3. Firebase shows two slots — **APNs Authentication Key (Sandbox)** and **APNs Authentication Key (Production)**
   — upload the same `.p8` key file to both:
   - **Key ID:** from step 12.1
   - **Team ID:** `X3WYVFTV38`

> The APNs key does not expire (unlike APNs certificates). Keep the `.p8` file
> stored securely — it cannot be re-downloaded from Apple.

### 12.3 iOS app configuration
The following are already configured in the project:
- `aps-environment = production` in `ios/Glu.entitlements`
  (Apple reviews push notification usage as part of standard app review — no additional App Store Connect configuration needed)
- `POST_NOTIFICATIONS` entitlement is covered by the APS environment key
- `GoogleService-Info.plist` includes the FCM sender ID

No additional iOS-side changes are needed beyond adding `firebase_messaging`
to `pubspec.yaml`.

---

## 13. Android — FCM

Android FCM works automatically once Firebase is configured — no additional
service setup is required.

The following are already configured in the project:
- `POST_NOTIFICATIONS` permission in `android/app/src/main/AndroidManifest.xml`
  (required for Android 13+ / API 33+; no Play Console declaration needed)
- `google-services.json` includes the FCM configuration
- `ScheduledNotificationBootReceiver` registered for local notifications on reboot

No additional Android-side changes are needed beyond adding `firebase_messaging`
to `pubspec.yaml`.

---

## 14. Push Notifications Checklist

- [ ] APNs key created in Apple Developer (`Glu FCM`)
- [ ] APNs key uploaded to Firebase → Cloud Messaging → Apple app configuration
- [ ] `firebase_messaging` added to `pubspec.yaml`
- [ ] Android: verify `POST_NOTIFICATIONS` is in `AndroidManifest.xml` (already present)
- [ ] iOS: verify `aps-environment = production` in `Glu.entitlements`
