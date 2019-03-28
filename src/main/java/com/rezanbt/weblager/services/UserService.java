package com.rezanbt.weblager.services;

import com.rezanbt.weblager.entities.User;

public interface UserService {
    void save(User user);

    User findByUserName(String username);
}
