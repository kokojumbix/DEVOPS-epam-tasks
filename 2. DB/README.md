## 1 PART

## First of all, mysql needed to be installed.

In case of using "apt":
```sh
sudo apt-get install mysql-server
```

In case of using "yum":
```sh
sudo yum install mariadb-server
```

I'm using Centos with package manager "yum", so there are result of using install command.
![install](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/Screenshots/DB%20task/image.png)

Also for this was written little script, which install db using yum. It has name "installdb.sh".
https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/2.%20DB/installdb.sh

## After install mysql, was created selected subject area and described the database scheme.

Selected subject area: Unified system from various spheres of life. (City-Transport ticket, medical card, passport)

![database_scheme](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/Screenshots/DB%20task/DB_designer_task_1_scheme.png)


## For every subject area needed different access level :

**1 level (Transport controller, Doctor during review):** 

Can read data only in their area. 
(example - Doctor can take information only about medical card)

**2 level** 

Can read and write data only in their area.

**3 level** 

Can read and write data in all areas.




