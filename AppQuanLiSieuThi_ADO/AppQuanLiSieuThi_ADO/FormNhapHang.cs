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
    public partial class FormNhapHang : Form
    {
        public FormNhapHang()
        {
            InitializeComponent();
        }

        DataTable dt = null;
        ClassNhapHang nhapHang = new ClassNhapHang();
        bool Them = false;
        void loadData()
        {
            txtMaHang.ResetText();
            txtMaNH.ResetText();
            txtNgayNhap.ResetText();
            txtSLNhap.ResetText();
            txtMaNCC.ResetText();


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
                DataSet ds = nhapHang.Show();

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
            txtMaNH.ResetText();
            txtNgayNhap.ResetText();
            txtSLNhap.ResetText();
            txtMaNCC.ResetText();

            txtMaNH.Enabled = true;

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
            txtMaHang.ResetText();
            txtMaNH.ResetText();
            txtNgayNhap.ResetText();
            txtSLNhap.ResetText();
            txtMaNCC.ResetText();

            txtMaNH.Enabled = false;

            btnLuu.Enabled = true;
            btnHuy.Enabled = true;

            panel4.Enabled = true;

            btnThem.Enabled = false;
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtMaHang.ResetText();
            txtMaNH.ResetText();
            txtNgayNhap.ResetText();
            txtSLNhap.ResetText();
            txtMaNCC.ResetText();

            txtMaNH.Enabled = true;

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

                    nhapHang.Xoa(ma);
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
                if (!txtMaNH.Text.Trim().Equals(""))
                {
                    try
                    {
                        nhapHang.Them(txtMaNH.Text, txtMaHang.Text, txtSLNhap.Text,
                            txtNgayNhap.Text, txtMaNCC.Text);
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
                    txtMaNH.Focus();
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
                    if (txtSLNhap.Text.Trim().Equals(""))
                        txtSLNhap.Text = dataGridView1.Rows[stt].Cells[2].Value.ToString();
                    if (txtNgayNhap.Text.Trim().Equals(""))
                        txtNgayNhap.Text = dataGridView1.Rows[stt].Cells[3].Value.ToString();
                    if (txtMaNCC.Text.Trim().Equals(""))
                        txtMaNCC.Text = dataGridView1.Rows[stt].Cells[4].Value.ToString();


                nhapHang.Sua(ma, txtMaHang.Text, txtSLNhap.Text,txtNgayNhap.Text, txtMaNCC.Text);
                    loadData();
                    MessageBox.Show("Đã sửa thành công !!");
               
            }
        }

        private void FormNhapHang_Load(object sender, EventArgs e)
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
                DataSet ds = tkiem.timKiemThongTin("ChiTietNhapHang", cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if(txtMaNhaCungCap.Text != "")
            {
                txtSoTien.Text = "";
                DataSet ds = nhapHang.TienCuaNCC($"{dateTimePicker1.Value.Year}-{dateTimePicker1.Value.Month}-{dateTimePicker1.Value.Day}", txtMaNhaCungCap.Text);
                DataTable dt = ds.Tables[0];
                txtSoTien.Text = String.Format("{0:0,00}", dt.Rows[0]["SoTien"]);
            }
            else
            {
                txtSoTien.Text = "";
                MessageBox.Show("Cho biết nhà cung cấp");
            }
        }
    }
}