using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using System.Data.SqlClient;

using AppQuanLiSieuThi_ADO.Perform_Layer;

namespace AppQuanLiSieuThi_ADO.FormUser_Layer
{
    public partial class FormHangHoaUser : Form
    {
        ClassHangHoa hh = null;
        private string tendangnhap;
        private string matkhau;
        public FormHangHoaUser(string tendangnhap, string matkhau)
        {
            InitializeComponent();
            this.tendangnhap = tendangnhap;
            this.matkhau = matkhau;
            hh = new ClassHangHoa(tendangnhap, matkhau);
        }
        DataTable dt = null;
        void loadData()
        {
            try
            {
                dt = new DataTable();
                dt.Clear();
                DataSet ds = hh.Show();

                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            catch (SqlException)
            {
                MessageBox.Show("Lỗi ở đâu rồi !!");
            }
        }
        private void btnLoad_Click(object sender, EventArgs e)
        {
            loadData();
        }

        private void FormHangHoaUser_Load(object sender, EventArgs e)
        {
            loadData();
        }

        private void btnTTLoaiHang_Click(object sender, EventArgs e)
        {
            FormLoaiHangUser lh = new FormLoaiHangUser(tendangnhap, matkhau);
            lh.ShowDialog();
        }

        private void btnTim_Click(object sender, EventArgs e)
        {
            ClassTimKiemTheoYeuCau tkiem = new ClassTimKiemTheoYeuCau(tendangnhap, matkhau);
            dt = new DataTable();
            dt.Clear();
            if (cbxThuocTinh.Text != "All")
            {
                DataSet ds = tkiem.timKiemThongTin("HangHoa", cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }
    }
}
