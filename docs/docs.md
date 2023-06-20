# vscode

```
 {
      "name": "fluxus3",
      "request": "launch",
      "type": "dart",
      "toolArgs": [
        "--dart-define",
        "keyApplicationId=123",
        "--dart-define",
        "keyClientKey=456"
      ]
    },
```
# deploy
cd ~/myapp/cemec.net.br/fluxus3 && flutter build web --dart-define=keyApplicationId=123 --dart-define=keyClientKey=456  && cd back4app/fluxus3 && b4a deploy
 
 cd ~/myapp/cemec.net.br/fluxus3 && flutter build web --dart-define-from-file=lib/app/core/keys/keys.json && cd back4app/fluxus3 && b4a deploy


# Duvidas Riverpod
* Como aplicar ProviderScope para evitar rebuild de lista
* Como preencher campos em statefull widget Form com AsyncValue sem passar toda vez o parametro de family

# Start

Quando baixar ou estiver trabalhando neste projeto ativar o 
~$ dart run build_runner watch -d


# github

Limpar cache e colocar novas regras no .gitignore
$  git rm -r --cached .
$ git add . 
$ git commit -m 'novas regras no gitignore'



# triggers
```
const myObj = new Parse.Object('_User');
const query = new Parse.Query(myObj);
query.equalTo('emailVerified',false);
const list=await query.find();
for(let i=0;i<list.length;i++){
  const obj = list[i];
console.log(obj.id);
  obj.set('emailVerified',true);
  await obj.save(null,{useMasterKey:true});
}
```