package com.whiteboard;
public class Activity {
    private String username;
    private String actionText;
    public Activity(String username, String actionText) {
        this.username = username;
        this.actionText = actionText;
    }
    public String getUsername() { return username; }
    public String getActionText() { return actionText; }
}