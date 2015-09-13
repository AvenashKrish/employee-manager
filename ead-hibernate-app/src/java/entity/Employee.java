/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author Avenash
 */
public class Employee {

    private int employeeId;
    private String name;
    private int roleId;
    private Set tasks;

    public Employee() {
        tasks = new HashSet();
    }

    public void addHat(Task task) {
        this.tasks.add(task);
    }

    public void removeHat(Task task) {
        this.tasks.remove(task);
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public Set getTasks() {
        return tasks;
    }

    public void setTasks(Set tasks) {
        this.tasks = tasks;
    }

}
