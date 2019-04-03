package com.lzh.hr.pms.response;

import java.util.List;

public class DataVo {
	private String label;
	private List<Integer[]> data;

	public DataVo(String label, List<Integer[]> data) {
		super();
		this.label = label;
		this.data = data;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public List<Integer[]> getData() {
		return data;
	}

	public void setData(List<Integer[]> data) {
		this.data = data;
	}

	public DataVo() {
	}
}
