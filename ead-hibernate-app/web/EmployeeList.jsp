<%-- 
    Document   : EmployeeList
    Created on : Sep 27, 2015, 5:33:02 PM
    Author     : Avenash
--%>

<%@page import="entity.GenericDaoImpl"%>
<%@page import="entity.Employee"%>
<%@page import="entity.GenericDao"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Roles - Employee Manager Application</title>        
        <link rel="stylesheet" type="text/css" href="style/theme.css">        
    </head>
    <body>

        <%
            GenericDaoImpl dao = new GenericDaoImpl();
        %>

        <div class="header">
            <a href="index.jsp"><h1>Employee Manager Application</h1></a>            
        </div>
        <div class="page-content">      
            <h2>Employee List</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th></th>
                    <th></th>
                </tr>
                
                <%
                    for (Iterator iter = dao.findAll(Employee.class).iterator(); iter.hasNext();) {
                        Employee element = (Employee) iter.next();
                        out.println("<tr>");
                        out.println("   <form method='POST' action='EmployeeManager.jsp'>");
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
