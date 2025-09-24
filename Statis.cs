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
    public partial class Statis : Form
    {
        public Statis()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Statis statis = new Statis();
            statis.Show();
            this.Hide();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Metnum nm = new Metnum();
            nm.Show();
            this.Hide();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Persdif pdif = new Persdif();
            pdif.Show();
            this.Hide();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            NormalDistribution();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            TDistribution();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            ChiSquared();
        }

        private static void NormalDistribution()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://stattrek.com/online-calculator/normal",
                UseShellExecute = true
            });
        }
        private static void TDistribution()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://stattrek.com/online-calculator/t-distribution",
                UseShellExecute = true
            });
        }
        private static void ChiSquared()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://www.graphpad.com/quickcalcs/chisquared1/",
                UseShellExecute = true
            });
        }

    }
}
