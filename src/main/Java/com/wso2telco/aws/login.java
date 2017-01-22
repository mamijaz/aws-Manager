package com.wso2telco.aws;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Created by ijaz-wso2telco on 11/28/2016.
 */
public class login extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Logger LOG = Logger.getLogger((String)login.class.getName());

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            LOG.info("login request recived with user name "+username+" and password ##########");
            String type = H2DB.login(username, password);
            PrintWriter out = response.getWriter();
            out.write(type);
        }
        catch (SQLException ex){
            LOG.error(ex.getMessage());
        }

    }
}
