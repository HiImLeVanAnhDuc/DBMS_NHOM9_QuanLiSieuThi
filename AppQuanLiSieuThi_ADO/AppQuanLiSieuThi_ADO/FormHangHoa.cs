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
    public partial class FormHangHoa : Form
    {
        private string tendangnhap;
        private string matkhau;
        ClassHangHoa hh = null;
        public FormHangHoa(string tendangnhap, string matkhau)
        {
            InitializeComponent();
            this.tendangnhap = tendangnhap;
            this.matkhau = matkhau;
            hh = new ClassHangHoa(tendangnhap, matkhau);
        }
        DataTable dt = null;
        bool Them = false;
        void loadData()
        {
            txtGia.ResetText();
            txtLoaiHang.ResetText();
            txtMaHang.ResetText();
            txtSLKho.ResetText();
            txtTenHang.ResetText();

            btnLuu.Enabled = false;
            btnHuy.Enabled = false;
            
            panel4.Enabled = false;

            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
            // Mói thêm vào để có tính logic cho dữ liệu
            
            try
            {
                dt = new DataTable();
                dt.Clear();
                DataSet ds = hh.Show();

                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            catch (SqlException e)
            {
                MessageBox.Show(e.ToString());
            }
        }
        void loadDataHangSapHet()
        {
            txtGia.ResetText();
            txtLoaiHang.ResetText();
            txtMaHang.ResetText();
            txtSLKho.ResetText();
            txtTenHang.ResetText();

            btnLuu.Enabled = false;
            btnHuy.Enabled = false;

            panel4.Enabled = false;

            btnThem.Enabled = true;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
            // Mói thêm vào để có tính logic cho dữ liệu

            try
            {
                dt = new DataTable();
                dt.Clear();
                DataSet ds = hh.ShowHangSapHet();

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
            txtGia.ResetText();
            txtLoaiHang.ResetText();
            txtMaHang.ResetText();
            txtSLKho.ResetText();
            txtTenHang.ResetText();

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

                    hh.Xoa(ma);
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
            txtGia.ResetText();
            txtLoaiHang.ResetText();
            txtMaHang.ResetText();
            txtSLKho.ResetText();
            txtTenHang.ResetText();


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
                        hh.Them(txtMaHang.Text, txtTenHang.Text, txtGia.Text,
                            txtSLKho.Text, txtLoaiHang.Text);
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
                try
                {
                    int stt = dataGridView1.CurrentCell.RowIndex;
                    string ma = dataGridView1.Rows[stt].Cells[0].
                        Value.ToString();

                    //Dùng để không làm thay đổi giá trị khi đổi 
                    if (txtTenHang.Text.Trim().Equals(""))
                        txtTenHang.Text = dataGridView1.Rows[stt].Cells[1].Value.ToString();
                    if (txtGia.Text.Trim().Equals(""))
                        txtGia.Text = dataGridView1.Rows[stt].Cells[2].Value.ToString();
                    if (txtSLKho.Text.Trim().Equals(""))
                        txtSLKho.Text = dataGridView1.Rows[stt].Cells[3].Value.ToString();
                    if (txtLoaiHang.Text.Trim().Equals(""))
                        txtLoaiHang.Text = dataGridView1.Rows[stt].Cells[4].Value.ToString();


                    hh.Sua(ma, txtTenHang.Text, txtGia.Text,
                        txtSLKho.Text, txtLoaiHang.Text);
                    loadData();
                    MessageBox.Show("Đã sửa thành công !!");
                }
                catch (SqlException)
                {
                    MessageBox.Show("Không thể sửa !!");
                }
            }        
        }

        private void FormHangHoa_Load(object sender, EventArgs e)
        {
            loadData();
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtGia.ResetText();
            txtLoaiHang.ResetText();
            txtMaHang.ResetText();
            txtSLKho.ResetText();
            txtTenHang.ResetText();

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
            ClassTimKiemTheoYeuCau tkiem = new ClassTimKiemTheoYeuCau(tendangnhap, matkhau);
            dt = new DataTable();
            dt.Clear();
            if (cbxThuocTinh.Text != "All")
            {
                DataSet ds = tkiem.timKiemThongTin("HangHoa",cbxThuocTinh.Text, txtYeuCau.Text.Trim());
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
                loadData();
        }

        private void btnTTNCC_Click(object sender, EventArgs e)
        {
            FormNhaCungCap ncc = new FormNhaCungCap();
            ncc.Show();
        }

        private void btnLoad_Click(object sender, EventArgs e)
        {
            loadData();
        }

        private void btnTTNhapHang_Click(object sender, EventArgs e)
        {
            FormNhapHang obj = new FormNhapHang();
            obj.Show();
        }

        private void btnTTLoaiHang_Click(object sender, EventArgs e)
        {
            FormLoaiHang lh = new FormLoaiHang(tendangnhap,matkhau);
            lh.Show();
        }

        private void btnTTXuatHang_Click(object sender, EventArgs e)
        {
            FormXuatHang xh = new FormXuatHang();
            xh.Show();
        }

        private void btnTTHangLoi_Click(object sender, EventArgs e)
        {
            FormHangLoi hl = new FormHangLoi();
            hl.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            loadDataHangSapHet();
        }

        private void cb_Show_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_Show.SelectedIndex == 0 )
            {
                DataSet ds = hh.Show();
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
            else
            {
                DataSet ds = hh.ShowHangSapHet();
                dt = ds.Tables[0];
                dataGridView1.DataSource = dt;
            }
        }
    }
}
