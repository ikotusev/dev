```
docker create --name dev quay.io/ikotusev/dev
docker start dev
sh customize vasia 'Vasia Pupkin' vasia.pupkin@revelsystems.com
docker exec -it dev su - $USER
```
