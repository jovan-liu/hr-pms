package com.lzh.hr.pms.entity;

import java.io.Serializable;
import java.util.Date;

public class SecretUser implements Serializable {

	/*
	*
	*/
	private Integer id;

	/*
	*
	*/
	private String title;

	/*
	*
	*/
	private String nickname;

	/*
	*
	*/
	private Integer longno;

	/*
	*
	*/
	private String photoPrefix;

	/*
	*
	*/
	private Integer sortNum;

	/*
	*
	*/
	private Integer status;

	/*
	*
	*/
	private Date createTime;

	/*
	*
	*/
	private Date updateTime;

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle() {
		return this.title;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getNickname() {
		return this.nickname;
	}

	public void setLongno(Integer longno) {
		this.longno = longno;
	}

	public Integer getLongno() {
		return this.longno;
	}

	public void setPhotoPrefix(String photoPrefix) {
		this.photoPrefix = photoPrefix;
	}

	public String getPhotoPrefix() {
		return this.photoPrefix;
	}

	public void setSortNum(Integer sortNum) {
		this.sortNum = sortNum;
	}

	public Integer getSortNum() {
		return this.sortNum;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

}