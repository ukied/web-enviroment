# 并行工作进程数
workers = 1
# 指定每个工作者的线程数
threads = 1
# 监听内网端口
bind = '0.0.0.0:5550'
# 工作模式协程
worker_class = 'gevent'
# 设置最大并发量
worker_connections = 1000
# 设置进程文件目录
pidfile = 'gunicorn.pid'
# 设置访问日志和错误信息日志路径
accesslog = 'gunicorn_access.log'
errorlog = 'gunicorn_error.log'
# 设置日志记录水平
loglevel = 'info'
# 代码发生变化是否自动重启
reload = True