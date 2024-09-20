module.exports = cds.service.impl(async function(){
    const {POs} = this.entities;

    this.on('increaseAmt', async(req)=>{

       try {
        const ID = req.params[0];
         // Initialize DB Transaction
         const tx = cds.tx(req);
         await tx.update(POs).with({
             GROSS_AMOUNT :{ '+=' : 1000}
         }).where(ID)
       } catch (error) {
        return "Error" + error.toString();
       }

    });

    this.on('getLargestOrder', async(req)=>{

        try {
          // Initialize DB Transaction
          const tx = cds.tx(req);
         const largetOrder =  await tx.read(POs).orderBy({
              GROSS_AMOUNT :'desc'
          }).limit(1);
          return largetOrder;
        } catch (error) {
         return "Error" + error.toString();
        }
 
     });

     this.on('getOrderStatus', async (req, res)=>{
        return{
          "OVERALL_STATUS":"N"
        }
     });

});