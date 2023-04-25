using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

using AppQuanLiSieuThi_ADO.Connection_Layer;

namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassHangHoa
    {
        ConnectionDataBase main = null;
        private string username;
        private string password;
        public ClassHangHoa(string username, string password)
        {
            this.username = username;
            this.password = password;
            main = new ConnectionDataBase(username, password);
        }
        public DataSet Show()
        {
            ClassLogin lg = new ClassLogin();
            if( lg.KiemTraUser(ClassLogin._TenDangNhap))
                return main.ImportData("select * from view_HangHoa");
            else
                return main.ImportData("select * from HangHoa");
        }
        public DataSet ShowHangSapHet()
        {
            return main.ImportData("select * from HangCoSoLuongDuoi10()");
        }
        public void Sua(string txtMaHang, string txtTenHang, string txtGia,
            string txtSLKho, string txtLoaiHang)
        {
            //string connection = $"Update HangHoa set TenHang=N'{txtTenHang}',Gia='{txtGia}',SoLuongTonKho='{txtSLKho}'," +
            //$"MaLoaiHang='{txtLoaiHang}' where MaHang='{txtMaHang}'";
            string connection = $"exec update_HangHoa '{txtMaHang}', N'{txtTenHang}', '{txtGia}', '{txtSLKho}'," +
                                $"'{txtLoaiHang}'";
            main.Run(connection);
        }
        public void Them(string txtMaHang, string txtTenHang, string txtGia,
            string txtSLKho, string txtLoaiHang)
        {
            string connection = $"exec insert_hanghoa '{txtMaHang}',N'{txtTenHang}','{txtGia}','{txtSLKho}','{txtLoaiHang}'";
            main.Run(connection);
        }
        public void Xoa(string txtMaHang)
        {
            string connection = $"exec DeleteRowOfTable_HangHoa '{txtMaHang}'";
            main.Run(connection);
        }
    }
}
