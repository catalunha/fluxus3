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


# Duvidas Riverpod
* Como aplicar ProviderScope para evitar rebuild de lista
* Como preencher campos em statefull widget Form com AsyncValue sem passar toda vez o parametro de family

# Start

Quando baixar ou estiver trabalhando neste projeto ativar o 
$ dart run build_runner watch -d


# github

Limpar cache e colocar novas regras no .gitignore
$  git rm -r --cached .
$ git add . 
$ git commit -m 'novas regras no gitignore'



# triggers brasizza
```js
Parse.Cloud.afterSave(Parse.User, async (req) => {
  let user = req.object;
  if (user.get('userProfile') === undefined) {
    const userProfile = new Parse.Object("UserProfile");
    userProfile.set('email', user.get('email'));
    let userProfileResult = await userProfile.save(null, { useMasterKey: true });
    user.set('userProfile', userProfileResult);
    await user.save(null, { useMasterKey: true });
  }
});

const addNotification = async (user, title, message) => {
  const notification = new Parse.Object("Notification");
  const userObject = Parse.Object.extend("_User");
  const query = new Parse.Query(userObject);
  var userReq = await query.get(user);
  notification.set('user', userReq);
  notification.set('title', title);
  notification.set('message', message);
  await notification.save(null, { useMasterKey: true });
}

function sendPush(user, title, message) {
  var oneWeekAway = new Date(new Date().getTime() + 7 * 24 * 60 * 60 * 1000);
  var destinationUser = new Parse.User();
  destinationUser.id = user;
  var userQuery = null;
  try {
    userQuery = new Parse.Query(Parse.User).get(destinationUser);
  } catch (e) {
    console.error(e);
  }
  console.log('MY USER');
  console.log(userQuery);
  console.log('FIND MY USER');
  var queryInstall = null;
  try {
    // Find devices associated with these users
    queryInstall = new Parse.Query(Parse.Installation);
    queryInstall.matchesQuery('user', userQuery);
  } catch (e) {
    console.error(e);
  }

  addNotification(user, title, message);
  Parse.Push.send({
    where: queryInstall,
    expiration_time: oneWeekAway,
    data: {
      "alert": message,
      "title": title,
      "badge": "Increment",
      "sound": "default",
    },
    notification: {
      'title': title,
      'body': message,
      "click_action": "FLUTTER_NOTIFICATION_CLICK"
    },
    priority: "high",
    android: {
      notification: {
        imageUrl: 'https://picsum.photos/200'
      }
    },
    apns: {
      payload: {
        aps: {
          'mutable-content': 1
        }
      },
      fcm_options: {
        image: 'https://picsum.photos/200'
      }
    },
    webpush: {
      headers: {
        image: 'https://picsum.photos/200'
      }
    }

  }, {
    useMasterKey: true,
    success: function () {
      // Push was successful
      console.log('Push was sent successfully.');
      return true;
    },
    error: function (error) {
      // Push was unsucessful
      console.log('Push failed to send with error: ' + error.message);
      return false;
    }
  });
}



Parse.Cloud.job('sendPush', (request) => {
  sendPush('PrBUaXI5pK', 'teste', 'teste de mensagem');
});



Parse.Cloud.define("sendPush", function (request, response) {
  const userId = request.params.userId;
  const title = request.params.title;
  const message = request.params.message;
  sendPush(userId, title, message);
  response.success();
});


Parse.Cloud.afterSave('Transaction', async (req) => {
  try {
    let transaction = req.object;
    let user = await (transaction.get('user'));
    let total_credit = transaction.get('total_transaction');
    const userObject = Parse.Object.extend("_User");
    const query = new Parse.Query(userObject);
    userReq = await query.get(user.id);
    let userProfileInfo = userReq.get('userProfile');
    console.log("userProfile => ");
    console.log(userProfileInfo);
    const profileObject = Parse.Object.extend("UserProfile");

    const queryProfile = new Parse.Query(profileObject);
    userProfile = await queryProfile.get(userProfileInfo.id);
    let prior_credit = userProfile.get('total_credit');
    console.log("prior_credit => " + prior_credit);
    console.log("total_credit => " + total_credit);
    const transaction_history = new Parse.Object("TransactionHistory");
    transaction_history.set('operator', '-');
    transaction_history.set('user', userReq);
    transaction_history.set('description', 'transaction.debit_operation');
    transaction_history.set('prior_credit', prior_credit);
    transaction_history.set('credit_add', total_credit);
    let credit_total = (prior_credit - total_credit);
    transaction_history.set('credit_total', credit_total);
    await transaction_history.save();

  } catch (e) {
    console.error(e);
  }



});



Parse.Cloud.afterSave('TransactionHistory', async (req) => {
  try {
    let transaction = req.object;
    let user = await (transaction.get('user'));
    let totalCredit = transaction.get('credit_total');
    const userObject = Parse.Object.extend("_User");
    const query = new Parse.Query(userObject);
    userReq = await query.get(user.id);

    let userProfile = userReq.get('userProfile');
    userProfile.set('total_credit', totalCredit);
    userProfile.save();
  } catch (e) {
    console.error(e);
  }
});

Parse.Cloud.afterDelete(Parse.User, async (req) => {
  let user = req.object;
  let userProfileId = user.get('userProfile').id;
  const userProfile = new Parse.Object("UserProfile");
  userProfile.id = userProfileId;
  await userProfile.destroy({ useMasterKey: true });
});
```

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