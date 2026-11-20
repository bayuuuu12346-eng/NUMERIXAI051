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
