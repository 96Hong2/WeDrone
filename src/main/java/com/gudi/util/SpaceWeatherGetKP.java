package com.gudi.util;

import java.io.IOException;
import java.net.SocketTimeoutException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
/**
 * 
{
   "error":false,
   "lastUpdate":"1632305940000",
   "errorCode":"NOERR",
   "kindex":{
      "time":"2021-09-22 07:19:48",
      "currentP":4,
      "currentK":5,
      "max24P":4,
      "max24K":5,
      "recent":[
         {
            "time":"2021-09-22 09:00:00",
            "kp":4,
            "kk":5
         },
         {
            "time":"2021-09-22 06:00:00",
            "kp":2,
            "kk":2
         },
         {
            "time":"2021-09-22 03:00:00",
            "kp":4,
            "kk":3
         },
         {
            "time":"2021-09-22 00:00:00",
            "kp":3,
            "kk":3
         },
         {
            "time":"2021-09-21 21:00:00",
            "kp":2,
            "kk":3
         },
         {
            "time":"2021-09-21 18:00:00",
            "kp":3,
            "kk":4
         },
         {
            "time":"2021-09-21 15:00:00",
            "kp":1,
            "kk":2
         },
         {
            "time":"2021-09-21 12:00:00",
            "kp":1,
            "kk":1
         }
      ]
   }
}


 *
 */
/*
 * json 파싱

1)JsonParser parser = new JsonParser();

2)String json = gson.toJson(객체);

3)JsonElement element = parser.parse(json);

4)JsonObject object = element.getAsJsonObject();

5)JsonArray array = object.get("key").getAsJsonArray(); (object 안에 json array 가 존재하는 경우)
 * 
 * 
 */

public class SpaceWeatherGetKP {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private final String url = "http://spaceweather.rra.go.kr/api/kindex";

	private static final SpaceWeatherGetKP instance=new SpaceWeatherGetKP();
	
	private SpaceWeatherGetKP() {}
	
	public static SpaceWeatherGetKP getInstance() {	
		return instance;
	}
	
	
	public static void main(String[] args) {
		SpaceWeatherGetKP customParsing = SpaceWeatherGetKP.getInstance();
		try {
			//System.out.println(customXmlParsing.getData().toString());	
			//json 포멧을 이해할수 있게 파싱
			SpaceWeatherDTO dto=customParsing.getDataParsing();
			Map<String, String> map=new HashMap<String, String>();
			map=customParsing.getRecentData(map, dto);
			//System.out.println("최근 시간 :" +map.get("time"));
			System.out.println("최근 kp지수 :" +map.get("kp"));
			
			//전체 출력
			//if(dto.getRecent() !=null && dto.getRecent().size()>0) {			
				//for(int i=0; i<dto.getRecent().size(); i++) {
				//	System.out.println(dto.getRecent().get(i).toString());
				//}
				
				//지구 자기장 api 가장 최근 데이터를 가져온다.
				//System.out.println(dto.getRecent().get(0).toString());
			//}
					
		} catch (SocketTimeoutException e) {
			e.printStackTrace();
		}
		//System.out.println("종료");
	}

	//Recent 최금 측정값 목록
	//지구 자기장 api 가장 최근 데이터를 map 에 넣는다.
	public Map<String, String> getRecentData(Map<String, String> map, SpaceWeatherDTO dto){	
		if(dto.getRecent() !=null && dto.getRecent().size()>0 && dto.getRecent().get(0)!=null) {			
			map.put("time", dto.getRecent().get(0).getSubTime());
			//map.put("kp", dto.getRecent().get(0).getKp());
			//map.put("kk", dto.getRecent().get(0).getKk());
			map.put("kp", dto.getCurrentP());
			map.put("kk", dto.getCurrentK());
			return map;
		}
		return null;
	}
	
	
	/** 
	 *  Json 파싱
	 */
	public SpaceWeatherDTO getDataParsing() throws SocketTimeoutException{
		Document doc = null;        //Document에는 페이지의 전체 소스가 저장된다
		try {
			doc = Jsoup.connect(url).get();
			//System.out.println("doc 데이타 : "+doc);
/**
 * 
 <html>
 <head></head>
 <body>
  {"error":false,"lastUpdate":"1632308580000","errorCode":"NOERR","kindex":{"time":"2021-09-22 08:04:49","currentP":4,"currentK":4,"max24P":4,"max24K":4,"recent":[{"time":"2021-09-22 09:00:00","kp":4,"kk":4},{"time":"2021-09-22 06:00:00","kp":2,"kk":2},{"time":"2021-09-22 03:00:00","kp":4,"kk":3},{"time":"2021-09-22 00:00:00","kp":3,"kk":3},{"time":"2021-09-21 21:00:00","kp":2,"kk":3},{"time":"2021-09-21 18:00:00","kp":3,"kk":4},{"time":"2021-09-21 15:00:00","kp":1,"kk":2},{"time":"2021-09-21 12:00:00","kp":1,"kk":1}]}}
 </body>
</html>			
 */
		} catch (IOException e) {
			e.printStackTrace();
		}

		//select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
		SpaceWeatherDTO spaceWeatherDTO=SpaceWeatherDTO.getInstance();
		try {
				Elements element = doc.select("body");    
				String jsonData=element.html();
				
				JsonObject jsonObj=(JsonObject)JsonParser.parseString(jsonData);
				//System.out.println("json 데이타 : "+jsonObj.toString()+"\n\n\n");
				
				spaceWeatherDTO.setError(jsonObj.get("error").toString()); //error 데이터 추출
				spaceWeatherDTO.setLastUpdate(jsonObj.get("lastUpdate").toString().replaceAll("\"", ""));
				spaceWeatherDTO.setErrorCode(jsonObj.get("errorCode").toString().toString().replaceAll("\"", ""));
				
				//경과된 millisecond를 현재시간에서 빼기
				//String strMilliSeconds = "1632304200000";
				//DATE 날짜를 String으로 변환
				String strMilliSeconds = spaceWeatherDTO.getLastUpdate();
				Long MilSeonds = Long.parseLong(strMilliSeconds.toString());
				Date nowDate=new Date();
				long wantMilSecs=nowDate.getTime()-MilSeonds;
				Date wantDate=new Date(wantMilSecs);
				
			    
				//kST 2021와 같은 시간의 형태를 yyyy-MM-dd HH:mm:ss의 데이터 포맷으로 변환하는 방법
                DateFormat dateFomatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				 
				String dateTime = "-";				 
				if (wantDate != null){
				   dateTime = dateFomatter.format(wantDate.getTime());
				}	
			    logger.info("dateTime"+dateTime);
				spaceWeatherDTO.setFormatLastUpdate(dateTime);
				
				//getAsJsonObject를 이용해서 원하는 타입을 이용해서 값을 받아오면 된다.
				JsonObject kindexObj=jsonObj.get("kindex").getAsJsonObject();
				
				spaceWeatherDTO.setTime(kindexObj.get("time").toString().replaceAll("\"", ""));
				spaceWeatherDTO.setCurrentP(kindexObj.get("currentP").toString().replaceAll("\"", ""));
				spaceWeatherDTO.setCurrentK(kindexObj.get("currentK").toString().replaceAll("\"", ""));
				spaceWeatherDTO.setMax24P(kindexObj.get("max24P").toString().replaceAll("\"", ""));
				spaceWeatherDTO.setMax24K(kindexObj.get("max24K").toString().replaceAll("\"", ""));
				
				
				//json 배열
				JsonArray recentArray=kindexObj.get("recent").getAsJsonArray();
			
				/**recentArray 는 다음과 같은 배열형식
				 * 
					"recent":[
					         {
					            "time":"2021-09-22 09:00:00",
					            "kp":4,
					            "kk":5
					         },
         				]
				 */
				for(int i=0; i<recentArray.size(); i++) {
					JsonObject obj=recentArray.get(i).getAsJsonObject();
					
					//Recent 객체 생성
					SpaceWeatherDTO.Recent recent=spaceWeatherDTO.new Recent();
					
					//subtime expr1 에 expr2 의 값을 뺀 날짜
					recent.setSubTime(obj.get("time").toString().replaceAll("\"", ""));
					recent.setKp(obj.get("kp").toString().replaceAll("\"", ""));
					recent.setKk(obj.get("kk").toString().replaceAll("\"", ""));					
					spaceWeatherDTO.getRecent().add(recent);					
				}
			
				
		}catch (Exception e) {
			e.printStackTrace();
		}
	
		return spaceWeatherDTO;		
	}

	
	
}
