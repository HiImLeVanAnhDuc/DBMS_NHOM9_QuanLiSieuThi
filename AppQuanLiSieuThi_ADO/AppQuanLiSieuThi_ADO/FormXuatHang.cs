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
    public partial class FormXuatHang : Form
    {
        public FormXuatHang()
        {
            InitializeComponent();
        }
        DataTable dt = null;
        ClassXuatHang xuatHang = new ClassXuatHang();
        bool Them = false;
        void loadData()
        {
            txtMaHang.ResetText();
            txtMaXH.ResetText();
            txtNgayXuat.ResetText();
            txtSLXuat.ResetText();


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
                DataSet ds = xuatHang.Show();

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
            txtMaXH.ResetText();
            txtNgayXuat.ResetText();
            txtSLXuat.ResetText();

            txtMaXH.Enabled = true;

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

                    xuatHang.Xoa(ma);
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
            txtMaXH.ResetText();
            txtNgayXuat.ResetText();
            txtSLXuat.ResetText();

            txtMaXH.Enabled = false;

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
                if (!txtMaXH.Text.Trim().Equals(""))
                {
                    try
                    {
                        xuatHang.Them(txtMaXH.Text, txtMaHang.Text, txtSLXuat.Text,
                            txtNgayXuat.Text);
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
                    txtMaXH.Focus();
                }
            }
            else
            {

                int stt = dataGridView1.CurrentCell.RowIndex;
                string ma = dataGridView1.Rows[stt].Cells[0].
                    Value.ToString();

                //Dùng để không làm thay đổi giá trị khi đổi 
                if (txtMaHang.Text.Trim().Equals(""))
                    txtMaHang.Text = dataGridView1.Rows[stt].Cells[1].Value.ToString();
                if (txtSLXuat.Text.Trim().Equals(""))
                    txtSLXuat.Text = dataGridView1.Rows[stt].Cells[2].Value.ToString();
                if (txtNgayXuat.Text.Trim().Equals(""))
                    txtNgayXuat.Text = dataGridView1.Rows[stt].Cells[3].Value.ToString();



                xuatHang.Sua(ma, txtMaHang.Text, txtSLXuat.Text,
                        txtNgayXuat.Text);
                loadData();
                MessageBox.Show("Đã sửa thành công !!");

            }
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtMaHang.ResetText();
            txtMaXH.ResetText();
            txtNgayXuat.ResetText();
            txtSLXuat.ResetText();

            txtMaXH.Enabled = true;

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
                DataSet ds = tkiem.timKiemThongTin("ChiTietXuatHang", cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }

        private void FormXuatHang_Load(object sender, EventArgs e)
        {
            loadData();
        }
    }
}
