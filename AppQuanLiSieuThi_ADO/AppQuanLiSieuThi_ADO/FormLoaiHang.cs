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
    public partial class FormLoaiHang : Form
    {
        ClassLoaiHang loaiHang = null;
        private string tendangnhap;
        private string matkhau;
        public FormLoaiHang(string tendangnhap, string matkhau)
        {
            InitializeComponent();
            this.tendangnhap = tendangnhap;
            this.matkhau = matkhau;
            loaiHang = new ClassLoaiHang(tendangnhap, matkhau);
        }

        DataTable dt = null;
        bool Them = false;
        void loadData()
        {
            txtTenLoaiHang.ResetText();
            txtMaLH.ResetText();

            btnLuu.Enabled = false;
            btnHuy.Enabled = false;

            panel4.Enabled = false;
            
            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
            try
            {
                dt = new DataTable();
                dt.Clear();
                DataSet ds = loaiHang.Show();

                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            catch (SqlException)
            {
                MessageBox.Show("Lỗi ở đâu rồi !!");
            }
        }
        private void btnThem_Click(object sender, EventArgs e)
        {
            Them = true;
            txtTenLoaiHang.ResetText();
            txtMaLH.ResetText();

            txtMaLH.Enabled = true;

            btnLuu.Enabled = true;
            btnHuy.Enabled = true;

            panel4.Enabled = true;

            btnThem.Enabled = false;
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            DialogResult traloi;
            traloi = MessageBox.Show("Bạn có chắc là muốn xóa", "Xóa dữ liệu",
                MessageBoxButtons.OKCancel);
            if (traloi == DialogResult.OK)
            {
                try
                {
                    int stt = dataGridView1.CurrentCell.RowIndex;
                    string ma = dataGridView1.Rows[stt].Cells[0].
                        Value.ToString();

                    loaiHang.Xoa(ma);
                    loadData();
                    MessageBox.Show("Đã xóa xong !!");
                }
                catch (SqlException)
                {
                    MessageBox.Show("Không thể xóa !!");
                }
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            Them = false;
            txtTenLoaiHang.ResetText();
            txtMaLH.ResetText();

            txtMaLH.Enabled = false;

            btnLuu.Enabled = true;
            btnHuy.Enabled = true;

            panel4.Enabled = true;

            btnThem.Enabled = false;
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
                if (Them)
                {
                    if (!txtMaLH.Text.Trim().Equals(""))
                    {
                        try
                        {
                            loaiHang.Them(txtMaLH.Text, txtTenLoaiHang.Text);
                            loadData();
                            MessageBox.Show("Đã thêm thành công!!");
                        }
                        catch (SqlException)
                        {
                            MessageBox.Show("Không thể thêm dữ liệu");
                        }
                    }
                    else
                    {
                        MessageBox.Show("Thiếu mã kìa !!");
                        txtTenLoaiHang.Focus();
                    }
                }
                else
                {
                    try
                    {                      
                        int stt = dataGridView1.CurrentCell.RowIndex;
                        string ma = dataGridView1.Rows[stt].Cells[0].
                            Value.ToString();
                        loaiHang.Sua(ma, txtTenLoaiHang.Text);
                        loadData();
                        MessageBox.Show("Đã sửa thành công !!");
                    }
                    catch (SqlException)
                    {
                        MessageBox.Show("Không thể sửa !!");
                    }
                }         
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtTenLoaiHang.ResetText();
            txtMaLH.ResetText();
            txtMaLH.Enabled = true;

            btnLuu.Enabled = false;
            btnHuy.Enabled = false;

            panel4.Enabled = false;

            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
        }

        private void FormLoaiHang_Load(object sender, EventArgs e)
        {
            loadData();
        }

        private void btnTim_Click(object sender, EventArgs e)
        {
            ClassTimKiemTheoYeuCau tkiem = new ClassTimKiemTheoYeuCau(ClassLogin._TenDangNhap, ClassLogin._MatKhau);
            dt = new DataTable();
            dt.Clear();
            if (cbxThuocTinh.Text != "All")
            {
                DataSet ds = tkiem.timKiemThongTin("LoaiHang", cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }
    }
}
