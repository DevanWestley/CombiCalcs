using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CombiCalcs
{
    public partial class Metnum : Form
    {
        public Metnum()
        {
            InitializeComponent();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Persdif pdif = new Persdif();
            pdif.Show();
            this.Hide();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Metnum nm = new Metnum();
            nm.Show();
            this.Hide();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Statis statis = new Statis();
            statis.Show();
            this.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            LinerRegression();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            RungeKutta2();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            RungeKutta4();
        }
        private static void LinerRegression()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://www.graphpad.com/quickcalcs/linear1/",
                UseShellExecute = true
            });
        }
        private static void RungeKutta2()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://atozmath.com/CONM/RungeKutta.aspx?q=rk2&m=2",
                UseShellExecute = true
            });
        }

        private static void RungeKutta4()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://www.emathhelp.net/calculators/differential-equations/fourth-order-runge-kutta-method-calculator/\r\n",
                UseShellExecute = true
            });
        }

    }
}
