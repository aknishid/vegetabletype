# vegetabletype
## 仮想apacheサーバー起動手順
```aidl
docker build -t myhttpd:1.0 /Users/akie/Desktop/Workspace/vegetabletype/ --no-cache
docker image ls
docker run -p 8081:80 --name akn_centos -d -t -i --privileged myhttpd:1.0 /sbin/init
docker ps
docker exec -it akn_centos /bin/bash
```


