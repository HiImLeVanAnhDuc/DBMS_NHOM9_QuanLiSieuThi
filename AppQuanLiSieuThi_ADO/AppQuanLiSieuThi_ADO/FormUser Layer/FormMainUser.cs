using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AppQuanLiSieuThi_ADO.FormUser_Layer
{
    public partial class FormMainUser : Form
    {
        string tendangnhap = Perform_Layer.ClassLogin.TenDangNhap;
        string matkhau = Perform_Layer.ClassLogin.MatKhau;
        public FormMainUser(string tendangnhap, string matkhau)
        {
            InitializeComponent();
            this.tendangnhap = tendangnhap;
            this.matkhau = matkhau;
        }

        private void btnDangXuat_Click(object sender, EventArgs e)
        {
            DialogResult tl = MessageBox.Show("Bạn có muốn thoát", "Thoát Ứng Dụng",
            MessageBoxButtons.OKCancel);
            if (tl == DialogResult.OK)
                this.Close();
        }

        private void btnHangHoa_Click(object sender, EventArgs e)
        {
            FormHangHoaUser hh = new FormHangHoaUser(tendangnhap, matkhau);
            //hh.Show();
            hh.ShowDialog();
        }

        private void btnLoaiHang_Click(object sender, EventArgs e)
        {
            FormLoaiHangUser lh = new FormLoaiHangUser(tendangnhap,matkhau);
            lh.ShowDialog();
        }
    }
}
