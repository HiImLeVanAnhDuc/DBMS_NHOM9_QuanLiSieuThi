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
namespace AppQuanLiSieuThi_ADO
{
    public partial class FormDangKyTaiKhoan : Form
    {
        ClassLogin login =null;
        public FormDangKyTaiKhoan()
        {
            InitializeComponent();
            login = new ClassLogin();
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            
            if (!txtMatKhau.Text.Trim().Equals("") &
                !txtTenDN.Text.Trim().Equals("") &
                !txtNhapLaiMK.Text.Trim().Equals("") )
            {
                if(login.kiemTraTaiKhoan(txtTenDN.Text.Trim()) ==false)
                {
                    if(txtMatKhau.Text.Trim().Equals(txtNhapLaiMK.Text.Trim()))
                    {
                        login.Them(txtTenDN.Text, txtMatKhau.Text);
                        MessageBox.Show("Đã Đăng kí thành công thành công!!");
                    }    
                    else
                    {
                        MessageBox.Show("Mật khẩu không trùng nhau");
                        txtMatKhau.Text = "";
                        txtNhapLaiMK.Text = "";
                        txtMatKhau.Focus();
                    } 
                }    
                else
                {
                    MessageBox.Show("Tên Đăng Nhập đã tồn tại");
                    txtTenDN.Text = "";
                    txtTenDN.Focus();
                } 
            }
            else
            {
                MessageBox.Show("Thiếu thông tin kìa !!");
                txtTenDN.Focus();
            }
           
        }
    }
}
