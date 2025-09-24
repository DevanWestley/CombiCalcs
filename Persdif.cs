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
    public partial class Persdif : Form
    {
        public Persdif()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ExponentialMatrixCalculator();
        }


        private void button2_Click(object sender, EventArgs e)
        {
            EigenvalueDecompotition();
        }


        private void button3_Click(object sender, EventArgs e)
        {
            DifferentialEquationSolver();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            SlopeFieldGrapher();
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

        private void button7_Click(object sender, EventArgs e)
        {
            Statis statis = new Statis();
            statis.Show();
            this.Hide();
        }

        private static void ExponentialMatrixCalculator()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://www.emathhelp.net/calculators/linear-algebra/matrix-exponential-calculator/",
                UseShellExecute = true
            });
        }

        private static void EigenvalueDecompotition()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://www.emathhelp.net/calculators/linear-algebra/eigenvalue-and-eigenvector-calculator/",
                UseShellExecute = true
            });
        }

        private static void DifferentialEquationSolver()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://www.wolframalpha.com/xamples/mathematics/differential-equations",
                UseShellExecute = true
            });
        }

        private static void SlopeFieldGrapher()
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "https://www.emathhelp.net/calculators/linear-algebra/matrix-exponential-calculator/",
                UseShellExecute = true
            });
        }

    }
}
