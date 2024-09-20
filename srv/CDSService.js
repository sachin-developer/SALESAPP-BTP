const cds = require('@sap/cds');
const { Employees } = cds.entities('salesdb.master');

module.exports = srv =>{
    srv.on('READ', 'ReadEmployeeSrv', async(req)=>{
            const tx = await cds.tx(req);
            var results = await tx.run(SELECT.from(Employees).limit(5));
            var returnData = [];
            for(let i=0; i < results.length;i++){
                const emp = results[i];
                emp.nameMiddle = 'Singh';
                returnData.push(emp);
            }
            return returnData;
            
    })
}