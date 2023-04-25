using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;

using AppQuanLiSieuThi_ADO.Connection_Layer;
namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassLogin
    {
        ConnectionDataBase main = null;
        public ClassLogin()
        {
            main = new ConnectionDataBase();
        }
        public bool Search(string tendangnhap, string matkhau)
        {
            string query = "select * from TaiKhoan where TenDangNhap = '" + tendangnhap +
               "' and MatKhau = '" + matkhau + "'";
            //  main.ImportData(query)
            DataTable result = main.ImportData(query).Tables[0];

            return (result.Rows.Count > 0) ? true : false;
        }
        public void Them(string txtTenDN, string txtMatKhau)
        {
            string query = $"exec sp_create_user {txtTenDN}, {txtMatKhau}";
            main.Run(query);
            
        }
        public bool kiemTraTaiKhoan(string tendangnhap)
        {
            string query = "select * from TaiKhoan where TenDangNhap = '" + tendangnhap + "'";
            DataTable result = main.ImportData(query).Tables[0];

            return (result.Rows.Count > 0) ? true : false;
        }

        //Mới thêm vô nha Đức, kiểm tra nếu là user thì return true hoặc ngược lại return false
        public bool KiemTraUser(string tendangnhap)
        {
            string query = $"select * from TaiKhoan Where TenDangNhap = '{tendangnhap}' and PhanLoai = 'user'";
            DataTable result = main.ImportData(query).Tables[0];

            return (result.Rows.Count > 0) ? true : false;
        }
        
        public static string _TenDangNhap;
        public static string _MatKhau;
        public static string TenDangNhap
        {
            get { return _TenDangNhap; }
            set { _TenDangNhap = value; }
        }

        public static string MatKhau
        {
            get { return _MatKhau; }
            set { _MatKhau = value; }
        }
    }
}
