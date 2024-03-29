<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Laporan extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        cek_login();

        $this->load->model('Admin_model', 'admin');
        $this->load->library('form_validation');
    }

    public function index()
    {
        $this->form_validation->set_rules('transaksi', 'Transaksi', 'required|in_list[barang_masuk,barang_keluar]');
        $this->form_validation->set_rules('tanggal', 'Periode Tanggal', 'required');

        if ($this->form_validation->run() == false) {
            $data['title'] = "Laporan Transaksi";
            $this->template->load('templates/dashboard', 'laporan/form', $data);
        } else {
            $input = $this->input->post(null, true);
            $table = $input['transaksi'];
            $tanggal = $input['tanggal'];
            $pecah = explode(' - ', $tanggal);
            $mulai = date('Y-m-d', strtotime($pecah[0]));
            $akhir = date('Y-m-d', strtotime(end($pecah)));

            $query = '';
            if ($table == 'barang_masuk') {
                $query = $this->admin->getBarangMasuk(null, null, ['mulai' => $mulai, 'akhir' => $akhir]);
            } else {
                $query = $this->admin->getBarangKeluar(null, null, ['mulai' => $mulai, 'akhir' => $akhir]);
            }

            $this->_cetak($query, $table, $tanggal, $mulai, $akhir);
        }
    }

    public function _cetak($data, $table_, $tanggal, $mulai, $akhir)
    {
        $this->load->library('CustomPDF');
        $table = $table_ == 'barang_masuk' ? 'Barang Masuk' : 'Barang Keluar';
        $barang = $this->admin->get('barang');

        $jml = $this->templates->query("SELECT SUM(harga*jumlah_keluar) jumlah FROM barang_keluar JOIN barang ON barang_keluar.barang_id = barang.id_barang WHERE tanggal_keluar BETWEEN '$mulai' AND '$akhir'")->result();

        $pdf = new FPDF();
        $pdf->AddPage('P', 'Letter');
        $pdf->SetFont('Times', 'B', 16);
        $pdf->Cell(190, 7, 'Laporan ' . $table, 0, 1, 'C');
        $pdf->SetFont('Times', 'B', 12);
        $pdf->Ln(1);
        $pdf->Cell(190, 4, 'BAROKAH MEBEL', 0, 1, 'C');
        $pdf->Ln(1);
        $pdf->SetFont('Times', '', 10);
        $pdf->Cell(190, 4, 'Jalan Profesor Soeharso No 8 Winong, Dusun 2, Kiringan, Boyolali', 0, 1, 'C');
        $pdf->Cell(190, 4, '(0276) 321717 / 081215363607', 0, 1, 'C');
        $pdf->Ln(1);
        $pdf->SetFont('Times', '', 10);
        $pdf->Cell(190, 4, 'Tanggal : ' . $mulai. ' - '.$akhir, 0, 1, 'C');
        $pdf->Ln(10);

        $pdf->SetFont('Arial', 'B', 10);

        if ($table_ == 'barang_masuk') :
            $pdf->Cell(10, 7, 'No.', 1, 0, 'C');
            $pdf->Cell(25, 7, 'Tgl Masuk', 1, 0, 'C');
            $pdf->Cell(35, 7, 'ID Transaksi', 1, 0, 'C');
            $pdf->Cell(55, 7, 'Nama Barang', 1, 0, 'C');
            $pdf->Cell(40, 7, 'Pekerja', 1, 0, 'C');
            $pdf->Cell(30, 7, 'Jumlah Masuk', 1, 0, 'C');
            $pdf->Ln();

            $no = 1;
            foreach ($data as $d) {
                $pdf->SetFont('Arial', '', 10);
                $pdf->Cell(10, 7, $no++ . '.', 1, 0, 'C');
                $pdf->Cell(25, 7, $d['tanggal_masuk'], 1, 0, 'C');
                $pdf->Cell(35, 7, $d['id_barang_masuk'], 1, 0, 'C');
                $pdf->Cell(55, 7, $d['nama_barang'], 1, 0, 'L');
                $pdf->Cell(40, 7, $d['nama_supplier'], 1, 0, 'L');
                $pdf->Cell(30, 7, $d['jumlah_masuk'] . ' ' . $d['nama_satuan'], 1, 0, 'C');
                $pdf->Ln();
            } 

            $pdf->Ln();
            $pdf->Ln();
            $pdf->Ln();
            $pdf->Ln();
            $pdf->Cell(195, 7, 'Hafidh Arifianto', 0, 1, 'R');

            else :
            $pdf->Cell(7, 7, 'No', 1, 0, 'C');
            $pdf->Cell(20, 7, 'Tgl Keluar', 1, 0, 'C');
            $pdf->Cell(35, 7, 'ID Transaksi', 1, 0, 'C');
            $pdf->Cell(55, 7, 'Nama Barang', 1, 0, 'C');
            $pdf->Cell(25, 7, 'Jml Keluar', 1, 0, 'C');
            $pdf->Cell(20, 7, 'Tgl Sampai', 1, 0, 'C');
            $pdf->Cell(35, 7, 'Total Keluar', 1, 0, 'C');
            $pdf->Ln();

            $no = 1;
            foreach ($data as $d) {
                $pdf->SetFont('Arial', '', 10);
                $pdf->Cell(7, 7, $no++ . '.', 1, 0, 'C');
                $pdf->Cell(20, 7, $d['tanggal_keluar'], 1, 0, 'C');
                $pdf->Cell(35, 7, $d['id_barang_keluar'], 1, 0, 'C');
                $pdf->Cell(55, 7, $d['nama_barang'], 1, 0, 'L');
                $pdf->Cell(25, 7, $d['jumlah_keluar'] . ' ' . $d['nama_satuan'], 1, 0, 'C');
                $pdf->Cell(20, 7, $d['tanggal_sampai'], 1, 0, 'C');

                foreach ($barang as $b) :
                    if($b['id_barang'] == $d['barang_id']){
                        //$pdf->Cell(35, 7, $d['jumlah_keluar']*$b['harga'], 1, 0, 'L');
                        $pdf->Cell(35, 7, "Rp " . number_format($d['jumlah_keluar']*$b['harga'], 0, ".", "."), 1, 0, 'L');
                        
                    }
                    //$jumlah = 0;
                    //$isi = $d['jumlah_keluar']*$b['harga'];
                    //$jl = array($isi);
                    //$jumlah =+ array_sum($jl);
                endforeach;

                $pdf->Ln();
            }
            $pdf->Cell(162, 7, 'Jumlah Total Keluar :', 1, 0, 'C');
            foreach ($jml as $jml) {
                $pdf->Cell(35, 7, "Rp " . number_format($jml->jumlah, 0, ".", "."), 1, 0, 'C');
            }

            $pdf->Ln();
            $pdf->Ln();
            $pdf->Ln();
            $pdf->Ln();
            $pdf->Cell(197, 7, 'Hafidh Arifianto', 0, 1, 'R');

        endif;

        $file_name = $table . ' ' . $tanggal;
        $pdf->Output($file_name, 'I');
    }
}
