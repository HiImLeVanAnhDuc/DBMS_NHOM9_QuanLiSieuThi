using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using AppQuanLiSieuThi_ADO.Perform_Layer;
using System.Data.SqlClient;

namespace AppQuanLiSieuThi_ADO
{
    public partial class FormHangLoi : Form
    {
        public FormHangLoi()
        {
            InitializeComponent();
        }
        DataTable dt = null;
        ClassHangLoi hangLoi = new ClassHangLoi();
        bool Them = false;
        void loadData()
        {
            txtMaHang.ResetText();
            txtSoLuong.ResetText();
            txtTenLoi.ResetText();


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
                DataSet ds = hangLoi.Show();

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
            txtMaHang.ResetText();
            txtSoLuong.ResetText();
            txtTenLoi.ResetText();

            txtMaHang.Enabled = true;

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

                    hangLoi.Xoa(ma);
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
            txtMaHang.ResetText();
            txtSoLuong.ResetText();
            txtTenLoi.ResetText();

            txtMaHang.Enabled = false;

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
                if (!txtMaHang.Text.Trim().Equals(""))
                {
                    try
                    {
                        hangLoi.Them(txtMaHang.Text, txtTenLoi.Text,
                            txtSoLuong.Text);
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
                    txtMaHang.Focus();
                }
            }
            else
            {

                int stt = dataGridView1.CurrentCell.RowIndex;
                string ma = dataGridView1.Rows[stt].Cells[0].
                    Value.ToString();

                //Dùng để không làm thay đổi giá trị khi đổi 
                if (txtTenLoi.Text.Trim().Equals(""))
                    txtTenLoi.Text = dataGridView1.Rows[stt].Cells[1].Value.ToString();
                if (txtSoLuong.Text.Trim().Equals(""))
                    txtSoLuong.Text = dataGridView1.Rows[stt].Cells[2].Value.ToString();



                hangLoi.Sua(ma, txtTenLoi.Text,
                        txtSoLuong.Text);
                loadData();
                MessageBox.Show("Đã sửa thành công !!");

            }
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtMaHang.ResetText();
            txtSoLuong.ResetText();
            txtTenLoi.ResetText();

            txtMaHang.Enabled = true;

            btnLuu.Enabled = false;
            btnHuy.Enabled = false;

            panel4.Enabled = false;

            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
        }

        private void btnTim_Click(object sender, EventArgs e)
        {
            ClassTimKiemTheoYeuCau tkiem = new ClassTimKiemTheoYeuCau(ClassLogin._TenDangNhap, ClassLogin._MatKhau);
            dt = new DataTable();
            dt.Clear();
            if (cbxThuocTinh.Text != "All")
            {
                DataSet ds = tkiem.timKiemThongTin("HangLoi", cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }

        private void FormHangLoi_Load(object sender, EventArgs e)
        {
            loadData();
        }
    }
}
