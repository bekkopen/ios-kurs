package no.bekk.ioskurs;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.HashSet;
import java.util.Set;

public class AllPosts {
    public static Set<Post> posts = new HashSet<Post>();

    public static void addPost(String from, String message) {

        DateTime dateTime = new DateTime();
        DateTimeFormatter dtf = DateTimeFormat.forPattern("dd/mm/yyyy HH:mm");
        String date = dateTime.toString(dtf);

        posts.add(new Post(from, message, date));
    }

    public static class Post {
        public String from;
        public String message;
        public String date;

        public Post(String from, String message, String date) {
            this.from = from;
            this.message = message;
            this.date = date;
        }

        public String toString(){
            return "ASDFASDF ";
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            Post post = (Post) o;

            if (from != null ? !from.equals(post.from) : post.from != null) return false;
            if (message != null ? !message.equals(post.message) : post.message != null) return false;

            return true;
        }

        @Override
        public int hashCode() {
            int result = from != null ? from.hashCode() : 0;
            result = 31 * result + (message != null ? message.hashCode() : 0);
            return result;
        }
    }

}