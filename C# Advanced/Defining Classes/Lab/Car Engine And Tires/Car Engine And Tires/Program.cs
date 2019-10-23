﻿using System;
using System.Collections.Generic;
using System.Linq;

namespace CarManufacturer
{
    public class Car
    {
        private string make;
        private string model;
        private int year;
        private double fuelQuantity;
        private double fuelConsumption;
        private Engine engine;
        private Tire[] tires;

        public string Make
        {
            get { return this.make; }
            set { this.make = value; }
        }
        public string Model
        {
            get { return this.model; }
            set { this.model = value; }
        }
        public int Year
        {
            get { return this.year; }
            set { this.year = value; }
        }
        public double FuelQuantity
        {
            get { return this.fuelQuantity; }
            set { this.fuelQuantity = value; }
        }
        public double FuelConsumption
        {
            get { return this.fuelConsumption; }
            set { this.fuelConsumption = value; }
        }

        public Tire[] Tires
        {
            get { return this.tires; }
            set { this.tires = value; }
        }

        public Engine Engine
        {
            get { return this.engine; }
            set { this.engine = value; }
        }

        public Car(string make, string model, int year, double fuelQuantity, double fuelConsumption, Engine engine, Tire[] tires) : this(make, model, year, fuelQuantity, fuelConsumption)
        {
            this.Engine = engine;
            this.Tires = tires;
        }

        public void Drive(double distance)
        {
            double fuelQNeeded = FuelQuantity - distance * this.FuelConsumption;
            if (fuelQNeeded >= FuelQuantity)
            {
                Console.WriteLine("Not enough fuel to perform this trip!");
            }
            else
            {
                FuelQuantity -= fuelQNeeded;
            }
        }

        public string WhoAmI()
        {
            string text = $"Make: {this.Make}\nModel: {this.Model}\nYear: {this.Year}\nFuel: {this.FuelQuantity:F2}L";
            return text;
        }

        public Car()
        {
            this.Make = "VW";
            this.Model = "Golf";
            this.Year = 2025;
            this.FuelQuantity = 200;
            this.FuelConsumption = 10;
        }

        public Car(string make, string model, int year) : this()
        {
            this.Make = make;
            this.model = model;
            this.Year = year;
        }

        public Car(string make, string model, int year, double fuelQuantity, double fuelConsumption) : this(make, model, year)
        {
            this.FuelQuantity = fuelQuantity;
            this.FuelConsumption = fuelConsumption;
        }
    }

    public class Engine
    {
        private int horsePower;
        private double cubicCapacity;

        public int HorsePower
        {
            get { return this.horsePower; }
            set { this.horsePower = value; }
        }

        public double CubicCapacity
        {
            get { return this.cubicCapacity; }
            set { this.cubicCapacity = value; }
        }

        public Engine(int horsePower, double cubicCapacity)
        {
            this.HorsePower = horsePower;
            this.CubicCapacity = cubicCapacity;
        }
    }

    public class Tire
    {
        private int year;
        private double pressure;

        public int Year
        {
            get { return this.year; }
            set { this.year = value; }
        }

        public double Pressure
        {
            get { return this.pressure; }
            set { this.pressure = value; }
        }

        public Tire(int year, double pressure)
        {
            this.Year = year;
            this.Pressure = pressure;
        }
    }

    public class StartUp
    {
        static void Main(string[] args)
        {
            string data = Console.ReadLine();
            List<Tire[]> tires = new List<Tire[]>();
            int count = 0;

            while (data != "No more tires")
            {
                count++;
                var tiresInfo = data.Split().ToArray();
                var tireExamples = new Tire[4];
                for (int i = 0; i < tireExamples.Length; i++)
                {
                    var tempList = new List<Tire>();
                    for (int j = 0; j < tiresInfo.Length; j+=2)
                    {
                        int yearInfo = int.Parse(tiresInfo[j]);
                        double pressureInfo = double.Parse(tiresInfo[j]);

                        tempList.Add(new Tire(yearInfo, pressureInfo));
                    }
                }

                tires.Add(tireExamples);
                data = Console.ReadLine();
            }



            List<Engine> engines = new List<Engine>();
            string command = Console.ReadLine();

            while (command != "Engines done")
            {
                var parts = command.Split().ToArray();
                int horsePower = int.Parse(parts[0]);
                double cubicCapacity = double.Parse(parts[1]);
                engines.Add(new Engine(horsePower, cubicCapacity));
                command = Console.ReadLine();
            }
            engines.ToArray();

            string showSpecial = Console.ReadLine();

            while (showSpecial != "Show special")
            {
                var parts = showSpecial.Split().ToArray();
                string make = parts[0];
                string model = parts[1];
                int year = int.Parse(parts[2]);
                double fuelQuantity = double.Parse(parts[3]);
                double fuelConsumption = double.Parse(parts[4]);
                int engineIndex = int.Parse(parts[5]);
                int tiresIndex = int.Parse(parts[6]);

                Car car = new Car(make, model, year, fuelQuantity, fuelConsumption, engines[engineIndex], tires);
                showSpecial = Console.ReadLine();
            }
        }
    }
}