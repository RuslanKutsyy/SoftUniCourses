﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace HakerRank_Arrays
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(String.Join(" ", rotLeft(new int[] { 1, 2, 3, 4, 5 }, 4)));
        }

        static int hourglassSum(int[][] arr)
        {
            int maxSum = int.MinValue;
            for (int i = 1; i < arr.Length - 1; i++)
            {
                for (int j = 1; j < arr.Length - 1; j++)
                {
                    int tempSum = arr[i - 1][j - 1] + arr[i - 1][j] + arr[i - 1][j + 1] + arr[i][j] + arr[i + 1][j - 1] + arr[i + 1][j] + arr[i + 1][j + 1];
                    if (tempSum > maxSum)
                    {
                        maxSum = tempSum;
                    }
                }
            }


            return maxSum;
        }

        static int[] rotLeft(int[] a, int d)
        {
            //solution 1
            int[] rotatedArr = new int[a.Length];
            int index = 0;

            for (int i = d; i < a.Length; i++)
            {
                rotatedArr[index] = a[i];
                index++;
            }

            for (int i = 0; i < d; i++)
            {
                rotatedArr[index] = a[i];
                index++;
            }

            return rotatedArr;

            //solution 2

            //int realRotations = d % a.Length;
            //int[] tempArr = new int[a.Length];
            //Array.Copy(a, 0, tempArr, a.Length - realRotations, realRotations);
            //Array.Copy(a, realRotations, tempArr, 0, a.Length - realRotations);

            //return tempArr;


            //solution 3

            //int realRotations = d % a.Length;
            //List<int> list = new List<int>();

            //list.AddRange(a.Skip(realRotations));
            //list.AddRange(a.Take(realRotations));

            //return list.ToArray();
        }
    }
}
