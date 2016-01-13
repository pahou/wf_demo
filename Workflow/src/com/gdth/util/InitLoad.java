package com.gdth.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class InitLoad {
	public static Properties properties = new Properties();

	private static final Logger logger = LogManager.getLogger();

	static {
		try {
			properties.load(InitLoad.class.getResourceAsStream("/configpath.properties"));

		} catch (FileNotFoundException e) {
			logger.catching(e);
		} catch (IOException e) {
			logger.catching(e);
		}

	}

	// public static String changeCharset(String str, String oldCharset,
	// String newCharset) throws UnsupportedEncodingException
	// {
	// if (str != null)
	// {
	// // 用旧的字符编码解码字符串。解码可能会出现异常。
	// byte[] bs = null;
	// if (oldCharset != null)
	// {
	// bs = str.getBytes(oldCharset);
	// }
	// else
	// {
	// bs = str.getBytes();
	// }
	// // 用新的字符编码生成字符串
	// return new String(bs, newCharset);
	// }
	// return null;
	// }
	//
	// public static String getFilePath(String fileName)
	// {
	// try
	// {
	// return new ClassPathResource(fileName).getURI().getPath();
	// }
	// catch (Exception e)
	// {
	// e.printStackTrace();
	// }
	// throw new IllegalArgumentException("get file :" + fileName +
	// " fail.....");
	//
	// }

}
