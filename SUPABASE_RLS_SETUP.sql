-- NUMERIX AI: kebijakan keamanan tabel public.profiles
-- Jalankan di Supabase Dashboard > SQL Editor.
-- Skrip ini mengganti seluruh policy pada tabel profiles agar tidak ada policy lama
-- yang lebih longgar yang secara tidak sengaja memberi akses tambahan.

begin;

alter table public.profiles enable row level security;

do $$
declare p record;
begin
  for p in
    select policyname
    from pg_policies
    where schemaname = 'public' and tablename = 'profiles'
  loop
    execute format('drop policy if exists %I on public.profiles', p.policyname);
  end loop;
end $$;

-- SECURITY DEFINER mencegah rekursi RLS ketika admin memeriksa tabel profiles.
create or replace function public.is_active_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles p
    where p.id = auth.uid()
      and p.role = 'admin'
      and p.is_active is true
  );
$$;

revoke all on function public.is_active_admin() from public;
grant execute on function public.is_active_admin() to authenticated;

-- Buat profil otomatis untuk setiap pendaftaran Supabase Auth.
-- Role selalu "user"; promosi menjadi admin dilakukan terpisah oleh pemilik proyek.
create or replace function public.handle_new_auth_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, display_name, role, is_active)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data ->> 'display_name', ''),
    'user',
    true
  )
  on conflict (id) do update
    set email = excluded.email,
        display_name = case
          when coalesce(profiles.display_name, '') = ''
          then excluded.display_name
          else profiles.display_name
        end;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created_numerix on auth.users;
create trigger on_auth_user_created_numerix
after insert on auth.users
for each row execute procedure public.handle_new_auth_user();

-- Pengguna hanya dapat membaca profil sendiri; admin aktif dapat membaca semua profil.
create policy profiles_select_self_or_admin
on public.profiles
for select
to authenticated
using (id = auth.uid() or public.is_active_admin());

-- Pendaftaran mandiri hanya boleh membuat profil sebagai user aktif.
-- Role admin tidak dapat diberikan dari browser.
create policy profiles_insert_self_user
on public.profiles
for insert
to authenticated
with check (
  id = auth.uid()
  and role = 'user'
  and is_active is true
);

-- Hanya admin aktif yang dapat mengubah status/kolom profil.
create policy profiles_update_admin
on public.profiles
for update
to authenticated
using (public.is_active_admin())
with check (public.is_active_admin());

commit;
