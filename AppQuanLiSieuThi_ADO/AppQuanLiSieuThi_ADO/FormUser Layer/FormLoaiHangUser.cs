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
    public partial class FormLoaiHangUser : Form
    {
        ClassLoaiHang hh = null;
        public FormLoaiHangUser(string tendangnhap, string matkhau)
        {
            InitializeComponent();
            hh = new ClassLoaiHang(tendangnhap, matkhau);
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
                MessageBox.Show("Lỗi ở đâu rồi!!");
            }
        }

        private void FormLoaiHangUser_Load(object sender, EventArgs e)
        {
            loadData();
        }

        private void btnTim_Click(object sender, EventArgs e)
        {
            ClassTimKiemTheoYeuCau tkiem = new ClassTimKiemTheoYeuCau(ClassLogin._TenDangNhap, ClassLogin._MatKhau);
            dt = new DataTable();
            dt.Clear();
            if (cbxThuocTinh.Text != "All")
            {
                DataSet ds = tkiem.timKiemThongTin("LoaiHang", cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }
    }
}
