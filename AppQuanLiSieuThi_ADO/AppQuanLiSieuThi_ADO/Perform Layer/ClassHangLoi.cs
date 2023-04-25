using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

using AppQuanLiSieuThi_ADO.Connection_Layer;

namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassHangLoi
    {
        ConnectionDataBase main = null;
        public ClassHangLoi()
        {
            main = new ConnectionDataBase();
        }
        public DataSet Show()
        {
            return main.ImportData("select * from ThongBaoHangLoi()");
        }
        public void Sua(string txtMaHang, string txtTenLoi, string txtSoLuong)
        {
            string connection = $"exec update_HangLoi '{txtMaHang}', N'{txtTenLoi}', '{txtSoLuong}'";
            main.Run(connection);
        }
        public void Them(string txtMaHang, string txtTenLoi, string txtSoLuong)
        {
            string connection = $"exec insert_hangloi '{txtMaHang}',N'{txtTenLoi}','{txtSoLuong}'";
            main.Run(connection);
        }
        public void Xoa(string txtMaHang)
        {
            string connection = $"exec DeleteRowOfTable_HangLoi '{txtMaHang}'";
            main.Run(connection);
        }
    }
}
