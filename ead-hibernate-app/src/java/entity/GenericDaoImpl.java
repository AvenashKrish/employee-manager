/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.Iterator;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.SessionFactoryUtil;

/**
 *
 * @author Avenash
 * @param <T>
 */
public class GenericDaoImpl<T> implements GenericDao<T> {

    private Class<T> type;

    private GenericDaoImpl() {

    }

    public GenericDaoImpl(Class<T> type) {
        this.type = type;
    }

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
    public void update(T t) {
        Transaction tx = null;
        Session session = SessionFactoryUtil.getCurrentSession();
        try {
            tx = session.beginTransaction();
            session.update(t);
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
    public void delete(T t) {
        Transaction tx = null;
        Session session = SessionFactoryUtil.getCurrentSession();
        try {
            tx = session.beginTransaction();
            session.delete(t);
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
    public List<T> findAll() {
        Transaction tx = null;
        Session session = SessionFactoryUtil.getCurrentSession();
        try {
            tx = session.beginTransaction();
            List entities = session.createCriteria(this.type).list();
            System.out.println("*** Start ***");
            for (Iterator iter = entities.iterator(); iter.hasNext();) {
                T element = (T) iter.next();
                System.out.println(element);
            }
            System.out.println("*** End ***");
            tx.commit();

            return entities;

        } catch (HibernateException e) {
            if (tx != null && tx.isActive()) {
                try {
                    // Second try catch as the rollback could fail as well
                    tx.rollback();
                } catch (HibernateException e1) {
                    System.out.println("Error rolling back transaction");
                }
                throw e;
            }
        }

        return null;
    }

}
