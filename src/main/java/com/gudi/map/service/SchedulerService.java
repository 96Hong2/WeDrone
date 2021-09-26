package com.gudi.map.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.gudi.board.dao.InformDAO;
import com.gudi.map.dao.MapDAO;

@Service
public class SchedulerService {

	@Autowired MapDAO dao;
	@Autowired InformDAO informDao;
	
	@Scheduled(fixedDelay=60000) //작업종료 1분 후 실행
	public void deleteLocMKs() {
		int success = dao.deleteLocMKs();
		System.out.println("1시간 경과한 내위치마커 제거 개수: "+success);
	}
	
	@Scheduled(fixedDelay=60000)
	public void deleteOldReq(){
		int success = informDao.deleteOldReq();
		System.out.println("30분 경과한 대화요청 제거 개수: "+success);
	}
}
