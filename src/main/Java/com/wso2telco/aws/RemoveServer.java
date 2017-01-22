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
 * Created by ijaz-wso2telco on 11/25/2016.
 */
public class RemoveServer extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Logger LOG = Logger.getLogger((String)RemoveServer.class.getName());

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String ins_id = request.getParameter("ins_id");

        try {
            HttpSession session = request.getSession();
            H2DB.removeServer(ins_id);
            LOG.info(session.getAttribute("username") + " removed the server with instance id " + ins_id);
        }
        catch (SQLException ex){
            LOG.error(ex.getMessage());
        }

    }

}
