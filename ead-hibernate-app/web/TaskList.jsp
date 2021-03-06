<%-- 
    Document   : TaskList
    Created on : Sep 26, 2015, 11:56:14 AM
    Author     : Avenash
--%>

<%@page import="java.util.Iterator"%>
<%@page import="entity.Task"%>
<%@page import="entity.GenericDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Task List - Human Resource Application</title>        
        <link rel="stylesheet" type="text/css" href="style/theme.css">        
    </head>
    <body>
        
        <%
            
            //Generic Data Access Object Creation
            GenericDaoImpl dao = new GenericDaoImpl();
            
            //Retreiving of Query String Parameters
            String taskId = request.getParameter("taskId");
            String taskSingleSelectCommand = request.getParameter("taskSingleSelectCommand");

            //Handling of Task Select
            if ((taskId != null) && (taskSingleSelectCommand != null)){
                response.sendRedirect("TaskManager.jsp?taskId="+ taskId + "&taskSingleSelectCommand=" + taskSingleSelectCommand);
            }            
        %>
        
        <div class="header">
            <a href="index.jsp"><h1>Human Resource Application</h1></a>            
        </div>
        <div class="page-content">      
            <h2>Task List</h2>
            <table>
                <tr>
                    <th>Task ID</th>
                    <th>Description</th>
                    <th>Assigned to</th>
                    <th></th>
                </tr>

                <%                    for (Iterator iter = dao.findAll(Task.class).iterator(); iter.hasNext();) {
                        Task element = (Task) iter.next();
                        out.println("<tr>");
                        out.println("   <form>");
                        out.println("       <td>" + element.getTaskId()+ "<input type='hidden' name='taskId' value='"
                                + element.getTaskId() + "'>" + "</td>");
                        out.println("       <td>" + element.getDescription() + "</td>");
                        out.println("       <td>" + ((element.getEmployee() != null) ? element.getEmployee().getName() : "-" ) + "</td>");
                        out.println("       <td>" + "<input type='submit' name='taskSingleSelectCommand' value='Select'>" + "</td>");
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
