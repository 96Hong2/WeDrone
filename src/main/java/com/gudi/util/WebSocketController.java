package com.gudi.util;

import java.io.IOException;
import java.util.HashMap;


import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint(value="/chat/{userId}")
public class WebSocketController {   
   
   //서버 접속시(이벤트) 실행되는 메서드
   @OnOpen
   public void onOpen(Session session, @PathParam("userId") String userId)
         throws IOException {
      //@PathParam 은 웹에서의 @PathVariable 과 같다.
      System.out.println(userId+"의 접속");
      System.out.println(session);
      
   }
   
   //서버 종료시(이벤트) 실행되는 메서드
   @OnClose
   public void onClose(Session session) {
      System.out.println("접속 종료");
      System.out.println(session);
   }
   
   
   //클라이언트 메시지 수신시(이벤트) 실행되는 메서드
   @OnMessage
   public void onMsg(String msg, Session session) {
      System.out.println("받은 메시지 : "+msg);
      broadCast(session, msg);
   }
      
   
   //에러 발생시(이벤트) 실행되는 메서드
   @OnError
   public void onError(Session session, Throwable e) {
      System.out.println(e.toString());
   }
      
   //서버에서 클라이언트로 보낼때
   public void broadCast(Session session, String msg) {
      try {
         session.getBasicRemote().sendText(msg);
      } catch (IOException e) {
         e.printStackTrace();
      }
   }

   
   
   
   
}