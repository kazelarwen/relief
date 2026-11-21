# Relief

Restroom discovery focused on access, cleanliness, accessibility, and fresh community updates.

## Run locally

```sh
npm install
npm run dev
```

Visit http://localhost:3000. The map uses OpenStreetMap tiles, centered on Pala-Pala, Dasmariñas. All 24 listings and ratings are demo data, not verified facilities or reports.

## Connect Supabase

The app uses Supabase email OTP and cookie-backed sessions.

1. Copy `.env.example` to `.env.local` and add the Project URL and Publishable key from your Supabase project.
2. In Supabase Auth, enable Email and allow `http://localhost:3000/**` under URL Configuration.
3. Run `supabase/schema.sql` in the Supabase SQL Editor to enable restroom reports and confirmations.
4. Restart `npm run dev` after changing local environment values.

The browser key must be a Supabase Publishable key. Never put a secret or service-role key in a `NEXT_PUBLIC_*` variable.

Reports and confirmations require sign-in. Availability reports appear current for two hours, then return to unconfirmed. Load reviewed listings before using for real-world decisions. Follow OpenStreetMap attribution and tile usage policy.
