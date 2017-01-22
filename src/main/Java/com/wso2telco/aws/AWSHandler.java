package com.wso2telco.aws;

import com.amazonaws.regions.Regions;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by ijaz-wso2telco on 11/20/2016.
 */
public class AWSHandler extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Logger LOG = Logger.getLogger((String)AWSHandler.class.getName());

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String type = request.getParameter("type");
        String region = request.getParameter("region");
        String ins_id = request.getParameter("ins_id");

        PrintWriter out =response.getWriter();
        if(type.equals("Update")){
            try {
                String state=new AWS(Regions.valueOf(region)).getStatus(ins_id);
                out.write(state);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        String type = request.getParameter("type");
        String region = request.getParameter("region");
        String ins_id = request.getParameter("ins_id");

        HttpSession session = request.getSession();
        LOG.info(session.getAttribute("username")+" "+ type +" the server in region "+region+" with instance id "+ins_id);

        if(type.equals("Start")){
            try {
                new AWS(Regions.valueOf(region)).startInstance(ins_id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else if(type.equals("Stop")){
            try {
                new AWS(Regions.valueOf(region)).stopInstance(ins_id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
