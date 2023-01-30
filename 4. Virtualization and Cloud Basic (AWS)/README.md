## NAVIGATION
1) [Start](#Starting)
2) [EC2](#EC2)
3) [AWS Lambda](#lambda)
4) [Route 53](#Route53) (It didn't work out. I opened case issue)
5) [Lightsail](#Lightsail)
7) [Static website. S3 bucket](#S3)   [Link]()
## Starting
<a name="Starting"></a>
Registered to AWS Cloud and created RDS instance for one of previous tasks (DB).

![image](https://user-images.githubusercontent.com/113692759/215345342-4d0ae174-c52b-4084-a8bd-6d5406375a83.png)

Deleting RDS instance:

![image](https://user-images.githubusercontent.com/113692759/215345705-6293f544-e7cc-4bab-8e1a-c4bbaada9203.png)

![image](https://user-images.githubusercontent.com/113692759/215345778-03384bdd-f96e-4029-8baa-733e41dc926f.png)

![image](https://user-images.githubusercontent.com/113692759/215345844-51f1aecd-9297-4790-a658-a7e44d4eecc3.png)






<a name="EC2"></a>
## Work with EC2 instances


Creating EC2 instance:

![image](https://user-images.githubusercontent.com/113692759/215347251-9f60e886-5a2e-43fc-b18a-20123b06f380.png)

Connect with key file:

![image](https://user-images.githubusercontent.com/113692759/215348937-1deb5745-c3da-4f84-b67d-942f47f7626e.png)

Created snapshot:

![image](https://user-images.githubusercontent.com/113692759/215349547-ab36acde-5650-414f-9cb7-01940dd5a160.png)

Terminating the instance:

![image](https://user-images.githubusercontent.com/113692759/215349624-b5cd8891-8935-410a-b027-d1683566b470.png)

Creating instance from snapshot:

![image](https://user-images.githubusercontent.com/113692759/215451765-3febbdc0-2680-4459-b8b8-1ed479a24990.png)

![image](https://user-images.githubusercontent.com/113692759/215452402-e5baa6f9-dd86-4ce3-bee1-ebc27c3229f8.png)

Connecting in through ssh:

![image](https://user-images.githubusercontent.com/113692759/215453833-3e1d3af0-61df-4865-9b6e-24cd13282f9a.png)

Creating new volume and adding to working machine:

![image](https://user-images.githubusercontent.com/113692759/215459973-3d3b51de-8b75-4203-8df8-21036c0c3b3c.png)

![image](https://user-images.githubusercontent.com/113692759/215460043-c279b0af-cdce-4631-8180-15cc85390117.png)

Creating partition for disk:

![image](https://user-images.githubusercontent.com/113692759/215463820-ec773b8a-c194-483d-a0f7-74e3d2db700b.png)

Formated the disk and mounted it:

![image](https://user-images.githubusercontent.com/113692759/215464230-43121be7-ce1d-4d92-9cf5-95b75855e8bb.png)

Deleted snapshot, to fit in free tier disk sizing:

![image](https://user-images.githubusercontent.com/113692759/215465149-1cf14504-d32e-4d83-a238-d887d8a380e4.png)

Created new EC2 instance:

![image](https://user-images.githubusercontent.com/113692759/215465374-d4b19c4d-b688-493b-b7ea-97e369ab2c1c.png)

![image](https://user-images.githubusercontent.com/113692759/215465883-d2de3a46-a8b9-478b-8a0f-9de6ef2c49a6.png)

Created some files on attached disk:

![image](https://user-images.githubusercontent.com/113692759/215467929-4cf0b04a-bbd8-4236-9c01-8bf343ff43ff.png)

Detached disk:

![image](https://user-images.githubusercontent.com/113692759/215468093-cbadd9a1-8c56-4066-9da9-ecaab4c41b19.png)

Attaching disk to new EC2 instance:

![image](https://user-images.githubusercontent.com/113692759/215469008-29c2c9a0-74e9-4b04-8460-547c8b8f054b.png)

List of files on attached disk:

![image](https://user-images.githubusercontent.com/113692759/215469480-4666ac6b-a77f-42eb-854a-59d4bbd028af.png)


<a name="Lambda"></a>
## AWS Lambda

Created AWS Lambda Function:

![image](https://user-images.githubusercontent.com/113692759/215475705-c9f6ff26-4ffc-48a7-9e99-b84e103636d8.png)

Running test:

![image](https://user-images.githubusercontent.com/113692759/215475777-44fe928d-f237-4e41-baac-9a1af0cf2b45.png)

Running function from url:

![image](https://user-images.githubusercontent.com/113692759/215476155-aa0e2235-4f89-4118-939a-e6c9d149e1b2.png)

Little editing of function:

![image](https://user-images.githubusercontent.com/113692759/215476883-fdb552f9-60de-46f0-888d-8edfd2cb67ba.png)

Executing function:

![image](https://user-images.githubusercontent.com/113692759/215476988-f2392b15-6a7a-4c30-be58-593d429f61e1.png)

<a name="Route53"></a>
## Route 53

Trying to create domain:

![image](https://user-images.githubusercontent.com/113692759/215485431-3ef6f2f4-9852-42bc-a38f-312305d52daa.png)

Domain not created.

<a name="Lightsail"></a>
## AWS Lightsail

Creating an Instance:

![image](https://user-images.githubusercontent.com/113692759/215591008-59a5df70-e6d3-4d4a-b8fa-af2cfc5c5ae3.png)

Connecting to take password:

![image](https://user-images.githubusercontent.com/113692759/215592106-710abea7-b35b-48ce-b5a4-5e53919a7889.png)

Connecting to admin panel in browser:

![image](https://user-images.githubusercontent.com/113692759/215592819-d79df9f9-6189-4da0-bae6-b20c1a4d255e.png)

Modifying theme:

![image](https://user-images.githubusercontent.com/113692759/215593155-3a27159f-77a2-40f9-aa03-655e54525977.png)

Modified site:

![image](https://user-images.githubusercontent.com/113692759/215593297-71f34e0c-32e8-49b2-a5c4-3bb56b32ad3e.png)

Terminating instance:

![image](https://user-images.githubusercontent.com/113692759/215593602-397b4e7c-5d14-4f44-ada2-b932b6cccb72.png)

## AWS S3

Creating bucket:

![image](https://user-images.githubusercontent.com/113692759/215595507-a630071a-99ab-46b6-9b84-5d5065e894d4.png)

![image](https://user-images.githubusercontent.com/113692759/215595844-e975bd8e-4767-4835-ac8b-dde4788c4c68.png)

Editing static hosting parameter:

![image](https://user-images.githubusercontent.com/113692759/215596684-c6764ca7-516a-44d7-871c-7e0b802f8453.png)

Creating files on static website:

![image](https://user-images.githubusercontent.com/113692759/215602321-25913be5-fa9c-4bd7-8588-a52c5fffd7d3.png)

Finded template and modified:

![image](https://user-images.githubusercontent.com/113692759/215607674-6afdda0a-a877-4c83-9e22-6f3a50dc8946.png)

[Link to bucket](https://localhorsebucket.s3.us-east-1.amazonaws.com/index.html)



