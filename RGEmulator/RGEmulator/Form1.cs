using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using InTheHand.Net; // e.g. BluetoothAddress, BluetoothEndPoint etc
using InTheHand.Net.Sockets; // e.g. BluetoothDeviceInfo, BluetoothClient, BluetoothListener
using InTheHand.Net.Bluetooth; // e.g. BluetoothService, BluetoothRadio

namespace RGEmulator
{
    public partial class Form1 : Form
    {
        BluetoothDeviceInfo[] devices = null;
        int[] sensors = new int[12];
        Random random = new Random();
        Thread doWork;

        public Form1()
        {
            InitializeComponent();
        }

        private void searchDevices_Click(object sender, EventArgs e)
        {
            devicesFound.Items.Clear(); 
            devicesFound.Refresh();
            
            BluetoothClient bc = new BluetoothClient();
            devices = bc.DiscoverDevices(8);
            foreach (BluetoothDeviceInfo i in devices)
            {
                devicesFound.Items.Add(i.DeviceName);
            }

            if (devices.Length == 0)
            {
                devicesFound.Items.Add("No Devices Found");
            }
        }

        private void connectDevices_Click(object sender, EventArgs e)
        {
            string selectedDeviceName = devicesFound.SelectedItem.ToString();
          
            foreach (BluetoothDeviceInfo i in devices)
            {
                if (i.DeviceName == selectedDeviceName)
                {
                  
                }
            }
        }

        private void startEmulator_Click(object sender, EventArgs e)
        {
            doWork = new Thread(backgroundWorker);
            doWork.Start();
        }

        private void backgroundWorker()
        {
            initSensors();
            updateDisplay();
            System.Threading.Thread.Sleep(125);
            while (true)
            {
                DateTime start = DateTime.Now;

                getNewValues();
                updateDisplay();
                //sendDataBluetooth();

                TimeSpan duration = DateTime.Now - start;

                int sleep = 125 - (duration.Milliseconds);
                try
                {
                    System.Threading.Thread.Sleep(sleep);
                }
                catch
                {
                    //fail silently
                }
            }
        }
        private void updateDisplay()
        {

            this.Invoke(new MethodInvoker(delegate
            {
                // Execute the following code on the GUI thread.
                egt1.Text = sensors[0].ToString();
                egt2.Text = sensors[1].ToString();
                egt3.Text = sensors[2].ToString();
                egt4.Text = sensors[3].ToString();
                afr.Text = sensors[4].ToString();
                tach.Text = sensors[5].ToString();
                speed1.Text = sensors[6].ToString();
                speed2.Text = sensors[7].ToString();
                psi1.Text = sensors[8].ToString();
                psi2.Text = sensors[9].ToString();
                psi3.Text = sensors[10].ToString();
                voltage.Text = sensors[11].ToString();
            this.Refresh();
            }));
        }
        private void getNewValues()
        {
            for (int i = 0; i < sensors.Length; i++)
            {
                int sensorValue = sensors[i];

                double offsetPercentage = random.Next(-20,20);
                double offset = sensorValue * (offsetPercentage / 100);
                sensorValue = sensorValue + Convert.ToInt16(offset);

                if (i < 8) //sensors 0-9
                {
                    if (sensorValue < 10) //if sensor gets too low, jump back up
                    {
                        sensorValue = sensorValue * 10;
                    }
                }
                sensors[i] = sensorValue;
            }
        }
        private void initSensors()
        {
            for (int i = 0; i < sensors.Length; i++)
            {
                int number = 0;

                switch (i)
                {
                    case 0: number = random.Next(1, 4000); break;
                    case 1: number = random.Next(1, 4000); break;
                    case 2: number = random.Next(1, 4000); break;
                    case 3: number = random.Next(1, 4000); break;
                    case 4: number = random.Next(1, 5); break;
                    case 5: number = random.Next(1, 6000); break;
                    case 6: number = random.Next(1, 200); break;
                    case 7: number = random.Next(1, 200); break;
                    case 8: number = random.Next(1, 20); break;
                    case 9: number = random.Next(1, 20); break;
                    case 10: number = random.Next(1, 20); break;
                    case 11: number = random.Next(1, 5); break;
                }
                sensors[i] = number;
            }
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (doWork.IsAlive)
            {
                doWork.Abort();
            }
        }
    }
}
