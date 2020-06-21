package vo;

import java.util.List;

public class Page<T> {
    private int allPageNum, currentPageNum, count;
    private List<T> list;

    public int getAllPageNum() {
        return allPageNum;
    }

    public void setAllPageNum(int allPageNum) {
        this.allPageNum = allPageNum;
    }

    public int getCurrentPageNum() {
        return currentPageNum;
    }

    public void setCurrentPageNum(int currentPageNum) {
        this.currentPageNum = currentPageNum;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
