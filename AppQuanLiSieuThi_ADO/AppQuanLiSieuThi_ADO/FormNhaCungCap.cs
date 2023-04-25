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
    public partial class FormNhaCungCap : Form
    {
        public FormNhaCungCap()
        {
            InitializeComponent();
        }

        DataTable dt = null;
        ClassNhaCungCap ncc = new ClassNhaCungCap();
        bool Them = false;
        void loadData()
        {
            txtMaNCC.ResetText();
            txtDiaChi.ResetText();
            txtTenNCC.ResetText();
            txtSDT.ResetText();

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
                DataSet ds = ncc.Show();

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
            txtMaNCC.ResetText();
            txtDiaChi.ResetText();
            txtTenNCC.ResetText();
            txtSDT.ResetText();

            txtMaNCC.Enabled = true;

            btnLuu.Enabled = true;
            btnHuy.Enabled = true;

            panel4.Enabled = true;

            btnThem.Enabled = false;
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            Them = false;
            txtMaNCC.ResetText();
            txtDiaChi.ResetText();
            txtTenNCC.ResetText();
            txtSDT.ResetText();

            txtMaNCC.Enabled = false;

            btnLuu.Enabled = true;
            btnHuy.Enabled = true;

            panel4.Enabled = true;

            btnThem.Enabled = false;
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtMaNCC.ResetText();
            txtDiaChi.ResetText();
            txtTenNCC.ResetText();
            txtSDT.ResetText();

            txtMaNCC.Enabled = true;

            btnLuu.Enabled = false;
            btnHuy.Enabled = false;

            panel4.Enabled = false;

            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
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

                    ncc.Xoa(ma);
                    loadData();
                    MessageBox.Show("Đã xóa xong !!");
                }
                catch (SqlException)
                {
                    MessageBox.Show("Không thể xóa !!");
                }
            }
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (Them)
            {
                if (!txtMaNCC.Text.Trim().Equals(""))
                {
                    try
                    {
                        ncc.Them(txtMaNCC.Text, txtTenNCC.Text, txtDiaChi.Text, txtSDT.Text);
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
                    txtMaNCC.Focus();
                }
            }
            else
            {
                try
                {
                    int stt = dataGridView1.CurrentCell.RowIndex;
                    string ma = dataGridView1.Rows[stt].Cells[0].
                        Value.ToString();

                    //Dùng để không làm thay đổi giá trị khi đổi 
                    if (txtTenNCC.Text.Trim().Equals(""))
                        txtTenNCC.Text = dataGridView1.Rows[stt].Cells[1].Value.ToString();
                    if (txtDiaChi.Text.Trim().Equals(""))
                        txtDiaChi.Text = dataGridView1.Rows[stt].Cells[2].Value.ToString();
                    if (txtSDT.Text.Trim().Equals(""))
                        txtSDT.Text = dataGridView1.Rows[stt].Cells[3].Value.ToString();



                    ncc.Sua(ma, txtTenNCC.Text, txtDiaChi.Text, txtSDT.Text);
                    loadData();
                    MessageBox.Show("Đã sửa thành công !!");
                }
                catch (SqlException)
                {
                    MessageBox.Show("Không thể sửa !!");
                }
            }
        }

        private void FormNhaCungCap_Load(object sender, EventArgs e)
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
                DataSet ds = tkiem.timKiemThongTin("NhaCungCap", cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }
    }
}
