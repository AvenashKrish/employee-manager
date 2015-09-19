/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.util.List;

/**
 *
 * @author Avenash
 * @param <T>
 */
public interface GenericDao<T> {      
    void create(T t);
    void update(T t);
    void delete(T t);
    //T find(T t);
    List<T> findAll();
}
