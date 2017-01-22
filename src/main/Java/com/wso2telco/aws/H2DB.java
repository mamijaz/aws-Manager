package com.wso2telco.aws;

import org.apache.log4j.Logger;

import java.sql.*;

/**
 * Created by ijaz-wso2telco on 11/24/2016.
 */
public class H2DB {

    private static final Logger LOG = Logger.getLogger((String)H2DB.class.getName());

    private static Connection conn=null;

    static {
        try {
            Class.forName("org.h2.Driver");
            conn = DriverManager.getConnection("jdbc:h2:~/awsDB", "admin", "");
        }
        catch (ClassNotFoundException ex){
            LOG.error(ex.getMessage());
        }
        catch (SQLException ex){
            LOG.error(ex.getMessage());
        }
    }
    private static Connection getConnection(){
        return conn;
    }


    public static ResultSet getServers()throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        ResultSet rs=statement.executeQuery("SELECT * FROM SERVERS");
        return rs;
    }

    public static ResultSet getAssingedServers(String userName)throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        ResultSet rs=statement.executeQuery("SELECT * FROM SERVERS  INNER JOIN USER_SERVERS ON SERVERS.INSTANCEID =USER_SERVERS.INSTANCEID WHERE USER_SERVERS.USERNAME=\'"+userName+"\'");
        return rs;
    }

    public static ResultSet getUnAssingedServers(String userName)throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        ResultSet rs=statement.executeQuery("SELECT * FROM SERVERS EXCEPT SELECT * FROM SERVERS  RIGHT JOIN USER_SERVERS ON SERVERS.INSTANCEID =USER_SERVERS.INSTANCEID ");
        return rs;
    }

    public static void addServer(String instanceID,String region,String name)throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        statement.execute("INSERT INTO  SERVERS VALUES (\'"+instanceID+"','"+region+"\',\'"+name+"\')");
    }

    public static void removeServer(String instanceID) throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        statement.execute("DELETE FROM SERVERS WHERE INSTANCEID='" + instanceID+ "'");
    }

    public static ResultSet getUsers() throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        ResultSet rs=statement.executeQuery("SELECT * FROM USERS ");
        return rs;
    }

    public static void addUsers(String userName,String password,String userType) throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        statement.execute("INSERT INTO  USERS VALUES (\'"+userName+"','"+password+"\',\'"+userType+"\')");
    }

    public static void removeUser(String userID) throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        statement.execute("DELETE FROM USERS WHERE USERNAME ='" + userID+ "'");
    }

    public static String login(String userID,String password) throws SQLException{
        Connection conn=getConnection();
        Statement statement = conn.createStatement();
        ResultSet rs=statement.executeQuery("SELECT * FROM USERS WHERE USERNAME ='" + userID+ "'");
        if(rs.next()){
            if(rs.getString("PASSWORD").equals(password)) {
                return rs.getString("TYPE");
            }
        }
        return "invalid";
    }

}
