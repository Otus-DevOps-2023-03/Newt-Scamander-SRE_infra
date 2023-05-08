# Newt-Scamander-SRE_infra
Newt-Scamander-SRE Infra repository
# Lesson 5. Homework 3 (Meeting with cloud infrastructure. Yandex Cloud)
## Рапорт
### Товарища майор:

задание выполнено!
1. приватные ключи - в кейпасе, шарятся в хост только после подключения вашего аппаратного ключа, при блокировке базы - удаляются из кеша.
2. в etc/.ssh/ - только публичные ключи и конфигурационный файл для распределения по подключаемым хостам.
3. подключение к jump-host (выполнено успешно):
```
ssh -J some-name@jump-host-ip:port the-same-name@internal-host-ip -p port
```


4. Для вашего удобства  создан alias позволяющий попасть сразу во внутренний хост по команде:
```
ssh otus-int-host1
```

5. параметры ssh/config:
```
Host otus-jh_yandex_cloud
 Hostname 158.160.0.243
 IdentityFile ~/.ssh/ya-cloud-otus-key.pub

Host otus-int-host1
 Hostname 10.129.0.32
 ProxyJump otus-jh_yandex_cloud
 User localuser
 IdentityFile ~/.ssh/ya-cloud-otus-key.pub
```
6. pritunl - при вскрытии оказался openvpn, мы его вскрывать умеем, я вам показывал ранее.

7. Для прикрытия пришлось поднять вместе со сгенерированным валидным ssl для web админки:
https://158.160.28.114.sslip.io/login

8.  Дублирую данные для подключения:

bastion_IP = 158.160.28.114
someinternalhost_IP = 10.129.0.32

9. Репы студентов посмотрел, у кого приватные ключи были - скопировал - у вас на рабочем столе в соответствующей папочке.



Прошу увольнительную до 10 мая включительно.

### Usefull commands:

ssh:

```
ssh-add -L
# show added ssh-key in cache
```
# Lesson 6. Homework 4 (deploy test cloud-application)


## Information for Testapp branch:
testapp_IP = 51.250.91.9

testapp_port = 9292
- `this IP will change after next deploy. Output should be used instead! {network_interfaces:index:primary_v4_address:one_to_one_nat:address:<IP>`


Custom scripts for ruby&mongo&deploy:
> install_mongodb.sh

> install_ruby.sh

> deploy.sh


Usefull script:
```
startup.sh
```
- `will be create vm && deploy application`

### Usefull commands:
```
yc compute instance list
yc config list
yc config profile list
yc config profile get cloud-otus-sea-profile
yc compute image list --folder-id standard-images | grep ubuntu
#if you create ssh-key.pub, default user for them: ya-user,
alternative- using cloud-config
#
```
