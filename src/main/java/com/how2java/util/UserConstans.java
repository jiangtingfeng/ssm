package com.how2java.util;


import com.how2java.pojo.User;

import java.io.*;

public class UserConstans {

    public boolean saveUser(User user) throws IOException {
        boolean result = true;
        File file = new File("D:\\project\\ssm\\user.txt");
        FileOutputStream fos = new FileOutputStream(file);
        ObjectOutputStream oos = new ObjectOutputStream(fos);
        oos.writeObject(user);
        oos.flush();
        oos.close();
        if(file.length() == 0){
            result = false;
        }
        return result;
    }
    public User getUser(){
        User user = new User();
        File file = new File("D:\\project\\ssm\\user.txt");
        try(FileInputStream fis = new FileInputStream(file);
                ObjectInputStream ois = new ObjectInputStream(fis)){
           user = (User) ois.readObject();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return user;
    }
}
