const express=require("express");
const bcrypt =require('bcryptjs');
const User =require("../models/users-models");
const jwt=require("jsonwebtoken");
const router=express.Router();
const secret=require("./confi");
const middleware=require("./middleware");
const confi = require("./confi");
router.route("/register").post(async(req,res)=>{
    // const user=new User({
    //     username:req.body.username,
    //     password:req.body.password,
    //     phonenumber:req.body.phonenumber,
    //     email:req.body.email,
    // });
    const { username,password,email } = req.body;
    bcrypt.hash(password, 10).then(async (hash) => {
        await User.create({
          username,
          password: hash,
          email,
        })
    // user.save()
        .then((user)=>{
        console.log("user registered");
        res.status(200).json("ok");
        })
        .catch((err)=>{
        res.status(403).json({err});
         });
    });
});
// router.route("/update/:username").put((req,res)=>{
//     User.findOneAndUpdate({username:req.params.username},
//         {$set:{password: req.body.password},$set:{phonenumber:req.body.phonenumber},$set:{email:req.body.email}},
//         (err,result)=>{
//             if(err) return res.status(500).json({msg:err});
//             const msg={
//                 msg:"password update",
//                 username:req.params.username,
//             }
//             return res.json(msg);
//         });
//     }
// )
//     (req, res) => {
//         // const { user } = req.body.username
//         User.findOneAndUpdate({username:req.params.username},
//             {$set:{password: req.body.password},$set:{phonenumber:req.body.phonenumber},$set:{email:req.body.email}},
//             // {$set:{phonenumber:req.body.phonenumber}},
//             // {$set:{email:req.body.email}},
//             (err,result)=>{
//                 if(err){ return res.status(500).json({msg:err});}
//                 const msg={
//                     msg:"password update",
//                     username:req.params.username,
//                 }
//                 return res.json(msg);
//             });
//       }
// )
    // async (req, res, next) => {
    //     const { user } = req.body.username
    //     await User.findOneAndUpdate(user)
    //       .then({$set:{password: req.body.password}},
    //         {$set:{phonenumber:req.body.phonenumber}},
    //         {$set:{email:req.body.email}},
    //         )
    //       .then(user =>
    //         res.status(201).json({ message: "User successfully deleted", user })
    //       )
        //   .catch(error =>
        //     res
        //       .status(400)
        //       .json({ message: "An error occurred", error: error.message })
        //   )
    // );
    router.route("/checkusername/:username").get(async(req,res)=>{
      try{
        const find=await User.findOne({username:req.params.username})
        if(find){
          return res.json({status:true})
        }
        if(!find){
          res.json({status:false})
        }
      }catch(err){
        res.json({err:err})
      }
      // User.findOne({username:req.params.username},(err,result)=>{
      //   if(err) return res.status(500).json({msg:err});
      //   if(result!==null){
      //     return res.json({
      //       Status:true,
      //     });
      //   }
      //   else return res.json({
      //     Status:false,
      //   });
      // })
    })
    router.route("/update/:username").patch(async(req,res)=>{
      const username=req.params.username;
      const password=req.body.password;
      if (!username || !password) {
        return res.status(400).json({
          message: "Username or Password not present",
        })
      }
      try {
        const user = await User.findOne({ username })
        if (!user) {
          res.status(400).json({
            message: "Login not successful",
            error: "User not found",
          })
        } else {
          let token =jwt.sign({username},confi.key);
          // comparing given password with hashed password
          bcrypt.compare(password, user.password).then(function (result) {
            if(result){
              User.Save(),
              res.status(200).json({
                      token:token,
                        message: "Login successful and token success",
                        user})
            }else{
              res.status(400).json({ message: "Login not succesful" })
            }})
          //   result
          //     ?
          //     // res.json({
          //     //   token:token,
          //     //   msg:"success",
          //     // })
          //     res.status(200).json({
          //       token:token,
          //         message: "Login successful and token success",
          //         user})
          //         : res.status(400).json({ message: "Login not succesful" })
          // })
          }
      }catch (error) {
        res.status(400).json({
          message: "An error occurred",
          error: error.message,
        })
      }
    }
  )
    router.route("/login").post(async (req, res, next) => {
        const { username, password,} = req.body
        // Check if username and password is provided
        if (!username || !password) {
          return res.status(400).json({
            message: "Username or Password not present",
          })
        }
        try {
          const user = await User.findOne({ username })
          if (!user) {
            res.status(400).json({
              message: "Login not successful",
              error: "User not found",
            })
          } else {
            let token =jwt.sign({username},confi.key);
            // comparing given password with hashed password
            bcrypt.compare(password, user.password).then(function (result) {
              result
                ?
                // res.json({
                //   token:token,
                //   msg:"success",
                // })
                res.status(200).json({
                  token:token,
                    message: "Login successful and token success",
                    user})
                    : res.status(400).json({ message: "Login not succesful" })
            })
          }
        } catch (error) {
          res.status(400).json({
            message: "An error occurred",
            error: error.message,
          })
        }
      }
    )
router.route("/delete").delete(middleware.checkToken,async (req, res, next) => {
    const { user } = req.body.username
    await User.findOne(user)
      .then(user => user.remove())
      .then(user =>
        res.status(201).json({ message: "User successfully deleted", user })
      )
      .catch(error =>
        res
          .status(400)
          .json({ message: "An error occurred", error: error.message })
      )
  }
)
    // User.findOneAndDelete({username: req.params.username},
    //     (err,result)=>{
    //         if(err) return res.status(500).json({msg:err});
    //         const msg={
    //             msg:"user is deleted",
    //             username:req.params.username,
    //         };
    //         return res.json(msg);
    //     }
    // );
    
module.exports=router;