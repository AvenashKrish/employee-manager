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
 */
public interface GenericDao {      
    void create(Object t);
    void update(Object t);
    void delete(Object t);
    Object find(Class clazz, int id);
    List findAll(Class clazz);
}
