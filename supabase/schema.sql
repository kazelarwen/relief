-- Relief restroom discovery schema. Safe to re-run after updates.
create extension if not exists pgcrypto;

create table if not exists public.restrooms (
  id text primary key,
  name text not null,
  kind text not null,
  lat double precision not null,
  lng double precision not null,
  access text not null default 'Unknown',
  price text not null default 'Unknown',
  accessibility text not null default 'Unknown',
  facilities text[] not null default '{}',
  amenities text[] not null default '{}',
  opening_hours text not null default 'Not verified',
  created_at timestamptz not null default now()
);
alter table public.restrooms add column if not exists amenities text[] not null default '{}';
alter table public.restrooms add column if not exists opening_hours text not null default 'Not verified';

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  restroom_id text not null references public.restrooms(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  kind text not null check (kind in ('open','closed','unavailable','needs_cleaning','no_water','out_of_supplies')),
  batch_id uuid not null default gen_random_uuid(),
  created_at timestamptz not null default now()
);
alter table public.reports add column if not exists batch_id uuid not null default gen_random_uuid();
create index if not exists reports_restroom_batch_idx on public.reports(restroom_id,batch_id,created_at desc);

create table if not exists public.report_votes (
  id uuid primary key default gen_random_uuid(),
  report_id uuid not null references public.reports(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  confirms boolean not null,
  created_at timestamptz not null default now(),
  unique(report_id,user_id)
);

insert into public.restrooms(id,name,kind,lat,lng,access,price,accessibility,facilities,amenities,opening_hours)
select 'demo-'||lpad(n::text,2,'0'),'Demo restroom '||lpad(n::text,2,'0'),
  (array['Public facility','Mall','Cafe','Fuel station','Restaurant','Public facility'])[1+((n-1)%6)],
  14.2992+(((((n-1)*17)%31)-15)*0.00115),120.9586+(((((n-1)*23)%37)-18)*0.0011),
  case when (n-1)%5=0 then 'Public' when (n-1)%5=1 then 'Customers only' when (n-1)%5=2 then 'Purchase required' when (n-1)%5=3 then 'Staff only' else 'Unknown' end,
  case when (n-1)%4=0 then 'Free' when (n-1)%4=1 then '₱10' when (n-1)%4=2 then 'Purchase required' else 'Unknown' end,
  case when (n-1)%4=0 then 'Accessible' when (n-1)%3=0 then 'Not accessible' else 'Unknown' end,
  case when (n-1)%4=0 then array['Soap','Water'] when (n-1)%4=1 then array['Soap','Water','Tissue'] when (n-1)%4=2 then array['Water'] else array['Soap','Water','Accessible stall'] end,
  case when (n-1)%5=0 then array['Bidet','Tissue'] when (n-1)%5=1 then array['Napkin vending machine','Tissue'] when (n-1)%5=2 then array['Bidet','Napkin vending machine','Tissue'] when (n-1)%5=3 then array['Tissue'] else array[]::text[] end,
  'Not verified'
from generate_series(1,24) n
on conflict(id) do update set amenities=excluded.amenities,opening_hours=excluded.opening_hours;

alter table public.restrooms enable row level security;
alter table public.reports enable row level security;
alter table public.report_votes enable row level security;

drop policy if exists "public read restrooms" on public.restrooms;
drop policy if exists "public read reports" on public.reports;
drop policy if exists "public read report votes" on public.report_votes;
drop policy if exists "own report inserts" on public.reports;
drop policy if exists "own vote inserts" on public.report_votes;
drop policy if exists "own vote updates" on public.report_votes;
drop policy if exists "own vote deletes" on public.report_votes;

create policy "public read restrooms" on public.restrooms for select using(true);
create policy "public read reports" on public.reports for select using(true);
create policy "public read report votes" on public.report_votes for select using(true);
create policy "own report inserts" on public.reports for insert to authenticated with check(auth.uid()=user_id);
create policy "own vote inserts" on public.report_votes for insert to authenticated with check(auth.uid()=user_id);
create policy "own vote updates" on public.report_votes for update to authenticated using(auth.uid()=user_id) with check(auth.uid()=user_id);
create policy "own vote deletes" on public.report_votes for delete to authenticated using(auth.uid()=user_id);

grant usage on schema public to anon,authenticated;
grant select on public.restrooms to anon,authenticated;
grant insert on public.reports to authenticated;
revoke select on public.reports from anon,authenticated;
grant select(id,restroom_id,kind,created_at,batch_id) on public.reports to anon,authenticated;
grant insert on public.report_votes to authenticated;
revoke select on public.report_votes from anon,authenticated;
grant select(report_id,confirms) on public.report_votes to anon,authenticated;
