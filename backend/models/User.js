const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    email:{type:String,required:true},
    password:{type:String,required:true},
    name:{type:String,required:true},
    phone:String,
    orders: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Order'  
  }]
})

module.exports=mongoose.model('User',userSchema)