using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AppQuanLiSieuThi_ADO.Connection_Layer;
using System.Data;

namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassNhaCungCap
    {
        ConnectionDataBase main = null;
        public ClassNhaCungCap()
        {
            main = new ConnectionDataBase();
        }
        public DataSet Show()
        {
            return main.ImportData("select * from NhaCungCap");
            //return main.ImportData("select * from view_NhaCungCap");
        }
        public void Sua(string txtMaNCC, string txtTenNCC, string txtDiaChi, string txtSDT)
        {
            string connection = $"exec update_NhaCungCap '{txtMaNCC}', N'{txtTenNCC}', '{txtDiaChi}', '{txtSDT}'";
            main.Run(connection);
        }
        public void Them(string txtMaNCC, string txtTenNCC, string txtDiaChi, string txtSDT)
        {
            string connection = $"exec insert_nhacungcap '{txtMaNCC}',N'{txtTenNCC}',N'{txtDiaChi}','{txtSDT}'";
            main.Run(connection);
        }
        public void Xoa(string txtMaNCC)
        {
            string connection = $"exec DeleteRowOfTable_NhaCungCap '{txtMaNCC}'";
            main.Run(connection);
        }
    }
}
