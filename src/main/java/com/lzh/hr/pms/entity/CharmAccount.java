package com.lzh.hr.pms.entity;

public class CharmAccount {
	private String name;
	private Integer gender;
	private Integer vip_flag;
	private String photo_path;
	private Long account_id;
	private Long charm_inc;
	private Long long_no;
	private Integer level;
	private String level_desc;
	private String local_name;
	private boolean block_flag;

	public boolean isBlock_flag() {
		return block_flag;
	}

	public void setBlock_flag(boolean block_flag) {
		this.block_flag = block_flag;
	}

	public Long getLong_no() {
		return long_no;
	}

	public void setLong_no(Long long_no) {
		this.long_no = long_no;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getLevel_desc() {
		return level_desc;
	}

	public void setLevel_desc(String level_desc) {
		this.level_desc = level_desc;
	}

	public String getLocal_name() {
		return local_name;
	}

	public void setLocal_name(String local_name) {
		this.local_name = local_name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public Integer getVip_flag() {
		return vip_flag;
	}

	public void setVip_flag(Integer vip_flag) {
		this.vip_flag = vip_flag;
	}

	public String getPhoto_path() {
		return photo_path;
	}

	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}

	public Long getAccount_id() {
		return account_id;
	}

	public void setAccount_id(Long account_id) {
		this.account_id = account_id;
	}

	public Long getCharm_inc() {
		return charm_inc;
	}

	public void setCharm_inc(Long charm_inc) {
		this.charm_inc = charm_inc;
	}

}
