
rmdir symlink-directory
rmdir real-directory

mkdir real-directory
mklink /D symlink-directory real-directory

java -cp . SymLinkTest real-directory
java -cp . SymLinkTest symlink-directory