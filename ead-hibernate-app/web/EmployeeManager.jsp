<%-- 
    Document   : EmployeeManager
    Created on : Sep 19, 2015, 5:06:08 PM
    Author     : Avenash
--%>

<%@page import="entity.Employee"%>
<%@page import="java.util.Iterator"%>
<%@page import="entity.Role"%>
<%@page import="entity.GenericDaoImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Employees - Employee Manager Application</title>        
        <link rel="stylesheet" type="text/css" href="style/theme.css">        

        <style>
            @font-face{font-family: Lobster;src: url('Lobster.otf');}
            //body{width:750px;margin:0px auto;}
            .space{margin-bottom: 4px;}
            .txt{width:250px;border:1px solid #00BB64; height:30px;border-radius:3px;font-family: Lobster;font-size:20px;color:#00BB64;}
            .but{width:250px;background:#00BB64;border:1px solid #00BB64;height:40px;border-radius:3px;color:white;margin-top:10px;}
        </style>

        <script src="scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
        <script src="scripts/app.js" type="text/javascript"></script>

    <body>
        <div class="header">
            <a href="index.jsp"><h1>Employee Manager Application</h1></a>            
        </div>
        <div class="page-content">      
            <h2>Manage Employees</h2>
            <a href="EmployeeManager.jsp">Add New Record</a>
            <br />
            <br />

            <%
                GenericDaoImpl<Role> roleDao = new GenericDaoImpl<Role>(Role.class);
                GenericDaoImpl<Employee> empDao = new GenericDaoImpl<Employee>(Employee.class);
            %>

            <form>
                <table>
                    <tr>
                        <td>Employee ID</td>
                        <td><input type="text" name="employeeId" placeholder="(auto)" disabled></td>
                    </tr>
                    <tr>
                        <td>Name</td>
                        <td><input type="text" name="employeeName"></td>
                    </tr>
                    <tr>
                        <td>Role</td>
                        <td>
                            <select name='customerId' style='width: 150px;' required>
                                <%
                                    for (Iterator iter = roleDao.findAll().iterator(); iter.hasNext();) {
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

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="roleCreateCommand" value="Create">
                            <input type="submit" name="roleUpdateCommand" value="Update">
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
