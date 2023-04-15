
package DAO;

import java.util.ArrayList;

public interface DAOInterface <T> {
    public int insert(T t);
    public int update(T t);
    public int delete(String id);
    public ArrayList<T> selectAll();
    public T selectById(String id);
    public ArrayList<T> selectByGivenCondition(String condition);
}
