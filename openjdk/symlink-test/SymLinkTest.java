import java.nio.file.Path;
import java.nio.file.Paths;

class SymLinkTest {

    public static void main(String[] args) throws Exception {        
        Path path = Paths.get(args[0]);
        System.out.println("Path: " + args[0]);        
        System.out.println("toRealPath: " + path.toRealPath());
    }
}
