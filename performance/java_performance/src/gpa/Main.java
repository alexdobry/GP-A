package gpa;

import java.util.Arrays;

public class Main {

	public static void main(String[] args) {
		int times = 10;
		
		floats(times);
		arrays(times);
	}
	
	private static void floats(int times) {
		if (times == 0) return;
		int n = 10000000;
		float x = 0.999999f;
		float a = 1f;
		
		
		long start = System.currentTimeMillis();
		
			
		for (int i = 0; i < n; i++) {
			a = a * x;
		}
		
		
		
		long end = System.currentTimeMillis();
		
		System.out.println((end-start)/1000. + " " + a);
		floats(times-1);
	}

	private static void arrays(int times) {
		if(times == 0)return;
		int n = 10000;
		
		int[] arr = new int[n];
		Arrays.fill(arr, 1);
		
		long start = System.currentTimeMillis();
		
			
		for (int i = 0; i < arr.length; i++) {
			for (int j = 0; j < arr.length; j++) {
				arr[i] = arr[j];
			}
		}
		
		
		
		long end = System.currentTimeMillis();
		
		System.out.println((end-start)/1000.);
		arrays(times-1);
	}
}
