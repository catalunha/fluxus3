Parse.Cloud.afterDelete("Patient", async (req) => {
  let curObj = req.object;
  //Apagando todos os healthPlan's deste paciente
	const table1Rel = curObj.relation("healthPlans");
  const query1 = await table1Rel.query();
	const results1 = await query1.find();
  if (results1.length !== 0) {
    for (let i = 0; i < results1.length; i++) {
      const result = results1[i];
      await result.destroy({ useMasterKey: true });
    }
  }
  //Apagando todos os Attendance's deste paciente
  const query2 = new Parse.Query("Attendance");
  query2.equalTo("patient", curObj);
  const results2 = await query2.find();
  if (results2.length !== 0) {
    for (let i = 0; i < results2.length; i++) {
      const result = results2[i];
      await result.destroy({ useMasterKey: true });
    }
  }
});

// Parse.Cloud.afterDelete("Patient", async (req) => {
//   let curObj = req.object;
//   const query = new Parse.Query("Attendance");
//   query.equalTo("patient", curObj);
  
//   const otherObjResults = await query.find();
//   if (otherObjResults.length !== 0) {
//     for (let i = 0; i < otherObjResults.length; i++) {
//       const result = otherObjResults[i];
//       await result.destroy({ useMasterKey: true });
//     }
//   }
// });