const express=require("express");
const Blogs =require("../models/blog-model");
const router=express.Router();
const middleware=require("./middleware");
const multer =require("multer");
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, "./uploads");
    },
    filename: (req, file, cb) => {
      cb(null, req.params.id + ".jpg");
    },
  });
  const upload = multer({
    storage: storage,
    limits: {
      fileSize: 1024 * 1024 * 6,
    },
  });
  router.route("/add").post(middleware.checkToken,async(req,res)=>{
    try{
        const blogs=Blogs({
            username:req.decoded.username,
            title:req.body.title,
            body:req.body.body,
        });
        if(blogs){
            blogs.save()
            res.json({data:blogs["_id"]});
        }
        else{
            req.json({data:[]})
        }
    }catch(err){
        req.json({err:err})
    }
  })
  router.route("/add/coverimage/:id").patch(middleware.checkToken,upload.single("img"),async(req,res)=>{
    try{
        const blogs= await Blogs.findOneAndUpdate(
            {_id:req.params.id},
            {
                $set:{
                    coverImage:req.file.path,
                }
            }
        );
        if(blogs){
            res.json({data:blogs});
        }
    }catch(err){
        res.json({err:err})
    }
  })
  router.route("/getownblog").get(middleware.checkToken,async(req,res)=>{
    try{
        const blog= await Blogs.find({username:req.decoded.username})
        if(blog){
            res.json({data:blog})
        }
        else{
            res.json({data:[]})
        }
    }catch(err){
        res.json({err:err})
    }
  })
  router.route("/getotherblogs").get(middleware.checkToken,async(req,res)=>{
    try{
        const blogs=await Blogs.find({username:{$ne:req.decoded.username}})
        if(blogs){
            res.json({data:blogs})
        }
        else{
            res.json({data:[]})
        }
    }catch(err){
        res.json({err:err})
    }
  })
  router.route("/delete/:id").delete(middleware.checkToken,async(req,res)=>{
    try{
        const blogs=await Blogs.findOneAndDelete({
            $and:[{username:req.decoded.username},{_id:req.params.id}]
        })
        if(blogs){
            res.status(200).json("blog is deleted")
        }
        else{
            res.json("blog is not deleted")
        }
    }catch(err){
        res.json({err:err})
    }
  })
  module.exports=router;