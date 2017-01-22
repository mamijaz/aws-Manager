package com.wso2telco.aws;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.ec2.AmazonEC2;
import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.model.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class AWS {

    static AmazonEC2 ec2 ;
    private static HashMap<String,String> serverLocation=new HashMap<>();

    public AWS(Regions region){
        try{
            AWSCredentials credentials = new PropertiesCredentials(AWS.class.getResourceAsStream("AWSPropertys.properties"));
            ec2 = new AmazonEC2Client(credentials).withRegion(region);
        }catch(IOException ex){
            ex.printStackTrace();
        }
    }

    public String getStatus(String ins_id){
        try {
            DescribeInstancesResult describeInstances = ec2.describeInstances();
            List<Reservation> reservations = describeInstances.getReservations();
            for (Reservation reservation : reservations) {
                List<Instance> instances = reservation.getInstances();
                for (Instance instance : instances) {
                    if(instance.getInstanceId().equals(ins_id)){
                        return instance.getState().getName();
                    }
                }
            }
            return "Unknown";
        }catch (Exception ex){
            ex.printStackTrace();
            return "Error";
        }
    }

    public  boolean stopInstance(String ins_id){
        try{
            StopInstancesRequest stoptRequest = new StopInstancesRequest().withInstanceIds(ins_id);
            ec2.stopInstances(stoptRequest);
            return true;
        }catch (Exception ex){
            ex.printStackTrace();
            return false;
        }
    }

    public boolean startInstance(String ins_id){
        try{
            StartInstancesRequest startRequest = new StartInstancesRequest().withInstanceIds(ins_id);
            ec2.startInstances(startRequest);
            return true;
        }catch (Exception ex){
            ex.printStackTrace();
            return false;
        }
    }


    public static String getServerLocationName(String key){
        return serverLocation.get(key);
    }

    static {
        serverLocation.put("US_EAST_1","N. Virginia");
        serverLocation.put("US_EAST_2","Ohio");
        serverLocation.put("US_WEST_1","N. California");
        serverLocation.put("US_WEST_2","Oregon");
        serverLocation.put("EU_WEST_1","Ireland");
        serverLocation.put("EU_CENTRAL_1","Frankfurt");
        serverLocation.put("AP_NORTHEAST_1","Tokyo");
        serverLocation.put("AP_NORTHEAST_2","Seoul");
        serverLocation.put("AP_SOUTHEAST_1","Singapore");
        serverLocation.put("AP_SOUTHEAST_2","Sydney");
        serverLocation.put("AP_SOUTH_1","Mumbai");
        serverLocation.put("SA_EAST_1","São Paulo");
    }
}