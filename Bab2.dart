import 'dart:async';

// Enumerasi untuk kategori produk
enum KategoriProduk { DataManagement, NetworkAutomation }

// Enumerasi untuk fase proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

// Mixin untuk menambahkan kinerja kepada karyawan
mixin Kinerja {
  int produktivitas = 0; // Nilai produktivitas karyawan, dalam skala 0 - 100
  DateTime?
      terakhirDiperbarui; // Tanggal terakhir kali produktivitas diperbarui

  // Metode untuk mengupdate produktivitas karyawan
  void updateProduktivitas(int nilai) {
    var sekarang = DateTime.now();
    // Memastikan update produktivitas hanya setiap 30 hari
    if (terakhirDiperbarui == null ||
        sekarang.difference(terakhirDiperbarui!).inDays >= 30) {
      produktivitas = (produktivitas + nilai)
          .clamp(0, 100); // Menyimpan produktivitas dalam rentang 0-100
      terakhirDiperbarui = sekarang;
    } else {
      print("Produktivitas hanya bisa diperbarui setiap 30 hari.");
    }
  }
}

// Class untuk mendefinisikan produk digital
class ProdukDigital {
  String namaProduk; // Nama produk
  double harga; // Harga produk
  KategoriProduk kategori; // Kategori produk
  int jumlahTerjual; // Jumlah produk yang terjual

  // Konstruktor untuk inisialisasi produk digital dengan pengecekan harga sesuai kategori
  ProdukDigital(this.namaProduk, this.harga, this.kategori,
      {this.jumlahTerjual = 0}) {
    // Validasi harga berdasarkan kategori
    if (kategori == KategoriProduk.NetworkAutomation && harga < 200000) {
      throw ArgumentError(
          "Harga untuk NetworkAutomation harus minimal 200.000.");
    } else if (kategori == KategoriProduk.DataManagement && harga >= 200000) {
      throw ArgumentError("Harga untuk DataManagement harus di bawah 200.000.");
    }
  }

  // Metode untuk menerapkan diskon jika memenuhi syarat
  void terapkanDiskon() {
    if (kategori == KategoriProduk.NetworkAutomation && jumlahTerjual > 50) {
      double diskon = harga * 0.15; // Diskon 15%
      double hargaAkhir = harga - diskon;
      // Memastikan harga setelah diskon tidak kurang dari 200.000
      if (hargaAkhir >= 200000) {
        harga = hargaAkhir;
      } else {
        harga = 200000;
      }
      print("Diskon diterapkan, harga sekarang: $harga");
    }
  }
}

// Abstract class untuk mendefinisikan atribut dasar karyawan
abstract class Karyawan {
  String nama; // Nama karyawan
  int umur; // Umur karyawan
  String peran; // Peran atau jabatan karyawan

  // Konstruktor untuk inisialisasi karyawan
  Karyawan(this.nama, {required this.umur, required this.peran});

  // Metode abstrak yang diimplementasikan oleh subclass
  void bekerja();
}

// Class untuk karyawan tetap yang menggunakan mixin Kinerja
class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  // Implementasi metode bekerja
  @override
  void bekerja() {
    print("$nama bekerja secara reguler sebagai $peran.");
  }
}

// Class untuk karyawan kontrak yang juga menggunakan mixin Kinerja
class KaryawanKontrak extends Karyawan with Kinerja {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  // Implementasi metode bekerja
  @override
  void bekerja() {
    print("$nama bekerja pada proyek sebagai $peran.");
  }
}

// Class untuk mendefinisikan perusahaan
class Perusahaan {
  List<Karyawan> karyawanAktif = []; // Daftar karyawan yang aktif
  List<Karyawan> karyawanNonAktif = []; // Daftar karyawan yang tidak aktif
  static const int batasKaryawanAktif = 20; // Batas maksimal karyawan aktif

  int get jumlahKaryawanAktif => karyawanAktif.length; // Jumlah karyawan aktif
  int get jumlahKaryawanResign =>
      karyawanNonAktif.length; // Jumlah karyawan resign

  // Metode untuk menambah karyawan jika belum mencapai batas
  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawanAktif) {
      karyawanAktif.add(karyawan);
    } else {
      print("Jumlah karyawan aktif mencapai batas maksimal.");
    }
  }

  // Metode untuk mengubah status karyawan menjadi non-aktif
  void karyawanResign(Karyawan karyawan) {
    if (karyawanAktif.remove(karyawan)) {
      karyawanNonAktif.add(karyawan);
      print("${karyawan.nama} telah menjadi karyawan non-aktif.");
    }
  }
}

// Class untuk mendefinisikan proyek yang dilakukan oleh perusahaan
class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan; // Fase awal proyek
  List<Karyawan> timProyek = []; // Tim karyawan yang mengerjakan proyek
  DateTime? tanggalMulai; // Tanggal mulai proyek

  // Konstruktor yang menetapkan tanggal mulai proyek
  Proyek() {
    tanggalMulai = DateTime.now();
  }

  // Metode untuk menambah karyawan ke dalam tim proyek
  void tambahKaryawanKeTim(Karyawan karyawan) {
    timProyek.add(karyawan);
  }

  // Metode untuk melanjutkan ke fase proyek berikutnya
  void lanjutKeFaseBerikutnya() {
    // Cek kondisi untuk lanjut ke fase Pengembangan
    if (fase == FaseProyek.Perencanaan && timProyek.length >= 5) {
      fase = FaseProyek.Pengembangan;
      print("Proyek telah masuk ke fase Pengembangan.");
    }
    // Cek kondisi untuk lanjut ke fase Evaluasi setelah lebih dari 45 hari
    else if (fase == FaseProyek.Pengembangan &&
        DateTime.now().difference(tanggalMulai!).inDays > 45) {
      fase = FaseProyek.Evaluasi;
      print("Proyek telah masuk ke fase Evaluasi.");
    } else {
      print("Tidak memenuhi syarat untuk beralih ke fase berikutnya.");
    }
  }
}

// Fungsi utama untuk menjalankan program
void main() {
  // Membuat instance perusahaan
  var perusahaan = Perusahaan();

  // Membuat produk digital dan menerapkan diskon pada produk yang memenuhi syarat
  var produk1 = ProdukDigital(
      "Sistem Manajemen Data", 150000, KategoriProduk.DataManagement);
  var produk2 = ProdukDigital(
      "Sistem Otomasi Jaringan", 250000, KategoriProduk.NetworkAutomation,
      jumlahTerjual: 60);
  produk2.terapkanDiskon();

  // Membuat karyawan tetap dan kontrak
  var karyawan1 = KaryawanTetap("susi", umur: 30, peran: "Developer");
  var karyawan2 = KaryawanKontrak("udin", umur: 27, peran: "NetworkEngineer");

  // Menambahkan karyawan ke perusahaan
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);

  // Memanggil metode bekerja untuk setiap karyawan
  karyawan1.bekerja();
  karyawan2.bekerja();

  // Membuat proyek baru dan menambahkan karyawan ke tim proyek
  var proyek = Proyek();
  proyek.tambahKaryawanKeTim(karyawan1);
  proyek.tambahKaryawanKeTim(karyawan2);

  // Menampilkan jumlah karyawan aktif dan yang resign
  print("Jumlah karyawan aktif: ${perusahaan.jumlahKaryawanAktif}");
  print("Jumlah karyawan resign: ${perusahaan.jumlahKaryawanResign}");

  // Mencoba melanjutkan ke fase proyek berikutnya
  proyek.lanjutKeFaseBerikutnya();
}
