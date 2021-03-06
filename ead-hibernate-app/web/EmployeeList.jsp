<%-- 
    Document   : EmployeeList
    Created on : Sep 27, 2015, 5:33:02 PM
    Author     : Avenash
--%>

<%@page import="entity.Task"%>
<%@page import="entity.GenericDaoImpl"%>
<%@page import="entity.Employee"%>
<%@page import="entity.GenericDao"%>
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

        <%
            //Generic Data Access Object Creation
            GenericDaoImpl dao = new GenericDaoImpl();

            //Retreiving Query String Parameters
            String employeeId = request.getParameter("employeeId");
            String employeeSingleSelectCommand = request.getParameter("employeeSingleSelectCommand");
            String employeeSingleDeleteCommand = request.getParameter("employeeSingleDeleteCommand");

            //Handling of Select Employee
            if ((employeeId != null) && (employeeSingleSelectCommand != null)) {
                response.sendRedirect("EmployeeManager.jsp?employeeId=" + employeeId + "&employeeSingleSelectCommand=" + employeeSingleSelectCommand);
            }

            //Handling of Delete Employee
            if ((employeeId != null) && (employeeSingleDeleteCommand != null)) {
                Employee deletingEmployee = (Employee) dao.find(Employee.class, Integer.parseInt(employeeId));
                for (Object element : deletingEmployee.getTasks()) {                    
                    ((Task)element).setEmployee(null);
                    dao.update(element);
                }
                dao.delete(deletingEmployee);
                
                //response.sendRedirect("EmployeeList.jsp");

                out.write("<script type='text/javascript'>\n");
                out.write("alert(' Employee Deleted Successfully ');\n");
                out.write("setTimeout(function(){window.location.href='EmployeeList.jsp'},1000);");
                out.write("</script>\n");
            }

        %>

        <div class="header">
            <a href="index.jsp"><h1>Human Resource Application</h1></a>            
        </div>
        <div class="page-content">      
            <h2>Employee List</h2>
            <table>
                <tr>
                    <th>Employee ID</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th></th>
                    <th></th>
                </tr>

                <%                    for (Iterator iter = dao.findAll(Employee.class).iterator(); iter.hasNext();) {
                        Employee element = (Employee) iter.next();
                        out.println("<tr>");
                        out.println("   <form>");
                        out.println("       <td>" + element.getEmployeeId() + "<input type='hidden' name='employeeId' value='"
                                + element.getEmployeeId() + "'>" + "</td>");
                        out.println("       <td>" + element.getName() + "</td>");
                        out.println("       <td>" + element.getRole().getTitle() + "</td>");
                        out.println("       <td>" + "<input type='submit' name='employeeSingleSelectCommand' value='Select'>" + "</td>");
                        out.println("       <td>" + "<input type='submit' name='employeeSingleDeleteCommand' value='Delete'>" + "</td>");
                        out.println("   </form>");
                        out.println("</tr>");
                    }
                %>

            </table>
        </div>
        <footer>
            <hr>
            <p>Assignment 2 - Enterprise Application Development 2015</p>
        </footer>
    </body>
</html>
