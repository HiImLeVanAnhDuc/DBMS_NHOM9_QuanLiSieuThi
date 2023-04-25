using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using AppQuanLiSieuThi_ADO.Perform_Layer;
using AppQuanLiSieuThi_ADO.FormUser_Layer;

namespace AppQuanLiSieuThi_ADO
{
    public partial class FormLogin : Form
    {
        ClassLogin timKiem;
        public FormLogin()
        {
            InitializeComponent();
            timKiem = new ClassLogin();
        }
        private void btnLogin_Click(object sender, EventArgs e)
        {
            var tendangnhap = tbxTenDangNhap.Text.Trim();
            var matkhau = tbxMatKhau.Text.Trim();
            // Lấy giá trị của mật khẩu và tên đăng nhập
            if (tendangnhap == "" || matkhau == "")
                MessageBox.Show("Bạn chưa nhập đầy đủ thông tin", "Thông báo");
            else
            {
                if ( timKiem.Search(tendangnhap, matkhau) ) 
                {
                    ClassLogin.TenDangNhap = tendangnhap;
                    ClassLogin.MatKhau = matkhau;
                    if (timKiem.KiemTraUser(tendangnhap))
                    {
                        FormMainUser form = new FormMainUser(tendangnhap, matkhau);
                        tbxTenDangNhap.Text = "";
                        tbxMatKhau.Text = "";
                        this.Hide();// Tạm ẩn form đăng nhập
                        form.ShowDialog();
                        this.Show();// Khi tắt form làm việc đi sẽ hiện lại form đăng nhập
                    }
                    else
                    {
                        FormMain frm = new FormMain(tendangnhap, matkhau);
                        tbxTenDangNhap.Text = "";
                        tbxMatKhau.Text = "";
                        this.Hide();// Tạm ẩn form đăng nhập
                        frm.ShowDialog();
                        this.Show();// Khi tắt form làm việc đi sẽ hiện lại form đăng nhập
                    }           
                }
                else
                {
                    MessageBox.Show("Sai tên đăng nhập hoặc mật khẩu", "Thông báo");
                    tbxTenDangNhap.Focus();
                }
            }         
        }
        private void cbShow_CheckedChanged(object sender, EventArgs e)
        {
            if (cbShow.Checked)
                tbxMatKhau.PasswordChar = (char)0;
            else
                tbxMatKhau.PasswordChar = '*';
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            FormDangKyTaiKhoan dk = new FormDangKyTaiKhoan();
            this.Hide();// Tạm ẩn form đăng nhập
            dk.ShowDialog();
            this.Show();// Khi tắt form làm việc đi sẽ hiện lại form đăng nhập
        }
    }
}
