package com.cts.model;

import java.util.List;

public class Faculty extends Option{
	private List<Department> departmentList;

	/**
	 * @return the departmentList
	 */
	public List<Department> getDepartmentList() {
		return departmentList;
	}

	/**
	 * @param departmentList the departmentList to set
	 */
	public void setDepartmentList(List<Department> departmentList) {
		this.departmentList = departmentList;
	}

}
