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
        <title>Manage Roles - Human Resource Application</title>        
        <link rel="stylesheet" type="text/css" href="style/theme.css">        
    </head>
    <body>
        <div class="header">
            <a href="index.jsp"><h1>Human Resource Application</h1></a>            
        </div>
        <div class="page-content">      
            <h2>Manage Roles</h2>            
            <a href="RoleManager.jsp">Add New Record</a>
            <br />
            <br />

            <%
                //Generic Data Access Object Creation
                GenericDaoImpl dao = new GenericDaoImpl();
                Role role = null;

                try {

                    //Retrieving Query String Parameters
                    String roleId = request.getParameter("roleId");
                    String roleTitle = request.getParameter("roleTitle");
                    String roleCreateCommand = request.getParameter("roleCreateCommand");
                    String roleUpdateCommand = request.getParameter("roleUpdateCommand");
                    String roleSingleSelectCommand = request.getParameter("roleSingleSelectCommand");

                    //Handling of Role Select 
                    if ((roleSingleSelectCommand != null) && (roleId != null)) {
                        role = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                    }

                    //Handling of Role Create / Update
                    if (roleCreateCommand != null) {
                        role = new Role();
                        role.setTitle(roleTitle);
                        dao.create(role);
                        role = null;

                        //response.sendRedirect("RoleManager.jsp");
                        
                        out.write("<script type='text/javascript'>\n");
                        out.write("alert(' Role Created Successfully ');\n");
                        out.write("setTimeout(function(){window.location.href='RoleManager.jsp'},1000);");
                        out.write("</script>\n");

                    } else if (roleUpdateCommand != null) {
                        role = (Role) dao.find(Role.class, Integer.parseInt(roleId));
                        role.setTitle(roleTitle);
                        dao.update(role);
                        role = null;

                        //response.sendRedirect("RoleManager.jsp");
                        
                        out.write("<script type='text/javascript'>\n");
                        out.write("alert(' Role Updated Successfully ');\n");
                        out.write("setTimeout(function(){window.location.href='RoleManager.jsp'},1000);");
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
                        <td>Role ID</td>                        
                        <td><input type="text" name="roleId" placeholder="(auto)" readonly value="<% if (role != null) {
                                out.print(role.getRoleId());
                            } else {
                                out.print("");
                            } %>"></td>
                    </tr>
                    <tr>
                        <td>Title</td>
                        <td><input type="text" name="roleTitle" required value="<% if (role != null) {
                                out.print(role.getTitle());
                            } else {
                                out.print("");
                            } %>"> </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" name="<% if (role != null) {
                                    out.print("roleUpdateCommand");
                                } else {
                                    out.print("roleCreateCommand");
                                } %>" value="<% if (role != null) {
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
            <div>
                <hr>
                <h4>Role List</h4>
                <table>
                    <tr>
                        <th>Role ID</th>
                        <th>Title</th>
                        <th></th>
                        <th></th>
                    </tr>
                    <%
                        for (Iterator iter = dao.findAll(Role.class).iterator(); iter.hasNext();) {
                            Role element = (Role) iter.next();
                            out.println("<tr>");
                            out.println("   <form>");
                            out.println("       <td>" + element.getRoleId() + "<input type='hidden' name='roleId' value='"
                                    + element.getRoleId() + "'>" + "</td>");
                            out.println("       <td>" + element.getTitle() + "</td>");
                            out.println("       <td>" + "<input type='submit' name='roleSingleSelectCommand' value='Select'>" + "</td>");
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
