#vegetabletype

- 仮想apacheサーバー起動手順
```aidl
docker build -t myhttpd:1.0 /Users/akie/Desktop/Workspace/vegetabletype/ --no-cache
docker image ls
docker run -p 8081:80 --name akn_centos -d -t -i --privileged myhttpd:1.0 /sbin/init
docker ps
docker exec -it akn_centos /bin/bash
```
- apache起動
```aidl
systemctl enable httpd.service
systemctl start httpd
```
- デプロイ
```aidl
cd
git clone https://github.com/aknishid/vegetabletype.git
chmod +x bin/fetch
su -l root
/root/vegetabletype/deploy
```

- 各種設定

```aidl
useradd -m -u 2000 www-data
chown -R www-data:www-data /var/www/vegetabletype_contents/
chmod 777 /var/www/vegetabletype_contents/.git/FETCH_HEAD

vim /etc/httpd/conf/httpd.conf 

<Directory /var/www/vegetabletype>
  Options -Indexes -FollowSymLinks +MultiViews +ExecCGI
  AllowOverride None
  Order allow,deny
  Allow from all
  AddHandler cgi-script .cgi
</Directory>

<IfModule dir_module>
    DirectoryIndex index.cgi

Alias /pages /var/www/vegetabletype_contents/pages
Alias /posts /var/www/vegetabletype_contents/posts

<Directory /var/www/vegetabletype_contents>
  Options -Indexes -FollowSymLinks
  AllowOverride None
  Order allow,deny
  Allow from all
</Directory>
```

- 実行権限
```aidl
chmod +x fetch_xxxxx.cgi 
```

