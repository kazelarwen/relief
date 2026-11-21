# Relief

Restroom discovery focused on access, cleanliness, accessibility, and fresh community updates.

## Run locally

```sh
npm install
npm run dev
```

Visit http://localhost:3000. The map uses OpenStreetMap tiles, centered on Pala-Pala, Dasmariñas. All 24 listings and ratings are demo data, not verified facilities or reports.

## Enable reports

1. Create a Supabase project and copy `.env.example` to `.env.local`.
2. Set `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY`.
3. Run `supabase/schema.sql` in the Supabase SQL editor.
4. Enable email OTP and allow your local/deployed app URL in Supabase Auth redirect settings.

Reports and confirmations require sign-in. Availability reports appear current for two hours, then return to unconfirmed. Load reviewed listings before using for real-world decisions. Follow OpenStreetMap attribution and tile usage policy.
