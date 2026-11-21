# Relief

Relief is a community-powered restroom discovery platform. It helps people find a restroom that fits their needs, with practical information about access, price, cleanliness, accessibility, availability, supplies, amenities, and opening hours.

> Don't just find the nearest restroom. Find one that meets your needs.

## The problem

Finding a restroom in an unfamiliar place can be inconvenient and stressful. General-purpose maps may show nearby businesses without explaining whether their restrooms are open to the public, require a purchase, are accessible, or have the supplies a visitor needs. People can waste time traveling to a facility that is closed or unavailable to them.

Relief brings restroom-specific information together in one location-based experience and lets the community share timely updates about changing conditions.

## What Relief offers

- **Map and nearby discovery:** Browse restroom listings around the Pala-Pala area of Dasmarinas, Cavite.
- **Useful details before a visit:** Check access policy, price, sample cleanliness rating, accessibility, water and supplies, amenities, and opening hours.
- **Clear access categories:** Listings can be marked Public, Customers only, Purchase required, Staff only, or Unknown.
- **Search and filters:** Narrow listings by free or paid access, accessibility, cleanliness, access policy, and recently reported availability.
- **Community reports:** Signed-in users can report that a restroom is open, closed, unavailable, needs cleaning, has no running water, or is missing supplies. A report can include an availability status and multiple conditions.
- **Community feedback:** Other users can confirm or contradict recent reports. Timestamps and confirmation counts help visitors judge how fresh and corroborated an update is.
- **Amenities:** Listings can note facilities such as bidets, tissue, and napkin vending machines.
- **Email sign-in:** Users sign in through a secure Supabase email link and can choose a display name.

## Who it is for

Relief is for anyone who needs restroom information in daily life or while visiting an unfamiliar area: commuters, families, travelers, people with disabilities, and people looking for a restroom with specific supplies or amenities. The project is designed around different needs rather than assuming every visitor is looking for the same thing.

## Data and trust

The current app is a demo centered on Pala-Pala, Dasmariñas. Its 24 map listings and sample ratings are demonstration data, not verified facilities or reviews. Community reports are labeled as community-submitted and time-stamped; a recent report should not be presented as guaranteed real-time verification. Listing accuracy and on-the-ground conditions need review before real-world reliance.

Longer term, the project can combine OpenStreetMap data, community contributions, and manual verification in a focused area. A useful research question is how often people face this problem and which restroom details actually change where they decide to go.

## Technology

- Next.js and TypeScript
- MapLibre GL JS
- OpenStreetMap raster tiles
- Supabase Auth and Postgres
- Vercel deployment

## Run locally

```sh
npm install
npm run dev
```

Visit http://localhost:3000.

## Connect Supabase

1. Copy `.env.example` to `.env.local` and add the Project URL and Publishable key from your Supabase project.
2. In Supabase Auth, enable Email and allow `http://localhost:3000/**` under URL Configuration.
3. Run `supabase/schema.sql` in the Supabase SQL Editor to create the tables, seed demo listings, and configure report permissions.
4. Restart `npm run dev` after changing local environment values.

Use only a Supabase Publishable key in a `NEXT_PUBLIC_*` variable. Never expose a secret or service-role key in client code.

## Notes

- Reports and confirmations require sign-in.
- Availability reports are treated as fresh for two hours in the interface, then shown as unconfirmed.
- Load and review accurate local listings before using Relief for real-world decisions.
- Follow OpenStreetMap attribution and tile usage policies.
