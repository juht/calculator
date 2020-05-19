package com.juht.calculator;
import org.springframework.stereotype.Service;

/**
 * This is a JavaDoc Comment for Calculator class
 */

@Service
public class Calculator {
	int sum(int a, int b) {
		return a + b;
	}
	int sub(int a, int b) {
		return a - b;
	}
}
