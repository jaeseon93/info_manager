package co.yedam.ic.common;

import java.io.*;
import java.net.URL;
import java.util.HashMap;

public class ConfigReader{

	static ConfigReader instance;

	public static ConfigReader getInstance(){
		if( instance == null){
			instance = new ConfigReader();
		}
		return instance;
	}

	public HashMap<String, String> ReadConfig(String fileName) throws IOException{

		HashMap<String, String> map = new HashMap<String, String>();
		File file = getFileFromResources("./config/"+fileName);

		String line;
		BufferedReader reader = new BufferedReader(new FileReader(file));
		while ((line = reader.readLine()) != null)
		{
			String[] parts = line.split("=", 2);
			if (parts.length >= 2)
			{
				String key = parts[0].trim();
				String value = parts[1].trim();

				map.put(key, value);
			} else {
				System.out.println("ignoring line: " + line);
			}
		}

		reader.close();

		return map;
	}

	private File getFileFromResources(String fileName) {

		ClassLoader classLoader = getClass().getClassLoader();
		URL resource = classLoader.getResource(fileName);
		if (resource == null) {
			throw new IllegalArgumentException("file is not found!");
		} else {
			return new File(resource.getFile());
		}

	}

	private static void printFile(File file) throws IOException {

		if (file == null) return;

		try (FileReader reader = new FileReader(file);
			 BufferedReader br = new BufferedReader(reader)) {

			String line;
			while ((line = br.readLine()) != null) {
				System.out.println(line);
			}
		}
	}

}
