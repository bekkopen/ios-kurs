package no.bekk.ioskurs;

import java.util.HashMap;

public class AllPosts {
    public static HashMap<String, String> posts = new HashMap<String, String>();

    public static void addPost(String from, String message){
        posts.put(from, message);
    }

}