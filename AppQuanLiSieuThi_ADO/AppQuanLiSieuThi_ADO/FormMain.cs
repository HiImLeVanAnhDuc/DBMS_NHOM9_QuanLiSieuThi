using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AppQuanLiSieuThi_ADO.Connection_Layer;

namespace AppQuanLiSieuThi_ADO
{
    public partial class FormMain : Form
    {
        private string tendangnhap = Perform_Layer.ClassLogin.TenDangNhap;
        private string matkhau = Perform_Layer.ClassLogin.MatKhau;
        public FormMain(string tendangnhap,string matkhau)
        {
            InitializeComponent();
            this.tendangnhap = tendangnhap;
            this.matkhau = matkhau;
        }

        private void btnNhapHang_Click(object sender, EventArgs e)
        {
            FormNhapHang nh = new FormNhapHang();
            nh.ShowDialog();
        }

        private void btnLoaiHang_Click(object sender, EventArgs e)
        {
            FormLoaiHang lh = new FormLoaiHang(tendangnhap, matkhau);
            lh.ShowDialog();
        }

        private void btnNhaCungCap_Click(object sender, EventArgs e)
        {
            FormNhaCungCap ncc = new FormNhaCungCap();
            ncc.ShowDialog();
        }
        private void btnHangHoa_Click(object sender, EventArgs e)
        {
            FormHangHoa hh = new FormHangHoa(tendangnhap,matkhau);
            //hh.Show();
            hh.ShowDialog();
        }

        private void btnDangXuat_Click(object sender, EventArgs e)
        {
            DialogResult tl = MessageBox.Show("Bạn có muốn thoát", "Thoát Ứng Dụng",
                MessageBoxButtons.OKCancel);
            if (tl == DialogResult.OK)
                this.Close();
        }

        private void btnXuatHang_Click(object sender, EventArgs e)
        {
            FormXuatHang xh = new FormXuatHang();
            xh.ShowDialog();
        }

        private void btnHangLoi_Click(object sender, EventArgs e)
        {
            FormHangLoi hl = new FormHangLoi();
            hl.ShowDialog();
        }
    }
}
