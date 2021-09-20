package com.gudi.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.gudi.board.dto.InformDTO;
import com.gudi.board.service.InformService;

@Component
public class AlarmHandler extends TextWebSocketHandler {

	// 로그인 한 전체
		List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
		// 1대1
		Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
		
		@Autowired
		InformService informService;
		
		

		// 서버에 접속이 성공 했을때
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			sessions.add(session);
			String senderID = getId(session);
			userSessionsMap.put(senderID, session);
		}

		// 소켓에 메세지를 보냈을때
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			String userId=getId(session);
			//int countInform=informService.countInform(userId);
			
			List<InformDTO> getInform= informService.selectInformDTO(userId);
			for(InformDTO informDTO :getInform) {
				//System.out.println("getInform : "+informDTO.toString());	
			}
			
			Gson gson = new Gson();
			WebSocketSession webSocketSession = userSessionsMap.get(userId);
			TextMessage textMessage = new TextMessage(gson.toJson(getInform));		
			webSocketSession.sendMessage(textMessage);
			
		}

		// 연결 해제될때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			//System.out.println("afterConnectionClosed " + session + ", " + status);
			userSessionsMap.remove(session.getId());
			sessions.remove(session);
		}
		

		// 웹소켓 id 가져오기
		private String getId(WebSocketSession session) {		
			Map<String, Object> httpSession = session.getAttributes();
			String loginId = (String) httpSession.get("loginId");		
			if (loginId == null) {
				return session.getId();
			} else {
				return loginId;
			}
		}


	}

	

