<%-- 
    Document   : EmployeeManager
    Created on : Sep 19, 2015, 5:06:08 PM
    Author     : Avenash
--%>

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
        <title>Manage Employees - Employee Manager Application</title>        
        <link rel="stylesheet" type="text/css" href="style/theme.css">        

        <script src="scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
        <script src="scripts/app.js" type="text/javascript"></script>

    <body>
        <div class="header">
            <a href="index.jsp"><h1>Employee Manager Application</h1></a>            
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

                if ((employeeSingleSelectCommand != null) && (roleId != null)) {
                    employee = (Employee) dao.find(Employee.class, Integer.parseInt(roleId));
                }

                if (employeeCreateCommand != null) {
                    Role selectedRole = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                    employee = new Employee();
                    employee.setName(employeeName);
                    employee.setRole(selectedRole);

                    while (parameters.hasMoreElements()) {
                        String name = (String) parameters.nextElement();
                        if (name.startsWith("task")) {
                            Task t = new Task();
                            t.setDescription(request.getParameter(name));
                            employee.addTask(t);
                        }
                    }

                    dao.create(employee);
                    employee = null;

                    response.sendRedirect("EmployeeManager.jsp");

                } else if (employeeUpdateCommand != null) {
                    Role selectedRole = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                    employee = new Employee();
                    employee.setEmployeeId(Integer.parseInt(employeeId));
                    employee.setName(employeeName);
                    employee.setRole(selectedRole);
                    dao.create(employee);
                    employee = null;
                }

            %>

            <form>
                <table>
                    <tr>
                        <td>Employee ID</td>
                        <td><input type="text" name="employeeId" placeholder="(auto)" readonly></td>
                    </tr>
                    <tr>
                        <td>Name</td>
                        <td><input type="text" name="employeeName" required></td>
                    </tr>
                    <tr>
                        <td>Role</td>
                        <td>
                            <select name='roleId' style='width: 150px;' required>
                                <%                                    for (Iterator iter = dao.findAll(Role.class).iterator(); iter.hasNext();) {
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
                            <div id='TextBoxesGroup'>
                                <div id="TextBoxDiv1">
                                    <input type='textbox' id='textbox1' style='width: 200px; ' name='task1' required />
                                </div>
                            </div>
                            <input type='button' value='  +  ' id='addButton'>
                            <input type='button' value='  -  ' id='removeButton'>
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
