using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AppQuanLiSieuThi_ADO.Connection_Layer;
using System.Data;

namespace AppQuanLiSieuThi_ADO.Perform_Layer
{
    class ClassTimKiemTheoYeuCau
    {
        ConnectionDataBase main = null;
        public ClassTimKiemTheoYeuCau(string tendangnhap, string matkhau)
        {
            main = new ConnectionDataBase(tendangnhap, matkhau);
        }
        public DataSet timKiemThongTin(string table,string thuocTinh, string yeuCau)
        {
            string connection;
            ClassLogin lg = new ClassLogin();
            if (lg.KiemTraUser(ClassLogin._TenDangNhap))
                connection = "select * from view_" + table;
            else connection = "select * from " + table;
            if (!yeuCau.Trim().Equals(""))
            {
                connection += " where " + thuocTinh + "=N'" + yeuCau + "'";
            }
            return main.ImportData(connection);
        }
    }
}
