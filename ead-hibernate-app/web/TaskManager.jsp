<%-- 
    Document   : TaskManager
    Created on : Sep 19, 2015, 12:21:47 PM
    Author     : Avenash
--%>

<%@page import="entity.Employee"%>
<%@page import="entity.Task"%>
<%@page import="java.util.List"%>
<%@page import="entity.Role"%>
<%@page import="entity.GenericDaoImpl"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Roles - Human Resource Application</title>        
        <link rel="stylesheet" type="text/css" href="style/theme.css">        
    </head>
    <body>
        <div class="header">
            <a href="index.jsp"><h1>Human Resource Application</h1></a>            
        </div>
        <div class="page-content">      
            <h2>Assign Tasks</h2>            
            <a href="TaskManager.jsp">Add New Record</a>
            <br />
            <br />

            <%
                GenericDaoImpl dao = new GenericDaoImpl();

                Task task = null;

                String taskId = request.getParameter("taskId");
                String taskDescription = request.getParameter("taskDescription");
                String employeeId = request.getParameter("employeeId");
                String taskCreateCommand = request.getParameter("taskCreateCommand");
                String taskUpdateCommand = request.getParameter("taskUpdateCommand");
//                String roleSingleDeleteCommand = request.getParameter("roleSingleDeleteCommand");
                String taskSingleSelectCommand = request.getParameter("roleSingleSelectCommand");

                if ((taskSingleSelectCommand != null) && (taskId != null)) {
                    task = (Task) dao.find(Task.class, Integer.parseInt(taskId));
                }

                if (taskCreateCommand != null) {
                    Employee selectedEmployee = (Employee) dao.find(Employee.class, Integer.parseInt(employeeId));
                    task = new Task();
                    task.setDescription(taskDescription);
                    task.setEmployee(selectedEmployee);
                    dao.create(task);
                    task = null;
                } else if (taskUpdateCommand != null) {
                    task = (Task) dao.find(Task.class, Integer.parseInt(taskId));
                    task.setDescription(taskDescription);
                    dao.update(task);
                    task = null;
                }
            %>

            <form>
                <table>
                    <tr>
                        <td>Task ID</td>                        
                        <td><input type="text" name="taskId" placeholder="(auto)" readonly value="<% if (task != null) {
                                out.print(task.getTaskId());
                            } else {
                                out.print("");
                            } %>"></td>
                    </tr>
                    <tr>
                        <td>Description</td>
                        <td><input type="text" name="taskDescription" required value="<% if (task != null) {
                                out.print(task.getDescription());
                            } else {
                                out.print("");
                            } %>"> </td>
                    </tr>
                    <tr>
                        <td>Assigned to</td>
                        <td>
                            <select name='employeeId' style='width: 150px;' required>
                                <%                                    for (Iterator iter = dao.findAll(Employee.class).iterator();
                                            iter.hasNext();) {
                                        Employee element = (Employee) iter.next();
                                        String x = "";
                                        if ((task != null) && (task.getEmployee().getEmployeeId() == element.getEmployeeId())) {
                                            x = "selected";
                                        }
                                        out.println("<option value='" + element.getEmployeeId() + "' " + x + " >" + element.getName() + "</option>");
                                    }

                                %>
                            </select>                        
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <!--<input type="Reset" value="New">-->                            
                            <input type="submit" name="<% if (task != null) {
                                    out.print("taskUpdateCommand");
                                } else {
                                    out.print("taskCreateCommand");
                                } %>" value="<% if (task != null) {
                                        out.print("Update");
                                    } else {
                                        out.print("Create");
                                    } %>">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </form>
            <!--            <div>
                            <hr>
                            <h4>Records List</h4>
                            <table>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th></th>
                                    <th></th>
                                </tr>
            <%
//                        for (Iterator iter = dao.findAll(Task.class).iterator(); iter.hasNext();) {
//                            Task element = (Task) iter.next();
//                            out.println("<tr>");
//                            out.println("   <form>");
//                            out.println("       <td>" + element.getRoleId() + "<input type='hidden' name='roleId' value='"
//                                    + element.getRoleId() + "'>" + "</td>");
//                            out.println("       <td>" + element.getTitle() + "</td>");
//                            out.println("       <td>" + "<input type='submit' name='roleSingleSelectCommand' value='Select'>" + "</td>");
////                            out.println("       <td>" + "<input type='submit' name='roleSingleDeleteCommand' value='Delete'>" + "</td>");
//                            out.println("   </form>");
//                            out.println("</tr>");
//                        }
%>
        </table>
    </div>            -->
        </div>
        <footer>
            <hr>
            <p>Assignment 2 - Enterprise Application Development 2015</p>
        </footer>
    </body>
</html>
