package utils;

public class StringUtil {
    public static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    public static boolean hasEmpty(String... str) {
        if (str == null) return true;
        for (String s : str)
            if (isEmpty(s)) return true;
        return false;
    }
}
