using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

using AppQuanLiSieuThi_ADO.Connection_Layer;

namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassXuatHang
    {
        ConnectionDataBase main = null;
        public ClassXuatHang()
        {
            main = new ConnectionDataBase();
        }
        public DataSet Show()
        {
            return main.ImportData("select * from ChiTietXuatHang");
            //return main.ImportData("select * from view_ChiTietXuatHang");
        }
        public void Sua(string txtMaXH, string txtMaHang, string txtSLXuat,string txtNgayXuat)
        {
            string connection = $"exec update_ChiTietXuatHang '{txtMaXH}', N'{txtMaHang}', " +
                $"'{txtSLXuat}', '{txtNgayXuat}'";
            main.Run(connection);
        }
        public void Them(string txtMaXH, string txtMaHang, string txtSLXuat, string txtNgayXuat)
        {
            string connection = $"exec insert_xuathang '{txtMaXH}','{txtMaHang}','{txtSLXuat}','{txtNgayXuat}'";
            main.Run(connection);
        }
        public void Xoa(string txtMaNH)
        {
            string connection = $"exec DeleteRowOfTable_ChiTietXuatHang '{txtMaNH}'";
            main.Run(connection);
        }
    
    }
}
