# Development private recipes

Oxid eShop setup recipes for private stuff

## Prerequirements

0. PERL is required to be available on the system! Try if you have one installed with ``perl -v```

1. Check if other docker project is stopped! If you have something running, ports may conflict and nothing will work as intended, just take a minute and stop everything before running this!

2. You should have docker and docker-compose installed on your machine.

3. It should be some Linux or Mac :) No idea if it will work with Windows at all.

4. The ``127.0.0.1 localhost.local`` should be added to /etc/hosts

5. For recipes that involves private repositories, you will need the Github token which have access to those repositories.
In case Github credentials are asked, put your username and the **Github Token in place of password**!

6. Also, consider preconfiguring the git authentication to be cached globally. It will help a lot with recipes where a lot of repositories are involved:
```
git config --global credential.helper cache
```

## Installation instructions:

1. Clone the SDK to ``MyProject`` directory in this case:
```
echo MyProject && git clone https://github.com/OXID-eSales/docker-eshop-sdk.git $_ && cd $_
```

2. Clone recipes
```
git clone https://github.com/mariolorenz/docker-eshop-sdk-oxid-ce-recipes recipes/pure-oxid
```

3. And last - run the desired recipe, for example:
```
./recipes/pure-oxid/oxid-ce/6.4/run.sh
```

