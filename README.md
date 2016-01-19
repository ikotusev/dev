```
EMAIL=ilia.kotusev@revelsystems.com
FULL=`getent passwd $USER|cut -d: -f5|cut -d, -f1`

docker create --name dev quay.io/ikotusev/dev:v1.0
docker start dev

docker exec dev adduser -D -s /bin/bash -g "$FULL,,,$EMAIL" -u `id -u` $USER
docker exec dev passwd -u $USER
docker exec dev su -lc "git config --global user.name \"$FULL\"" $USER
docker exec dev su -lc "git config --global user.email $EMAIL" $USER
HOME=`docker exec dev getent passwd $USER|cut -d: -f6`
docker exec dev mkdir -p $HOME/.config/git $HOME/.ssh
for file in bashrc profile tmux.conf; do cat $file|docker exec -i dev sh -c "cat>$HOME/.$file"; done
cat gitignore|docker exec -i dev sh -c "cat>$HOME/.config/git/ignore"
cat ~/.ssh/id_rsa|docker exec -i dev sh -c "cat>$HOME/.ssh/id_rsa"
cat ~/.ssh/id_rsa.pub|docker exec -i dev sh -c "tee $HOME/.ssh/id_rsa.pub >$HOME/.ssh/authorized_keys"
docker exec dev chmod 400 $HOME/.ssh/id_rsa
docker exec dev sh -c "echo export TERM=$TERM >>$HOME/.bashrc"
docker exec dev chown -R $USER:$USER $HOME
docker exec dev sh -c "echo \"%$USER ALL=(ALL) NOPASSWD: ALL\" >/etc/sudoers.d/$USER"

docker exec -it dev su - $USER
```
