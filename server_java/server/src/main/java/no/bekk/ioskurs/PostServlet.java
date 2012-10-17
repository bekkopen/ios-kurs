package no.bekk.ioskurs;

import com.google.gson.Gson;
import com.google.gson.stream.JsonReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Collection;

public class PostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");

        String from = req.getParameter("from");
        String message = req.getParameter("message");
        if (from != null) {
            out.println(String.format("Mottatt post fra %s message %s", from, message));
            AllPosts.addPost(from, message);
        } else {
            out.println("Mangler from eller message");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");

        String from = req.getParameter("from");
        String message = req.getParameter("message");

        if (from == null) {
            out.println("Mangler from eller message");
        } else {
            AllPosts.addPost(from, message);
            out.println(String.format("Mottatt post fra %s message %s", from, message));
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        AllPosts.Post post = gson.fromJson(req.getReader(), AllPosts.Post.class);
        AllPosts.addPost(post.from, post.message);

        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        out.write(gson.toJson(post));
    }
}
