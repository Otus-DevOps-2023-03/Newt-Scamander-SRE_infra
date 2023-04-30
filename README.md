# Newt-Scamander-SRE_infra
Newt-Scamander-SRE Infra repository
#Рапорт
##Товарища майор:
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
7. Репы студентов посмотрел, у кого приватные ключи были - скопировал - у вас на рабочем столе в соответствующей папочке.

Прошу увольнительную до 2 мая включительно.
