Parse.Cloud.afterDelete("AnamnesePeople", async (req) => {
  let curObj = req.object;
  //Apagando todos os Attendance's deste paciente
  const query = new Parse.Query("AnamneseAnswer");
  query.equalTo("people", curObj);
  const results = await query.find();
  if (results.length !== 0) {
    for (let i = 0; i < results.length; i++) {
      const result = results[i];
      await result.destroy({ useMasterKey: true });
    }
  }
});