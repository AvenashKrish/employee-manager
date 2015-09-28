<%-- 
    Document   : EmployeeManager
    Created on : Sep 19, 2015, 5:06:08 PM
    Author     : Avenash
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="entity.Role"%>
<%@page import="entity.Employee"%>
<%@page import="entity.Task"%>
<%@page import="entity.GenericDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Employees - Human Resource Application</title>        
        <link rel="stylesheet" type="text/css" href="style/theme.css">        

        <script src="scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
        <script src="scripts/app.js" type="text/javascript"></script>

    <body>
        <div class="header">
            <a href="index.jsp"><h1>Human Resource Application</h1></a>            
        </div>
        <div class="page-content">      
            <h2>Employee Form</h2>
            <a href="EmployeeManager.jsp">Add New Record</a>
            <br />
            <br />

            <%
                GenericDaoImpl dao = new GenericDaoImpl();

                Employee employee = null;

                String employeeId = request.getParameter("employeeId");
                String employeeName = request.getParameter("employeeName");
                String roleId = request.getParameter("roleId");
                String employeeCreateCommand = request.getParameter("employeeCreateCommand");
                String employeeUpdateCommand = request.getParameter("employeeUpdateCommand");
                String employeeSingleSelectCommand = request.getParameter("employeeSingleSelectCommand");

                Enumeration parameters = request.getParameterNames();

                if ((employeeSingleSelectCommand != null) && (employeeId != null)) {
                    employee = (Employee) dao.find(Employee.class, Integer.parseInt(employeeId));
                }

                if (employeeCreateCommand != null) {
                    Role selectedRole = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                    employee = new Employee();
                    employee.setName(employeeName);
                    employee.setRole(selectedRole);

                    while (parameters.hasMoreElements()) {
                        String name = (String) parameters.nextElement();
                        if (name.startsWith("taskDesc")) {
                            Task t = new Task();
                            t.setDescription(request.getParameter(name));
                            employee.addTask(t);
                        }
                    }

                    dao.create(employee);
                    employee = null;

                } else if (employeeUpdateCommand != null) {
                    Role selectedRole = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                    employee = (Employee) dao.find(Employee.class, Integer.parseInt(employeeId));
                    employee.setName(employeeName);
                    employee.setRole(selectedRole);

                    List taskIds = new ArrayList();
                    List taskDescs = new ArrayList();
                    List<Task> tasks = new ArrayList<Task>();

                    while (parameters.hasMoreElements()) {
                        String name = (String) parameters.nextElement();
                        if (name.startsWith("taskId")) {
                            taskIds.add(name);
                        }
                    }

                    while (parameters.hasMoreElements()) {
                        String name = (String) parameters.nextElement();
                        if (name.startsWith("taskDesc")) {
                            taskDescs.add(name);
                        }
                    }

                    Iterator iter = taskIds.iterator();

                    while (iter.hasNext()) {
                        String element = (String) iter.next();

                        for (Iterator iter2 = taskDescs.iterator(); iter2.hasNext();) {
                            String desc = (String) iter2.next();

                            if (element.charAt(element.length() - 1) == desc.charAt(desc.length() - 1)) {
                                Task t = (Task) dao.find(Task.class, Integer.parseInt(element));
                                t.setDescription(desc);
                                tasks.add(t);
                                break;
                            }
                        }

                    }

                    dao.update(employee);
                    employee = null;
                }

            %>

            <form>
                <table>
                    <tr>
                        <td>Employee ID</td>
                        <td><input type="text" name="employeeId" placeholder="(auto)" value="<% if (employee != null) {
                                out.print(employee.getEmployeeId());
                            } else {
                                out.print("");
                            } %>" readonly></td>
                    </tr>
                    <tr>
                        <td>Name</td>
                        <td><input type="text" name="employeeName" value="<% if (employee != null) {
                                out.print(employee.getName());
                            } else {
                                out.print("");
                            } %>" required></td>
                    </tr>
                    <tr>
                        <td>Role</td>
                        <td>
                            <select name='roleId' style='width: 150px;' required>
                                <%                                    for (Iterator iter = dao.findAll(Role.class).iterator();
                                            iter.hasNext();) {
                                        Role element = (Role) iter.next();
                                        out.println("<option value='" + element.getRoleId() + "'>" + element.getTitle() + "</option>");
                                    }

                                %>
                            </select>                        
                        </td>
                    </tr>
                    <tr>
                        <td>Tasks</td>
                        <td>
                            <%                                if (employee == null) {

                                    out.println("<div id='TextBoxesGroup'>");
                                    out.println("   <div id='TextBoxDiv1'>");
                                    out.println("       Task 1 - <input type='textbox' id='textbox1' style='width: 200px; ' name='task1' required />");
                                    out.println("   </div>");
                                    out.println("</div>");
                                    out.println("<br />");
                                    out.println("<input type='button' value='  +  ' id='addButton'>");
                                    out.println("<input  type ='button' value ='  -  ' id ='removeButton'>");

                                } else {

                                    int count = 1;
                                    out.println("<div id='TextBoxesGroup'>");
                                    for (Iterator iter = employee.getTasks().iterator();
                                            iter.hasNext();) {
                                        Task element = (Task) iter.next();

                                        out.println("   <div id='TextBoxDiv" + count + "'>");
                                        out.println("       Task " + count + " - <input type='textbox' id='textbox1' style='width: 200px; ' name='taskDesc" + count + "' value='" + element.getDescription() + "'required />");
                                        out.println("       <input type='hidden' name='taskId" + count + "' value='" + element.getTaskId() + "'required />");
                                        out.println("   </div>");

                                        count++;
                                    }
                                    
                                    out.println("</div>");
                                    out.println("<br />");
                                    out.println("<input type='button' value='  +  ' id='addButton'>");
                                    out.println("<input  type ='button' value ='  -  ' id ='removeButton'>");
                                }

                            %>


                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="employeeCreateCommand" value="Create">
                            <input type="submit" name="employeeUpdateCommand" value="Update">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </form>

        </div>
        <footer>
            <hr>
            <p>Assignment 2 - Enterprise Application Development 2015</p>
        </footer>
    </body>
</html>
