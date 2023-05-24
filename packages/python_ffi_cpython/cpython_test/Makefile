initialize: initialize.c ../cpython/libpython3.11.so
	rm -f libpython3.11.so
	ln -s ../cpython/libpython3.11.so libpython3.11.so
	gcc -o initialize initialize.c -ldl
	./initialize
