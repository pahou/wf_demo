package com.gdth.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ReadProperties {
//	public static String yhClassName;
//	public static String gnClassName;
	public static String entitypath;
	public static void readProperties(String file){
		InputStream inputStream = Object.class.getResourceAsStream(file);  
		Properties p = new Properties();
		try {
			p.load(inputStream);
			entitypath = p.getProperty("ENTITYPATH").trim();   
//			gnClassName = p.getProperty("GNPACKAGE").trim();  
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		readProperties("/constants.properties");
		System.out.println(ReadProperties.entitypath);
	}
}
