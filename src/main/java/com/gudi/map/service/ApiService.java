package com.gudi.map.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class ApiService {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> apiCall(HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		
		String key = "eaec4d61845289e22fbb5441ec3f7084";
		String url = "https://api.openweathermap.org/data/2.5/weather";
		String param = "lat=" + params.get("lat") + "&lon=" + params.get("lon") + "&appid=" + key + "&units=metric";
		
		ArrayList<String> urls = new ArrayList<String>();
		urls.add(url);
		String result = sendMsg(urls, null, param, "GET");
		logger.info("result : {}", result);
		
		if(!result.contains("Fail")) {
			success = true;
			ObjectMapper mapper = new ObjectMapper();
			try {
				map = mapper.readValue(result, new TypeReference<HashMap <String, Object>>() {});//문자열을 무엇으로 변환할 것 인지?
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
		map.put("success", success);
		
		ArrayList<HashMap<String,Object>> list = (ArrayList<HashMap<String, Object>>) map.get("data");
		
		return map;
	}

	/*
	 * 요청한 내용을 다른 서버로 전송하여 결과값을 받아오는 메소드 작성자 : 노의건 작성일 : 2021-08-31
	 * 
	 * @param urls ArrayList<String>
	 * 
	 * @param header HashMap<String,String>
	 * 
	 * @param params String
	 * 
	 * @param method String
	 * 
	 * @return 전송 결과 값 : String
	 */
	public String sendMsg(ArrayList<String> urls, HashMap<String, String> header, String params, String method) {

		StringBuffer sb = new StringBuffer();
		String result = "";
		HttpURLConnection con = null;
		BufferedReader reader = null;

		// 파라미터가 있고 GET방식으로 왔다면
		if (method.toUpperCase().equals("GET") && params != null) {
			urls.add("?" + params);// URL 뒤에 ?와 파라미터를 붙임
		}

		for (String url : urls) {// arrayList에 있는 url을 하나씩 꺼내서
			sb.append(url);// StringBuffer에 붙임(객체 낭비를 막을 수 있음)
			// String url += url 방식으로 해도됨
		}

		try {
			URL url = new URL(sb.toString());// Buffer->String->URL
			con = (HttpURLConnection) url.openConnection();// 해당 서버와 연결
			con.setRequestMethod(method.toUpperCase());// 어떤 메소드로 전송하는지 GET or POST
			con.setDoOutput(true);// 결과 값을 받아야 하는지

			if (header != null && header.size() > 0) {// 헤더 값이 있는지?
				for (String key : header.keySet()) {// 있는 만큼 헤더 값을 넣어줌
					con.setRequestProperty(key, header.get(key));
				}
			}

			// body값이 있는지 (파라미터가 post로 body에 담겨온다)
			if (method.toUpperCase().equals("POST") && params != null) {
				con.getOutputStream().write(params.getBytes("UTF-8"));
				con.getOutputStream().flush();
			} 

			int resultCode = con.getResponseCode();// 200이 나오면 성공
			logger.info("code : {}", resultCode);

			if (resultCode == 200) {// 성공
				reader = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			} else {// 실패
				reader = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			}

			String readLine = "";
			sb = new StringBuffer();

			while ((readLine = reader.readLine()) != null) {
				sb.append(readLine);
			}

			result = sb.toString();

			if (resultCode != 200) {
				logger.info("Fail Message : " + result);
				result = "Fail Message : " + result;
			}

		} catch (Exception e) {
			e.printStackTrace();
			result = "Exception Message : " + e.toString();
		} finally {
			try {
				if (con != null) {
					con.disconnect();
				}
				if (reader != null) {
					reader.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	/*
	//실시간 정보 위젯
	public HashMap<String, Object> apiCalls(HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		
		String key = "eaec4d61845289e22fbb5441ec3f7084";
		String url = "https://api.openweathermap.org/data/2.5/weather";
		String param = "lat=" + params.get("lat") + "&lon=" + params.get("lon") + "&appid=" + key + "&units=metric";
		
		ArrayList<String> urls = new ArrayList<String>();
		urls.add(url);
		String result = sendMsgs(urls, null, param, "GET");
		logger.info("result : {}", result);
		
		if(!result.contains("Fail")) {
			success = true;
			ObjectMapper mapper = new ObjectMapper();
			try {
				map = mapper.readValue(result, new TypeReference<HashMap <String, Object>>() {});//문자열을 무엇으로 변환할 것 인지?
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
		map.put("success", success);
		
		ArrayList<HashMap<String,Object>> list = (ArrayList<HashMap<String, Object>>) map.get("data");
		
		return map;
	}
     
	//실시간 정보 위젯
	public String sendMsgs(ArrayList<String> urls, HashMap<String, String> header, String params, String method) {

		StringBuffer sb = new StringBuffer();
		String result = "";
		HttpURLConnection con = null;
		BufferedReader reader = null;

		// 파라미터가 있고 GET방식으로 왔다면
		if (method.toUpperCase().equals("POST") && params != null) {
			urls.add("?" + params);// URL 뒤에 ?와 파라미터를 붙임
		}

		for (String url : urls) {// arrayList에 있는 url을 하나씩 꺼내서
			sb.append(url);// StringBuffer에 붙임(객체 낭비를 막을 수 있음)
			// String url += url 방식으로 해도됨
		}

		try {
			URL url = new URL(sb.toString());// Buffer->String->URL
			con = (HttpURLConnection) url.openConnection();// 해당 서버와 연결
			con.setRequestMethod(method.toUpperCase());// 어떤 메소드로 전송하는지 GET or POST
			con.setDoOutput(true);// 결과 값을 받아야 하는지

			if (header != null && header.size() > 0) {// 헤더 값이 있는지?
				for (String key : header.keySet()) {// 있는 만큼 헤더 값을 넣어줌
					con.setRequestProperty(key, header.get(key));
				}
			}

			// body값이 있는지 (파라미터가 post로 body에 담겨온다)
			if (method.toUpperCase().equals("GET") && params != null) {
				con.getOutputStream().write(params.getBytes("UTF-8"));
				con.getOutputStream().flush();
			} 

			int resultCode = con.getResponseCode();// 200이 나오면 성공
			logger.info("code : {}", resultCode);

			if (resultCode == 200) {// 성공
				reader = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			} else {// 실패
				reader = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			}

			String readLine = "";
			sb = new StringBuffer();

			while ((readLine = reader.readLine()) != null) {
				sb.append(readLine);
			}

			result = sb.toString();

			if (resultCode != 200) {
				logger.info("Fail Message : " + result);
				result = "Fail Message : " + result;
			}

		} catch (Exception e) {
			e.printStackTrace();
			result = "Exception Message : " + e.toString();
		} finally {
			try {
				if (con != null) {
					con.disconnect();
				}
				if (reader != null) {
					reader.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
	*/
}
