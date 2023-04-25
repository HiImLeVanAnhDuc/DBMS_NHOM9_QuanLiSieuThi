using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace AppQuanLiSieuThi_ADO.Connection_Layer
{
    class ConnectionDataBase
    {
        SqlConnection conn = null;
        SqlDataAdapter da = null;
        SqlCommand comm = null;
        public ConnectionDataBase()
        {
            conn = new SqlConnection("Data Source=.;Initial Catalog=QLHH; Integrated Security=True;");
            comm = conn.CreateCommand();
        }

        //Constructor khởi tạo kết nối đến database theo tên đăng nhập và mật khẩu
        public ConnectionDataBase(string username, string password)
        {
            string strConnectionStringForLogin = $"Data Source =.; Initial Catalog = QLHH; User ID = {username};Password = {password}";
            conn = new SqlConnection(strConnectionStringForLogin);
            comm = conn.CreateCommand();
        }
        public DataSet ImportData(string query)
        {
            DataSet ds = new DataSet();
            if (conn.State == ConnectionState.Open)
                conn.Close();

            conn.Open();
            comm.Connection = conn;
            comm.CommandText = query;

            da = new SqlDataAdapter(comm);
            da.Fill(ds);

            return ds;
        }
        public void Run(string query)
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();

            conn.Open();

            comm.Connection = conn;
            comm.CommandText = query;
            try
            {
                comm.ExecuteNonQuery();
            }
            finally
            {
                conn.Close();
            }
        }
        /*public DataTable ThongKe(string query)
        {
            DataTable dt = new DataTable();
            if (conn.State == ConnectionState.Open)
                conn.Close();

            conn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();
                dt.Load(reader);
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                conn.Close();
            }
            return dt;
        }*/
    }
}
