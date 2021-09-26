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


@ServerEndpoint(value="/chat/{userNick}")
public class WebSocketController {   
	
	static HashMap<String, Session> userList = new HashMap<String, Session>();
   
   //서버 접속시(이벤트) 실행되는 메서드
   @OnOpen
   public void onOpen(Session session, @PathParam("userNick") String userNick)
         throws IOException {
      //@PathParam 은 웹에서의 @PathVariable 과 같다.
      System.out.println(userNick+"의 접속");
      System.out.println(session);
      
      /*
      if(userList.get(userId) != null) {//map 에 해당 키가 존재 하는지?
          sendMsg(session,"중복된 대화명 입니다.");
          session.close();
       }else {   */
          userList.put(userNick, session);
          userList.size();
          System.out.println("현재 접속자 : "+ userList.size());
          broadCast("<span id='alert'>"+userNick+" 님께서 입장 하셨습니다.</span>");
       }
      
   
   
 //서버 종료시(이벤트) 실행되는 메서드
   @OnClose
   public void onClose(Session session, @PathParam("userNick") String userNick) {
      System.out.println("접속 종료");
      System.out.println(session);
      
           //접속 종료된 session 만 hashmap 에서 빼주기
            String id = session.getId();
            
              for(String key : userList.keySet()) {//map 에서 키를 추출하고
               //Session sess = (Session)userList.get(key);//키를 통해 session을 추출해서
               if(id.equals(userList.get(key).getId())) {//session의 id 와 종료한 session의 id가 같으면
                  System.out.println("종료하려는 userId : "+key);
                   userList.remove(key);//map 에서 지워준다.
                   System.out.println("현재 사용자 Id : "+userList.size());
                  
               
               }
           }    
      broadCast("<span id='alert'>"+userNick+" 님께서 나가셨습니다.</span>");
      
   }
   
   
 //클라이언트 메시지 수신시(이벤트) 실행되는 메서드
   @OnMessage
   public void onMsg(String msg, Session session) {
      System.out.println("받은 메시지 : "+msg);
      //sendMsg(session, msg);//뭐든것이 들어있다 socket과 같은 역할
      broadCast(msg);
   }
      
   
   //에러 발생시(이벤트) 실행되는 메서드
   @OnError
   public void onError(Session session, Throwable e) {
      System.out.println(e.toString());
   }
      
 //전체 유저한테 보낸다
   private void broadCast(String msg) {
       try {
      for(String userId : userList.keySet()) {//keyset hashmap을 모아서 하나씩 보내는 메서드
          Session session = (Session) userList.get(userId);
          System.out.println("session id : "+session.getId());
          session.getBasicRemote().sendText(msg);
       
        }
      } catch (IOException e) {
         
         e.printStackTrace();
      }
      
   }
   
 //서버에서 클라이언트로 보낼때
   public void sendMsg(Session session, String msg) {
      try {
         session.getBasicRemote().sendText(msg);
      } catch (IOException e) {
         e.printStackTrace();
      }
   }

   
   
   
   
}