# deploy

 cd ~/myapp/cemec.net.br/fluxus3 && flutter build web --dart-define-from-file=lib/app/core/keys/keys.json && cd back4app/fluxus3 && b4a deploy

# vscode

cd ~/myapp/cemec.net.br/fluxus3 && flutter build web --dart-define=keyApplicationId=123 --dart-define=keyClientKey=456  && cd back4app/fluxus3 && b4a deploy

 --dart-define-from-file=lib/app/core/keys/keys.json

 cd ~/myapp/cemec.net.br/fluxus3 && flutter build web --dart-define-from-file=lib/app/core/keys/keys.json  && cd back4app/fluxus3 && b4a deploy
 
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
cd ~/myapp/cemec.net.br/fluxus3 && flutter build web --dart-define=keyApplicationId=123 --dart-define=keyClientKey=456  && cd back4app/fluxus3 && b4a deploy


# Duvidas Riverpod
* Como aplicar ProviderScope para evitar rebuild de lista
* Como preencher campos em statefull widget Form com AsyncValue sem passar toda vez o parametro de family

# Start

Quando baixar ou estiver trabalhando neste projeto ativar o 
~$ dart run build_runner watch -d


# github

Limpar cache e colocar novas regras no .gitignore
~$  git rm -r --cached .
~$ git add . 
~$ git commit -m 'novas regras no gitignore'



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


# dateDescribe

```dart
Class(varInternalGet: varExternalSet) => varExternalSet.
extension DescribeDate on DateTime {
  void describe() {
    final now = DateTime.now();
    final difference = this.difference(DateTime(now.year, now.month, now.day));
print(Duration());
    String description = switch (difference) {
      Duration(inDays: -1) => 'Yesterday',
      Duration(inDays: 0) => 'Today',
      Duration(inDays: 1) => 'Tomorrow',
      Duration(inDays: int d, isNegative: true) => '${d.abs()} days ago',
      Duration(inDays: int d, isNegative: false) => '$d days from now',
    };

    print('$year/$month/$day is $description');
  }
}

main() {
  DateTime(2023, 5, 16).describe();
  DateTime(2023, 5, 17).describe();
  DateTime(2023, 5, 18).describe();
  DateTime(2023, 5, 10).describe();
  DateTime(2023, 5, 25).describe();
}
```

# outros projetos usando este DB
flutter create --project-name=prokids0 --org net.brintec --platforms android,web ./prokids0

