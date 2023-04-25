using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

using AppQuanLiSieuThi_ADO.Connection_Layer;

namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassLoaiHang
    {
        ConnectionDataBase main = null;
        private string username;
        private string password;
        public ClassLoaiHang(string username, string password)
        {
            main = new ConnectionDataBase(username, password);
            this.username = username;
            this.password = password;
        }
        public DataSet Show()
        {
            ClassLogin lg = new ClassLogin();
            if (lg.KiemTraUser(username))
                return main.ImportData("select * from view_LoaiHang");
            else
                return main.ImportData("select * from LoaiHang");
        }
        public void Sua(string txtMaLH, string txtTenLoaiHang)
        {
            string connection = $"exec update_LoaiHang '{txtMaLH}', N'{txtTenLoaiHang}'";
            main.Run(connection);
        }
        public void Them(string txtMaLH, string txtTenLoaiHang)
        {
            string connection = $"exec insert_loaihang '{txtMaLH}',N'{txtTenLoaiHang}'";
            main.Run(connection);
        }
        public void Xoa(string txtMaLH)
        {
            string connection = $"exec DeleteRowOfTable_LoaiHang '{txtMaLH}'";
            main.Run(connection);
        }
    }
}
