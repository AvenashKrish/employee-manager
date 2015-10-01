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
                
                //Generic Data Access Object Creation
                GenericDaoImpl dao = new GenericDaoImpl();
                Employee employee = null;

                try {
                    
                    //Retreiving Query String Parameters
                    String employeeId = request.getParameter("employeeId");
                    String employeeName = request.getParameter("employeeName");
                    String roleId = request.getParameter("roleId");
                    String employeeCreateCommand = request.getParameter("employeeCreateCommand");
                    String employeeUpdateCommand = request.getParameter("employeeUpdateCommand");
                    String employeeSingleSelectCommand = request.getParameter("employeeSingleSelectCommand");

                    //Handling of Select Employee
                    if ((employeeSingleSelectCommand != null) && (employeeId != null)) {
                        employee = (Employee) dao.find(Employee.class, Integer.parseInt(employeeId));
                    }

                    //Handling of New Employee Creation / Update
                    if (employeeCreateCommand != null) {
                        Role selectedRole = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                        employee = new Employee();
                        employee.setName(employeeName);
                        employee.setRole(selectedRole);

                        dao.create(employee);
                        employee = null;

                        out.write("<script type='text/javascript'>\n");
                        out.write("alert(' Employee Created Successfully ');\n");
                        out.write("setTimeout(function(){window.location.href='EmployeeManager.jsp'},1000);");
                        out.write("</script>\n");
                        
                    } else if (employeeUpdateCommand != null) {
                        Role selectedRole = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                        employee = (Employee) dao.find(Employee.class, Integer.parseInt(employeeId));
                        employee.setName(employeeName);
                        employee.setRole(selectedRole);

                        dao.update(employee);
                        employee = null;

                        out.write("<script type='text/javascript'>\n");
                        out.write("alert(' Employee Updated Successfully ');\n");
                        out.write("setTimeout(function(){window.location.href='EmployeeManager.jsp'},1000);");
                        out.write("</script>\n");
                    }
                    
                } catch (Exception ex) {
                    ex.printStackTrace();
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert(' Error Occured Unexpectedly. Try Again. ');\n");
                    out.write("setTimeout(function(){window.location.href='index.jsp'},1000);");
                    out.write("</script>\n");
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

                                <option value="">-</option>

                                <%                                    for (Iterator iter = dao.findAll(Role.class).iterator();
                                            iter.hasNext();) {
                                        Role element = (Role) iter.next();
                                        String x = "";
                                        if ((employee != null) && (element.getRoleId() == employee.getRole().getRoleId())) {
                                            x = "selected";
                                        }
                                        out.println("<option value='" + element.getRoleId() + "' " + x + " >" + element.getTitle() + "</option>");
                                    }

                                %>
                            </select>                        
                        </td>
                    </tr>                    
                    <tr>
                        <td>
                            <input type="submit" name="<% if (employee != null) {
                                    out.print("employeeUpdateCommand");
                                } else {
                                    out.print("employeeCreateCommand");
                                }%>" value="<% if (employee != null) {
                                        out.print("Update");
                                    } else {
                                        out.print("Create");
                                    }%>">
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
