# node-gulp

```bash
git clone git@github.com:joao-parana/node-gulp.git
cd node-gulp
docker build -t parana/node-gulp  .
docker run --rm -i -t -p 8080:8080 -v $PWD/src/app:/app parana/node-gulp bash
```

Dentro do conteiner execute dentro do projeto

```bash
npm install gulp -D
touch gulpfile.js
gulp --help
```