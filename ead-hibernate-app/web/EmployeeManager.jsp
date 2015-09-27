<%-- 
    Document   : EmployeeManager
    Created on : Sep 19, 2015, 5:06:08 PM
    Author     : Avenash
--%>

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

        <style>
            @font-face{font-family: Lobster;src: url('Lobster.otf');}
            //body{width:750px;margin:0px auto;}
            .space{margin-bottom: 4px;}
            .txt{width:250px;border:1px solid #00BB64; height:30px;border-radius:3px;font-family: Lobster;font-size:20px;color:#00BB64;}
            .but{width:250px;background:#00BB64;border:1px solid #00BB64;height:40px;border-radius:3px;color:white;margin-top:10px;}
        </style>

        <script src="scripts/jquery-1.11.2.min.js" type="text/javascript"></script>
        <script src="scripts/app.js" type="text/javascript"></script>

        <script>

        </script>

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

                if ((employeeSingleSelectCommand != null) && (roleId != null)) {
                    employee = (Employee) dao.find(Employee.class, Integer.parseInt(roleId));
                }

                if (employeeCreateCommand != null) {
                    employee = new Employee();
                    employee.setName(employeeName);
                    employee.setRole((Role)dao.find(Role.class, Integer.parseInt(roleId)));
                    dao.create(employee);
                    employee = null;

                } else if (employeeUpdateCommand != null) {
                    employee = new Employee();
                    employee.setEmployeeId(Integer.parseInt(employeeId));
                    employee.setName(employeeName);
                    employee.setRole((Role)dao.find(Role.class, Integer.parseInt(roleId)));
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
                            <div>
                                <form>
                                    <input type="text" name="taskDesc" style="width: 150px; " required />
                                    <input type="button" name="taskCreateCommand" id="btnTaskAdd" value="Add" />
                                </form>
                                <br />
                                <br />
                            </div>
                            <table>
                                <tr>
                                    <th>ID</th>
                                    <th>Description</th>                                    
                                    <th></th>
                                    <th></th>
                                </tr>
                                <%
                                    if (employee != null) {
                                        for (Iterator iter = employee.getTasks().iterator(); iter.hasNext();) {
                                            Task element = (Task) iter.next();
                                            out.println("<tr>");
                                            out.println("   <form>");
                                            out.println("       <td>" + element.getTaskId() + "<input type='hidden' name='employeeId' value='"
                                                    + element.getTaskId() + "'>" + "</td>");
                                            out.println("       <td>" + element.getDescription() + "</td>");
                                            out.println("       <td>" + "<input type='submit' name='employeeSingleSelectCommand' value='Select'>" + "</td>");
                                            out.println("       <td>" + "<input type='submit' name='employeeSingleDeleteCommand' value='Delete'>" + "</td>");
                                            out.println("   </form>");
                                            out.println("</tr>");
                                        }
                                    }
                                %>
                            </table>
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
