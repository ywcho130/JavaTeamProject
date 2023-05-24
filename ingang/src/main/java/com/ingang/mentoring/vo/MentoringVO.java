package com.ingang.mentoring.vo;


import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

// @Data : Getter, Setter, equals, hashCode, toString 등의 메서드를 자동으로 생성함
@Data
public class MentoringVO {

	private long mno, lecFee;
	private String mid, head, field, career, incumbent, intro, status;
	private long avaStartTime, avaEndTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date avaStartDate, avaEndDate;
	private String memberimg;
}
