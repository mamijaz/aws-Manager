package com.wso2telco.aws;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by ijaz-wso2telco on 11/28/2016.
 */
public class RemoveUser extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Logger LOG = Logger.getLogger((String)RemoveUser.class.getName());

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String user_name = request.getParameter("user_name");

        try {
            HttpSession session = request.getSession();
            H2DB.removeUser(user_name);
            LOG.info(session.getAttribute("username") + " removed the user with username " + user_name);
        }
        catch (SQLException ex){
            LOG.error(ex.getMessage());
        }

    }
}
