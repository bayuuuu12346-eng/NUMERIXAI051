TEBAK NOMOR — PAKET PWA

Paket ini dibuat dari ZIP deploy yang Anda unggah.
Perubahan hanya:
1. Memanggil fungsi setupManifestAndWorker() yang sudah ada di index.html.
2. Memperbarui sw.js agar hanya menangani GET same-origin, melewati API/cross-origin, dan hanya menghapus cache dengan awalan angka-ai-.
3. Menambahkan ikon PNG 192x192 dan 512x512 serta mencantumkannya di manifest.json.

Semua kode aplikasi lainnya di index.html dipertahankan.

CARA DEPLOY AMAN:
- Simpan ZIP asli sebagai cadangan dan jangan hapus.
- Unggah isi folder hasil ekstrak paket ini ke deploy Netlify baru / metode deploy yang biasa digunakan.
- Jangan mengubah domain/site yang sama.
- Setelah deploy, uji website, login, akun tamu, generator, pola/paket, dan AI.
- Data localStorage yang ada pada browser biasanya tetap ada selama origin/domain yang sama dipertahankan. Namun, ZIP deploy tidak membawa data localStorage pengguna; ekspor cadangan data dari aplikasi sebelum perubahan besar.


INTEGRASI SUPABASE:
- Login dan daftar akun sekarang menggunakan Supabase Auth email/password.
- Panel Admin hanya ditampilkan setelah profil terverifikasi sebagai role=admin dan is_active=true.
- Jalankan SUPABASE_RLS_SETUP.sql di Supabase SQL Editor sebelum uji login/daftar/panel admin.
- Pengaturan generator dan riwayat masih disimpan lokal per email pada browser.
- Publishable key aman digunakan di frontend; jangan pernah menaruh service_role/secret key di file ini.
