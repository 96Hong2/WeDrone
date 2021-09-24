package com.gudi.calendar.dto;

public class CalendarDTO {
	
	private int scheduleId;
	private String scheduleName;
	private String startDate;
	private String endDate;
	
	private String id;
	private String title;
	private String start;
	private String end;
	private String color="#039be5";
	
	
	public int getScheduleId() {
		return scheduleId;
	}
	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}
	public String getScheduleName() {
		return scheduleName;
	}
	public void setScheduleName(String scheduleName) {
		this.scheduleName = scheduleName;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "CalendarDTO [scheduleId=" + scheduleId + ", scheduleName=" + scheduleName + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", id=" + id + ", title=" + title + ", start=" + start + ", end=" + end
				+ ", color=" + color + "]";
	}
	
	
	
	
}