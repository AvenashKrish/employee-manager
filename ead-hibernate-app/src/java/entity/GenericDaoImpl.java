/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.SessionFactoryUtil;

/**
 *
 * @author Avenash
 * @param <T>
 * @param <PK>
 */
public class GenericDaoImpl<T> implements GenericDao<T> {

    @Override
    public void create(T t) {
        Transaction tx = null;
        Session session = SessionFactoryUtil.getCurrentSession();
        try {
            tx = session.beginTransaction();
            session.save(t);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null && tx.isActive()) {
                try {
                    // Second try catch as the rollback could fail as well
                    tx.rollback();
                } catch (HibernateException e1) {
                    System.out.println("Error rolling back transaction");
                }
                // throw again the first exception
                throw e;
            }
        }
    }

    @Override
    public T find(T t) {
        return null;
    }

    @Override
    public List<T> findAll() {        
        return null;
    }
    
    @Override
    public void update(T t) {
    }

    @Override
    public void delete(T t) {
    }

}
