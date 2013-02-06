namespace RGEmulator
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.searchDevices = new System.Windows.Forms.Button();
            this.connectDevices = new System.Windows.Forms.Button();
            this.devicesFound = new System.Windows.Forms.ListBox();
            this.label1 = new System.Windows.Forms.Label();
            this.startEmulator = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.label = new System.Windows.Forms.Label();
            this.label13 = new System.Windows.Forms.Label();
            this.egt1 = new System.Windows.Forms.Label();
            this.egt2 = new System.Windows.Forms.Label();
            this.egt3 = new System.Windows.Forms.Label();
            this.egt4 = new System.Windows.Forms.Label();
            this.afr = new System.Windows.Forms.Label();
            this.tach = new System.Windows.Forms.Label();
            this.voltage = new System.Windows.Forms.Label();
            this.psi3 = new System.Windows.Forms.Label();
            this.psi2 = new System.Windows.Forms.Label();
            this.psi1 = new System.Windows.Forms.Label();
            this.speed2 = new System.Windows.Forms.Label();
            this.speed1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // searchDevices
            // 
            this.searchDevices.Location = new System.Drawing.Point(742, 167);
            this.searchDevices.Name = "searchDevices";
            this.searchDevices.Size = new System.Drawing.Size(75, 23);
            this.searchDevices.TabIndex = 0;
            this.searchDevices.Text = "Search";
            this.searchDevices.UseVisualStyleBackColor = true;
            this.searchDevices.Click += new System.EventHandler(this.searchDevices_Click);
            // 
            // connectDevices
            // 
            this.connectDevices.Location = new System.Drawing.Point(690, 383);
            this.connectDevices.Name = "connectDevices";
            this.connectDevices.Size = new System.Drawing.Size(75, 23);
            this.connectDevices.TabIndex = 1;
            this.connectDevices.Text = "Connect";
            this.connectDevices.UseVisualStyleBackColor = true;
            this.connectDevices.Click += new System.EventHandler(this.connectDevices_Click);
            // 
            // devicesFound
            // 
            this.devicesFound.FormattingEnabled = true;
            this.devicesFound.Location = new System.Drawing.Point(694, 24);
            this.devicesFound.Name = "devicesFound";
            this.devicesFound.Size = new System.Drawing.Size(167, 134);
            this.devicesFound.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(738, 8);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(79, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Devices Found";
            // 
            // startEmulator
            // 
            this.startEmulator.Location = new System.Drawing.Point(12, 316);
            this.startEmulator.Name = "startEmulator";
            this.startEmulator.Size = new System.Drawing.Size(106, 23);
            this.startEmulator.TabIndex = 4;
            this.startEmulator.Text = "Start Emulator";
            this.startEmulator.UseVisualStyleBackColor = true;
            this.startEmulator.Click += new System.EventHandler(this.startEmulator_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(34, 21);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(38, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "EGT 1";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(143, 21);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(38, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "EGT 2";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(368, 21);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(38, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "EGT 4";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(259, 21);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(38, 13);
            this.label5.TabIndex = 7;
            this.label5.Text = "EGT 3";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(594, 21);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(32, 13);
            this.label6.TabIndex = 10;
            this.label6.Text = "Tach";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(485, 21);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(28, 13);
            this.label7.TabIndex = 9;
            this.label7.Text = "AFR";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(594, 167);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(43, 13);
            this.label8.TabIndex = 16;
            this.label8.Text = "Voltage";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(485, 167);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(33, 13);
            this.label9.TabIndex = 15;
            this.label9.Text = "PSI 3";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(368, 167);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(33, 13);
            this.label10.TabIndex = 14;
            this.label10.Text = "PSI 2";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(259, 167);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(33, 13);
            this.label11.TabIndex = 13;
            this.label11.Text = "PSI 1";
            // 
            // label
            // 
            this.label.AutoSize = true;
            this.label.Location = new System.Drawing.Point(143, 167);
            this.label.Name = "label";
            this.label.Size = new System.Drawing.Size(79, 13);
            this.label.TabIndex = 12;
            this.label.Text = "Speedometer 2";
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(34, 167);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(79, 13);
            this.label13.TabIndex = 11;
            this.label13.Text = "Speedometer 1";
            // 
            // egt1
            // 
            this.egt1.AutoSize = true;
            this.egt1.Location = new System.Drawing.Point(34, 56);
            this.egt1.Name = "egt1";
            this.egt1.Size = new System.Drawing.Size(41, 13);
            this.egt1.TabIndex = 17;
            this.egt1.Text = "label14";
            // 
            // egt2
            // 
            this.egt2.AutoSize = true;
            this.egt2.Location = new System.Drawing.Point(143, 56);
            this.egt2.Name = "egt2";
            this.egt2.Size = new System.Drawing.Size(41, 13);
            this.egt2.TabIndex = 18;
            this.egt2.Text = "label15";
            // 
            // egt3
            // 
            this.egt3.AutoSize = true;
            this.egt3.Location = new System.Drawing.Point(259, 56);
            this.egt3.Name = "egt3";
            this.egt3.Size = new System.Drawing.Size(41, 13);
            this.egt3.TabIndex = 19;
            this.egt3.Text = "label16";
            // 
            // egt4
            // 
            this.egt4.AutoSize = true;
            this.egt4.Location = new System.Drawing.Point(365, 56);
            this.egt4.Name = "egt4";
            this.egt4.Size = new System.Drawing.Size(41, 13);
            this.egt4.TabIndex = 20;
            this.egt4.Text = "label17";
            // 
            // afr
            // 
            this.afr.AutoSize = true;
            this.afr.Location = new System.Drawing.Point(485, 56);
            this.afr.Name = "afr";
            this.afr.Size = new System.Drawing.Size(41, 13);
            this.afr.TabIndex = 21;
            this.afr.Text = "label18";
            // 
            // tach
            // 
            this.tach.AutoSize = true;
            this.tach.Location = new System.Drawing.Point(594, 56);
            this.tach.Name = "tach";
            this.tach.Size = new System.Drawing.Size(41, 13);
            this.tach.TabIndex = 22;
            this.tach.Text = "label19";
            // 
            // voltage
            // 
            this.voltage.AutoSize = true;
            this.voltage.Location = new System.Drawing.Point(594, 206);
            this.voltage.Name = "voltage";
            this.voltage.Size = new System.Drawing.Size(41, 13);
            this.voltage.TabIndex = 28;
            this.voltage.Text = "label20";
            // 
            // psi3
            // 
            this.psi3.AutoSize = true;
            this.psi3.Location = new System.Drawing.Point(485, 206);
            this.psi3.Name = "psi3";
            this.psi3.Size = new System.Drawing.Size(41, 13);
            this.psi3.TabIndex = 27;
            this.psi3.Text = "label21";
            // 
            // psi2
            // 
            this.psi2.AutoSize = true;
            this.psi2.Location = new System.Drawing.Point(365, 206);
            this.psi2.Name = "psi2";
            this.psi2.Size = new System.Drawing.Size(41, 13);
            this.psi2.TabIndex = 26;
            this.psi2.Text = "label22";
            // 
            // psi1
            // 
            this.psi1.AutoSize = true;
            this.psi1.Location = new System.Drawing.Point(259, 206);
            this.psi1.Name = "psi1";
            this.psi1.Size = new System.Drawing.Size(41, 13);
            this.psi1.TabIndex = 25;
            this.psi1.Text = "label23";
            // 
            // speed2
            // 
            this.speed2.AutoSize = true;
            this.speed2.Location = new System.Drawing.Point(143, 206);
            this.speed2.Name = "speed2";
            this.speed2.Size = new System.Drawing.Size(41, 13);
            this.speed2.TabIndex = 24;
            this.speed2.Text = "label24";
            // 
            // speed1
            // 
            this.speed1.AutoSize = true;
            this.speed1.Location = new System.Drawing.Point(34, 206);
            this.speed1.Name = "speed1";
            this.speed1.Size = new System.Drawing.Size(41, 13);
            this.speed1.TabIndex = 23;
            this.speed1.Text = "label25";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(874, 421);
            this.Controls.Add(this.voltage);
            this.Controls.Add(this.psi3);
            this.Controls.Add(this.psi2);
            this.Controls.Add(this.psi1);
            this.Controls.Add(this.speed2);
            this.Controls.Add(this.speed1);
            this.Controls.Add(this.tach);
            this.Controls.Add(this.afr);
            this.Controls.Add(this.egt4);
            this.Controls.Add(this.egt3);
            this.Controls.Add(this.egt2);
            this.Controls.Add(this.egt1);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.label);
            this.Controls.Add(this.label13);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.startEmulator);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.devicesFound);
            this.Controls.Add(this.connectDevices);
            this.Controls.Add(this.searchDevices);
            this.Name = "Form1";
            this.Text = "Redline Guages Emulator";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button searchDevices;
        private System.Windows.Forms.Button connectDevices;
        private System.Windows.Forms.ListBox devicesFound;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button startEmulator;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.Label egt1;
        private System.Windows.Forms.Label egt2;
        private System.Windows.Forms.Label egt3;
        private System.Windows.Forms.Label egt4;
        private System.Windows.Forms.Label afr;
        private System.Windows.Forms.Label tach;
        private System.Windows.Forms.Label voltage;
        private System.Windows.Forms.Label psi3;
        private System.Windows.Forms.Label psi2;
        private System.Windows.Forms.Label psi1;
        private System.Windows.Forms.Label speed2;
        private System.Windows.Forms.Label speed1;
    }
}

