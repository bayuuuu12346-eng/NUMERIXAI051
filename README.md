# NUMERIXAI051
NUMERIXAI051 Android APK Builder


## Integrasi Supabase (Numerix AI)

- Login dan pendaftaran menggunakan Supabase Auth (email/password).
- Profil dibaca dari `public.profiles`.
- Panel Admin ditampilkan hanya bila `role = 'admin'` dan `is_active = true`.
- Jalankan `SUPABASE_RLS_SETUP.sql` melalui Supabase SQL Editor sebelum menguji pendaftaran dan panel admin.
- Pastikan URL dan publishable key pada `index.html` sesuai proyek Supabase Anda.
- Jangan pernah memasukkan `service_role` atau secret key ke file frontend.
- Pengaturan generator dan riwayat tetap disimpan lokal per email pada browser; autentikasi dan profil menggunakan Supabase.
