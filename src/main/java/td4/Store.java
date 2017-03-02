package td4;

/**
 * Created by wgata on 02/03/17.
 */
public interface Store {
    String name();
    int size();
    long at(int index);
    void add(int index, long amount);
    void substract(int index, long amount);
}
