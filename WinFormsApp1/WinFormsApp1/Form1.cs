using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string userName = textBox2.Text;
            string userPass = textBox3.Text;
            string dbServer = textBox1.Text;
            string dbName = "p4g8";
            TestDBConnection(dbServer, dbName, userName, userPass);
        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            string userName = textBox2.Text;
            string userPass = textBox3.Text;
            string dbServer = textBox1.Text;
            string dbName = "p4g8";
            SqlConnection CN = new SqlConnection("Data Source = " + dbServer + ";" + "Initial Catalog = " + dbName + "; uid = " + userName + ";" + "password = " + userPass);
            string conteudo = GetTableContent(CN);
            MessageBox.Show(conteudo);
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            var userName = textBox2.Text;
        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            var userPass = textBox3.Text;
        }
        private void TestDBConnection(string dbServer, string dbName, string userName, string userPass)
        {
            SqlConnection CN = new SqlConnection("Data Source = " + dbServer + ";"
           + "Initial Catalog = " + dbName + "; uid = " + userName + ";" + "password = " + userPass);

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    MessageBox.Show("Successful connection to database " + CN.Database + " on the "
                   + CN.DataSource + " server", "Connection Test", MessageBoxButtons.OK);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to open connection to database due to the error \r\n" +
               ex.Message, "Connection Test", MessageBoxButtons.OK);
            }
            if (CN.State == ConnectionState.Open)
                CN.Close();
        }
        private string GetTableContent(SqlConnection CN)
        {
            string str = "";

            try
            {
                CN.Open();
                if (CN.State == ConnectionState.Open)
                {
                    int cnt = 1;
                    SqlCommand sqlcmd = new SqlCommand("SELECT * FROM Hello", CN);
                    SqlDataReader reader;
                    reader = sqlcmd.ExecuteReader();
                    while (reader.Read())
                    {
                        str += cnt.ToString() + " - " + reader.GetInt32(reader.GetOrdinal("MsgID")) +
                       ", ";
                        str += reader.GetString(reader.GetOrdinal("MsgSubject"));
                        str += "\n";
                        cnt += 1;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(" Failed to open connection to database due to the error \r\n" +
               ex.Message, "Connection Error", MessageBoxButtons.OK);
            }
            if (CN.State == ConnectionState.Open)
                CN.Close();
            return str;
        }
    }
}
