# [Puma web server](https://github.com/puma/puma)

Each request is served in a separate thread.
When used with concurrent ruby implementations (like jruby) all available CPU cores will be used.
In MRI there's a global virtual machine lock (GVL), it means that only one thread can run ruby code at a time. But if you do a lot of IO operations the performance will be improved cause blocking IO can run concurrently.

## Thread Pool
Puma uses a thread pool. You can specify minimum and maximum number of them.

## Clustered mode
Clustered mode `forks` workers from a master process. Each child has it's own thread pool.

You can use a `preload` flag. In this way puma will preload your app prior to forking. It'll reduce memory usage because of copy-on-write technique.

## Binding TCP / Sockets
You can use `--b` or `--bind` flag which accepts a uri parameter.
You can bind to TCP, unix or ssl sockets.



