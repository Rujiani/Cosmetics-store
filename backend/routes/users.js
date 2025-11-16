const express = require('express')
const router = express.Router()
const User = require('../models/User')

router.post('/register', async(req,res)=>{
    try{
    const{
    email,
    password,
    name,
    phone,
    orders
    }=req.body

    if(!email || !password|| !name){
        return res.status(400).json({message:'Обязательные поля email, password и name'})
    }

    const newUser= await User.create({
        email,
        password,
        name,
        phone,
        orders
    })
    const { password: _ignored, ...safe } = user.toObject();
    res.status(201).json(safe);
    } catch(err){
        if (err.name === 'ValidationError') {
        return res.status(400).json({ message: 'Ошибка валидации', details: err.errors });
    }
    console.error('POST /api/register error:', err.message);
    res.status(500).json({ message: 'Ошибка сервера при создании юзера' });
}
})

router.post ('/login',(req,res)=>{
    const {email,password}=req.body
    if (!email || !password) {
      return res.status(400).json({ message: 'email и password обязательны' });
    }

    const user=User
})