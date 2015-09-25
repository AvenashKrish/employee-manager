<%-- 
    Document   : RoleManager
    Created on : Sep 19, 2015, 12:21:47 PM
    Author     : Avenash
--%>

<%@page import="java.util.List"%>
<%@page import="entity.Role"%>
<%@page import="entity.GenericDaoImpl"%>
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
        <div class="header">
            <h1>Employee Manager Application</h1>
        </div>
        <div class="page-content">      
            <h2>Manage Roles</h2>

            <%
                Role role = null;
                boolean isUpdate = false;

                GenericDaoImpl<Role> dao = new GenericDaoImpl<Role>(Role.class);

                String roleId = request.getParameter("roleId");
                String roleTitle = request.getParameter("roleTitle");
                String roleCreateCommand = request.getParameter("roleCreateCommand");
                String roleUpdateCommand = request.getParameter("roleUpdateCommand");
                String roleSingleDeleteCommand = request.getParameter("roleSingleUpdateCommand");
                String roleSingleSelectCommand = request.getParameter("roleSingleSelectCommand");

                if ((roleSingleSelectCommand != null) && (roleId != null)) {
                    List<Role> allRoles = dao.findAll();
                    for (Role item : allRoles) {
                        if (item.getRoleId() == Integer.parseInt(roleId)) {
                            role = item;
                        }
                    }
                }

                if ((roleSingleDeleteCommand != null) && (roleId != null)) {

                }

                if ((role == null) && (roleId != null) && (roleTitle != null)) {
                    role = new Role();
                    role.setRoleId(Integer.parseInt(roleId));
                    role.setTitle(roleTitle);
                }

                if (role != null) {
                    if (roleCreateCommand != null) {
                        dao.create(role);
                    } else if (roleUpdateCommand != null) {
                        dao.update(role);
                    }
                }
            %>

            <form method="POST" action="RoleManager.jsp">
                <table>
                    <tr>
                        <td>Role ID</td>                        
                        <td><input type="text" name="roleId" placeholder="(auto)" disabled value="<% if (role != null) role.getRoleId(); %>"></td>
                    </tr>
                    <tr>
                        <td>Title</td>
                        <td><input type="text" name="roleTitle" required value="<% if (role != null) role.getTitle(); %>"> </td>
                    </tr>
                    <tr>
                        <td>
                            <!--<input type="Reset" value="New">-->
                            <input type="submit" name="roleCreateCommand" value="Create">
                            <input type="submit" name="roleUpdateCommand" value="Update">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </form>
            <div>
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
                        for (Iterator iter = dao.findAll().iterator(); iter.hasNext();) {
                            Role element = (Role) iter.next();
                            out.println("<tr>");
                            out.println("   <form method='POST' action='RoleManager.jsp'>");
                            out.println("       <td>" + element.getRoleId() + "<input type='hidden' name='roleId' value='"
                                    + element.getRoleId() + "'>" + "</td>");
                            out.println("       <td>" + element.getTitle() + "</td>");
                            out.println("       <td>" + "<input type='submit' name='roleSingleSelectCommand' value='Select'>" + "</td>");
                            out.println("       <td>" + "<input type='submit' name='roleSingleDeleteCommand' value='Delete'>" + "</td>");
                            out.println("   </form>");
                            out.println("</tr>");
                        }
                    %>
                </table>
            </div>            
        </div>
        <footer>
            <hr>
            <p>Assignment 2 - Enterprise Application Development 2015</p>
        </footer>
    </body>
</html>
