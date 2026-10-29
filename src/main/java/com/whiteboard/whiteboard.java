package com.whiteboard;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/draw")
public class whiteboard {

    private static Set<Session> sessions = new CopyOnWriteArraySet<>();

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }

    @OnMessage
    public void onMessage(String message, Session sender) {

        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}