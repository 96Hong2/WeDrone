package com.gudi.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
@Component
public class AlarmHandler extends TextWebSocketHandler  {
		
	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Autowired
	InformService informService;
	
	

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
				
		Gson gson = new Gson();
		//1.해당 유저 알림데이터 전체 가져오기일 경우 JSON 으로 전환 후 TextMessage 변환
		//TextMessage textMessage = new TextMessage(gson.toJson(getInform));		
		
		//2.해당 유저 알림데이터 전체 가져오기일 경우  JSON 으로 전환 후 TextMessage 변환
		TextMessage textMessage = new TextMessage(gson.toJson(selectLsatInform));
		webSocketSession.sendMessage(textMessage);
		

	}

	// 연결 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//System.out.println("afterConnectionClosed " + session + ", " + status);
		//소켓 연결이 끊겼을 때 개별 접속아이디 해체 저리한다.
		userSessionsMap.remove(session.getId());
		//소켓 연결이 끊겼을 때 전체 접속자 아이디 해체 저리한다.
		sessions.remove(session);
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
			System.out.println("로그인 loginID 가 널일경우  :" + session.getId());
			//브라우저가 열리고 해당 사이트에 접속하면 세션이 생깁니다.
			//이때 로그인한 아이디값이 없을 경우 임의 값이 랜덤으로 생성합니다.
			//랜던으로 생성된 아이디값은 전체 접속자들 마다 전부 다름니다. 그럼 임의값을 주는 이유는 뭔가요??
			
			//알림 설정을 위해서 임니다.  로그인 한  접속한 유저들에게 보내는가? 아니면 사이트에만 접속을 해도 메시지를 보내는 가 입니다.
			//아 그걸 구별하기 위해서 이군요??네
			//원래 웹 소켓이 채팅이 주 목적입니다. 각종 채팅  사이트 아시죠?채팅을 위해 해당 사이트에 접속을 하면 임의 데이터 아이값이 부여 됩니다.
			//ex ) vawpuj5h, 5qw40sff
			return session.getId();
		} else {
			return loginId;
		}
	}
	
	 

}
