# Project 12: 42_inception

## Setting up three containers: wordpress, mariadb and nginx using dockerfiles and docker-compose, in a VM Ubuntu.
</br>

[![opacaud's 42 inception Score](https://badge42.vercel.app/api/v2/cl2g6sk3a013609l6l237136q/project/2487499)](https://github.com/JaeSeoKim/badge42)
</br>
</br>

I designed my Makefile so that it calls ```docker-compose -f docker-compose.yml up --detach --build```
</br>

The point is to set up a wordpress with our own NGINX server and mariadb SQL database.
</br>

I learned about docker, dockerfiles, docker-compose, wordpress.
</br>
</br>

* Run ```make```
* Wait...
* Once all three images are created and containers are up, open a navigator window
* Go to https://opacaud.42.fr
* Depending on the navigator you are using, the following steps may slightly differ but the spirit remains the same: you have to accept the risk to go on a site self-certified
  * click on "Advanced"
  * accept the risk and continue to https://opacaud.42.fr
</br>

The wordpress homepage appears.
</br>

I can then log in with either my author or my admin account. I can comment, edit the site, the articles.
</br>

To access the containers, you have to go back to the terminal and run ```docker exec -ti <container_name> bash```.
</br>

That is for instance how I check my database. By lauching bash in the mariadb container, connecting to mariadb with -u root -p and entering the right password.
</br>

I can then simply send SQL requests:
* SHOW databases;
* USE wordpress;
* SHOW tables;
* SELECT comment_author,comment_content FROM wp_comments;
</br>
