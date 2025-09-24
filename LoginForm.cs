using System.Diagnostics;

namespace CombiCalcs
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            LoginAppCombCalcs();
        }

        private void LoginAppCombCalcs()
        {
            if (textBox1.Text == "DevanWestley" && textBox2.Text == "********")
            {
                Persdif pdif = new Persdif();
                pdif.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Macam tak betul budak ni");
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
