﻿using System;

namespace CustomStack
{
    public class StartUp
    {
        static void Main(string[] args)
        {
            StackOfStrings newStack = new StackOfStrings();
            Console.WriteLine(newStack.IsEmpty());
        }
    }
}
