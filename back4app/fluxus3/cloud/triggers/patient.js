Parse.Cloud.afterDelete("Patient", async (req) => {
  let curObj = req.object;
	const table1Rel = curObj.relation("healthPlans");
  const query = await table1Rel.query();
	const otherObjResults = await query.find();
  if (otherObjResults.length !== 0) {
    for (let i = 0; i < otherObjResults.length; i++) {
      const result = otherObjResults[i];
      await result.destroy({ useMasterKey: true });
    }
  }
  const query2 = new Parse.Query("Attendance");
  query.equalTo("patient", curObj);
  
  const otherObjResults2 = await query2.find();
  if (otherObjResults2.length !== 0) {
    for (let i = 0; i < otherObjResults2.length; i++) {
      const result = otherObjResults2[i];
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