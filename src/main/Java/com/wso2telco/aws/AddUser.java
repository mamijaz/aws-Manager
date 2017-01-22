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
public class AddUser extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Logger LOG = Logger.getLogger((String)AddUser.class.getName());

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        try {
            HttpSession session = request.getSession();
            H2DB.addUsers(userName, password, userType);
            LOG.info(session.getAttribute("username") + " created the User " + userName);
        }
        catch (SQLException ex){
            LOG.error(ex.getMessage());
        }

    }
}
