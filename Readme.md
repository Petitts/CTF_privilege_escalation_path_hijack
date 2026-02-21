# CTF_privilege_escalation_path_hijack

User credentials: ctf:qwerty123

Access: SSH, port 2222

## Launch

> docker build -t privesc-ctf .
> 
> docker run -d -p 2222:22 --name privesc privesc-ctf

## Suplementary materials:

> https://www.hackingarticles.in/linux-privilege-escalation-using-path-variable/
>
> https://vk9-sec.com/privilege-escalation-linux-path-hijacking/
>
> https://medium.com/@corentin_mh/path-hijacking-a-way-to-lead-to-privesc-b33af710bdca
