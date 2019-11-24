﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Border_Control
{
    public class Citizen : IIdentifiable, IMammal
    {
        public int Age { get; }
        public string Id { get; }
        public string Name { get; set; }
        public string BirthdayDate { get; set; }

        public Citizen(string name, int age, string id, string birthdayDate)
        {
            this.Name = name;
            this.Age = age;
            this.Id = id;
            this.BirthdayDate = birthdayDate;
        }
    }
}
