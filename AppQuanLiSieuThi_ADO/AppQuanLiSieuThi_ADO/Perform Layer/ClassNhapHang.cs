using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

using AppQuanLiSieuThi_ADO.Connection_Layer;

namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassNhapHang
    {
        ConnectionDataBase main = null;
        public ClassNhapHang()
        {
            main = new ConnectionDataBase();
        }
        public DataSet Show()
        {
            return main.ImportData("select * from ChiTietNhapHang");
            //return main.ImportData("select * from view_ChiTietNhapHang");
        }
        public void Sua(string txtMaNH,string txtMaHang, string txtSLNhap,
                           string txtNgayNhap, string txtMaNCC)
        {
            string connection = $"exec update_ChiTietNhapHang '{txtMaNH}', N'{txtMaHang}', " +
                $"'{txtSLNhap}', '{txtNgayNhap}', '{txtMaNCC}'";

            main.Run(connection);
        }
        public void Them(string txtMaNH, string txtMaHang, string txtSLNhap,
                           string txtNgayNhap, string txtMaNCC)
        {
            string connection = $"exec insert_nhaphang '{txtMaNH}','{txtMaHang}','{txtSLNhap}','{txtNgayNhap}','{txtMaNCC}'";
            main.Run(connection);
        }
        public void Xoa(string txtMaNH)
        {
            string connection = $"exec DeleteRowOfTable_ChiTietNhapHang '{txtMaNH}'";
            main.Run(connection);
        }
        public DataSet TienCuaNCC(string date, string MaNCC)
        {
            string connection = $"select dbo.ChiPhiPhaiThanhToanChoNhaCungCap('{date}','{MaNCC}') as SoTien";
            return main.ImportData(connection);
        }
    }
}
