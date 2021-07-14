-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Jul 2021 pada 06.40
-- Versi server: 10.1.38-MariaDB
-- Versi PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barang_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id_barang` char(7) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `stok` int(11) NOT NULL,
  `satuan_id` int(11) NOT NULL,
  `jenis_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `stok`, `satuan_id`, `jenis_id`) VALUES
('B000002', 'Samsung Galaxy J1 Ace', 10, 1, 4),
('B000003', 'Aqua 1,5 Liter', 495, 3, 2),
('B000004', 'Mouse Wireless Logitech M220', 80, 1, 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barang_keluar` char(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_keluar` int(11) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `nama_pembeli` varchar(250) NOT NULL,
  `alamat_pembeli` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barang_keluar`, `user_id`, `barang_id`, `jumlah_keluar`, `tanggal_keluar`, `nama_pembeli`, `alamat_pembeli`) VALUES
('T-BK-19092000003', 1, 'B000001', 5, '2019-09-20', '', ''),
('T-BK-19092000005', 1, 'B000004', 10, '2019-09-20', '', ''),
('T-BK-20121700000', 1, 'B000001', 10, '2020-12-17', '', ''),
('T-BK-20121700001', 1, 'B000003', 10, '2020-12-17', '', ''),
('T-BK-20121700002', 1, 'B000001', 30, '2020-12-17', '', ''),
('T-BK-20121700003', 1, 'B000001', 12, '2020-12-17', '', ''),
('T-BK-20121700004', 1, 'B000001', 20, '2020-12-17', '', ''),
('T-BK-20121700005', 1, 'B000002', 80, '2020-12-17', '', ''),
('T-BK-20122100000', 1, 'B000002', 23, '2020-12-21', '', ''),
('T-BK-20122100001', 1, 'B000001', 1, '2020-12-21', '', ''),
('T-BK-21070900001', 1, 'B000002', 5, '2021-07-09', '', ''),
('T-BK-21070900005', 1, 'B000003', 100, '2021-07-09', 'C', ''),
('T-BK-21070900006', 1, 'B000002', 2, '2021-07-09', 'D', 'Kebumen'),
('T-BK-21070900007', 1, 'B000004', 150, '2021-07-09', 'Fauzi', 'Boyolali'),
('T-BK-21071000001', 1, 'B000003', 33, '2021-07-10', 'E', 'Telkom'),
('T-BK-21071100001', 1, 'B000002', 1, '2021-07-11', 'fyfu', 'Alamkjguoogoat Pembeli');

--
-- Trigger `barang_keluar`
--
DELIMITER $$
CREATE TRIGGER `update_stok_keluar` BEFORE INSERT ON `barang_keluar` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - NEW.jumlah_keluar WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang_masuk` char(16) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_masuk` int(50) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `Harga` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang_masuk`, `supplier_id`, `user_id`, `barang_id`, `jumlah_masuk`, `tanggal_masuk`, `Harga`) VALUES
('T-BM-19082000004', 1, 1, 'B000004', 15, '2019-08-20', 0),
('T-BM-19092000005', 3, 1, 'B000002', 40, '2019-09-20', 0),
('T-BM-19092000006', 2, 1, 'B000003', 50, '2019-09-20', 0),
('T-BM-19092200007', 3, 1, 'B000004', 15, '2019-09-22', 0),
('T-BM-19092200008', 1, 1, 'B000003', 135, '2019-09-22', 0),
('T-BM-20122100000', 1, 1, 'B000001', 2, '2020-12-21', 5000000),
('T-BM-20122100001', 1, 1, 'B000002', 5, '2020-12-21', 6000000),
('T-BM-20122100002', 1, 1, 'B000003', 2, '2020-12-21', 5000000),
('T-BM-20122100003', 1, 1, 'B000002', 8, '2020-12-21', 15000000),
('T-BM-20122100004', 2, 1, 'B000003', 12, '2020-12-21', 4000000),
('T-BM-20122100005', 1, 1, 'B000004', 10, '2020-12-21', 20000000),
('T-BM-20122100006', 1, 1, 'B000001', 1, '2020-12-21', 2000000),
('T-BM-20122100007', 1, 1, 'B000001', 1, '2020-12-21', 8000000),
('T-BM-20122100009', 1, 1, 'B000002', 2, '2020-12-21', 7000000),
('T-BM-21070900001', 1, 1, 'B000002', 3, '2021-07-09', 2452555),
('T-BM-21071100001', 2, 1, 'B000003', 2, '2021-05-05', 797662);

--
-- Trigger `barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `update_stok_masuk` BEFORE INSERT ON `barang_masuk` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + NEW.jumlah_masuk WHERE `barang`.`id_barang` = NEW.barang_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis`
--

CREATE TABLE `jenis` (
  `id_jenis` int(11) NOT NULL,
  `nama_jenis` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jenis`
--

INSERT INTO `jenis` (`id_jenis`, `nama_jenis`) VALUES
(1, 'Snack'),
(2, 'Minuman'),
(3, 'Laptop'),
(4, 'Handphone'),
(5, 'Sepeda Motor'),
(6, 'Mobil'),
(7, 'Perangkat Komputer'),
(0, 'Elektronik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `satuan`
--

CREATE TABLE `satuan` (
  `id_satuan` int(11) NOT NULL,
  `nama_satuan` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `satuan`
--

INSERT INTO `satuan` (`id_satuan`, `nama_satuan`) VALUES
(1, 'Unit'),
(2, 'Pack'),
(3, 'Kursi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `nama_supplier` varchar(50) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `no_telp`, `alamat`) VALUES
(1, 'Ahmad Hasanudin', '085688772971', 'Kec. Cigudeg, Bogor - Jawa Barat'),
(2, 'Asep Salahudin', '081341879246', 'Kec. Ciampea, Bogor - Jawa Barat'),
(3, 'Filo Lial', '087728164328', 'Kec. Ciomas, Bogor - Jawa Barat');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `role` enum('gudang','admin') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  `foto` text NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `email`, `no_telp`, `role`, `password`, `created_at`, `foto`, `is_active`) VALUES
(1, 'Adminisitrator', 'admin', 'admin@admin.com', '025123456789', 'admin', '$2y$10$wMgi9s3FEDEPEU6dEmbp8eAAEBUXIXUy3np3ND2Oih.MOY.q/Kpoy', 1568689561, 'd5f22535b639d55be7d099a7315e1f7f.png', 1),
(7, 'Arfan ID', 'arfandotid', 'arfandotid@gmail.com', '081221528805', 'gudang', '$2y$10$5es8WhFQj8xCmrhDtH86Fu71j97og9f8aR4T22soa7716kAusmaeK', 1568691611, 'user.png', 1),
(8, 'Muhammad Ghifari Arfananda', 'mghifariarfan', 'mghifariarfan@gmail.com', '085697442673', 'gudang', '$2y$10$5SGUIbRyEXH7JslhtEegEOpp6cvxtK6X.qdiQ1eZR7nd0RZjjx3qe', 1568691629, 'user.png', 1),
(13, 'Arfan Kashilukato', 'arfankashilukato', 'arfankashilukato@gmail.com', '081623123181', 'gudang', '$2y$10$/QpTunAD9alBV5NSRJ7ytupS2ibUrbmS3ia3u5B26H6f3mCjOD92W', 1569192547, 'user.png', 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `satuan_id` (`satuan_id`),
  ADD KEY `kategori_id` (`jenis_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
