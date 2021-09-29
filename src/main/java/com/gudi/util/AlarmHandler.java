package com.gudi.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.gudi.board.dto.InformDTO;
import com.gudi.board.service.InformService;
/**
 * 알림 개발
 * 1.라이브러리 등록
 * 	<!-- 알림 -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-websocket</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>
		<dependency>
			<groupId>com.google.code.gson</groupId>
			<artifactId>gson</artifactId>
			<version>2.8.6</version>
		</dependency>			
		
		
 * 2. servlet-context.xml  설정
 * 
 	  <beans:bean id="alarmHandler"
		class="com.gudi.util.AlarmHandler" />
	<websocket:handlers allowed-origins="*">
		<websocket:mapping handler="alarmHandler"
			path="/alarm" />
		<websocket:handshake-interceptors>
			<beans:bean
				class="org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor" />
		</websocket:handshake-interceptors>
		<websocket:sockjs
			client-library-url="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js" />

	</websocket:handlers> 
 *
 * 3. AlarmHandler 
 * 
 *  4.footer.jsp
 */


@Component//<Bean class=“…”/>와 동일한 표현이다
//@Component 어노테이션을 이용하면 Bean Configuration 파일에 Bean을 따로 등록하지 않아도 사용할 수 있다.
//빈 등록자체를 빈 클래스 자체에다가 할 수 있다는 의미이다.//@Autowired 비슷한 기능
public class AlarmHandler extends TextWebSocketHandler  {
		
	// 로그인 한 전체의 세션 값을 list로 가져온다.
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Autowired
	InformService informService;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	 // afterConnectionEstablished : 웹소켓이 연결되면 호출되는 함수
	// 서버에 접속이 성공 했을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//접속한 전체 유저 아이디
		sessions.add(session);
		//로그인한 개별 유저 아이디를 가져온다.
		String senderID = getId(session);
		//userSessionsMap 에 개별유저아이디를 넣는다.
		userSessionsMap.put(senderID, session);
	}

	// 소켓에 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String userId=getId(session);
		
		Map<String, Object> httpSession = session.getAttributes();
		String loginId = (String) httpSession.get("loginId");	
		//logger.info(" message - {} " , message.getPayload());
		//logger.info("접속자 유저 세션 - {} " , userId);
		//logger.info("로그인한 유저 세션 - {} " , loginId);
		
		if(loginId!=null) {
			
			    //Recent 최금 측정값 목록
			    //message.getPayload() 라는 함수를 통해서 메시지에 담긴 텍스트값을 얻을 수 있다
			  //텍스트 값이 ALARM-SPACEWEATHERGETKP 라면
				if(message.getPayload().equals("ALARM-SPACEWEATHERGETKP")) {
					//json 포멧을 이해할수 있게 파싱
					SpaceWeatherGetKP customParsing =SpaceWeatherGetKP.getInstance();
					SpaceWeatherDTO dto = customParsing.getDataParsing();//getDataParsing() 구문 분석
					Map<String, String> paramMap = new HashMap<String, String>();
					paramMap = customParsing.getRecentData(paramMap, dto);
					
					logger.info("지구 자기장 알림 내용 데이타 파싱 값 : {}", paramMap.toString());
					
					//알림 수신 여부
					String chkAlert = (String) httpSession.get("chkAlert");
					//문자형에서 double 형으로 변경(kp는 숫자이므로 변경해줘야 함)
					Double kp =Double.parseDouble((String)paramMap.get("kp"));
					
					//logger.info("알람수신 체크여부:  {} " ,chkAlert);
					//logger.info("KP 지수:  {} " ,paramMap.get("kp"));
					
					/**  알람 수신 체크 Y  , KP 지수가 5 이 상인 경우  테스트용으로 1으로 넣어놈*/
					if(chkAlert!=null && chkAlert.equals("Y") && kp >=-1) {
						WebSocketSession webSocketSession = userSessionsMap.get(userId);
						Gson gson = new Gson();
						paramMap.put("messageType", "weather");//footer.jsp
						//해당 유저 알림데이터 전체 가져오기일 경우  JSON 으로 전환 후 TextMessage 변환
						TextMessage textMessage = new TextMessage(gson.toJson(paramMap));
						webSocketSession.sendMessage(textMessage);
					}
										
				}else{

		//접속한 해당 유저 읽지않은 알림 데이터 전체 카운트 만 가져올 경우  
		//int countInform=informService.countInform(userId);
		
		//1.해당 유저 알림데이터 전체 가져오기
		//List<InformDTO> getInform= informService.selectInformDTO(userId);
		//for(InformDTO informDTO :getInform) {
			//System.out.println("getInform : "+informDTO.toString());	
		//}
		
		//2.해당 유저 알림데이터 마지막 데이터만 가져올 경우
		InformDTO selectLsatInform= informService.selectLsatInform(userId);
		
		WebSocketSession webSocketSession = userSessionsMap.get(userId);
		
		//json으로 바꾸기 위해 gson 객체화//서버에 복잡한 데이터를 편리하게 보내기 위해 json으로 변환
		Gson gson = new Gson();
		//1.해당 유저 알림데이터 전체 가져오기일 경우 JSON 으로 전환 후 TextMessage 변환
		//TextMessage textMessage = new TextMessage(gson.toJson(getInform));		
		
		//2.해당 유저 알림데이터 전체 가져오기일 경우  JSON 으로 전환 후 TextMessage 변환
		TextMessage textMessage = new TextMessage(gson.toJson(selectLsatInform));
		webSocketSession.sendMessage(textMessage);
		
		
    	}			
}


}

	// 연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//System.out.println("afterConnectionClosed " + session + ", " + status);
		//소켓 연결이 끊겼을 때 개별 접속아이디 해체 저리한다.
		userSessionsMap.remove(session.getId());
		//소켓 연결이 끊겼을 때 전체 접속자 아이디 해체 저리한다.
		sessions.remove(session);
		//CloseStatus 소켓이 닫혀 있는지 상태 확인
	}
	

	// 웹소켓 id 가져오기
	private String getId(WebSocketSession session) {
/*		
		(String)request.getSession().getAttribute("loginId");
		또는 ,
		session.getAttribute("loginId"); 
		이렇게 세션값을 가져오나 여기 웹소켓에서는 세션값을 WebSocketSession session  형태로 가져옵니다.
		따라서 , 다음과 코드 형태로 세션값을 가져옵니다. 
*/		    
        Map<String, Object> httpSession = session.getAttributes();
		String loginId = (String) httpSession.get("loginId");		
		if (loginId == null) {
			//System.out.println("로그인 loginID 가 널일경우  :" + session.getId());
			//브라우저가 열리고 해당 사이트에 접속하면 세션이 생긴다
			//이때 로그인한 아이디값이 없을 경우 임의 값이 랜덤으로 생성된다.
			//랜던으로 생성된 아이디값은 전체 접속자들 마다 전부 다름니다. 그럼 임의값을 주는 이유는 뭔가요??
			//알림 설정을 위해서 이다.  로그인 한  접속한 유저들에게 보내는가? 아니면 사이트에만 접속을 해도 메시지를 보내는 가 입니다.
			//구별을 하기 위해서 이다.
			//원래 웹 소켓이 채팅이 주 목적이다. 각종 채팅  사이트  생각해 보면?채팅을 위해 해당 사이트에 접속을 하면 임의 데이터 아이디값이 부여 된다
			//ex ) vawpuj5h, 5qw40sff
			return session.getId();
		} else {
			return loginId;
		}
	}
	
	 

}
