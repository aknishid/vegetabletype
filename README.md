#vegetabletype

- 仮想apacheサーバー起動手順
```
docker build -t myhttpd:1.0 /Users/akie/Desktop/Workspace/vegetabletype/ --no-cache
docker image ls
docker run -p 8081:80 --name akn_centos2 -d -t -i --privileged myhttpd:1.0 /sbin/init
docker ps
docker exec -it akn_centos /bin/bash
```
- apache起動
```
systemctl enable httpd.service
systemctl start httpds
systemctl restart httpd


```
- デプロイ
```
cd
git clone https://github.com/aknishid/vegetabletype.git
chmod +x bin/fetch
su -l root
/root/vegetabletype/deploy

```
- 各種設定

```
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

Alias /pages /var/www/vegetabletype_contents/pages
Alias /posts /var/www/vegetabletype_contents/posts

<Directory /var/www/vegetabletype_contents>
  Options -Indexes -FollowSymLinks
  AllowOverride None
  Order allow,deny
  Allow from all
</Directory>


<IfModule dir_module>
    DirectoryIndex index.cgi


```

- 実行権限
```
chmod +x fetch_xxxxx.cgi 
chmod +x bin/index.cgi 

```

# LIST POSTS DATA
```
cd "$datadir"
find posts pages -type f |
grep created_time |
xargs grep -H . |
sed 's;/created_time:; ;' |
awk '{print $2,$3,$1}' |
sort -k 1,2 |
tee ${tmp}-list |
awk '$3~/^posts/' > ${tmp}-post_list
mv ${tmp}-post_list "$datadir/post_list"

```
# LIST PAGES DATA
```
awk '$3~/^pages/' $tmp-list > $tmp-page_list
mv $tmp-page_list "$datadir/page_list"

```
# MAKE PREV/NEXT NAVIGATION LINK
```
cat "$datadir/post_list" |
while read ymd hms d ; do
    grep -C1 " $d$" "$datadir/post_list" |
    awk '{print $3}' |
    sed -n -e '1p' -e '$p' |
    xargs -I@ cat "$datadir/@/link" |
    awk 'NR<=2{print}END{for(i=NR;i<2;i++){print "LOST TITLE"}}' |
    sed -e 'ls/^/prev:/' -e '2s/^/next:/' |
    tr '\n' ' ' > "$datadir/$d/nav"
done

rm -f ${tmp}-*

```        
                           
=======

- 各種設定

```
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
```
chmod +x fetch_xxxxx.cgi 
```
