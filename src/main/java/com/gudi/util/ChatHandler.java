package com.gudi.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler {
//현재 프로젝트에서 로그인한 유저에게 보여주는 모든 페이지 레이아웃에서 공통으로 사용하는 lognav.jsp파일에 
//웹 소켓을 연결시켜서 모든 페이지에서 알림을 받도록 한다.
	
	//로그인 중인 개별 유저들이 들어가는 맵
	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
	//로그인한 전체 유저의 세션 값이 들어가는 리스트
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();

	//클라이언트가 서버에 연결되면 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession WSsession) throws Exception {
		String loginId = getMemberId(WSsession); //http세션을 조회하여 접속한 유저의 loginId를 얻어온다.
		if(loginId != null) { //loginId가 존재한다면?
			log(loginId + " 의 웹소켓이 연결됨");
			//로그인 중인 개별 유저들이 들어가는 맵에 키 loginId - 값 WSsession 저장
			users.put(loginId, WSsession);
		}
	}
	
	//클라이언트가 데이터 전송 시, 특정 유저에게 소켓으로 알림을 보낸다.
	@Override
	protected void handleTextMessage(WebSocketSession WSsession, TextMessage message) throws Exception {
		//매개변수로 들어온 웹소켓에 해당하는 특정 유저의 loginId를 꺼내온다.
		String loginId = getMemberId(WSsession);
		
		//TextMessage타입 message객체의 내용을 문자열로 반환
		//여기서 message는 알림 데이터로 "타입, 타겟(알림을 받을 유저아이디), 내용, 알림 클릭 시 이동할 URL"의 형식을 가진다.(,로 구분)
		String msg = message.getPayload();
		if(msg != null) {
			// ,(콤마)를 기준으로 스플릿한 문자열 배열
			String[] strs = msg.split(",");
			//log("웹소켓 알림 데이터 : "+strs.toString());  //(웹소켓이 연결되는 동안 계속 뜬다.)
			if(strs != null && strs.length == 4) {
				String type = strs[0]; //타입
				String target = strs[1]; //타겟(알림받을 유저아이디)
				String content = strs[2]; //내용
				String url = strs[3]; //알림 클릭 시 이동할 URL
				//String url = "#";
				log("type/target/content/url - "+type+"/"+target+"/"+content+"/"+url);
				//targetSession변수로 알림받을 유저의 웹소켓세션을 가져온다.
				WebSocketSession targetSession = users.get(target);
				
				//알림받을 유저가 실시간 접속하고 있을 경우(targetSession이 users에 아직 존재할 경우)
				if(targetSession != null) {
					if(type.equals("chat")) { //채팅 요청 //그냥 보내면 일반알림메시지랑 구분할 수 없어서 **을 넣었음
						//TextMessage txtMsg = new TextMessage("**<a target='_blank' href='"+ url +"'>[<b>대화요청</b>] &nbsp;" + content + " 님</a>");
						TextMessage txtMsg = new TextMessage("**"+ content);
						log("웹소켓 채팅요청 txtMsg - "+txtMsg.getPayload());
						targetSession.sendMessage(txtMsg);
					}else {
						//ex) [타입] 알림메시지 내용 , 클릭하면 url로 이동함
						TextMessage txtMsg = new TextMessage("<a target='_blank' href='"+ url +"'>[<b>" + type + "</b>] " + content + "</a>");
						log("웹소켓 알림메시지 txtMsg - "+txtMsg.getPayload());
						//알림받을 유저의 세션으로 txtMsg를 전송한다.
						targetSession.sendMessage(txtMsg);
						//받는 jsp페이지의 javascript영역에서 onMessage(e)의 e.data로 받게된다.
					}
				}
			}
		}else {
			log("--msg null--");
		}
	}
	
	//웹소켓 연결 해제 시 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession WSsession, CloseStatus status) throws Exception {
		//연결 해제된 웹소켓의 loginId를 가져온다.
		String loginId = getMemberId(WSsession);
		
		if(loginId != null) {
			log(loginId + " 의 웹소켓 연결이 종료됨");
			users.remove(loginId); //접속한 유저 목록Map에서 해당 loginId를 제거
			sessions.remove(WSsession); //로그인한 전체 세션 목록에서 해당 세션을 제거
		}
	}
	
	//에러 발생 시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 웹소켓 에러 발생 : " + exception.getMessage());
	}
	
	//로그 메시지 띄우기(시간 : 메시지내용)
	private void log(String logMsg) {
		System.out.println(new Date() + " : " + logMsg);
	}
	
	//접속한 유저의 Http세션을 조회하여 매개변수로 들어온 웹소켓에 해당하는 아이디를 얻어오는 함수
	private String getMemberId(WebSocketSession WSsession) {
		
		//웹소켓세션에 저장된 모든 Attributes의 Map을 httpSessionMap에 저장한다.
		Map<String, Object> httpSessionMap = WSsession.getAttributes();
		//세션에 저장된 loginId를 조회하여 가져온다.
		String loginId = (String)httpSessionMap.get("loginId");
		
		//현재 세션에 저장된 loginId가 없으면 null을 반환, 존재하면 loginId 반환
		return loginId == null ? null : loginId;
	}
	
}
