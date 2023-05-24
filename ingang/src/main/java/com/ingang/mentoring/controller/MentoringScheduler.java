package com.ingang.mentoring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ingang.mentoring.service.MentoringService;

// 스케줄링 기능을 사용 가능하게 하는 어노테이션 @EnableScheduling
@EnableScheduling
// @Component 어노테이션은 Spring의 컴포넌트 스캔을 위한 어노테이션으로, 해당 클래스를 스프링의 빈으로 등록
@Component
public class MentoringScheduler {
	
    private final MentoringService mservice;

	@Autowired
    public MentoringScheduler(@Qualifier("mentoringServiceImpl")MentoringService mservice) {
        this.mservice = mservice;
    }

	// 어노테이션은 Spring에서 제공하는 어노테이션으로, 메서드를 스케줄링 작업으로 지정할 수 있다.
	// cron 속성을 사용하여 실행 주기를 지정할 수 있으며,"*/10 * * * * *"으로 설정되어 있어 10초마다 runTimer() 메서드가 실행된다.
	@Scheduled(cron = "*/10 * * * * *")
    public void runTimer() {
        mservice.timer();
        System.out.println("멘토 리스트 갱신 스케줄러 실행 ............................");
    }
}