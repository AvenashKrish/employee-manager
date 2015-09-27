/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
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
public class GenericDaoImpl implements GenericDao {

    public GenericDaoImpl() {

    }

    @Override
    public void create(Object t) {
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
    public void update(Object t) {
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
    public void delete(Object t) {
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
    public List findAll(Class clazz) {
        Transaction tx = null;
        Session session = SessionFactoryUtil.getCurrentSession();
        try {
            tx = session.beginTransaction();
            List entities = session.createCriteria(clazz).list();            
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

    @Override
    public Object find(Class clazz, int id) {
        Transaction tx = null;
        Session session = SessionFactoryUtil.getCurrentSession();
        try {
            return session.get(clazz, id);
        } catch (RuntimeException e) {
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
        return null;
    }

}
