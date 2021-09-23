package com.gudi.map.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.gudi.map.dao.MapDAO;

@Service
public class SchedulerService {

	@Autowired MapDAO dao;
	
	@Scheduled(fixedDelay=3000) //작업종료 30초 후 실행
	public void deleteLocMKs() {
		int success = dao.deleteLocMKs();
		System.out.println("1시간 경과한 내위치마커 제거 개수: "+success);
	}
}
